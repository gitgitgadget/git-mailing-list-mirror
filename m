Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E79C6FA89
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 15:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiINP5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiINP5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 11:57:44 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949954F3AF
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663171058; bh=12B/7Tra4DVIaB10HH10xUzr5FQ2wQLk1xIf6OWJP9c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tBq8yeTBU4XpTWQ0eacyWKHZcMyqKJNsrpapzHhNFAJRYKR1rqEJoiZ6hyCHxX2zU
         8G0ZWhwVPXlsDYzeZ5L69v7cL1o949qtGn3q07RtChe95CVfp5wn5ecsdirfC2DI1v
         MTUZ4WXl7oP9m9HPJda80Y3Li/X1vKK28Q3U3prokvRj7XH5dEK6k9A7j/xcC29p7q
         0HkQQHK/CWeF6lionAhiHl16ALOVj1MR9Q8iy5uZvUrCzvMqtioOkHHUwbjp3lRdFZ
         3vVMUhoRDOVWcpN+LdUHiEmJlJVvJ9t438fBX1HD+jg1dPcvMlXnGfrMxehdhbhE2+
         sGEcAaL/9gzxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1pNNQ809O6-017F8M; Wed, 14
 Sep 2022 17:57:38 +0200
Message-ID: <70e87095-d8be-f859-f5b4-a5e15904149c@web.de>
Date:   Wed, 14 Sep 2022 17:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: git diff ^! syntax stopped working for stashes in Git 2.28
Content-Language: en-US
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Tim Jaacks <tim.jaacks@garz-fricke.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <6f729c8c43c4409faf6a11a69791f45a@garz-fricke.com>
 <9e0c1a2c-542b-156f-4c70-371d3a9b452d@web.de>
 <CAPx1Gve=BZ3J7KH0FA_BbAnYMEFXyDyiD=tX1vBiKCfHS0JfFg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPx1Gve=BZ3J7KH0FA_BbAnYMEFXyDyiD=tX1vBiKCfHS0JfFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fOHfPYxPEKQ0Sb2LEmodeXkCzlGOBKQBGfAl/YcoDeID05K7MXs
 HI3ES/uZFFsWE6Y3gmr9tLgApUonxq47vpmkFDjwKH8vIjJZ4mCLCjNUZShLbN4HBpbx+8f
 Gha/NaAHu2rFfroAIAlq0vW0WbY4IXpIlwyn/0gQUNkDhqyvc1USBlpjQ6odGgU6G70pgZE
 Y3KwzkI2MiMrK0bdU5RFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cV2gbBgo6Ro=:TOIcMnbqIAvJu4fu8cZR1h
 Xz5PC+pxQmrFEjkdk0FFrH5qCf70XtF5l8JwbN3ynCle9W2S0zCAfas6lCdwLSHal6mG6iLrh
 0AhH1qRYRCK0QZB8tm+IXpyCzKh75n7ErSFyBo75vjLilMVwthngs0QvEqKP6/JQU+Tp/AcLr
 rD82Apt7rZdyX37PuagN67AIJHAmvf7S77ltQwNseErJ2dhzhh1UxumxuPd8syQpH7uDIrnWy
 VGeSQfkQFutM1MwQhnqaXnDexhxpw760kJVQn2Tiv1a1mdOFKKqoHoqShUtFMcFuKdeWeOI/u
 F8fKcJEOGphTTdX+SteDkvEmMaxQiUnb7j24A1JDsCF8RGClobdMkF037WmKh2qSMc1dTiyOA
 tatgRuw44bLVSGFepY/FUgRivJcXQdZyD0zOhzlWm5+8HHFa04DWGuGDkOTLRZKrMLQLeex00
 jLLy9pqNapC0kJjxZFbXD8xFVGnkhegWAM/4NBYuPbnwTBv/twUhgt/JAW3F1Vut3elKpP820
 ORtRWBZ5dYiYQ3OJNcLRP96UFAl6D2vLKFkQTjbb+uyBUiydgFKMTVk/1zNwd52lmBaoTuKTI
 pxXb4m8mAMaRmLKMKANEO+a2mIPB0skiydHVNLFjDGvzUPjeTYfIIYG4J1GCYRHYWx2sPqr9t
 8+5OolNhbFtvoHEun2y86bwUKKEtxJtbBOOU7MvAenh3RsopvzUVMbGVl3B3Mk/6gfRB+h+Rq
 /ghLeiairz2lRoha8Os/vttQpjD9uN1lFirJBlqMJeFRS39WjyGTgvmWda4mwdi1kVei8Fwgk
 PVPgqcQGjwKb2/OnAgtWU0rTn7FuIxEVdYgWjlXXSbQE85wK0Chvyzw9frErlVqnWco7TfadG
 yL9OOqFFf+t6xxvy4WVVdbooFky+2pWJTXcE72WEjur7+cubV7ltnuTeysMeSBLxgKyA5l9CE
 vNfY476E4sUXpSILdG2OV9B6bjLtSMCJijTppX/STgZbhEFXEd++TxEBuMJX4aOOy1ZHvld9Y
 pVXhyj97MW/83lZqA8fzvAs4gpkFjt6N+0hrO+1NS27BYlenRH1GyuzLZi7h9KB7uzvOlUV5v
 MqRj0Nv+sNt+KHeaFAYiNjOgiRmptcOk+keM8vTtTn1BpOIaZNlJUlyBxvwqxH4s5j8Jznsm1
 4vxWo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.09.22 um 21:09 schrieb Chris Torek:
> On Mon, Sep 12, 2022 at 4:16 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Am 12.09.22 um 11:57 schrieb Tim Jaacks:
>>> I noticed that the following syntax to show the changes of a stash sto=
pped working in Git 2.28:
>>>
>>>   git diff stash@{0}^!
>
>> Bisects to 8bfcb3a690 (git diff: improve range handling, 2020-06-12).
>
> It's not really clear to me what `git diff stash^!` (and similar) *shoul=
d* do.
> That it worked before was at least in part an accident of implementation=
.

I get the same impression.

git show stash@{0}` and `git show stash@{0}^!` both show a combined
diff, which makes sense to me.  `git diff stash@{0}^!` also results in a
call of diff_tree_combined(), but with trees  in a different order.
`git diff stash@{0} stash@{0}^1 stash@{0}^2` gives me the same combined
diff, but `git diff stash@{0}^!` gives nothing because it acts like
`git diff stash@{0}^1 stash@{0}^2 stash@{0}` instead, and both parents
have the same tree.

That's because revision.c::handle_revision_arg_1() adds the parents
before the child when handling "^!" and
builtin/diff::builtin_diff_combined() expects the child first.
Rotating the array there lets `git diff stash@{0}^!` show a combined
diff, but breaks t4013.173, t4013.174 and t4057.

Letting revision.c::handle_revision_arg_1() add the child first makes
`git diff stash@{0}^!` consistent with `git show stash@{0}^!`.  Tests
still pass.  gitrevisions(7) says <rev>^! is the "same as giving commit
<rev> and then all its parents prefixed with ^ to exclude them", so
this seems to be an actual fix.

My demo patch below feels iffy, though.  Hopefully this behavior can
be implemented in a nicer way.

>> A stash revision is a merge.  With "stash@{0}^!" it ends up in
>> ent.objects[2] and its parents (marked UNINTERESTING) in ent.objects[0]
>> and ent.objects[1].
>
> Right: the ^! suffix produces a negated list of the children as addition=
al
> revs (with the stash itself as the lone positive rev).  Note that a stas=
h
> made with `-u` will list *three* such revs rather than just two, since s=
uch
> a stash is a three-parent merge.
>
> You're advised (in the git stash documentation) to use `git stash show`,
> not `git diff`, to get a diff from the stash's parent commit to the stas=
h's
> working-tree commit.

So, Tim, does `git stash show -p stash@{0}` work for you?

> It's certainly possible to detect a single positive rev and two or three
> negative ones as special cases here, but it's not clear that this is a
> good idea.  Note that in commit bafa2d741e I made one
> of the tests stop using `git diff HEAD^!` on the grounds that it's not
> defined behavior.

Letting `git diff X^!` mean the same as `git diff X ^X^` for a non-merge
makes sense to me given the definition from gitrevisions(7) cited above.
That in turn is the same as `git diff X^..X` and `git diff X^ X`.

Ren=C3=A9


=2D--
 revision.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index c516415c48..ad4ead2c0a 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -1819,7 +1819,7 @@ static void add_alternate_refs_to_pending(struct rev=
_info *revs,
 }

 static int add_parents_only(struct rev_info *revs, const char *arg_, int =
flags,
-			    int exclude_parent)
+			    int exclude_parent, int dry_run)
 {
 	struct object_id oid;
 	struct object *it;
@@ -1850,6 +1850,8 @@ static int add_parents_only(struct rev_info *revs, c=
onst char *arg_, int flags,
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents))
 		return 0;
+	if (dry_run)
+		return 1;
 	for (parents =3D commit->parents, parent_number =3D 1;
 	     parents;
 	     parents =3D parents->next, parent_number++) {
@@ -2083,6 +2085,7 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 	const char *arg =3D arg_;
 	int cant_be_filename =3D revarg_opt & REVARG_CANNOT_BE_FILENAME;
 	unsigned get_sha1_flags =3D GET_OID_RECORD_PATH;
+	int add_parents =3D 0;

 	flags =3D flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;

@@ -2100,14 +2103,16 @@ static int handle_revision_arg_1(const char *arg_,=
 struct rev_info *revs, int fl
 	mark =3D strstr(arg, "^@");
 	if (mark && !mark[2]) {
 		*mark =3D 0;
-		if (add_parents_only(revs, arg, flags, 0))
+		if (add_parents_only(revs, arg, flags, 0, 0))
 			return 0;
 		*mark =3D '^';
 	}
 	mark =3D strstr(arg, "^!");
 	if (mark && !mark[2]) {
 		*mark =3D 0;
-		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0))
+		if (add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0, 1)=
)
+			add_parents =3D 1;
+		else
 			*mark =3D '^';
 	}
 	mark =3D strstr(arg, "^-");
@@ -2122,7 +2127,7 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 		}

 		*mark =3D 0;
-		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), excl=
ude_parent))
+		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), excl=
ude_parent, 0))
 			*mark =3D '^';
 	}

@@ -2145,6 +2150,8 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	free(oc.path);
+	if (add_parents)
+		add_parents_only(revs, arg_, flags ^ (UNINTERESTING | BOTTOM), 0, 0);
 	return 0;
 }

=2D-
2.37.3
