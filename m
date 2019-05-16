Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259241F461
	for <e@80x24.org>; Thu, 16 May 2019 03:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEPDNm (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 23:13:42 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:32987 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfEPDNm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 23:13:42 -0400
Received: by mail-pl1-f170.google.com with SMTP id y3so869424plp.0
        for <git@vger.kernel.org>; Wed, 15 May 2019 20:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=meuv5u0z8p84uStTiyIciVDpfhyyogilJCd+Qxut/Tc=;
        b=dcrhmcgLCiBU28C7EFk/QP3+DHTLO8UQjCWiGhharb6r4x4NyjiRMAY3iGWP2xqk+w
         scRvWsEhxh2GXYlVsq63z1uYdwKSB+gsbBP4dmO0uIie52Ml7Y+K+vx98UkFKm9OzI38
         5oyLSq8VQBahiCHb2HXEBemL+3tJLoA9zBK6GH5UuSzugak0dSdcN+/gT4ix3e+kdVve
         MlHKOJ2eoIUv47Ix+wqDxNaDbBcs7/tWtcryFjMxoX6h4HJv3S02tF17KILQ71fTp8G7
         Lw7bO95x1YMWq946WKPFVKBmnwi4QJ8sUqesARRvRBZ2vTu5hvdoI/WKnWzToa4bAaiC
         1b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=meuv5u0z8p84uStTiyIciVDpfhyyogilJCd+Qxut/Tc=;
        b=Kl1F9eCiNU2zx2J7Pp9uM/0cAev2mgBCTr0+5zKKx0eXNbKB8WzMnkvVTukvjoT7aD
         4J4wNZKBetBbo3obO0NcgRY4bi6Eb/F7MSc2QGqCnSIlTyMYZ8yNggYAXb45NsAh9otb
         LhSTLG8pgfMsaPiNc0SaNwCbLW3v3a12BAcwRJGE+pJSGcBjopetjufXW+s5VJKbAvSX
         Mo1TXyHOz5T1MDhE2FjdZg7c0koiNevFVgjAdVhHBwxQj2lL/MRi0JYeFb5VtaM50puP
         prx9NW9aCrbeEFBbci+D+oVDPxTZJ3rpjq22UyhMXE5Z4hWueDR2kcROiLoL2uvhaBaI
         7JCA==
X-Gm-Message-State: APjAAAUtWk4K3PhYnGpTnw4NOCfkIw1+F6lWW1AS3StUyP7n3dZiJwML
        p5Lzb5tEb+eFGK22eYmSOjdbRkqP
X-Google-Smtp-Source: APXvYqwpG7RP0S6kaEQhI1vWsH7b/LDZjHX6H5i++5QbiK2wiPicmQLkim1GMW8tUKsJ+2hRPMHT3Q==
X-Received: by 2002:a17:902:8305:: with SMTP id bd5mr23603351plb.339.1557976420922;
        Wed, 15 May 2019 20:13:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id q20sm4182966pgq.66.2019.05.15.20.13.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 20:13:40 -0700 (PDT)
Date:   Wed, 15 May 2019 20:13:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] grep: provide sane default to grep_source struct
Message-ID: <20190516031338.GA156553@google.com>
References: <20190516020023.61161-1-emilyshaffer@google.com>
 <xmqqy3373xnj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3373xnj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Currently the only use of the function is to see if the log message
> matches with the given pattern (yes/no), but it is conceivable that
> new callers may want to prepare in-core data and use it to see if
> that matches the pattern, or even to _show_ the lines that match the
> pattern (possibly with its own .output callback).

Oh, good point about .output.  That answers my question about getting
the output in the right place.

[...]
>> Thanks in advance for everyone's thoughts.
>> Emily

Thanks, both.

Jonathan
