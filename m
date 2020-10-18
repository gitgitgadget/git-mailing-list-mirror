Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91131C43457
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550B022268
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QaWQh9GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgJRTtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:49:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60288 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbgJRTta (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 15:49:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B39AE928F6;
        Sun, 18 Oct 2020 15:49:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=A/bmE/u86lSlIx7zs9Rx/hC9o
        eo=; b=QaWQh9GRHf7MCISz/+GUxZGqmCGqNTZOokfjXg5/ucUut1l6WOepX4tHd
        W211JomoqHzXuN5Zsdwn0YY8Kcmd1dNy7PZ4z09mNPqbYxkMxyUthDq1iTJgWyJl
        IKGDeqxeKPpcyyFn+5i8I3xLqvcjfHPvgN8JHwZLubWzociFq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=A3DHK7Rb0EjXg7qxbRD
        LVI5ZV51wouDuv1RFvUUYsXssv2tvUuHS2C3RVMJesaULMHMQ9XRIvbOLsohYFY/
        cUIF6Jn0evL3hD4vc8Ubpo89oM7mISC2PK5JdVS3S/iuVzbFux4VnlURHHPFt5GW
        d9sl69K++IqX7VsZzKi0CuSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC2CF928F5;
        Sun, 18 Oct 2020 15:49:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37AF0928F2;
        Sun, 18 Oct 2020 15:49:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/3] SubmittingPatches: clarify DCO is our --signoff rule
Date:   Sun, 18 Oct 2020 12:49:12 -0700
Message-Id: <20201018194912.2716372-4-gitster@pobox.com>
X-Mailer: git-send-email 2.29.0-rc2-130-g9dc1ca14f3
In-Reply-To: <20201018194912.2716372-1-gitster@pobox.com>
References: <20201018194912.2716372-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 067CE122-117B-11EB-8989-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description on sign-off and DCO was written back in the days
where there was only a choice between "use sign-off and it means the
contributor agrees to the Linux-kernel style DCO" and "not using
sign-off at all will make your patch unusable".  These days, we are
trying to clarify that the exact meaning of a sign-off varies
project to project.

Let's be more explicit when presenting what _our_ rules are.  It is
of secondary importance that it originally came from the kernel
project, so move the description as a historical note at the end,
while cautioning that what a sign-off means to us may be different from
what it means to other projects contributors may have been used to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index 291b61e262..f83a050b35 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -300,15 +300,12 @@ patch.
 [[sign-off]]
 =3D=3D=3D Certify your work by adding your "Signed-off-by: " line
=20
-To improve tracking of who did what, we've borrowed the
-"sign-off" procedure from the Linux kernel project on patches
-that are being emailed around.  Although core Git is a lot
-smaller project it is a good discipline to follow it.
+To improve tracking of who did what, we ask you to certify that you
+wrote the patch or have the right to pass it on under the same license
+as ours, by "signing off" your patch.  Without sign-off, we cannot
+accept your patches.
=20
-The sign-off is a simple line at the end of the explanation for
-the patch, which certifies that you wrote it or otherwise have
-the right to pass it on as an open-source patch.  The rules are
-pretty simple: if you can certify the below D-C-O:
+If you can certify the below D-C-O:
=20
 [[dco]]
 .Developer's Certificate of Origin 1.1
@@ -338,14 +335,15 @@ d. I understand and agree that this project and the=
 contribution
    this project or the open source license(s) involved.
 ____
=20
-then you just add a line saying
+you add a "Signed-off-by" trailer to your commit, that looks like
+this:
=20
 ....
 	Signed-off-by: Random J Developer <random@developer.example.org>
 ....
=20
-This line can be automatically added by Git if you run the git-commit
-command with the -s option.
+This line can be added by Git if you run the git-commit command with
+the -s option.
=20
 Notice that you can place your own Signed-off-by: line when
 forwarding somebody else's patch with the above rules for
@@ -353,6 +351,11 @@ D-C-O.  Indeed you are encouraged to do so.  Do not =
forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
=20
+This procedure originally came from the Linux kernel project, so our
+rule is quite similar to theirs, but what exactly it means to sign-off
+your patch differs from project to project, so it may be different
+from that of the project you are accustomed to.
+
 [[real-name]]
 Also notice that a real name is used in the Signed-off-by: line. Please
 don't hide your real name.
--=20
2.29.0-rc2-130-g9dc1ca14f3

