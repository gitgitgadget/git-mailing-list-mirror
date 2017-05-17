Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF14201CF
	for <e@80x24.org>; Wed, 17 May 2017 06:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbdEQGrx (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 02:47:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33543 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbdEQGrw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 02:47:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so627105pfe.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pIShrsWbkqB2HUxSKI0RH8JAXds18BDFYqx9EzUobt8=;
        b=tos6c5JRdA0o0+GnM7rwsa/hFh1STHQNLkU9qEF6J8Jk5ukU94qeXChZ+sCm5BiX2S
         K1Rk6wt7lSgPmrhwITDabJh0ZpEZzJcq3orO7tkR57Nno//m/wnPhz7gKImQC2piNTR3
         qTRatTLKbzzkFxDrPWC+FV3bO0hngJRcgt+qcjDwn7Fvq6NRXo0owff6u+SxPdAMmpl1
         nOgQMZDgoMv32Qe5IwrUezbSDawLWedyy/IKxY02C/b1vY1m/gGCQ7L17b4+5Axaga6t
         VOa3cTsFL30vQq77HbS0NbuTky9fgYSFx4+pvQpyMnt4x39NfKcXG6nwW7O7mFa0JZOo
         UgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pIShrsWbkqB2HUxSKI0RH8JAXds18BDFYqx9EzUobt8=;
        b=CGvUoE9YhSwxpb8P/pBkWP7U1pSXiwQ2YcXDJ9b+vT+5K0qUAZ07W+ftw3b+DSxpPt
         QlVptlQXrqQA9IaKXE2UxA2J5IPmwrG5+AIy6UqCGgYyrTJCZxMtaq1SJDDYLYBJLWJP
         n7t4/BiPfZbCd6c8itjVcUm8/L8pjwKsOIqrw1vyB2WmVuVRV/qJXcdeaRahypP+3pe5
         GWZfMWlwvXlXNq/rumug0gnYoscYsC3sGfiH4bqVIvQaaAW/pcbxPxSRLPhL0ilUMpu9
         kXBz8Ynk/NHJe4WbfbxNEIrpuVXb9xVw4CXVW7zlxYbqa+Q78t1xWrWtCi2O4YDAIaec
         tJdw==
X-Gm-Message-State: AODbwcAPpU2+rUZMuSuv4gZkcdjwIBp3I48omqoqT8/iwPFKTTq/d5Yy
        JEoOLomKUSJdGQ==
X-Received: by 10.84.202.163 with SMTP id x32mr2450073pld.51.1495003671300;
        Tue, 16 May 2017 23:47:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id p10sm1709854pgf.63.2017.05.16.23.47.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 23:47:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dir: hide untracked contents of untracked dirs
References: <20170516073423.25762-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
        <20170516073423.25762-5-sxlijin@gmail.com>
Date:   Wed, 17 May 2017 15:47:49 +0900
In-Reply-To: <20170516073423.25762-5-sxlijin@gmail.com> (Samuel Lijin's
        message of "Tue, 16 May 2017 03:34:19 -0400")
Message-ID: <xmqqo9usvv1m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> When we taught read_directory_recursive() to recurse into untracked
> directories in search of ignored files given DIR_SHOW_IGNORED_TOO, that
> had the side effect of teaching it to collect the untracked contents of
> untracked directories. It doesn't always make sense to return these,
> though (we do need them for `clean -d`), so we introduce a flag
> (DIR_KEEP_UNTRACKED_CONTENTS) to control whether or not read_directory()
> strips dir->entries of the untracked contents of untracked dirs.
>
> We also introduce check_contains() to check if one dir_entry corresponds
> to a path which contains the path corresponding to another dir_entry.
>
> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---
>  dir.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  dir.h |  3 ++-
>  2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 6bd0350e9..214a148ee 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1852,6 +1852,14 @@ static int cmp_name(const void *p1, const void *p2)
>  	return name_compare(e1->name, e1->len, e2->name, e2->len);
>  }
>  
> +/* check if *out lexically contains *in */
> +static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
> +{
> +	return (out->len < in->len) &&
> +			(out->name[out->len - 1] == '/') &&
> +			!memcmp(out->name, in->name, out->len);
> +}

OK, treat_one_path() and treat_pah_fast() both ensure that a path to
a directory is terminated with '/' before calling dir_add_name() and
dir_add_ignored(), so we know a dir_entry "out" that is a directory
must end with '/'.  Good.

The second and third line being overly indented is a bit
distracting, though.

>  static int treat_leading_path(struct dir_struct *dir,
>  			      const char *path, int len,
>  			      const struct pathspec *pathspec)
> @@ -2067,6 +2075,52 @@ int read_directory(struct dir_struct *dir, const char *path,
>  		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
>  	QSORT(dir->entries, dir->nr, cmp_name);
>  	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
> +
> +	// if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
> +	// up untracked contents of untracked dirs; by default we discard these,
> +	// but given DIR_KEEP_UNTRACKED_CONTENTS we do not

	/*
	 * Our multi-line comments are formatted like this 
	 * example.  No C++/C99 // comments, outside of
	 * borrowed code and platform specific compat/ code,
	 * please.
	 */

> +	if ((dir->flags & DIR_SHOW_IGNORED_TOO)
> +		     && !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {

Both having && at the end and && at the beginning are valid C, but
please stick to one style in a single file.

> +		int i, j, nr_removed = 0;
> +
> +		// remove from dir->entries untracked contents of untracked dirs

	/* And our single-liner comments look like this */

> +		for (i = 0; i < dir->nr; i++) {
> +			if (!dir->entries[i])
> +				continue;
> +
> +			for (j = i + 1; j < dir->nr; j++) {
> +				if (!dir->entries[j])
> +					continue;
> +				if (check_contains(dir->entries[i], dir->entries[j])) {
> +					nr_removed++;
> +					free(dir->entries[j]);
> +					dir->entries[j] = NULL;
> +				}
> +				else {
> +					break;
> +				}
> +			}
> +		}

This loop is O(n^2).  I wonder if we can do better, especially we
know dir->entries[] is sorted already.

Well, because it is sorted, if A/, A/B, and A/B/C are all untracked,
the first round that scans for A/ will nuke both A/B and A/B/C, so
we won't have to scan looking for entries inside A/B, which is a bit
of consolation ;-)

> +			for (i = 0;;) {
> +				while (i < dir->nr && dir->entries[i])
> +					i++;
> +				if (i == dir->nr)
> +					break;
> +				j = i;
> +				while (j < dir->nr && !dir->entries[j])
> +					j++;
> +				if (j == dir->nr)
> +					break;
> +				dir->entries[i] = dir->entries[j];
> +				dir->entries[j] = NULL;
> +			}
> +			dir->nr -= nr_removed;

This looks like an overly complicated way to scan an array and skip
NULLs.  Are you doing an equivalent of this loop, or am I missing
something subtle?

	for (src = dst = 0; src < nr; src++)
		if (array[src])
			array[dst++] = src;
	nr = dst;
