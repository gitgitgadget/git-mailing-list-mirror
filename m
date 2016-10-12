Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5232E215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 20:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934112AbcJLUqU (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 16:46:20 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:21358 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934110AbcJLUqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 16:46:19 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3svQr82cNlz5tlC;
        Wed, 12 Oct 2016 22:46:16 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D19B6519A;
        Wed, 12 Oct 2016 22:46:15 +0200 (CEST)
Subject: Re: [PATCH v3 25/25] sequencer: mark all error messages for
 translation
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
 <cover.1476120229.git.johannes.schindelin@gmx.de>
 <e38bf77ff57d06ca3250bc3ec71a34088b49abd0.1476120229.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d24a3823-1ed0-ad97-f02d-febab7a97590@kdbg.org>
Date:   Wed, 12 Oct 2016 22:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e38bf77ff57d06ca3250bc3ec71a34088b49abd0.1476120229.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.2016 um 19:26 schrieb Johannes Schindelin:
> There was actually only one error message that was not yet marked for
> translation.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 676f16c..86d86ce 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -515,16 +515,19 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  		if (!env) {
>  			const char *gpg_opt = gpg_sign_opt_quoted(opts);
>  
> -			return error("you have staged changes in your working "
> -				"tree. If these changes are meant to be\n"
> -				"squashed into the previous commit, run:\n\n"
> -				"  git commit --amend %s\n\n"
> -				"If they are meant to go into a new commit, "
> -				"run:\n\n"
> -				"  git commit %s\n\n"
> -				"In both cases, once you're done, continue "
> -				"with:\n\n"
> -				"  git rebase --continue\n", gpg_opt, gpg_opt);
> +			return error(_("you have staged changes in your "
> +				       "working tree. If these changes are "
> +				       "meant to be\n"
> +				       "squashed into the previous commit, "
> +				       "run:\n\n"
> +				       "  git commit --amend %s\n\n"
> +				       "If they are meant to go into a new "
> +				       "commit, run:\n\n"
> +				       "  git commit %s\n\n"
> +				       "In both cases, once you're done, "
> +				       "continue with:\n\n"
> +				       "  git rebase --continue\n"),
> +				     gpg_opt, gpg_opt);
>  		}
>  	}
>  
> 

Can we please have the following change instead? I think it makes sense
to deviate from the usual conventions in a case like this.

Note that this is an error() text, hence, there should not be a
fullstop on the first line. That's now a good excuse to start the next
sentence on a new line; hence, this is not a faithful conversion to _()
anymore (a will happily take authorship and all blame if you don't
want to for this reason). Also note that _( is not moved to the
beginning of the line because it would be picked up as hunk header by
git diff.

---- 8< ----
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] sequencer: mark all error messages for translation

There was actually only one error message that was not yet marked for
translation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 sequencer.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 95a382e..79f7aa4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -515,16 +515,20 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-			return error("you have staged changes in your working "
-				"tree. If these changes are meant to be\n"
-				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend %s\n\n"
-				"If they are meant to go into a new commit, "
-				"run:\n\n"
-				"  git commit %s\n\n"
-				"In both cases, once you're done, continue "
-				"with:\n\n"
-				"  git rebase --continue\n", gpg_opt, gpg_opt);
+			return error(_(
+"you have staged changes in your working tree\n"
+"If these changes are meant to be squashed into the previous commit, run:\n"
+"\n"
+"  git commit --amend %s\n"
+"\n"
+"If they are meant to go into a new commit, run:\n"
+"\n"
+"  git commit %s\n"
+"\n"
+"In both cases, once you're done, continue with:\n"
+"\n"
+"  git rebase --continue\n"),
+				     gpg_opt, gpg_opt);
 		}
 	}
 
-- 
2.10.0.343.g37bc62b


