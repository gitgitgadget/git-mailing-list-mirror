Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B065C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1173D2166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="V1fvnuDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBDV0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:26:24 -0500
Received: from mout.web.de ([212.227.15.14]:50643 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDV0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580851579;
        bh=+uV7DwFH2+4zlrqPt4rScavXprpVXgv/PZeWYEmHxYY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=V1fvnuDawCY3Okh/zJOdmtrOnuQa3n5GfM4plXw+8YQb3cEFMV94vcTQyJoXZt//2
         rG1O79vG3cstbUxHJeCgtjjYVucPiQLGzvnEgo9LLvjlf9ySeMh/W+gg+EXHHTDvz7
         Vmz4aBqs7zE6zVZfwSDP9m/9cEPVtnPqHto3vwjQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgYRZ-1jLlOx3Dq1-00o09A; Tue, 04
 Feb 2020 22:26:18 +0100
Subject: [PATCH 10/10] name-rev: release unused name strings
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <4eddc458-6294-9b9c-857b-50ba484a7168@web.de>
Date:   Tue, 4 Feb 2020 22:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTQsin1l7Ui7l4xE4Sloza/yltC55JaRlpLXlb2zib5h6t7qDCU
 Df5yer00Jlt1LOv6iZU3OlERb9um9i+3rDAH7g4wDGgiMoLs9VXIiPtA51TAY6VUweUahjy
 68MKdmGu+8Qc8rmQUtEfIMYtUcB+/KMd/2ZgqnnyKfcO2ehisWWFk570kWmhakFqAe4WBuy
 d4ip3AAYY4HS4SIqSYZ0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UuspuAYIz9c=:MRvdBMDZs1DbruI71Vll35
 0g6+emhxQcl5Ry06e8e/it6H/hyFH4W7JMs8Qnm/jgZZyx6RxvanK2HGudJ8YuncEu6fSkKmL
 pI9CeCByU1ZdLPOCwaecHzXrinGW0gzWDWA2HsAuUP9ePByyzUqitJvv6Xd3PJw9ZIE1FMO3V
 gttdsH5EUWuik2+19+Qtd9q90IWvjnf2AXBWa5E47Gvy22nrloLIzi3Q3VEqFIsp/UmZFlU/h
 iqG6LIp6UzoPw8cGd98WYAznPBqfgp6Be+UN6eG/TU7I3lUojiGDK/wvOXw4KnhTgpk2RAD90
 aP1HTeTvk/1yz5F2GByfsBqm6VtSkHzGb4FM7fSMtqi0K/5lwZ2/r/uQoPTpiTntTEiV7XVsn
 Fu+JKnXYC2V8gEr2jVNS5eNPoRIYkC4lVWL6GftiPPpzb+TSmGmurnlfiD1mJ9tuFpZxDYL7i
 uX4NT/JwWecLmSxa0Qc+4nuEyTi1CVy2nvupPzKHzHYWByo2yqWO1thOe0C3UA/+8HSiyjFsu
 FtYZn+NjnOsPAGZBOkR0AKagZHca0lhdeVRZAaTijJNLsKTDhdBWFqEUBZkNRoQIfFEsOpT/V
 cLLP4Ropgk2jGHXrkF2ks1nSsUU3T7qtZuRFM40LF1eqkQ5iWzpqN4Cs0quVJxfi9h47bFtm6
 sxC92tOk0+y3taGwXBSvzJ16HqDzdn7ba25KifXe7vOyXkSwSe/pxaTv8N7EfPhn2gf1HPBQN
 XE40dV9xR9ltML1SBEYF5SJb4oZFQsvkUasj30FmEV5FVSAWqsj9j2ap3dJLSLLVCEOFUMd0D
 bLv5Qlk5EWXC2/24MwdiAGMQWT+MizZnr+wfCuQASbmrkvt7NLzqANqyDRhT+LA17jAV3R8U8
 aaI1VThRK1b4sT+QUvT+WCM+WuZZuj+K8Cp7G0iStOEWa7hZY4FypQ5aOEg04uovymrIr6uxx
 xr9kqpEELPf3mMbOkPNK/iYLZ/eBvsI2pRPaisV6b43ADw5hWNuMi3TWQ9Zh3rRYqCxiS/ErC
 shSJ8/iLC86awGXZJRIcP+9IpJPhtXtFKAjx8twDkaspM6LkVm3y9TwHZMfEwsg8z/TBLaAag
 oznUYPdIWVorwsYIA5bRVBpASD0d5KeaygvnbfYfIf1sJ/D8LBvIl1ExZgSVat85kMxEDPjro
 FU5uQcpTwekq/QvKCe8MfqDeRy2OGD017toZDQeGPf4ljcpbpyqxd9g04O02nkhsPa8O0i8sp
 LwpckaOk9qRxhQ/fS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

name_rev() assigns a name to a commit and its parents and grandparents
and so on.  Commits share their name string with their first parent,
which in turn does the same, recursively to the root.  That saves a lot
of allocations.  When a better name is found, the old name is replaced,
but its memory is not released.  That leakage can become significant.

Can we release these old strings exactly once even though they are
referenced multiple times?  Yes, indeed -- we can make use of the fact
that name_rev() visits the ancestors of a commit after it set a new name
for it and tries to update their names as well.

Members of the first ancestral line have the same taggerdate and
from_tag values, but a higher distance value than their child commit at
generation 0.  These are the only criteria used by is_better_name().
Lower distance values are considered better, so a name that is better
for a child will also be better for its parent and grandparent etc.

That means we can free(3) an inferior name at generation 0 and rely on
name_rev() to replace all references in ancestors as well.

If we do that then we need to stop using the string pointer alone to
distinguish new empty rev_name slots from initialized ones, though, as
it technically becomes invalid after the free(3) call -- even though its
value is still different from NULL.

We can check the generation value first, as empty slots will have it
initialized to 0, and for the actual generation 0 we'll set a new valid
name right after the create_or_update_name() call that releases the
string.

For the Chromium repo, releasing superceded names reduces the memory
footprint of name-rev --all significantly.  Here's the output of GNU
time before:

0.98user 0.48system 0:01.46elapsed 99%CPU (0avgtext+0avgdata 2601812maxres=
ident)k
0inputs+0outputs (0major+571470minor)pagefaults 0swaps

... and with this patch:

1.01user 0.26system 0:01.28elapsed 100%CPU (0avgtext+0avgdata 1559196maxre=
sident)k
0inputs+0outputs (0major+314370minor)pagefaults 0swaps

It also gets faster; hyperfine before:

Benchmark #1: ./git -C ../chromium/src name-rev --all
  Time (mean =C2=B1 =CF=83):      1.534 s =C2=B1  0.006 s    [User: 1.039 =
s, System: 0.494 s]
  Range (min =E2=80=A6 max):    1.522 s =E2=80=A6  1.542 s    10 runs

... and with this patch:

Benchmark #1: ./git -C ../chromium/src name-rev --all
  Time (mean =C2=B1 =CF=83):      1.338 s =C2=B1  0.006 s    [User: 1.047 =
s, System: 0.291 s]
  Range (min =E2=80=A6 max):    1.327 s =E2=80=A6  1.346 s    10 runs

For the Linux repo it doesn't pay off; memory usage only gets down from:

0.76user 0.03system 0:00.80elapsed 99%CPU (0avgtext+0avgdata 292848maxresi=
dent)k
0inputs+0outputs (0major+44579minor)pagefaults 0swaps

... to:

0.78user 0.03system 0:00.81elapsed 100%CPU (0avgtext+0avgdata 284696maxres=
ident)k
0inputs+0outputs (0major+44892minor)pagefaults 0swaps

The runtime actually increases slightly from:

Benchmark #1: ./git -C ../linux/ name-rev --all
  Time (mean =C2=B1 =CF=83):     828.8 ms =C2=B1   5.0 ms    [User: 797.2 =
ms, System: 31.6 ms]
  Range (min =E2=80=A6 max):   824.1 ms =E2=80=A6 838.9 ms    10 runs

... to:

Benchmark #1: ./git -C ../linux/ name-rev --all
  Time (mean =C2=B1 =CF=83):     847.6 ms =C2=B1   3.4 ms    [User: 807.9 =
ms, System: 39.6 ms]
  Range (min =E2=80=A6 max):   843.4 ms =E2=80=A6 854.3 ms    10 runs

Why is that?  In the Chromium repo, ca. 44000 free(3) calls in
create_or_update_name() release almost 1GB, while in the Linux repo
240000+ calls release a bit more than 5MB, so the average discarded
name is ca.  1000x longer in the latter.

Overall I think it's the right tradeoff to make, as it helps curb the
memory usage in repositories with big discarded names, and the added
overhead is small.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 98f55bcea9..23a639ff30 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -17,7 +17,7 @@
 #define CUTOFF_DATE_SLOP 86400

 struct rev_name {
-	const char *tip_name;
+	char *tip_name;
 	timestamp_t taggerdate;
 	int generation;
 	int distance;
@@ -34,7 +34,7 @@ static struct commit_rev_name rev_names;

 static int is_valid_rev_name(const struct rev_name *name)
 {
-	return name && name->tip_name;
+	return name && (name->generation || name->tip_name);
 }

 static struct rev_name *get_commit_rev_name(const struct commit *commit)
@@ -87,9 +87,20 @@ static struct rev_name *create_or_update_name(struct co=
mmit *commit,
 {
 	struct rev_name *name =3D commit_rev_name_at(&rev_names, commit);

-	if (is_valid_rev_name(name) &&
-	    !is_better_name(name, taggerdate, distance, from_tag))
-		return NULL;
+	if (is_valid_rev_name(name)) {
+		if (!is_better_name(name, taggerdate, distance, from_tag))
+			return NULL;
+
+		/*
+		 * This string might still be shared with ancestors
+		 * (generation > 0).  We can release it here regardless,
+		 * because the new name that has just won will be better
+		 * for them as well, so name_rev() will replace these
+		 * stale pointers when it processes the parents.
+		 */
+		if (!name->generation)
+			free(name->tip_name);
+	}

 	name->taggerdate =3D taggerdate;
 	name->generation =3D generation;
=2D-
2.25.0
