Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A5920248
	for <e@80x24.org>; Tue, 16 Apr 2019 12:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfDPMjt (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 08:39:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfDPMjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 08:39:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so26871820wrp.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jxgHTC35I3bgzeBQSbQ9flxWjdFeL44UBmhyEXTulHc=;
        b=BpLHz4snGksZO9KO5ayAAN0X+qUd7JBrXHy7qvHFo7zzQZg93InETfhB3YeREmh9cQ
         qW1RSpmFF0r20O81ZjbexTiZlrZjMXJ2gaC08S8T/UuSOAqGDvNAxfGqc27OzgPGgvXE
         jRpjagxeTvmBqK/E/TNWY6NgIAmJcpTZDHvV3/PYbby70yzhZ6vytFQs8EV4aXVxwl0S
         5R/ctote5NbL/yHDWzI0aH77yKBVj/WUhj+hk8BplUg7Jqko2oTb8OvaeQQU3jTdw5UF
         g3pkNCqrOS36MAXIudoS06cfQCMWnwsbeUblJEqfx1q58iJ8yOIMmWOrhzj1ya9TewM1
         iRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jxgHTC35I3bgzeBQSbQ9flxWjdFeL44UBmhyEXTulHc=;
        b=c6GH8WIaVV6Ni5xY85XNdJL9nnR8HF+Chd/XDtwecB/DC2JPzzHYNUuEHJWqLEK1Us
         gRwGoTInDcb+DHPw6gwxpTNkRVXAaSH4cHQVIQ4vfZLXSvBIPvOyj0aBVqs7ueLzuS54
         t/S5TVbUQ5DbLf2Y3VjEtP9kO5QWasThpfAdgAxAeEi3ilV8YYapJM81GvooH4+/NT8U
         Zqz+7jttbjSWF1Mz3qBLFNKHpJ+64kaP7I4Vxu9n7tPOW2Bt6YZHwpkjWWuttsV191Ke
         d8CNTs5V5Mv/4HvRs8Qj6l2hsemQwV7Q+BmKWCAoGyPyxKB2QS6yah+uNL4KA10gSR1/
         kmBQ==
X-Gm-Message-State: APjAAAWP+Gh1uqP/06ED5hU3Qlj8ESYXlA4Kb0OYVNNDwKnTPKXVw71x
        PcyOOy0LWzQqx7kwTkBIByI=
X-Google-Smtp-Source: APXvYqxJKqxlsuPNoz8HZpOtjPEIXVzFbbtK6AWVsgY8I7B9wfAkZFdMUrklbdbXHiyQ1OFKPGaJQQ==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr4069170wrx.201.1555418386581;
        Tue, 16 Apr 2019 05:39:46 -0700 (PDT)
Received: from mithrim ([147.210.21.27])
        by smtp.gmail.com with ESMTPSA id b134sm36697027wmd.26.2019.04.16.05.39.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Apr 2019 05:39:45 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:39:45 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/1] Fix %(push:track) in ref-filter
Message-ID: <20190416123944.vtoremaitywtmkhj@mithrim>
References: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
 <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
 <20190415220108.GD28128@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415220108.GD28128@sigill.intra.peff.net>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 16 Apr 2019 14:28:41 +0200
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Mon 15 Apr 2019 at 18:01:08 (-0400) :
> > +		if ((atom->u.remote_ref.push ?
> > +		     stat_push_info(branch, &num_ours, &num_theirs,
> > +				    NULL, AHEAD_BEHIND_FULL) :
> > +		     stat_tracking_info(branch, &num_ours, &num_theirs,
> > +					NULL, AHEAD_BEHIND_FULL)) < 0) {

> I'm a big fan of the "?" operator, but this ternary-within-an-if might
> be pushing even my boundaries of taste. :)

I knew I was pushing the limit of readability a bit here :)

> All that said, we would need to do the exact same conditional for
> ":trackshort", wouldn't we?

Crap, you are right, I wanted to handle this case too but forgot :-(

> The tests don't pick it up because the
> symbol is still ">" for both branches (deja vu!). So it might be worth
> not just having push be 2 ahead, but have it actually be behind instead
> (or in addition to).

Done in the new version.

> Or perhaps it argues for just giving access to the more generic stat_*
> function, and letting callers pass in a flag for push vs upstream (and
> either leaving stat_tracking_info() as a wrapper, or just updating its
> few callers).

So I went ahead with modifying `stat_tracking_info` to accept a 'for_push'
flag, and updated the few callers. This means that `stat_compare_info` is
only used by `stat_tracking_info` so I could reinline it, but I guess it
could still be useful latter.

> 
> > -int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
> > -		       const char **upstream_name, enum ahead_behind_flags abf)
> > +
> > +int stat_compare_info(const char **branch_name, const char **base,
> > +		      int *num_ours, int *num_theirs,
> > +		      enum ahead_behind_flags abf)
> 
> In the original, we need a pointer-to-pointer for upstream_name, because
> we return the string as an out-parameter. But here we're just taking two
> strings as input. We can drop the extra layer of indirection, like the
> patch below.

Good catch, done.

> Also, since this is an internal helper function for the file, we should
> mark it as static.

Yes. In fact in the first version of the patch I would call
`stat_compare_info` directly in `ref_filter.c` so I needed to export it in
`remote.h`, and then when I changed the patch I forgot to make it static.

> Other than that, the patch looked quite reasonable. I didn't dig too far
> into the ripple effects of the test changes, since I think we'll end up
> changing them again to make sure ":trackshort" is distinct.

There are now less impactful than before because the master branch in the
test refers to the same commit as before; there is just a new commit for the
'myfork' remote branch.

> Thanks for working on this.

You are welcome. What's the standard way to acknowledge your help in
the Foo-By: trailers? I did not put a Reviewed-By: because you reviewed the
previous patch, not the current one :)

-- 
Damien Robert
http://www.normalesup.org/~robert/pro

---- >8 -----
From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date: Tue, 16 Apr 2019 14:16:46 +0200
Subject: [v2 PATCH 1/1] Fix %(push:track) in ref-filter

In ref-filter.c, when processing the atom %(push:track), the
ahead/behind values are computed using `stat_tracking_info` which refers
to the upstream branch.

Fix that by introducing a new flag `for_push` in `stat_tracking_info`
in remote.c, which does the same thing but for the push branch.
Update the few callers of `stat_tracking_info` to handle this flag. This
ensure that whenever we use this function in the future, we are careful
to specify is this should apply to the upstream or the push branch.

This bug was not detected in t/t6300-for-each-ref.sh because in the test
for push:track, both the upstream and the push branches were behind by 1
from the local branch. Change the test so that the upstream branch is
behind by 1 while the push branch is ahead by 1. This allows us to test
that %(push:track) refer to the correct branch.

This change the expected value of some following tests (by introducing
new references), so update them too.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 ref-filter.c            |  6 ++--
 remote.c                | 68 ++++++++++++++++++++++++++++-------------
 remote.h                |  3 +-
 t/t6300-for-each-ref.sh | 14 +++++++--
 wt-status.c             |  4 +--
 5 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3aca105307..31af81fb28 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1392,7 +1392,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
-				       NULL, AHEAD_BEHIND_FULL) < 0) {
+				       NULL, atom->u.remote_ref.push,
+				       AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = xstrdup("");
@@ -1410,7 +1411,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
-				       NULL, AHEAD_BEHIND_FULL) < 0) {
+				       NULL, atom->u.remote_ref.push,
+				       AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup("");
 			return;
 		}
diff --git a/remote.c b/remote.c
index 9cc3b07d21..e98c6f2a0a 100644
--- a/remote.c
+++ b/remote.c
@@ -1880,37 +1880,27 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 }
 
 /*
- * Lookup the upstream branch for the given branch and if present, optionally
- * compute the commit ahead/behind values for the pair.
+ * Compute the commit ahead/behind values for the pair branch_name, base.
  *
  * If abf is AHEAD_BEHIND_FULL, compute the full ahead/behind and return the
  * counts in *num_ours and *num_theirs.  If abf is AHEAD_BEHIND_QUICK, skip
  * the (potentially expensive) a/b computation (*num_ours and *num_theirs are
  * set to zero).
  *
- * The name of the upstream branch (or NULL if no upstream is defined) is
- * returned via *upstream_name, if it is not itself NULL.
- *
- * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
- * upstream defined, or ref does not exist).  Returns 0 if the commits are
- * identical.  Returns 1 if commits are different.
+ * Returns -1 if num_ours and num_theirs could not be filled in (e.g., ref
+ * does not exist).  Returns 0 if the commits are identical.  Returns 1 if
+ * commits are different.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name, enum ahead_behind_flags abf)
+
+static int stat_compare_info(const char *branch_name, const char *base,
+			     int *num_ours, int *num_theirs,
+			     enum ahead_behind_flags abf)
 {
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
-	const char *base;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	/* Cannot stat unless we are marked to build on top of somebody else. */
-	base = branch_get_upstream(branch, NULL);
-	if (upstream_name)
-		*upstream_name = base;
-	if (!base)
-		return -1;
-
 	/* Cannot stat if what we used to build on no longer exists */
 	if (read_ref(base, &oid))
 		return -1;
@@ -1918,7 +1908,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (!theirs)
 		return -1;
 
-	if (read_ref(branch->refname, &oid))
+	if (read_ref(branch_name, &oid))
 		return -1;
 	ours = lookup_commit_reference(the_repository, &oid);
 	if (!ours)
@@ -1932,7 +1922,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (abf == AHEAD_BEHIND_QUICK)
 		return 1;
 	if (abf != AHEAD_BEHIND_FULL)
-		BUG("stat_tracking_info: invalid abf '%d'", abf);
+		BUG("stat_compare_info: invalid abf '%d'", abf);
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	argv_array_push(&argv, ""); /* ignored */
@@ -1966,6 +1956,42 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return 1;
 }
 
+/*
+ * Lookup the upstream branch for the given branch and if present, optionally
+ * compute the commit ahead/behind values for the pair.
+ *
+ * If abf is AHEAD_BEHIND_FULL, compute the full ahead/behind and return the
+ * counts in *num_ours and *num_theirs.  If abf is AHEAD_BEHIND_QUICK, skip
+ * the (potentially expensive) a/b computation (*num_ours and *num_theirs are
+ * set to zero).
+ *
+ * The name of the upstream branch (or NULL if no upstream is defined) is
+ * returned via *upstream_name, if it is not itself NULL.
+ *
+ * If for_push is true, then return the stats and name of the push branch
+ * rather than the upstream branch.
+ *
+ * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
+ * upstream defined, or ref does not exist).  Returns 0 if the commits are
+ * identical.  Returns 1 if commits are different.
+ */
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
+		       const char **upstream_name, int for_push,
+		       enum ahead_behind_flags abf)
+{
+	const char *base;
+
+	/* Cannot stat unless we are marked to build on top of somebody else. */
+	base = for_push ? branch_get_push(branch, NULL) :
+		branch_get_upstream(branch, NULL);
+	if (upstream_name)
+		*upstream_name = base;
+	if (!base)
+		return -1;
+
+	return stat_compare_info(branch->refname, base, num_ours, num_theirs, abf);
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -1977,7 +2003,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	char *base;
 	int upstream_is_gone = 0;
 
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, abf);
+	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
 		if (!full_base)
 			return 0;
diff --git a/remote.h b/remote.h
index da53ad570b..0138b3fb98 100644
--- a/remote.h
+++ b/remote.h
@@ -253,7 +253,8 @@ enum ahead_behind_flags {
 
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name, enum ahead_behind_flags abf);
+		       const char **upstream_name, int for_push,
+		       enum ahead_behind_flags abf);
 int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf);
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0ffd630713..836c985744 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -392,8 +392,15 @@ test_atom head upstream:track '[ahead 1]'
 test_atom head upstream:trackshort '>'
 test_atom head upstream:track,nobracket 'ahead 1'
 test_atom head upstream:nobracket,track 'ahead 1'
-test_atom head push:track '[ahead 1]'
-test_atom head push:trackshort '>'
+
+test_expect_success 'setup for push:track[short]' '
+	test_commit third &&
+	git update-ref refs/remotes/myfork/master master &&
+	git reset master~1
+'
+
+test_atom head push:track '[behind 1]'
+test_atom head push:trackshort '<'
 
 test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 	test_must_fail git for-each-ref --format="%(refname:track)" 2>/dev/null &&
@@ -420,8 +427,10 @@ test_expect_success 'Check for invalid refname format' '
 test_expect_success 'set up color tests' '
 	cat >expected.color <<-EOF &&
 	$(git rev-parse --short refs/heads/master) <GREEN>master<RESET>
+	$(git rev-parse --short refs/remotes/myfork/master) <GREEN>myfork/master<RESET>
 	$(git rev-parse --short refs/remotes/origin/master) <GREEN>origin/master<RESET>
 	$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
+	$(git rev-parse --short refs/tags/third) <GREEN>third<RESET>
 	$(git rev-parse --short refs/tags/two) <GREEN>two<RESET>
 	EOF
 	sed "s/<[^>]*>//g" <expected.color >expected.bare &&
@@ -594,6 +603,7 @@ $(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
 $(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
 EOF
 
+
 test_expect_success 'Verify sort with multiple keys' '
 	git for-each-ref --format="%(objectname) %(taggeremail) %(refname)" --sort=objectname --sort=taggeremail \
 		refs/tags/bogo refs/tags/master > actual &&
diff --git a/wt-status.c b/wt-status.c
index 445a36204a..5a7ec2cf99 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1851,7 +1851,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
 	sti = stat_tracking_info(branch, &num_ours, &num_theirs, &base,
-				 s->ahead_behind_flags);
+				 0, s->ahead_behind_flags);
 	if (sti < 0) {
 		if (!base)
 			goto conclude;
@@ -1990,7 +1990,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		branch = branch_get(branch_name);
 		base = NULL;
 		ab_info = stat_tracking_info(branch, &nr_ahead, &nr_behind,
-					     &base, s->ahead_behind_flags);
+					     &base, 0, s->ahead_behind_flags);
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
-- 
Patched on top of v2.21.0-313-ge35b8cb8e2 (git version 2.21.0)

