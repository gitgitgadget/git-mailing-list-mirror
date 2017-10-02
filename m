Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC6D20281
	for <e@80x24.org>; Mon,  2 Oct 2017 16:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdJBQHW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 12:07:22 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:46642 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdJBQHV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 12:07:21 -0400
Received: by mail-pg0-f44.google.com with SMTP id v3so3202614pgv.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t76fpxDzNKUw0Z8EEOnO33FKwdZZtt5MBFZDARjSU1k=;
        b=m2fp2c8LFSchv0tUyReJkuGowsfXu5WVx5+/HS9CpXLbBz47jfCilvs1FZxFJErBNo
         iCocCURB6/W+WoIz1t5yuzGMEVhfuhD0YOeTdydg7tgDzFWpHtLb+JU/S4kk61xdCVrc
         9csOr8RQOuLA1DNATHfcrDLjxHG59hUp7V2ohJSrxWzPDzWePF0tIyHzhFZXGnzqZiFm
         zPgkmrQ5MDmei83WdKn90fxm9PYmd+wFKQy74U9fvrLlbjsHP042hur2rPwD92jVBHVP
         GCZKJN9AE5z7pnc61G+qXlSU4N53cz/IukwuKfwSIKpbKW/SoGovpY3fSrrk+nxqhU11
         lqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t76fpxDzNKUw0Z8EEOnO33FKwdZZtt5MBFZDARjSU1k=;
        b=tx3TkMpRPEAlEkOA+T373Fm7wORbZYXLYX7hDxqU0rlPCwx1Y0Z4yXSCSanvQVSHTj
         pQ9wrZIXMwfPoyNerGm4dTBaMOlZkJ61XmU16kw/k+ogtmtInVKh2FFtpXVWwWbbcmTl
         BKhju8y2fq7wUF3qgGE8R1zc2udwGpzR1qL9hg/GWEsbA83nvfEps9pnlVcVKPBZaaIe
         in6BZU5UpcGd4vXR0bWrEHTqAi9im+cc1x3P8zgoD/F41kViY6/XPtyQDk6EUNlwef2m
         Otwh1kk33c8zpKTGlKyK9CDga3TN/wc4OQPVCi3HUtMbveIPBN8tIsKk05OUBGY4OCu+
         jYWQ==
X-Gm-Message-State: AHPjjUjfo6FABSG0z3LFaOjaSrTlhFMYjVQCfOQFhEQar6Ix9NFcMI5p
        cV5zX3sdZZ2xdCJb/aE+xQYXAr8Uo3I=
X-Google-Smtp-Source: AOwi7QCaHVBCsJSpd5ilpbwB9kGKuuwViFOQR+67zZ9iDVFTqQG10w749LY9QGOaaSoFMriQOZeG6Q==
X-Received: by 10.84.129.193 with SMTP id b59mr14469617plb.147.1506960441068;
        Mon, 02 Oct 2017 09:07:21 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id j1sm17706755pfc.169.2017.10.02.09.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 09:07:19 -0700 (PDT)
Date:   Mon, 2 Oct 2017 09:07:18 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v6 0/7] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20171002160718.GB39723@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <xmqq7eweotup.fsf@gitster.mtv.corp.google.com>
 <xmqqy3otn3uj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3otn3uj.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 09:15:00PM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Thanks.  t6300 seems to show that %(contents:trailers:unfold) does
> > not quite work, among other things.
> >
> >   https://travis-ci.org/git/git/jobs/282126607#L3658
> >
> > I didn't have a chance to look into it myself.
>
> Peff's "oops, your logic is backwards" fixes the above failure.
>
> We also need this on top to pass the gettext-poison build.
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 872973b954..3bdfa02559 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -685,19 +685,21 @@ test_expect_success '%(contents:trailers:only) and %(contents:trailers:unfold) w
>  '
>
>  test_expect_success '%(trailers) rejects unknown trailers arguments' '
> +	# error message cannot be checked under i18n
>  	cat >expect <<-EOF &&
>  	fatal: unknown %(trailers) argument: unsupported
>  	EOF
>  	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
> -	test_cmp expect actual
> +	test_i18ncmp expect actual
>  '
>
>  test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
> +	# error message cannot be checked under i18n
>  	cat >expect <<-EOF &&
>  	fatal: unknown %(trailers) argument: unsupported
>  	EOF
>  	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
> -	test_cmp expect actual
> +	test_i18ncmp expect actual
>  '
>
>  test_expect_success 'basic atom: head contents:trailers' '

Thank you for pointing this out. I am not well-versed on gettext, and
its usage within Git. I am happy to send out v7 of this series, or you
can apply these changes in queueing. Whichever is easier :-).

--
- Taylor
