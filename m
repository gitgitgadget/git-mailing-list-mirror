Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA5220D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 19:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFATm0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 15:42:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35777 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFATm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 15:42:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so13826934wmc.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TW96yGcJ2OVoOm4R10fcYxkkEUr3/yVK7sA0eUrunlQ=;
        b=dJvlLDSr3rLrt/+e81wX3ElPOpWIHJGjkTqRWKYwv4RWdYgujSbQDtzdfIqJXHErkp
         gglt7EXUfYp1dPhH4uBNZJKr1Lujq8jALPTn6j42k6UlWuSRAG+3W0WA1cel2D92qZpz
         /6Xj25wxVS1O97bdZH5XGTk1iD2t+1Y+9vYKQ0/bzAbw5yGEsyl6YsLjczHQKQiX+zVy
         4DvDtafh/IFJ5YQdYjT+baBzy2irP81uC1eB/icaDjoRQzOHhmKPP2+7SW183vMNc62U
         qscwsxdfSPV8Q7yPqbYaUb6AJdVbgtyLkZQC1m2qbRIw7HjOtg8AVyqUgJsjt2xxFRUt
         i6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TW96yGcJ2OVoOm4R10fcYxkkEUr3/yVK7sA0eUrunlQ=;
        b=PkDEZRoHnU9GX7AWOBU4ukeDwb7uyQ6Duli9+Ft+BTNwVMS39caQFu/S2fTlTmhSXx
         EAmTBWKcjd3rpUlT344A6vp/wg5Y80Qlr8D9rcf7xYL8xznj4T9eVhdPThylux4IftxV
         OU3gX6g3ZCiLz9f3kVdfTXn7GwAGvANe5pw2OGOy3EGrcpSbvB2P309XoY8hSskxGRWA
         2yLU36ugUBB94m2Mg+rrJmoLCw6kYTm+kI9t2w20+N7UbjGIR+mDjhy5KtBx4gHEfWsR
         I0pECAl3Zb5GWvDXU0aOHg0v1qryIdfzJZrLqrLsAO7UPg71hzOUQNgFCP28wznmG42w
         CK2g==
X-Gm-Message-State: AODbwcCyKW11M5Whh56rlqSLEmKYXjVyHHQjQ6KFhssk4N/402ziIDYk
        vTRrnQBafujiUDF2
X-Received: by 10.80.192.16 with SMTP id r16mr3093695edb.155.1496346144709;
        Thu, 01 Jun 2017 12:42:24 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id a54sm11527950edd.68.2017.06.01.12.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Jun 2017 12:42:23 -0700 (PDT)
Message-ID: <1496346143.26495.1.camel@kaarsemaker.net>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only
 when necessary
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Eric Biggers <ebiggers3@gmail.com>
Date:   Thu, 01 Jun 2017 21:42:23 +0200
In-Reply-To: <xmqq37bkabfl.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
         <20170324213732.29932-1-dennis@kaarsemaker.net>
         <1493881302.20467.3.camel@kaarsemaker.net>
         <1495227246.19473.3.camel@kaarsemaker.net>
         <xmqq37bkabfl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-06-01 at 07:50 +0900, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > Second ping. This problem is not going away, so if this solution is not
> > acceptable, I'd like to know what needs to be improved.
> 
> Perhaps you needed to actually test with older installation that
> people have, it seems, between pings.  Immediately after this was
> merged to 'master', we start getting bug reports X-<.
> 
> Eric Biggers' message 
> 
>     https://public-inbox.org/git/<20170531222455.GD72735@gmail.com>;
> 
> seems to indicate that we should cut off at 3.01 not 1.28?
> 
> Thanks.

Apologies for that. The version numbering of libnet is *weird*. The
libnet version this was fixed in *is* 1.28, but the Net::SMTP module in
 libnet version 1.28 has version 2.33.

I did test with some older perl versions, but not far enough back it
seems :(

D.
