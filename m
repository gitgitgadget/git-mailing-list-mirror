Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89C21F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeHVTy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:54:26 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37998 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:54:25 -0400
Received: by mail-wr1-f49.google.com with SMTP id w11-v6so2119087wrc.5
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fMLRdSmXjPjKm1c6hvMSXVI1B3M7SrM5XWu7XgItq1U=;
        b=YLzxhiFHfTcuZ2+qIcrkX1kH7NW5MWl1fgRG8+3ODL6ZiKH70AvxSFW5NCgP6F4Bif
         yetP2/W68/duYFK1CEXvO4gE8QMtqvLMhHSG4W1wYsF2dtNhR5FerBcMQ9nVPPWqVMUB
         TKxX0NIT5O8TlxC2ARmwJxb6yqPGlnPYlzb6fBOMgpDfI8Fmbyg01AW8tcys4VGnofXd
         Nho7ZIp97o07lJq4554QbhC2WEocvRRH73SZZHVXG3KBKe3Ahwq8sZ6UnxKweN1+VJRR
         GxE2ElmKE8D6V7q2isd2+KCXdjVYuPpDzeydM1ga8CJWFa3WlALT9Uphml3urI6W6HFw
         LRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fMLRdSmXjPjKm1c6hvMSXVI1B3M7SrM5XWu7XgItq1U=;
        b=p9UcvSAzMHn0hvhzkmnKOAerkYE6LmDYBHFk4LymsMPZq06vr+T5NAkYBQaAjdeKpT
         51SQw8OeOW0wh8FXwf8KgpjN6u/F1WZebh7HkDRXvfiX5FgqXHkvdirhMsifsBPGFAZ9
         EcgZM3yzfeR+LcF91PwFDk9oZJQanJf7i5hPzsaiGua46gaIWTPY2c621voz0JgdN4J9
         ut9H5IS/D958EfjbJJQUktWDyBsc0vaY1weNuJMOxq6vnG1dd7VVfyrDMWY4xqGAkJRR
         NTxZUOt7ArslxA5oAhFDtWCu01RxVIS5kwTB48Cz92AR2lTed8hrmBMjaBVZpGj6hHFp
         CV+g==
X-Gm-Message-State: AOUpUlFy7QT46zTpYmTOeAqBT1eBui/HZzgk3D53cRp0A92sMIKZ3HmU
        Naicw5nI6zUbleUHlj1LnnA=
X-Google-Smtp-Source: AA+uWPymyWn8YoZHnmLPZ6T+QpsI5ekPnzmJQ1O3ECmHbYtDnfatFmcLkK4CuD56zsCcBvP/nL26sw==
X-Received: by 2002:adf:9007:: with SMTP id h7-v6mr37602575wrh.178.1534955330426;
        Wed, 22 Aug 2018 09:28:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1564540wrw.79.2018.08.22.09.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 09:28:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] Break down Documentation/config.txt
References: <20180822160605.21864-1-pclouds@gmail.com>
Date:   Wed, 22 Aug 2018 09:28:49 -0700
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 22 Aug 2018 18:05:54 +0200")
Message-ID: <xmqqh8jm5pry.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> I notice a couple times lately that people added new config keys in
> the wrong place, which is understandable since this file has become so
> big, it's hard to see the structure of anything.
>
> Since we have broken down some parts of it into separate files
> already, this continues in that direction and moves even more parts
> out of config.txt.

Especially with <20180819105210.19296-1-pclouds@gmail.com>, which is
your recent update to the "git help --config" collection machinery
in place, this sounds like a sensible move.
