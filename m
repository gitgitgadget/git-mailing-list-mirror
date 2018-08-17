Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABCC1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeHQUYv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 16:24:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQUYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 16:24:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so5028904wrc.13
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=l9VcVsTv7WWTUza8OTLpYPeUCiTsGvr0Wz8PrwZGAJA=;
        b=TaFubulQ9J6GFKq3j/3IoYrs6wwPI41xjRsEob/Fscv8jr91caoikAFww1I2ySQkdu
         kSrCv32Vwy9+wD1TyJUWD0nl3Eop38AGgozyr9fj9mi2x3KswO6eCAfZlrZaLt+WiDax
         +ywlwiD/1z/A2b78tTthbVIEoaoti329SHOzGtYam7KTG8AP7iOtr5xOVFS5pMHVQpjX
         PnGuS0m4uZQxzu80orJd2Awb3uN2VYddRqUlE5k+sFyyryrie1k190oCgrz/KjT+kduv
         jqR+OO0QAgSrBUTxRNekwTJUbmWWyoDfMDu6MgT4eKQCCl/t0bWg0TKFlkuBYtwMLYGE
         LTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=l9VcVsTv7WWTUza8OTLpYPeUCiTsGvr0Wz8PrwZGAJA=;
        b=LrjvgyjztWr53tET0lItViCJxlW4zC1uaigK4QYYnuoV8o1rxi0dMTdwpue6h2QP7v
         N2txvM1il3OWD5JsXAmVp5q/6WafcYNKmQuR299YiUhT+RS5owlYAcdZZzms168PVhl0
         rGiCHubB2EDhKuRofwxwVzWKUBjWYF2Gp5FasS/imZLo8aKds1J6nyyzb7up3XoZcZzf
         sn+dm0CtCwAcZk7EEJFlnGmmRIjBqE0Ax3RtvTXX28e9/fBsF6epXdqCoVDzIjFxmpzO
         1bN9h3xWf2id3JOaSNuJ8LdY4iuOVNg+rJM82Gax6bzOXc1brwOOnFGWNnWtN3+NTEp6
         AL3w==
X-Gm-Message-State: AOUpUlE2gPwn2STN56k9bzcK97wfYBIUcUoUF51nS2OjOCHhLYE9iYoJ
        Y0JPEtD4eh/3cM2HxQdtqvA=
X-Google-Smtp-Source: AA+uWPz90NfOhXhLspHV+LfdfO4AjIrIVzQ7L2vLp85nOdT8+PQnxdIaEmQ37G/v0SGvbkNku9iqvw==
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr22820572wri.36.1534526437721;
        Fri, 17 Aug 2018 10:20:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j66-v6sm3273865wrj.28.2018.08.17.10.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 10:20:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
References: <20180812090714.19060-1-pclouds@gmail.com>
        <20180817161645.28249-1-pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 10:20:36 -0700
In-Reply-To: <20180817161645.28249-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 17 Aug 2018 18:16:45 +0200")
Message-ID: <xmqqh8jsc3kr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  I still don't trust magic st_ino zero, or core.checkStat being zero
>  on Windows, so the #if condition still remains but it covers smallest
>  area possible and I tested it by manually make it "#if 1"
>
>  The fallback with fspathcmp() is only done when inode can't be
>  trusted because strcmp is more expensive and when fspathcmp() learns
>  more about real world in the future, it could become even more
>  expensive.
>
>  The output sorting is the result of Sublime-Gitignore repo being
>  reported recently. It's not perfect but it should help seeing the
>  groups in normal case.

Looks small and safe.

> +
> +	if (o->clone) {
> +		struct string_list list = STRING_LIST_INIT_NODUP;
> +		int i;
> +
> +		for (i = 0; i < index->cache_nr; i++) {
> +			struct cache_entry *ce = index->cache[i];
> +
> +			if (!(ce->ce_flags & CE_MATCHED))
> +				continue;
> +
> +			string_list_append(&list, ce->name);
> +			ce->ce_flags &= ~CE_MATCHED;
> +		}
> +
> +		list.cmp = fspathcmp;
> +		string_list_sort(&list);
> +
> +		if (list.nr)
> +			warning(_("the following paths have collided (e.g. case-sensitive paths\n"
> +				  "on a case-insensitive filesystem) and only one from the same\n"
> +				  "colliding group is in the working tree:\n"));
> +
> +		for (i = 0; i < list.nr; i++)
> +			fprintf(stderr, "  '%s'\n", list.items[i].string);
> +
> +		string_list_clear(&list, 0);

I would have written the "sort, show warning, and list" all inside
"if (list.nr)" block, leaving list-clear outside, which would have
made the logic a bit cleaner.  The reader does not have to bother
thinking "ah, when list.nr==0, this is a no-op anyway" to skip them
if written that way.

I highly suspect that the above was written in that way to reduce
the indentation level, but the right way to reduce the indentation
level, if it bothers readers too much, is to make the whole thing
inside the above if (o->clone) into a dedicated helper function
"void report_collided_checkout(void)", I would think.
