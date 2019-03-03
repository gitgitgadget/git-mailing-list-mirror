Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7501E20248
	for <e@80x24.org>; Sun,  3 Mar 2019 19:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCCTUu (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 14:20:50 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:28462
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfCCTUu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Mar 2019 14:20:50 -0500
X-IronPort-AV: E=Sophos;i="5.58,437,1544482800"; 
   d="scan'208";a="297933401"
Received: from zcs-store5.inria.fr ([128.93.142.32])
  by mail3-relais-sop.national.inria.fr with ESMTP; 03 Mar 2019 20:20:46 +0100
Date:   Sun, 3 Mar 2019 20:20:46 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     corentin bompard <corentin.bompard@etu.univ-lyon1.fr>
Cc:     git <git@vger.kernel.org>,
        nathan berbezier <nathan.berbezier@etu.univ-lyon1.fr>,
        pablo chabanne <pablo.chabanne@etu.univ-lyon1.fr>
Message-ID: <1990905128.10960364.1551640846345.JavaMail.zimbra@inria.fr>
In-Reply-To: <ddf8692759de4bc28f8d49dfec939805@BPMBX2013-01.univ-lyon1.fr>
References: <ddf8692759de4bc28f8d49dfec939805@BPMBX2013-01.univ-lyon1.fr>
Subject: Re: [PATCH v2] doc: format pathnames and URLs as monospace
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [91.68.56.209]
X-Mailer: Zimbra 8.7.11_GA_3706 (ZimbraWebClient - FF65 (Linux)/8.7.11_GA_3706)
Thread-Topic: format pathnames and URLs as monospace
Thread-Index: AQHU0d/ZAiGHCVrojk+Hv1N5xbW3hirNOSG/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"corentin bompard" <corentin.bompard@etu.univ-lyon1.fr> wrote:

> Updating the documentation to use monospace on URLs and pathnames because it
> makes more sense

We usually write commit message with an imperative tone, eg. "Update
documentation", not "Updating documentation". Also, the period (.) is
missing at the end of the sentence and the message is not wrapped at
72 characters (your text editor probably can do that for you; with
Emacs it's M-q or M-x auto-fill-mode RET).

But more importantly, "makes more sense" is the question here, not an
answer. The commit message is precisely here to justify why the code
after the patch makes more sense than before, and you can't argue "it
makes more sense because it makes more sense".

Among the arguments:

* It is already an established practice. For example:

  $ git grep "'[^' ]*/[^' ]*'" | wc -l
  204
  $ git grep '`[^` ]*/[^` ]*`' | wc -l
  576
  
  There are false on both sides, but after a cursory look at the
  output of both, I don't think the false positive rate is really
  higher in the second case.

  At least, this shows that the existing documentation uses inconsistent
  formatting, and that it would be good to do something about it.

* It may be debatable whether path names need to be typed in
  monospace (I wouldn't be shocked if they were using the normal
  font), but having them in italics is really unusual.

In addition to doing the actual change, you probably want to add a
mention of the rule followed in Documentation/CodingGuideline.

The patch itself looks good, except the error noted by Eric Sunshine
and:

> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -48,7 +48,7 @@ rewriting published history.)
> 
> Always verify that the rewritten version is correct: The original refs,
> if different from the rewritten ones, will be stored in the namespace
> -'refs/original/'.
> +`refs/original/`.
> 
> Note that since this operation is very I/O expensive, it might
> be a good idea to redirect the temporary directory off-disk with the
[...]
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 023ca95e7..9848d0d84 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -524,7 +524,7 @@ The most notable example is `HEAD`.
> [[def_remote_tracking_branch]]remote-tracking branch::
> 	A <<def_ref,ref>> that is used to follow changes from another
> 	<<def_repository,repository>>. It typically looks like
> -	'refs/remotes/foo/bar' (indicating that it tracks a branch named
> +	`refs/remotes/foo/bar` (indicating that it tracks a branch named
> 	'bar' in a remote named 'foo'), and matches the right-hand-side of
> 	a configured fetch <<def_refspec,refspec>>. A remote-tracking
> 	branch should not contain direct modifications or have local
> @@ -654,7 +654,7 @@ The most notable example is `HEAD`.
> 	The default <<def_branch,branch>> that is merged into the branch in
> 	question (or the branch in question is rebased onto). It is configured
> 	via branch.<name>.remote and branch.<name>.merge. If the upstream branch
> -	of 'A' is 'origin/B' sometimes we say "'A' is tracking 'origin/B'".
> +	of 'A' is `origin/B` sometimes we say "'A' is tracking `origin/B`".
> 
> [[def_working_tree]]working tree::
> 	The tree of actual checked out files.  The working tree normally
[...]
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 72daa20e7..92b1d5638 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -23,27 +23,27 @@ characters and to avoid word splitting.
>   followed by a dash and a number of commits, followed by a dash, a
>   'g', and an abbreviated object name.
> 
> -'<refname>', e.g. 'master', 'heads/master', 'refs/heads/master'::
> +'<refname>', e.g. 'master', `heads/master`, `refs/heads/master`::

These are refnames, and you said you excluded them from the patch.

-- 
Matthieu Moy
https://matthieu-moy.fr/
