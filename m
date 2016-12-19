Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79577203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 11:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763100AbcLSL6U (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:58:20 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34320 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbcLSL6S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 06:58:18 -0500
Received: by mail-pf0-f195.google.com with SMTP id y68so7499586pfb.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 03:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=guNcEXcrSO24xpscqj3mlHPEg9c7J3HtFCH4TUrghtg=;
        b=rsRoNS7+6s8z9+bHY63JGuGU+YdJvvLzguQEo0QNm0v8lSu5HHAlF+ic0+UmOj8ZVB
         J5yBUD2EICSXrMAXD0I5DpoSuKeh3EdFBLhjkDw4zHv3kCEZNErc/3aG6qkMOiWwiXzR
         VgrFLu4iYGK+t2a4wp5OidjZ1DBy94s4E9/e9UWoxlYJCCPJqs/56tKfpDigoD1UsU25
         Ns1XoCQ0jLCGB2QdSl8aRzirmI7AKx93HtAL40jkW5kVc5hnVAwSh+kqbsztYFVjxuJ/
         qfHRqRF/bhtwzBQqemQ1IAhqrNt9/nZa+gwR9X0Rehz/SmSLpMu2QjbjnTeH65N9U0E+
         NrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=guNcEXcrSO24xpscqj3mlHPEg9c7J3HtFCH4TUrghtg=;
        b=Oc8v0VkbHmwGaHjx+YH+409Wo1taLA5KBFtxYTu2DwMLR5+Bw/k2r8cYW3WqDXZpiI
         oxKNiqtP9lQA+u5szRy0KpSUrkBDn0r1tVg6m8qUwSgxdLQh1tRo7o4KHUKbXjI1aNgW
         gsfJzz+C7xJi6PI6byvISFl5fVakQfhHi3osrZO5Yu41QfjS5Ow3fDjPLwiDFRcp6lvj
         QuCTEn+i4KKH6C3EjM7NJsKntxmyBqitBbyMcWVOS3Em6g1Ufb1tmwBQ67qPRCXEuPKD
         PY4oHw6ioDjYFuYn2HXKOCOAnIECnG1PPtcoh+VjSdQa0/0gAukwJTlrIr/srvzYpYfY
         OAig==
X-Gm-Message-State: AKaTC00VQDkobOWAlUKQDsJKx5g9PVkuGbtDgYpGY9yBKIMB8dCJ/Ji4kAdBOgQx8MoxXQ==
X-Received: by 10.99.222.85 with SMTP id y21mr28110298pgi.119.1482148697981;
        Mon, 19 Dec 2016 03:58:17 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id c8sm31084150pfe.15.2016.12.19.03.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 03:58:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 19 Dec 2016 18:58:13 +0700
Date:   Mon, 19 Dec 2016 18:58:13 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 16/21] read-cache: unlink old sharedindex files
Message-ID: <20161219115812.GD24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-17-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161217145547.11748-17-chriscool@tuxfamily.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 03:55:42PM +0100, Christian Couder wrote:
> +static int clean_shared_index_files(const char *current_hex)
> +{
> +	struct dirent *de;
> +	DIR *dir = opendir(get_git_dir());
> +
> +	if (!dir)
> +		return error_errno(_("unable to open git dir: %s"), get_git_dir());
> +
> +	while ((de = readdir(dir)) != NULL) {
> +		const char *sha1_hex;
> +		if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
> +			continue;
> +		if (!strcmp(sha1_hex, current_hex))

fspathcmp since we're dealing fs paths?

In theory we should be ok using strcmp, even on Windows because case
is preserved, I think. It's only a problem when we write path 'abc'
down and read 'ABC' back.

Oh well.. your call because if you go with fspathcmp, skip_prefix can't
be used either. A lot more changes for a very rare case.

> +			continue;
> +		if (can_delete_shared_index(sha1_hex) > 0 &&

Probably shorter to pass full d->name here so you don't have to do
another git_path() in can_delete_

> +		    unlink(git_path("%s", de->d_name)))
> +			error_errno(_("unable to unlink: %s"), git_path("%s", de->d_name));
> +	}
> +	closedir(dir);
> +
> +	return 0;
> +}
