Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D94D1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 23:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeDKXxC (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 19:53:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52366 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDKXxB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 19:53:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id g8so7612746wmd.2
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3atiHbP1zd9KGG10/hWcSG9YBBJn2oOfv97pWxJJo88=;
        b=A/u1Ii9A8luhjIwNpQPao36ATprZHEpjjYJUdOxU6GGh302CmSdBSVqRDU0Dgu+MhI
         L+52YG/w91729Wq9ia5II0FVbR3jAsMzUfWQyYxO7F4p78fzutyF/7Rc3q+oQo907eke
         qWAMEBcQ3yb20+PmM024LvRDrr3+gREhIZ9I6nL8MoawXhgUa39hnJBeyH9cvc3FVtkh
         GFJm1XjPc7ZFtPNhmyniKnmEiCpzJ5rEyfg95UtVSe2PX5+x5mbw+xIQezz8t/UaHhqR
         RA0zHZljmmeE83OFgG1l87WtxCjhmU3NvqNCjtL4nBwz8t1ttp7mCJ2GgrmPVV3BPncy
         ykBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3atiHbP1zd9KGG10/hWcSG9YBBJn2oOfv97pWxJJo88=;
        b=SvXFTOABv33gjayRSsh9g92//j/xgDIxKjd+K8eKOcKPRvDupAi3kLZZ1EZulKhuv0
         vSGM3eGqddY4o8LgtcPUlp2DC3jqUeS0rSF9FQq6IDMgA0Gk+ocU2I7qQmtZfek97xOg
         g61XajqrIZyzv+KYsYA5N5oJrC9tv2c0VDZdvd4ZwhUQisqCd9aG1mVacn0vNNRcjHxu
         yO8epNf5AraLjCOlnsAYyFmrklYB3Gcbh4glO4UpwWJbXfIdqSK71+D4RZ0mCnvXREUW
         fcHDwmnK2pFx2jNJb9+iHWXhXxV/ovSND+0NPJZMbvaK8kKQvAxqey6gn53k38RnVJl4
         GD6g==
X-Gm-Message-State: ALQs6tC69QZpRk83oBktFwGAatkT4sA38oHf9Cbu95SmXw0oKl3X9833
        B93tcAFbu6nK3ts/JyWiiuk=
X-Google-Smtp-Source: AIpwx4+qq1czfNoFi7y43Eo6caB9+Clleyfo+Cx4tGtDNBNzNsRybAI+1GWLGyDe9mf1jk+g57Ee8w==
X-Received: by 10.28.19.193 with SMTP id 184mr3578512wmt.158.1523490780072;
        Wed, 11 Apr 2018 16:53:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e8sm5737245wmf.15.2018.04.11.16.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 16:52:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "alexmv\@dropbox.com" <alexmv@dropbox.com>,
        "blees\@dcon.de" <blees@dcon.de>,
        "bmwill\@google.com" <bmwill@google.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren\@gmail.com" <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] fsexcludes: add a programmatic way to exclude files from git's working directory traversal logic
References: <20180410210408.13788-1-benpeart@microsoft.com>
        <20180411200007.8612-1-benpeart@microsoft.com>
        <20180411200007.8612-2-benpeart@microsoft.com>
Date:   Thu, 12 Apr 2018 08:52:59 +0900
In-Reply-To: <20180411200007.8612-2-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 11 Apr 2018 20:01:34 +0000")
Message-ID: <xmqqsh812td0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I haven't studied and thought about the motivation behind these two
patches, but one thing I noticed...

Ben Peart <Ben.Peart@microsoft.com> writes:

> diff --git a/dir.c b/dir.c
> index 63a917be45..1aa639b9f4 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1102,6 +1103,12 @@ int is_excluded_from_list(const char *pathname,
>  			  struct exclude_list *el, struct index_state *istate)
>  {
>  	struct exclude *exclude;
> +
> +	if (*dtype == DT_UNKNOWN)
> +		*dtype = get_dtype(NULL, istate, pathname, pathlen);
> +	if (fsexcludes_is_excluded_from(istate, pathname, pathlen, *dtype) > 0)
> +		return 1;
> +
>  	exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
>  						  dtype, el, istate);
>  	if (exclude)
> @@ -1317,8 +1324,15 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
>  int is_excluded(struct dir_struct *dir, struct index_state *istate,
>  		const char *pathname, int *dtype_p)
>  {
> -	struct exclude *exclude =
> -		last_exclude_matching(dir, istate, pathname, dtype_p);
> +	struct exclude *exclude;
> +	int pathlen = strlen(pathname);
> +
> +	if (*dtype_p == DT_UNKNOWN)
> +		*dtype_p = get_dtype(NULL, istate, pathname, pathlen);
> +	if (fsexcludes_is_excluded_from(istate, pathname, pathlen, *dtype_p) > 0)
> +		return 1;
> +
> +	exclude = last_exclude_matching(dir, istate, pathname, dtype_p);
>  	if (exclude)
>  		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
>  	return 0;

A piece of impression I am getting from the above two hunks is that
the fsexcludes_is_excluded_from() function requires a real dtype in
its last parameter (i.e. DT_UNKNOWN is not acceptable).

> @@ -1671,6 +1685,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>  	if (dtype != DT_DIR && has_path_in_index)
>  		return path_none;
>  
> +	if (fsexcludes_is_excluded_from(istate, path->buf, path->len, dtype) > 0)
> +		return path_excluded;
> +

And this hunk reinforces that impression (we are comparing dtype
with DT_DIR, so we know we cannot be passing DT_UNKNOWN to it).

> @@ -2011,6 +2028,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  		/* add the path to the appropriate result list */
>  		switch (state) {
>  		case path_excluded:
> +			if (fsexcludes_is_excluded_from(istate, path.buf, path.len, DTYPE(cdir.de)) > 0)
> +				break;

Then the use of DTYPE() looks a bit odd here.  On
NO_D_TYPE_IN_DIRENT platforms, we would get DT_UNKNOWN out of it and
then end up passing DT_UNKNOWN to the function.
