Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30D520281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964832AbdKBUZh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:25:37 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:46642 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934408AbdKBUZg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:25:36 -0400
Received: by mail-yw0-f173.google.com with SMTP id t71so686831ywc.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LdmPCtLnJrpezJu3xSvzC++NCzg0hZ/38EeWOnQ6wlg=;
        b=uFP6JZRezOjMrQm0at+24iinKlNfxn0krj7ug1AYZmYL8qt20zZ3ke/mV9T55EMNoU
         hJmyc6CjxFaBg3uxb8XoVGBEuzGTDTg/TkspkCtOYZ3AXUx1j2C+oDGnCQJNjzVMJDzw
         9x97ugqXpVBhQDv3WzKx6A0hqjT/5OV++z0/tSp04eU3exZk6hwx9wkKojzqP37tNNAy
         iT2ALHAy7RjWcSGJLjbmUZhGrCXb25KrUFWkAJhko+kaBcbIq0YFVbSnjsJT3yJtBCLV
         UXykfXFQ3yd+igcUyZm1Q1DNbtstMUcRH+93w7J5MJvrC2pfeuma5XNOTvuqRR1cEp8o
         BqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LdmPCtLnJrpezJu3xSvzC++NCzg0hZ/38EeWOnQ6wlg=;
        b=CEU8W5KhuSIi+Q3LXxLY09t0NNlRHjWsp76JOzil12NAz0DHl/8R6fooO3qapjJpre
         41BDTC9NHBiX5YnX74PlTQxACyDb2jsk5qKI/jOXILo3Mg2gDIsS2uH08neZ1qJXWPB/
         RoNFMOVN31Ejj9wPAenmIHx/oN6/U6eH5zCY1jAjSz2WT7otXQ5xTvvvVRHqUTW/63FB
         cX4b3cI3To3U5nLuyo/jj7MLsIozpD+fB26edb+7jsTykQBizDQV37bzYIu3t9QOo7+v
         H7ryxN6lnVls5TZhGEI7+rukZqV/tFJPYdY7f0ydmb5NAdOuMVbKZPSVeXO8EryIVhkx
         CxNg==
X-Gm-Message-State: AMCzsaVrjTSAeqkYWjoRyg6KsT+IQYxJqYdU2lQ5Koqm7U5wvMFXf4r/
        EifIy4wr+im99vB47Ak6ZubFpXPXfzxxA1fxtMM=
X-Google-Smtp-Source: ABhQp+Ta3T/eCB269FqGndd1u3CwnX/lZPHBn9NXLoxAohBvRNuo5mVNGoykNl0ctulnwVjFqH0hqg7+HngZyQMyAfU=
X-Received: by 10.37.179.40 with SMTP id l40mr3209727ybj.487.1509654335687;
 Thu, 02 Nov 2017 13:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.65.194 with HTTP; Thu, 2 Nov 2017 13:25:15 -0700 (PDT)
In-Reply-To: <CAGZ79kZHapHLXDM-iU9T_BU5qoYAAAS+yKWLVvfUhxMmp+6mxg@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
 <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
 <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com>
 <CAFA_24K99LkeJBKV7+a-m-m9PUZik49cOd40+cEn-6zCvGmMsQ@mail.gmail.com> <CAGZ79kZHapHLXDM-iU9T_BU5qoYAAAS+yKWLVvfUhxMmp+6mxg@mail.gmail.com>
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Thu, 2 Nov 2017 16:25:15 -0400
X-Google-Sender-Auth: QtKUmckbpEUJy02t10wrmsKl8WI
Message-ID: <CAFA_24JXc=qJw1-_aJJUMPhW9DaBofxSb6hkVD6n4MWyeT5UOQ@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No problem! Let me know if I've done something wrong with this patch,
I'm new to git's contributor process.

completion: add missing completions for log, diff, show

* Add bash completion for the missing --no-* options on git log
* Add bash completion for --textconv and --indent-heuristic families to
  git diff and all commands that use diff's options
* Add bash completion for --no-abbrev-commit, --expand-tabs, and
  --no-expand-tabs to git show
---
 contrib/completion/git-completion.bash | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 0e16f017a4144..252a6c8c0c80c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1412,6 +1412,8 @@ __git_diff_common_options="--stat --numstat
--shortstat --summary
                        --dirstat-by-file= --cumulative
                        --diff-algorithm=
                        --submodule --submodule=
+                       --indent-heuristic --no-indent-heuristic
+                       --textconv --no-textconv
 "

 _git_diff ()
@@ -1752,6 +1754,10 @@ _git_log ()
                __gitcomp "$__git_diff_submodule_formats" ""
"${cur##--submodule=}"
                return
                ;;
+       --no-walk=*)
+               __gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
+               return
+               ;;
        --*)
                __gitcomp "
                        $__git_log_common_options
@@ -1759,16 +1765,19 @@ _git_log ()
                        $__git_log_gitk_options
                        --root --topo-order --date-order --reverse
                        --follow --full-diff
-                       --abbrev-commit --abbrev=
+                       --abbrev-commit --no-abbrev-commit --abbrev=
                        --relative-date --date=
                        --pretty= --format= --oneline
                        --show-signature
                        --cherry-mark
                        --cherry-pick
                        --graph
-                       --decorate --decorate=
+                       --decorate --decorate= --no-decorate
                        --walk-reflogs
+                       --no-walk --no-walk= --do-walk
                        --parents --children
+                       --expand-tabs --expand-tabs= --no-expand-tabs
+                       --patch
                        $merge
                        $__git_diff_common_options
                        --pickaxe-all --pickaxe-regex
@@ -2816,8 +2825,9 @@ _git_show ()
                return
                ;;
        --*)
-               __gitcomp "--pretty= --format= --abbrev-commit --oneline
-                       --show-signature
+               __gitcomp "--pretty= --format= --abbrev-commit
--no-abbrev-commit
+                       --oneline --show-signature --patch
+                       --expand-tabs --expand-tabs= --no-expand-tabs
                        $__git_diff_common_options
                        "
                return

On Tue, Oct 24, 2017 at 11:32 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Oct 24, 2017 at 8:15 AM, Max Rothman <max.r.rothman@gmail.com> wrote:
>> Just re-discovered this in my inbox. So is this worth fixing? I could
>> (probably) figure out a patch.
>>
>> Thanks,
>> Max
>>
>
> $ git log -- <TAB>
> Display all 100 possibilities? (y or n)
>
> I guess adding one more option is no big deal, so go for it!
> We also have a couple --no-options already (as you said earlier),
> which I think makes it even more viable.
>
> Tangent:
> I wonder if we can cascade the completion by common
> prefixes, e.g. --no- or --ignore- occurs a couple of times,
> such that we could only show these --no- once and only
> if you try autocompleting thereafter you get all --no- options.
>
> Thanks for reviving this thread!
> Stefan
