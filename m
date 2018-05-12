Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8811F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeELIEm (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:04:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50497 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeELIEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:04:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id t11-v6so5832898wmt.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iV4zjFw/MZlKdPyqzs2+MVPEeaNiaqSrOPacKroq0Oc=;
        b=FkeYxSVOE0DpkameWUcWScq1xXgffB1iABxIpQjUZ8KZLxYjXGp7ipXeQq1ow47JVU
         NEnj+bYi9lbhsEkfca/TjS7GG6aUNjBJpAFQoM/1xBl0Fj1MZ3VY+9rygwXNPIC4I2Ra
         C066UdCX4QXzptc8KxwWpopRkvhAMR7JniQM3z47SH196zFSf2zet0hwDT8ZOZtPIX+C
         KbVUZ09hMQ9D/5wb6yYHf0qMZKdsIsTWBYaONxX3ofNFRz+E0VtLcl55AK+wADAqfiIV
         G8YNKYcuInTZ0BxXNRa3X99nDifOUvS2iCF9wVPJ0vk5NsVeT+X1099YVWOod4pH3ves
         +Svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iV4zjFw/MZlKdPyqzs2+MVPEeaNiaqSrOPacKroq0Oc=;
        b=p5+9lQQH3OmMwSGFtE6Ly12mE07e/ELfj5YcrxwBfJr9XEZ1OT1QPxBmeLUTm3dfV7
         M8Ie1c6+88vtwB+ACJ6VpZzHGqIuFfheFqV5LEBwe8MNInFGOU4nS7rv7iuh6En/acWq
         54CFJRjPPRl1lCW5LTKe/uIOHoRb8lWd3awKYgpIIf0rISn4RpK8FIvgwAH7AjQArTkP
         HHF47Q+5CbQxxxsxUeoLvNVh/QxA3mBLqmsDpkUf16LEUkUt6rNZhB4clfMSo9vi1/BZ
         4U8Hnhw2ZqINxqGNzY92jpYuhxDpJV7QnLidfMms1rh+vL9apP910UmqkUvt10xPQW2q
         pvSQ==
X-Gm-Message-State: ALKqPwdlkC8QkBgsS/EGK5M6pCHqZd8mRj+APmd9GKUfFN8DIIol2R2Z
        qmVHGhGPhjAZfNOHZaIFItM=
X-Google-Smtp-Source: AB8JxZoIywh0jDoUQTqgOpUk0cKCo4F+WeAm3ADpuwEytxR64MOpej8hcUgTSZubIzL6D1/CtVGfPA==
X-Received: by 2002:a50:9164:: with SMTP id f33-v6mr2287949eda.29.1526112279779;
        Sat, 12 May 2018 01:04:39 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2489603edr.89.2018.05.12.01.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:04:39 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Sat, 12 May 2018 10:04:37 +0200
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com" <newren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v3] add status config and command line options for rename
 detection
Message-ID: <20180512080437.GA16679@esm>
References: <20180509144213.18032-1-benpeart@microsoft.com>
 <20180511125623.6068-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511125623.6068-1-benpeart@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 12:56:39PM +0000, Ben Peart wrote:
> After performing a merge that has conflicts git status will, by default,
> attempt to detect renames which causes many objects to be examined.  In a
> virtualized repo, those objects do not exist locally so the rename logic
> triggers them to be fetched from the server. This results in the status call
> taking hours to complete on very large repos vs seconds with this patch.

I see where your need comes from, but as you based this on my little
patch one can achieve this already with tweaking diff.renames itself. I
do wonder why there is a special need for the status command here. And
if there is, I personally would like it more in a style that you could
take all the options provided by diff.*-configuration and prefix that
with status, eg status.diff.renames = true. What do you think? If you
really only need this for merges, maybe a more specialised option is
called for that only kicks in when there is a merge going on?

I would like that status behaves as similar as possible to
diff/show/log. Special options will pull away from that again - passing
-m to show or log will lead to the same performance issues, correct?
Could it be feasible to impose an overall time limit on the detection?

And after writing this I wonder what were your experience with just
tweaking renameLimit - setting it very low should have helped the
fetching from server part already, shouldn't it?

> Add --no-renames command line option to status that enables overriding the
> config setting from the command line. Add --find-renames[=<n>] command line
> option to status that enables detecting renames and optionally setting the
> similarity index.

Would it be reasonable to extend this so that we just use the same
machinery for parsing command line options for the diffcore options and
pass this along? It seems to me that git status wants the same init as
diff/show/log has anyway. But I like the direction towards passing more
command line options to the git status command. 

>  static void wt_longstatus_print_unmerged_header(struct wt_status *s)
> @@ -592,6 +595,9 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
>  	}
>  	rev.diffopt.format_callback = wt_status_collect_changed_cb;
>  	rev.diffopt.format_callback_data = s;
> +	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
> +	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
> +	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
>  	copy_pathspec(&rev.prune_data, &s->pathspec);
>  	run_diff_files(&rev, 0);
>  }
> @@ -625,6 +631,9 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>  	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = wt_status_collect_updated_cb;
>  	rev.diffopt.format_callback_data = s;
> +	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
> +	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
> +	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
>  	copy_pathspec(&rev.prune_data, &s->pathspec);
>  	run_diff_index(&rev, 1);
>  }
> @@ -982,6 +991,9 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>  	setup_revisions(0, NULL, &rev, &opt);
>  
>  	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
> +	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
> +	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
> +	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
>  	rev.diffopt.file = s->fp;
>  	rev.diffopt.close_file = 0;
>  	/*

Somehow I am inclined that those should be factored out to a common
method if the rest of the patch stays as it is.

Greetings,
Eckhard
