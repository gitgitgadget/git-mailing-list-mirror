Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937884687
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159548; cv=none; b=HRorX9PKMnT7QstY1MaEaI0mundH7lsaSa9o0vIjNFYxcvxMHLMZRiXAJn809aUm0VrJh67Ei6e4ujcCb6THe9XFalxt6bcKDg3cwBPrjIPf0Cm7PyLGvqngz6vAiAirW/sNPC1YUmAQLkthkbmI/U78WZp9tUejCdVrNHAvXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159548; c=relaxed/simple;
	bh=b3XaOQZdNGdhk/OEhm7Hex1jdlFcvSDEQVwctUs1EoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=munWg+NFvh8Oe6ROygpyx5ar7ped7zjqSnmi748oLXn9f6HHMHq7fUDSnV9TT7gO2Q4dTOuwfu/kGyIWqRT6e3hqUe2uwgkYpHa6Mar7AHIiSSPLkDDbGbIUp2BezSEYCvm/TBJg0lBuUp5MukKdRtPerjlumYbe3LkoDnN0YdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LXcoSNdz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LXcoSNdz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 665533F49F;
	Tue, 16 Jul 2024 15:52:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b3XaOQZdNGdh
	k/OEhm7Hex1jdlFcvSDEQVwctUs1EoM=; b=LXcoSNdzMQo3bM0KCBTUvAOIY7h5
	CNzqITFS0CRegKcKVkOSWbbWsECvXkLBf8J73jdKHEx5RdC1uYY2ZCngVO6xJj7F
	+yp75NDESkcnhh8Qi5DLB+UxrjY1XWM/kBT+yIa+3782zLC6AQN6ZYSmeYqXQ5db
	xpmBABpgjrtyK4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DCE33F49E;
	Tue, 16 Jul 2024 15:52:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9FCB3F49D;
	Tue, 16 Jul 2024 15:52:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  karthik188@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [GSoC][PATCH v4 0/5] t: port reftable/tree_test.c to the unit
 testing framework
In-Reply-To: <20240716075641.4264-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Tue, 16 Jul 2024 13:18:12 +0530")
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
	<20240716075641.4264-1-chandrapratap3519@gmail.com>
Date: Tue, 16 Jul 2024 12:52:23 -0700
Message-ID: <xmqqh6cp8688.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EC3016DC-43AC-11EF-8A93-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit

Consistently refer to an existing commit with --format=3Dreference.

	$ git show -s --format=3Dreference 8bf6fbd
	8bf6fbd00d (Merge branch 'js/doc-unit-tests', 2023-12-09)

> testing framework written entirely in C was introduced to the Git proje=
ct
> aimed at simplifying testing and reducing test run times.

I doubt that the reason why "unit-tests" written entirely in C was
introduced is because we wanted to simplify testing and to reduce
test run times to begin with.  The traditional tests to observe the
effect visible to end-users by actually running commands that would
be run by end-users and unit tests serve two separate purposes.  The
latter does not "simplify", or "reduce time"---you cannot write a
test "entirely in C" to make sure, say, that "git push --force"
allows a non-fast-forward update to happen using unit-test
framework.  The unit-tests cannot replace end-to-end tests.  They
are complementary.

The statement may need to be rethought.

Or just stop at saying something like

    The reftable library comes with self tests, which are exercised
    as part of the usual end-to-end tests that are designed to
    observe the end-user visible effects of Git commands.  What it
    exercises, however, is a better match to the unit-testing
    framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
    2023-12-09), that are designed to observe how low level
    implementation details, at the level of sequences of individual
    function calls, behave.

which already covers the next paragraph while at it.

> Currently, tests for the reftable refs-backend are performed by a custo=
m
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/tree_test.c to the unit testing framework and improve upon
> the ported test.
>
> The first patch in the series is preparatory cleanup, the second patch
> moves the test to the unit testing framework, and the rest of the patch=
es
> improve upon the ported test.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> ---
> Changes in v4:
> - Rename the tests to be in-line with unit-tests' standards
>
> CI/PR: https://github.com/gitgitgadget/git/pull/1740

By the way, did you rebase the patches?  On which commit is this
iteration based?  Judging from the second patch, it seems to assume
that Makefile does not yet have t-reftable-record in it, and it
applies cleanly to 'master' before 9118e46e (Merge branch
'cp/unit-test-reftable-record', 2024-07-15).  Newer 'master' has
textual conflicts (nothing that I cannot resolve, but it shows that
apparently that anything newer than 9118e46e are not commits that
you developed this series on).

Has this series even been compile-tested?  I do not think that even
the unit test added by this series has been run (or compiled).

$ make -j32 t/unit-tests/t-reftable-tree.o
GIT_VERSION =3D 2.46.0.rc0.27.g0c2075a7c5
    * new build flags
    CC t/unit-tests/t-reftable-tree.o
In file included from t/unit-tests/t-reftable-tree.c:9:
t/unit-tests/t-reftable-tree.c: In function =E2=80=98t_tree_search=E2=80=99=
:
t/unit-tests/t-reftable-tree.c:45:44: error: =E2=80=98test_compare=E2=80=99=
 undeclared (first use in this function); did you mean =E2=80=98t_compare=
=E2=80=99?
   45 |         check(!tree_search(values, &root, &test_compare, 0));
      |                                            ^~~~~~~~~~~~
t/unit-tests/test-lib.h:75:45: note: in definition of macro =E2=80=98chec=
k=E2=80=99
   75 |         check_bool_loc(TEST_LOCATION(), #x, x)
      |                                             ^
t/unit-tests/t-reftable-tree.c:45:44: note: each undeclared identifier is=
 reported only once for each function it appears in
   45 |         check(!tree_search(values, &root, &test_compare, 0));
      |                                            ^~~~~~~~~~~~
t/unit-tests/test-lib.h:75:45: note: in definition of macro =E2=80=98chec=
k=E2=80=99
   75 |         check_bool_loc(TEST_LOCATION(), #x, x)
      |                                             ^
make: *** [Makefile:2754: t/unit-tests/t-reftable-tree.o] Error 1





Let's concentrate on quality, not quantity; too many topics with the
same prefix cp/unit-test* seem to be left unreviewed on the list.

In the meantime, I'll queue the following fix-up on top.  In this
codebase, it is preferred to write a pointer to a function whose
name is "func" as just "func", not "&func".


 t/unit-tests/t-reftable-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tre=
e.c
index b3d4008e5c..107f1f69bf 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -33,16 +33,16 @@ static void t_tree_search(void)
 	size_t i =3D 1;
=20
 	do {
-		nodes[i] =3D tree_search(values + i, &root, &t_compare, 1);
+		nodes[i] =3D tree_search(values + i, &root, t_compare, 1);
 		i =3D (i * 7) % 11;
 	} while (i !=3D 1);
=20
 	for (i =3D 1; i < ARRAY_SIZE(nodes); i++) {
 		check_pointer_eq(values + i, nodes[i]->key);
-		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, =
0));
+		check_pointer_eq(nodes[i], tree_search(values + i, &root, t_compare, 0=
));
 	}
=20
-	check(!tree_search(values, &root, &test_compare, 0));
+	check(!tree_search(values, &root, t_compare, 0));
 	tree_free(root);
 }
=20
@@ -58,7 +58,7 @@ static void t_infix_walk(void)
 	size_t count =3D 0;
=20
 	do {
-		tree_search(values + i, &root, &t_compare, 1);
+		tree_search(values + i, &root, t_compare, 1);
 		i =3D (i * 7) % 11;
 		count++;
 	} while (i !=3D 1);
--=20
2.46.0-rc0-137-g851401d64b

