Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3C21F453
	for <e@80x24.org>; Fri, 26 Oct 2018 02:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeJZLXv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 07:23:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43911 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZLXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 07:23:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so11246741wrn.10
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 19:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FhxTMDzcOWaK+cwe31e8fDxA4otRqbHZ6avXb576Eik=;
        b=KxmcJhnWl4G9GMVo4vDCpMRZxmn1RFak4rtoEJdHG9B7zGa50K5VG6Oazzi3MFHBvZ
         0/GYe5gvfH3w+95pfyS0oEz29CF5X1oBFuRx0m0rwM+PD+7xMHMWXzZV/8+9RfjNEl8g
         pdN//MZJLm/Jlop8TQSyf7RGbyhLubO1htahuBGwDDVmAiG9sYsS4wOBmF03HGIuQhuu
         l3UinzFKfiSDmobaeMn8/M1sAfJoOnBWaaGj2uXVOLpeUfXbFcyksxVBmJLlQ42EgtVt
         80DpfmBsMxtyou1x++qyEkNI99tfOYueK1Mf2GO57MH7BpQb9ewL5lAB2Jj7L4+Jjmy2
         keyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FhxTMDzcOWaK+cwe31e8fDxA4otRqbHZ6avXb576Eik=;
        b=LUGaOlw1UqVeJfbshmLkpbC+B/4u/DdlBvPucXw6iyuzRrvq2UfOCFJT1ImTfIRehA
         6D0uAhIwC24nWUfX8ZT9+bTeCbGkt1JSZRJl5ZOb0C7JcVFHJ3UgUJlGJ0F0npMTbpb+
         EP81ivUgbl17HQUNLqWrYXlV0XdLebgIMniQkKnV7X8qvQOOgBmpavShm3q1yH8EBWeb
         qXBE+Jqk+letjve8aAqq+MoUVXsYWYULbrTN4gNvEfgNor+3XRlXjFkc+CawW6X03CzE
         1UTixGg+AjYv35adJaQOeDKQER2t42WmEAmkT5+ZwsUAfKJ7PfcAEWrp42r0uQIv5Edn
         iaSA==
X-Gm-Message-State: AGRZ1gLjzfqJqKH9QMSvYCRWgjLWAWAE1dQV18Ta8MbOlalApv4eZZk6
        JEp+LQ3y2wYd3H2AFdNIDYA=
X-Google-Smtp-Source: AJdET5fFH2jItqt5VS+deTxflK58mJz17neVRxtKl0EZ8UeYJiiFM+ecQErlPXNiwfP73Yeisq1/3g==
X-Received: by 2002:a5d:64c1:: with SMTP id y1-v6mr3842956wrv.92.1540522120167;
        Thu, 25 Oct 2018 19:48:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b128-v6sm3419754wmh.22.2018.10.25.19.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 19:48:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 2/2] curl_off_t xcurl_off_t is not portable
References: <20181025161310.29249-1-tboegi@web.de>
Date:   Fri, 26 Oct 2018 11:48:38 +0900
In-Reply-To: <20181025161310.29249-1-tboegi@web.de> (tboegi's message of "Thu,
        25 Oct 2018 18:13:10 +0200")
Message-ID: <xmqq4ld9e83d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>

> Subject: Re: [PATCH v1 2/2] curl_off_t xcurl_off_t is not portable

That title is misleading; it sounded as if the are these two
typedefs and they do not work correctly on some platforms, but that
is not what you are doing with the patch.

> Comparing signed and unsigned values is not always portable.

Is that what the compiler is complaining about?  There is this bit
in git-compat-util.h:

/*
 * Signed integer overflow is undefined in C, so here's a helper macro
 * to detect if the sum of two integers will overflow.
 *
 * Requires: a >= 0, typeof(a) equals typeof(b)
 */
#define signed_add_overflows(a, b) \
    ((b) > maximum_signed_value_of_type(a) - (a))

which is designed to be fed signed a and signed b.  The macro is
used in packfile codepaths to compare int, off_t, etc..

So the statement may be true but it does not seem to have much to do
with the problem you are seeing with maximum_signed_value_of_type().

> When  setting
> DEVELOPER = 1
> DEVOPTS = extra-all
>
> "gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516" errors out with
> "comparison is always false due to limited range of data type"
> "[-Werror=type-limits]"

Then this sounds a bit different from "comparison between signed
ssize_t len and unsigned maximum_signed_value_of_type() is bad".
Isn't it saying that "No matter how big you make len, you can never
go beyond maximum_signed_value_of_type(curl_off_t)"?

> diff --git a/remote-curl.c b/remote-curl.c
> index 762a55a75f..c89fd6d1c3 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -618,9 +618,10 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  }
>  
>  static curl_off_t xcurl_off_t(ssize_t len) {
> -	if (len > maximum_signed_value_of_type(curl_off_t))

Is the issue that len is signed and maximum_signed_value_of_type()
gives an unsigned value, and these two are compared?  As we saw
earlier, signed_add_overflows() is another example that wants a
mixed comparison.

I am just wondering if casting len to uintmax_t before comparing
with maximum_signed_value_of_type() is a simpler solution that can
safely be cargo-culted to other places without much thinking.

"git grep maximum_signed_value_of_type" reports a handful
comparisons in vcs-svn/, all of which does

	if (var > maximum_signed_value_of_type(off_t))

with var of type uintmax_t, which sounds like a sane thing to do.

Thanks.

> +	curl_off_t size = (curl_off_t) len;
> +	if (len != (ssize_t) size)
>  		die("cannot handle pushes this big");
> -	return (curl_off_t) len;
> +	return size;
>  }

