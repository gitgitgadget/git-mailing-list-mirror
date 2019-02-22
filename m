Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B320248
	for <e@80x24.org>; Fri, 22 Feb 2019 23:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfBVXX2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 18:23:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 18:23:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so4057905wrp.7
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 15:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=C7oGbDIuTYQdSsspDQTbE52oSMFv2C9HcMvTyA16EJk=;
        b=SQQ2YxWvVGAV/xqvsaSGPFEY1JokBqjvFgxlQ23aqMJ5ecf40xpF+N6gr9jGNUSyzF
         WMxaoL4MoHm4FK+fFfd1qCkZAFhHGt6FFBpX06Xjo9Y1Tp2lLNd3RnnA5MH5A5UPpuK3
         hdosUExT0FWTyNyOifE88HHG5FLwyil8Klk2MYyFrN5ly7eDN2ucKoUe8YhjswL/Yrzx
         GtHBtql+f9kpriuLAumHtHiD7nbqX/rbMEdIru1IIuHgEIZweZX5Iq9BbJMia/aoNadW
         O5h1bk7mArub6C0gbjiISzBPgVPbfQnnaCbtFL0y4Nrj0Q6pEiN1p2+EzeqO2DiL+mdk
         r+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=C7oGbDIuTYQdSsspDQTbE52oSMFv2C9HcMvTyA16EJk=;
        b=V/i6RIR93yBD+g7qV9h97XnY5eSjG+aa5CqF6bJIedWaYNEuUxt1KNUjf8Em64Y8wM
         z+hWJLa+pre09tZPKEFthSOEGCvzbKL+v3f330tAsyyaarJ1YrsnV+aKNoqq6hGLZb++
         /SWPw9oMvWloLie0eTiWKl/dv5KG005eE9Qqy5/L4Nnu67tZaNgel1hUgMVKKX//NS9z
         VWu7ab1fMQaHWZfNcDCHwgBMyOeYkQb/y4mOXzVZDM33iDX0rvxY0SKoD7LRYlvY3yvN
         i/QFZgQ3acn7dtGslbRDxtDFAaXC0QD47Q64RcJ+iCrISWfkPBQXWShTGwpKY1ew4ECU
         WXig==
X-Gm-Message-State: AHQUAuZqYQ02TQ1gFiIa0OwOBL7hJG6g9EB3z2GiCIVQmDYnLYCMJddB
        xappfZyhUaaZgkzW4RqGF5c=
X-Google-Smtp-Source: AHgI3IbqlCjf/Cn5vasA7cWANYlok6Q4lPSgZrNwX02VUQiDAQYAE6gJ6v09GgZ/1+blQupFG22VLA==
X-Received: by 2002:adf:c704:: with SMTP id k4mr4883156wrg.142.1550877806009;
        Fri, 22 Feb 2019 15:23:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v20sm2046133wmj.2.2019.02.22.15.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:23:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2 6/6] Makefile: allow for combining DEVELOPER=1 and CFLAGS="..."
References: <20190222105658.26831-1-avarab@gmail.com>
        <20190222144127.32248-7-avarab@gmail.com>
Date:   Fri, 22 Feb 2019 15:23:24 -0800
In-Reply-To: <20190222144127.32248-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Feb 2019 15:41:27 +0100")
Message-ID: <xmqqr2bzo1ar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/config.mak.dev b/config.mak.dev
> index 7354fe15b3..bf1f3fcdee 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -1,41 +1,41 @@
>  ifeq ($(filter no-error,$(DEVOPTS)),)
> -CFLAGS += -Werror
> +DEVELOPER_CFLAGS += -Werror

This is the first mention of DEVELOPER_CFLAGS; what is -Werror
appended to?  Any random thing in the environment or command line?

>  endif
