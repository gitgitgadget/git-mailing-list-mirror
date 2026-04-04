Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65822277C96
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315871; cv=none; b=g+R+t3wK0KCVtH93n8OX+gwpTBpqGt1OeVQuY4BqeOm78UenNpZD3H2yrfsTYA5GsFfIP9PW9+tVe7MkqGXXEspIV0t1DXf/BPOWfpi9MFdqHjs/T1+kHh9PBJ9o89D4JI6Oo8ayyhZpQcBacmACJU4PkYfe/OYuh8W6fw+p+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315871; c=relaxed/simple;
	bh=s33AuMj3cRqRnf45sWBUfyHM3FI3W6YOrDxM/xvWBPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ftnREOQT7lKioHBHacS/Yr2pTLZv7D4AwD1wEsa4vDqMroTk6iEh9zfBD78T6VFYWpQwhS21g0iab6Iw3oIkmooQSuWhuSIN+P3GYxGgetMHpivHqYQuG+cyqV5tOUr7hIRyFj21271dO0b6gFmUrEoGKCMfovbW8l+oPJpp/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=Meoz2NHz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QIQrocfC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="Meoz2NHz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QIQrocfC"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 53A24EC01AD;
	Sat,  4 Apr 2026 11:17:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 04 Apr 2026 11:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1775315868; x=1775402268; bh=IsjSbx1suL53TXfFVak82h347KL8hxNk
	kcxriJBF62Y=; b=Meoz2NHzwaVbkwrKflOf1eVHwRCfM0r7LYWvfsbZPUnBf7BB
	j0uYxmyIQm8/DOG2EHXWKVvMEquSbBRA+pcBVT/688DvRw3Cy8wbXEQAftNUQ/lK
	Ja1YLC3odOmLoynXsIzN48JLSxGpb0fh0uiM+EITrANg41XFd7eTQW7ILIrd0Hyd
	ng4HSoQ5CQuOrbdOmTvY4/u163x9jpcwmXpKZhpb9nU8uSMr46BPDYPTaTK6tHWN
	Biu/z36PRwP2cjeOuKJZMZ50lqDkmeY+NDvdV/UIg/B4YxLRlL1kETwV2JmnXEfh
	pFj5NsgoocJRjiNSjqMOSwhinlYrOlPeCn8+hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775315868; x=
	1775402268; bh=IsjSbx1suL53TXfFVak82h347KL8hxNkkcxriJBF62Y=; b=Q
	IQrocfCdpUPujLt9qK85QTbEKhLoD5KaPFrKRPavPUATqq2Oz8bAMXYYDEtrgF3d
	y8q/coEQn8sJwY30KXmk/EZkNd6G96Ogh6WRMT0l6WbKX3y6y84oLbNrgCROJ+IJ
	fLAhSJWfaeOXvyynvQ0qMJoWM4oqeaRNP7cZjPTY8Lfz0TKusi4tLHN4LTpbcU89
	1TOVx4OkE4fgnbwh3zgc8FSnheDkIotnQHThj5ZzCHF1yffGQZCW+8tlM0kA0DSB
	h9qAI9dYA9xL9NX3VyMLZTvEKSb9oBOPXnY0stJ6g96LMmSawTQKFAXLWlKsUjGd
	6NYHo67uAa/EJ22ouPKTA==
X-ME-Sender: <xms:nCvRaUWvMAdTOoUVCP6lZV3iNv65P16c5Sqx3SYrq_2YWA6oyMosUw>
    <xme:nCvRaek9Yg8yG0CDLEDQfWn2KSqOHx_K9nu-BoiYqjsLZzqj0DIqzkoRiug_R0h6g
    ZMyWcBVNQpun2oPsCmGoqVX26NqQsdpGL_wAPfEhO5o5JWzCDo9bg>
X-ME-Received: <xmr:nCvRaWCoiCW_ntn2EZ8jlVO97jtjTgZDqA0UkSqTu5gvm8MTllxZAe3mJyFGv4IUeWLd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttddtje
    enucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledv
    rdgvuheqnecuggftrfgrthhtvghrnhepheejhfeuffevtdetgeffleelkeefkeffteffje
    duudejtdefvdfghfeugeegteelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuhdpnhgspghrtghpthhtoh
    epvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:nCvRaec50GKGDewU7S3GoKcs6taNDi9UwKsny7iug9qIisDE4dlkTg>
    <xmx:nCvRaRKvaMPxaaI9ay9SGh5A60q0nN-a7NQ3iq1hM1jvT3Si0Ib_xw>
    <xmx:nCvRaReiDN8U3kRnEe-o2zliRvJ2h5_rE_oANxMp056ipSbpUiXsiQ>
    <xmx:nCvRaY1gyoy2v-VPyEiVR3IxnErZWlcU4252hmMUfMmF6YK2P035wg>
    <xmx:nCvRaSfp_BmmowSFRcfT6oPOQ7gKkprH7v9UCIJwfd7FCLICAQsuX_Lm>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Apr 2026 11:17:46 -0400 (EDT)
Date: Sat, 4 Apr 2026 17:17:43 +0200
From: Fernando Ramos <greenfoo@u92.eu>
To: git@vger.kernel.org
Cc: me@ttaylorr.com
Subject: [RFC] Show empty root commits when using --simplify-by-decoration
Message-ID: <adErl-EdiaXopVx-@x395.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Regarding "--simplify-by-decoration", I found a somewhat unexpected behavior.

Let's say we have a repository with two branches ("master" and "branch") and
this history structure:

         a * <master>       b * <branch>
           |                  |
         2 *------------------'
           |
         1 *
           |
    start  *

If I now run this...

    $ git log --graph --all --oneline --simplify-by-decoration

...I get this (which is expected and ok):

    * 0f3892d (branch) b
    | * 0c37d8c (master) a
    |/
    * d783631 Start

HOWEVER, if the root commit ("start") is an empty commit, then the same command
will print this instead:

    * 7abc10a (branch) b
    * 14d51e1 (master) a

...which is confusing for two reasons:

1. The graph is not showing a common origin.
2. Because "root" commits use an "*", it looks like "a" is the parent of "b",
   when the reality is that the graph is showing two independen origins.

Issue (1) seems to be caused by the fact that empty root commits are marked as
TREESAME and thus discarded when showing the graph.  This can be fixed with
patch #1 at the end of this email.  Note, however, that this patch partially
breaks what Taylor did on 1343c893138 (I say "partially" because it only happens
when using "--simplify-by-decoration").  I have CC'ed Taylor in case he has any
comments about it.

Issue (2) can be "fixed" by using a diferent character (for example "I") for
root commits (ie. those without parents), which can be done with patch #2 at the
end of this email.

With those two patches applied, this is what the output looks like in both cases
(with the root commit being empty or not):

    * 7abc10a (branch) b
    | * 14d51e1 (master) a
    |/
    I c0db521 Start

Let me know what you think and whether you want me to send a proper patch that
includes (1) or (2) or (1)+(2).

Thanks!

PS: Path #3 at the end of this emails includes a dummy script to quickly
recreate the two scenarios described above.



--------------------------------------------------------------------------------
Patch #1
--------------------------------------------------------------------------------

diff --git a/revision.c b/revision.c
index c9b8bfd09f..0e7bf2ed3c 100644
--- a/revision.c
+++ b/revision.c
@@ -978,15 +978,17 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
                return;

        if (!commit->parents) {
-               /*
-                * Pretend as if we are comparing ourselves to the
-                * (non-existent) first parent of this commit object. Even
-                * though no such parent exists, its changed-path Bloom filter
-                * (if one exists) is relative to the empty tree, using Bloom
-                * filters is allowed here.
-                */
-               if (rev_same_tree_as_empty(revs, commit, 0))
-                       commit->object.flags |= TREESAME;
+               if (!revs->simplify_by_decoration) {
+                       /*
+                        * Pretend as if we are comparing ourselves to the
+                        * (non-existent) first parent of this commit object. Even
+                        * though no such parent exists, its changed-path Bloom filter
+                        * (if one exists) is relative to the empty tree, using Bloom
+                        * filters is allowed here.
+                        */
+                       if (rev_same_tree_as_empty(revs, commit, 0))
+                               commit->object.flags |= TREESAME;
+               }
                return;
        }


--------------------------------------------------------------------------------
Patch #2
--------------------------------------------------------------------------------

diff --git a/revision.c b/revision.c
index 31808e3df0..c9b8bfd09f 100644
--- a/revision.c
+++ b/revision.c
@@ -4565,7 +4565,7 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
                else
                        return ">";
        } else if (revs->graph)
-               return "*";
+               return commit->parents ? "*" : "I";
        else if (revs->cherry_mark)
                return "+";
        return "";


--------------------------------------------------------------------------------
Patch #3
--------------------------------------------------------------------------------

diff --git a/build_example.sh b/build_example.sh
new file mode 100755
index 0000000000..60f63c5344
--- /dev/null
+++ b/build_example.sh
@@ -0,0 +1,61 @@
+#!/bin/bash
+
+################################################################################
+# Example #1
+################################################################################
+#
+# This will create this a repo with this history structure:
+#
+#       a * (master)       b * (branch)
+#         |                  |
+#       2 * -----------------'
+#         |
+#       1 *
+#         |
+#   start *
+
+rm -rf EXAMPLE1 || true; mkdir -p EXAMPLE1; cd EXAMPLE1
+
+touch start.txt; git init; git add start.txt; git commit -m 'Start'
+touch 1.txt; git add 1.txt; git commit -m '1'
+touch 2.txt; git add 2.txt; git commit -m '2'
+touch a.txt; git add a.txt; git commit -m 'a'
+git checkout -b branch HEAD^
+touch b.txt; git add b.txt; git commit -m 'b'
+
+git log --graph --all --oneline --simplify-by-decoration
+# The previous command will print this, which is what we expected:
+#
+#   * 0f3892d (HEAD -> branch) b
+#   | * 0c37d8c (master) a
+#   |/
+#   * d783631 Start
+
+cd ..
+
+
+
+################################################################################
+# Example #2
+################################################################################
+#
+# This will create this a repo with the same structure as before, but this time
+# the root commit ("start") is an empty one.
+
+rm -rf EXAMPLE2 || true; mkdir -p EXAMPLE2; cd EXAMPLE2
+
+git init; git commit --allow-empty -m 'Start'
+touch 1.txt; git add 1.txt; git commit -m '1'
+touch 2.txt; git add 2.txt; git commit -m '2'
+touch a.txt; git add a.txt; git commit -m 'a'
+git checkout -b branch HEAD^
+touch b.txt; git add b.txt; git commit -m 'b'
+
+git log --graph --all --oneline --simplify-by-decoration
+# The previous command will print this, which is unexpected:
+#
+#   * 7abc10a (HEAD -> branch) b
+#   * 14d51e1 (master) a
+
+cd ..
+

