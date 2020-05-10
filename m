Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69AEC38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B116720801
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oitOOWwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgEJQM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 12:12:26 -0400
Received: from mout.web.de ([212.227.15.4]:51001 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbgEJQM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 12:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589127137;
        bh=DgcG5MO5qU5MZtrYnwdBWk4krUKnBxhtpGpbmvY1RWI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=oitOOWwAGfCanfzHsBuhNmlkcKz8CG7NCuu8ypwcRNwOKXq+XsLOc8UmRoZcu6mqU
         qSF9sU6JhROFYd+C970i/bcKRnWXd7mAynbfOyjE1GTrfAh3PDbeYvBQEleh1jSYUs
         D7xMj3fd8UhNQbNzwuruleKAp2Wxeyog3EK/4400=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdVty-1iqT3L2lve-00inXs; Sun, 10
 May 2020 18:12:17 +0200
Subject: Re: invalid tree and commit object
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
Message-ID: <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
Date:   Sun, 10 May 2020 18:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BVO3UaBl+GwWYnowV/Qw8v6iN3YkSL4sdnj36VOWBdSbe0d5OKZ
 liSQhBNybe9U28rHg+o40F6hkApT4BGIt+LPvHqUlFmbPC29Xu1R2CO/et0upttR14lxzux
 bLuirQ+B4lfO28x2otTwlVPIuZfZHhvcbt63Cd1CHyOpptwrJquokdtnF0z1L77jpapWSE3
 yxfedJAGmsvEOq/siXxVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vt0SWOT6TFk=:71iDT8DVmzX7DyMdHBaYXJ
 foyNEwKm+vfSaNnSPlb2Vb37nvFIJ4tjSzgGz84xxSyi51RDXhy79R2h8xYZYAXB+hhHW/eAq
 TIuLOJs17+1MxWu+0jojzIhkJ7PNkJClzYQupjzl0ZVgvH1HMpJqkPxkGiVS+V+6ZinBtvawV
 xTHt45wHqAALWsPXA+0Y1JnTU4yFD7SaYBoRkdipQ1eb1IbtGF9AnV44WccMtUAGPqROko/Wj
 f5QQBp7qM40TgO1xyy35GCW3CWToQwK4XVSVCc8yLxhmG0QVhR/LfGgBnQCxOP9f0ETuaCRrg
 zQkRhTedoZg3bk2uZzhH0N/gf+8uGMecpRebWEcupw6Z7hSc/Pcv7QJTJdK/wa6f0vPy3Mcm6
 QhKLR8qFybjvA4ZqcQu6rSUYszxDbYA+jI4N24aydbLPLWDXcyTK0SIcYrc6phfdeoKEWSlTU
 WFPk5xXBE2Ojp1pvj2y9c+favRCyTvPNincWfV72ODw8rzlH1rVA07ehS1dlpdq22GF0CJpPU
 ggN1EQfQwaVL1IRz+XLg+idhgdjpqpr/WGoo1SuXfSdEUTafEVVqEI/QWZSp2PXHtm086IiSI
 g0jIOoeBHHXqd/WmKP1DL47A2eEadzMffnFc8prw0/KzJNH5Zj6eb7smPgiTRxmBOrie2dDI1
 6dVMfkznu/HqnqZC/x3MTKrgLQLwG3Nn/8Drkdwk2XIEfPhpf41fZkKTCo7r/8IKW7bPhVXKn
 8Wu9hv0xnUqCyAPgvJGDnWEptmsqJ3fjwLLSSZYZcmBMEuO2hmACmvY6YxxSuTHBS9mJC3ROm
 HEtH2m1y6PsMWl2OOnp9/JtgHT0snApZmbFxYDpRffPH5/ruWrfMUqz6jyJ/Stxxx4ZChp7Cx
 cXD6LLvVxt339Bdk+rh3AKhSKYeZTNp8jTpeBCfKNsfqAQyZ8a77yiAWlTmnvPiyjCTPzexjp
 YxRrdxGP/YMVJAVC7wK1ZTiQCFH3zCDY8GJiMqExQxnVPg7+GX1GR37icPOnDknkNTvlZ5Ajs
 fQec6ux2SJy9TjPo0Ps1C3X4HzME1goWylpZqqH58XaMZTnJdOG/SclZ00D9JjiagdOnzTuPf
 1UC3BeFApB/64ES1AI865fa8kw/O3oQhyrI1iPsOjhREvj+MAy8B5Bsz4PIulKXVQ3HKCZ174
 VIbMq3Km93a32vtc6XZqo6bEHn4VIctw8ZqWCs0tqs/F4jY3uIzbQwaRkQsAEH84sUXPI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.05.20 um 11:07 schrieb Ren=C3=A9 Scharfe:
> Would a stack work?  When we see a candidate non-directory, we put
> it on the stack.  When we see a candidate directory, we compare it
> to the entry at the top of the stack using strcmp().  Equality
> indicates a duplicate and we are done.  If the directory name is
> less then we can pop the entry from the stack and check again, as
> we're past the point where a duplicate would be.  Makes sense?
>
> The candidate stack solution would have linear complexity and
> require less memory than a full list of candidates.
>
> It would rely on the entries to be in the correct order (same as
> the patch below, come to think of it), but that's probably OK.
> We may miss DUPLICATE_ENTRIES (just like today :), but
> TREE_NOT_SORTED would still be reported.

Here's what I mean.  It seems to work, but could use some critical
thought and testing.

=2D- >8 --
Subject: [PATCH] fsck: report non-consecutive duplicate names in trees

Tree entries are sorted in path order, meaning that directory names get
a slash ('/') appended implicitly.  Git fsck checks if trees contains
consecutive duplicates, but due to that ordering there can be
non-consecutive duplicates as well if one of them is a directory and the
other one isn't.  Such a tree cannot be fully checked out.

Find these duplicates by recording candidate file names on a stack and
check candidate directory names against that stack to find matches.

Suggested-by: Brandon Williams <bwilliamseng@gmail.com>
Original-test-by: Brandon Williams <bwilliamseng@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 fsck.c          | 72 +++++++++++++++++++++++++++++++++++++++++++++++--
 t/t1450-fsck.sh | 16 +++++++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 087a7f1ffc..8bb3ecf282 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -523,6 +523,28 @@ int fsck_walk(struct object *obj, void *data, struct =
fsck_options *options)
 	}
 }

+struct name_stack {
+	const char **names;
+	size_t nr, alloc;
+};
+
+static void name_stack_push(struct name_stack *stack, const char *name)
+{
+	ALLOC_GROW(stack->names, stack->nr + 1, stack->alloc);
+	stack->names[stack->nr++] =3D name;
+}
+
+static const char *name_stack_pop(struct name_stack *stack)
+{
+	return stack->nr ? stack->names[--stack->nr] : NULL;
+}
+
+static void name_stack_clear(struct name_stack *stack)
+{
+	FREE_AND_NULL(stack->names);
+	stack->nr =3D stack->alloc =3D 0;
+}
+
 /*
  * The entries in a tree are ordered in the _path_ order,
  * which means that a directory entry is ordered by adding
@@ -534,7 +556,14 @@ int fsck_walk(struct object *obj, void *data, struct =
fsck_options *options)
 #define TREE_UNORDERED (-1)
 #define TREE_HAS_DUPS  (-2)

-static int verify_ordered(unsigned mode1, const char *name1, unsigned mod=
e2, const char *name2)
+static int is_less_than_slash(unsigned char c)
+{
+	return '\0' < c && c < '/';
+}
+
+static int verify_ordered(unsigned mode1, const char *name1,
+			  unsigned mode2, const char *name2,
+			  struct name_stack *candidates)
 {
 	int len1 =3D strlen(name1);
 	int len2 =3D strlen(name2);
@@ -566,6 +595,41 @@ static int verify_ordered(unsigned mode1, const char =
*name1, unsigned mode2, con
 		c1 =3D '/';
 	if (!c2 && S_ISDIR(mode2))
 		c2 =3D '/';
+
+	/*
+	 * There can be non-consecutive duplicates due to the implicitly
+	 * add slash, e.g.:
+	 *
+	 *   foo
+	 *   foo.bar
+	 *   foo.bar.baz
+	 *   foo.bar/
+	 *   foo/
+	 *
+	 * Record non-directory candidates (like "foo" and "foo.bar" in
+	 * the example) on a stack and check directory candidates (like
+	 * foo/" and "foo.bar/") against that stack.
+	 */
+	if (!c1 && is_less_than_slash(c2)) {
+		name_stack_push(candidates, name1);
+	} else if (c2 =3D=3D '/' && is_less_than_slash(c1)) {
+		for (;;) {
+			const char *p;
+			const char *f_name =3D name_stack_pop(candidates);
+
+			if (!f_name)
+				break;
+			if (!skip_prefix(name2, f_name, &p))
+				break;
+			if (!*p)
+				return TREE_HAS_DUPS;
+			if (is_less_than_slash(*p)) {
+				name_stack_push(candidates, f_name);
+				break;
+			}
+		}
+	}
+
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }

@@ -587,6 +651,7 @@ static int fsck_tree(const struct object_id *oid,
 	struct tree_desc desc;
 	unsigned o_mode;
 	const char *o_name;
+	struct name_stack df_dup_candidates =3D { NULL };

 	if (init_tree_desc_gently(&desc, buffer, size)) {
 		retval +=3D report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot b=
e parsed as a tree");
@@ -666,7 +731,8 @@ static int fsck_tree(const struct object_id *oid,
 		}

 		if (o_name) {
-			switch (verify_ordered(o_mode, o_name, mode, name)) {
+			switch (verify_ordered(o_mode, o_name, mode, name,
+					       &df_dup_candidates)) {
 			case TREE_UNORDERED:
 				not_properly_sorted =3D 1;
 				break;
@@ -682,6 +748,8 @@ static int fsck_tree(const struct object_id *oid,
 		o_name =3D name;
 	}

+	name_stack_clear(&df_dup_candidates);
+
 	if (has_null_sha1)
 		retval +=3D report(options, oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "contain=
s entries pointing to null sha1");
 	if (has_full_path)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 449ebc5657..91a6e34f38 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -257,6 +257,22 @@ test_expect_success 'tree object with duplicate entri=
es' '
 	test_i18ngrep "error in tree .*contains duplicate file entries" out
 '

+test_expect_success 'tree object with dublicate names' '
+	test_when_finished "remove_object \$blob" &&
+	test_when_finished "remove_object \$tree" &&
+	test_when_finished "remove_object \$badtree" &&
+	blob=3D$(echo blob | git hash-object -w --stdin) &&
+	printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
+	tree=3D$(git mktree <tree) &&
+	printf "100644 blob %s\t%s\n" $blob x.1 >badtree &&
+	printf "100644 blob %s\t%s\n" $blob x >>badtree &&
+	printf "040000 tree %s\t%s\n" $tree x >>badtree &&
+	badtree=3D$(git mktree <badtree) &&
+	test_must_fail git fsck 2>out &&
+	test_i18ngrep "$badtree" out &&
+	test_i18ngrep "error in tree .*contains duplicate file entries" out
+'
+
 test_expect_success 'unparseable tree object' '
 	test_oid_cache <<-\EOF &&
 	junk sha1:twenty-bytes-of-junk
=2D-
2.26.2
