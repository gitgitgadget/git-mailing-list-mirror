Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D1C1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 21:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeKPHna (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 02:43:30 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43633 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPHna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 02:43:30 -0500
Received: by mail-ot1-f44.google.com with SMTP id a11so15756473otr.10
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RBzG/sswxAEPcv9oEADbC9sESfohFo0YFc+Y9pKK4eU=;
        b=wfGYxmrKU9gbhH//jZLw00AkaoB/7Y6YvNxVcHAQyT355W3EwQYxgTaaGaEv3B5ZnM
         BcKsmwug+r/XNnTL5fjgq+VRvt/leaQxKfiMRiobh8sQrlnNUXC9RQKCiZYQRj6FjvJX
         rYbfJieoVHPdzmKEAl9WdutbzlOh56RsznAlVIEqsWxGe8cKw3WdZ9tgyab+jPSo/ekn
         h5of/FQ2n7mtkRqqHIwBKbbjU88AUkxOqI3IBasu5pBJMCzSJtkTOfKYxfNeeQRtLQ9X
         /d5IjZzGFJ1oA+kJwwwxdRuCNDuJUG4yxV/PDUgx207wziY1fRoo3p70VYojIXpU/ZSE
         w3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RBzG/sswxAEPcv9oEADbC9sESfohFo0YFc+Y9pKK4eU=;
        b=XaDmDNH+Bkd4SSRy1oyEZdQoeI0NGaaV+Pj4utElD1WxX13qNT5onby7r/cmfC4Kuj
         5aG1Eigao76nw1SaukZwvVfIFsxE7Zxt0SX7J2gqziTJDKj7A9lrnSQIwRp4xwO6Vpv/
         oy4ZV3kp+nEmIEBVkxtNy/chpGGxNOwUmB1T53DR3NCv1r5UPvBOzPMGvJvJtydXbFWj
         qmOAArpG9Ydq4lcvEW5GsTAJ8cF7kKD6NBybOdQQFpdUjlsEhNioRX2TRucQ2P0uJmaO
         P8LMFz2uHsmJq896b+1+wcbO/ixrSJeciy6YUeVm7dhpjaAOAFdEWg5ltxnjaKoIIRoo
         UWEw==
X-Gm-Message-State: AGRZ1gLlyl6e06BLPm9PU1WQKbDjtcmnYBpTll70MCNQlcwI2rDTHrQ8
        b5KVi7gMa8zE7bAa/rtGpYQHkMe4kF1rmwGCJbjU0cPTya0MBQ==
X-Google-Smtp-Source: AJdET5fmU/GuVX21xn2ILP3RKlj0aTMJqbN21tRRR4Jf0HVw7SMfJEg9MYmTYjhqcB89C4OO+rVzahXSuhDfVsmiUH8=
X-Received: by 2002:a9d:927:: with SMTP id 36mr4949991otp.263.1542317638006;
 Thu, 15 Nov 2018 13:33:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:d182:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 13:33:57
 -0800 (PST)
X-Originating-IP: [2601:647:5180:35d7::13ed]
In-Reply-To: <CAGZ79kYiWnciitwTQCXR5bHOj7nhHWr40xBiS5sPCH5W4_yQ5w@mail.gmail.com>
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
 <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
 <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
 <CAGw6cBth+j+vAjhrQutxBXAkuJrBfHKG4GdCu1jpvAAXOwudEA@mail.gmail.com> <CAGZ79kYiWnciitwTQCXR5bHOj7nhHWr40xBiS5sPCH5W4_yQ5w@mail.gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Thu, 15 Nov 2018 13:33:57 -0800
Message-ID: <CAGw6cBvLGZKcf1em0d47hcCuKau2QVbX4wfb0yN+m4umbNLaRg@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-11-15, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Nov 14, 2018 at 10:05 PM Michael Forney <mforney@mforney.org>
> wrote:
>> Looking at ff6f1f564c, I don't really see anything that might be
>> related to git-add, git-reset, or git-diff, so I'm guessing that this
>> only worked before because the submodule config wasn't getting loaded
>> during `git add` or `git reset`. Now that the config is loaded
>> automatically, submodule.<name>.ignore started taking effect where it
>> shouldn't.
>>
>> Unfortunately, this doesn't really get me much closer to finding a fix.
>
> Maybe selectively unloading or overwriting the config?
>
> Or we can change is_submodule_ignored() in diff.c
> to be only applied selectively whether we are running the
> right command? For this approach we'd have to figure out the
> set of commands to which the ignore config should apply or
> not (and come up with a more concise documentation then)
>
> This approach sounds appealing to me as it would cover
> new commands as well and we'd only have a central point
> where the decision for ignoring is made.

Well, currently the submodule config can be disabled in diff_flags by
setting override_submodule_config=1. However, I'm thinking it may be
simpler to selectively *enable* the submodule config in diff_flags
where it is needed instead of disabling it everywhere else (i.e.
use_submodule_config instead of override_submodule_config).

I'm also starting to see why this is tricky. The only difference that
diff.c:run_diff_files sees between `git add inner` and `git add --all`
is whether the index entry matched the pathspec exactly or not.

Here is a work-in-progress diff that seems to have the correct
behavior in all cases I tried. Can you think of any cases that it
breaks? I'm not quite sure of the consequences of having diff_change
and diff_addremove always ignore the submodule config; git-diff and
git-status still seem to work correctly.

diff --git a/builtin/add.c b/builtin/add.c
index f65c17229..9902f7742 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -117,7 +117,6 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
-	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
diff --git a/diff-lib.c b/diff-lib.c
index 83fce5151..fbb048cca 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -68,12 +68,13 @@ static int check_removed(const struct cache_entry
*ce, struct stat *st)
 static int match_stat_with_submodule(struct diff_options *diffopt,
 				     const struct cache_entry *ce,
 				     struct stat *st, unsigned ce_option,
-				     unsigned *dirty_submodule)
+				     unsigned *dirty_submodule,
+				     int exact)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
+		if (!diffopt->flags.override_submodule_config && !exact)
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
 		if (diffopt->flags.ignore_submodules)
 			changed = 0;
@@ -88,7 +89,7 @@ static int match_stat_with_submodule(struct
diff_options *diffopt,

 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
-	int entries, i;
+	int entries, i, matched;
 	int diff_unmerged_stage = revs->max_count;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
@@ -110,7 +111,8 @@ int run_diff_files(struct rev_info *revs, unsigned
int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;

-		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
+		matched = ce_path_match(istate, ce, &revs->prune_data, NULL);
+		if (!matched)
 			continue;

 		if (ce_stage(ce)) {
@@ -226,7 +228,8 @@ int run_diff_files(struct rev_info *revs, unsigned
int option)
 			}

 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
-							    ce_option, &dirty_submodule);
+							    ce_option, &dirty_submodule,
+							    matched == MATCHED_EXACTLY);
 			newmode = ce_mode_from_stat(ce, st.st_mode);
 		}

@@ -292,7 +295,7 @@ static int get_stat_data(const struct cache_entry *ce,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, 0);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = &null_oid;
diff --git a/diff.c b/diff.c
index e38d1ecaf..73dc75286 100644
--- a/diff.c
+++ b/diff.c
@@ -6209,24 +6209,6 @@ int diff_can_quit_early(struct diff_options *opt)
 		opt->flags.has_changes);
 }

-/*
- * Shall changes to this submodule be ignored?
- *
- * Submodule changes can be configured to be ignored separately for each path,
- * but that configuration can be overridden from the command line.
- */
-static int is_submodule_ignored(const char *path, struct diff_options *options)
-{
-	int ignored = 0;
-	struct diff_flags orig_flags = options->flags;
-	if (!options->flags.override_submodule_config)
-		set_diffopt_flags_from_submodule_config(options, path);
-	if (options->flags.ignore_submodules)
-		ignored = 1;
-	options->flags = orig_flags;
-	return ignored;
-}
-
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const struct object_id *oid,
@@ -6235,7 +6217,7 @@ void diff_addremove(struct diff_options *options,
 {
 	struct diff_filespec *one, *two;

-	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
+	if (S_ISGITLINK(mode) && options->flags.ignore_submodules)
 		return;

 	/* This may look odd, but it is a preparation for
@@ -6285,7 +6267,7 @@ void diff_change(struct diff_options *options,
 	struct diff_filepair *p;

 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
-	    is_submodule_ignored(concatpath, options))
+	    options->flags.ignore_submodules)
 		return;

 	if (options->flags.reverse_diff) {
