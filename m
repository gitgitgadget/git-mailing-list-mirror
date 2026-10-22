Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648161;
	b=Jn+sZ1dfyaPjrau4cSLHVT5sRbqj2XG6rSdZKUx8cFbG/p10b6QuZvtWoY747aDZs+LZ
	 6Zc3+ikPC1SUf9Ki+kdseD9e2r5NF8EwajvHV+bWV/PkgYsyDbzOhs4xVhh+z69PjEjy9
	 GYcB8vwFV1m1609pCpVtnBkQRPd2Yc1h1Lua5L4eE5KU7HhESBcFMH6qfDQd3FcN5HDxf
	 ZNeV3bYTZKoVJf3Qbur13i4LJ91xTZ66kOdVBGtTmKVSM0UejFGJcA/NW6BEjMGus8BBy
	 fQOk+umh7gY3CARN1xk4ti2c+rvG4pck40TZXVpvDsYFtajQmgOgK1YfydVQzRovybQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648161;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=z0gtRtzEjDmJhjMksW6xU2lmh4A4G1ecgsW1dZjKZro=;
	b=5CwVOPB1MF07c4kuq1+wQGCpSk1Hcg6F6HmJ2yP5hrW0m2bWVUUhuK/WY+vo1ET9d5gw
	 vyPj0mR+kywH7nP6Ow7Ubj8XcbQ1t1Fy0IblOPoZ3dJnFY9DkcGTV3mlc6q996bQxYr4c
	 gIp2amcr/yPwdux1xlIosESsc2NtS/1+u2EhfcwpgK8qkMNiLDepWVy61JcVV4aDsod9V
	 A0DtLInCsYGeI0cNSWnASJCGsZraiQA3EBAp8b5N0dIylroiMg+iuBMJR5kxX3wTYwzBr
	 WBiXhHsjxNcxKDX4oYsgUeczLQUG/bv1nM07BpxloLiBzG3fl8dUPbU6RGbY5ZafVuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MSH8BSjc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ShdC299T;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B7606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E2B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MSH8BSjc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ShdC299T
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F35C7A00DB
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 01:49:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 01:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792648159; x=1792734559; bh=z0gtRtzEjD
	mJhjMksW6xU2lmh4A4G1ecgsW1dZjKZro=; b=MSH8BSjcheQWtLLoHyOVha37rZ
	m8TAIlpueLRr3nS6xcKbWj6CxjLsqhynG1RCQ68ksJeXw1RiUlZBB1ZxS9vzFvIK
	SWdh/wlgDG2SaplUj6sJMGs+CIOS+LnjqwYKDM4fw6ewSHD4DdEqO4uKP7BYY3g6
	yTlXlut4hucJpnvl1pH6gydeNMka7tJlHPF1X0Azk9azifdejb0nymqMwl0KGZdH
	f2k4rRzQUm2tHQCypQLleYz1xt+AjyFFfdskK97u/TO0FQZMnh1dtypq8JBs5qqv
	R7pTJdUGGVShI6KGiwOnAx6OrpF1IraBPzFDd8CzImhZmDlyVXlb341uQjQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792648159; x=1792734559; bh=z0gtRtzEjDmJhjMksW6xU2lmh4A4G1ecgsW
	1dZjKZro=; b=ShdC299TIPez9epAVe0FZ4EbOfEP8LR38xCIEcGHaRG+eiL7kzL
	gX9JvmHM+6g81i24FsJ1rFEHAnVgs4+S7GdLXptQCWVywvpE3yuqE8BEEekxJH/j
	bofiEJUidF2+N/dZ0UA4kFkOulmv8A3qyI91xuIl3cVgBLeXJG9FD/XO9jcIPyYo
	FfZbzmuWu2xaFi7z4NRyFTobelTNmN7MNVmbnO16TSpCOTUDHvSM2OzASsFNUwhh
	bVXJcA+Z8mAxtprirZ0eIB8L6gMf1YaCLtlInR7iDtA7L9CMRrcI0GLv5BgaoXJR
	XClAo8v1t8cFIkikmOA5PTUK4YpsHAjV7pA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792648159; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:BfXk9ijKq0hvFfnHzJ1EHbwdXuG3cKCrkQ8Kpp3iDcXlQq2
	X+hnMOIm6yFXEkfBcEod4OqWEYBeXWr8S5JWttYIxnlTh0q/L6unJjfsqHb+FUg2
	9H3JspXVc1m1bPBLoChlC09YIRtqQCk2DBT6EcHS+DkpWkpTZUfCnQK4Te61Yc7y
	8k0AeMbdFMXn/khWpuAdzYwLGXUc6NstsHXWwZnSYAF0sg41dJSKMB2pjig2vRHZ
	9VV25h/t99VN1zrHZj8zaUh3iQiZrT95fnuEsXo0ZFmFUhd5CsPU5hLBgwdoz8wT
	8uzhb95rI52lVnfwfRCKZ0amyFB2sZ/dFcl1eCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kruvh8oG+Vtk7N30itDtZRkYeu25hEXYRTXYFZJYhic=:dzTFUKDk5IssjngbzWQJ1B8KdycAKZp8Hp0+PhobioQ=;
X-ME-Sender: <xms:36PZana-v1JU8Gnn7Z1Bk6-6al7gLZUMMypQ4ZwJ1VrZ8l56Bcqpeg>
    <xme:36PZalcX8_dveXF-x7kxcVPhSygz37ypnO8e8Z3V7P1XNCVSqGG084WALzU3hdxB-
    zSizgJbPVHsD2WgLhdNrlmRCrlts7Zv9OatAERKMHD1aKF9GSTY7tJX>
X-ME-Received: <xmr:36PZagLYOYNuLnOLPfua9CPYdyCRJPSHjiOBwC-ZGYYs804G8FHFYUqv8FHYCN8vdNQExRYbYHMtCNbgZgkY3giC_xgNYZ5Y-7ZA>
X-ME-Proxy-Cause: dmFkZTGkedrRIi5Z1B3zVi5z+7n5lndU2o/fFfOw0GdgmiRK1dc6rMcmdPpvBvtvRszh5A
    zhYnsFD6GVv9cF1xc/99TGD9naOncSfirnLIlTW6ZoprHxfxo4gy5/yGp3B/RuYW3oayPi
    WpRGfDDmjwtyU8dsPQtTPRYatF7s41SMq8qTbss6+Q6v4tV/PLNHuYTesMf1rPpTPSmE5k
    pd2oDMy+h+zQpcRCWkbhKiUa1/lCAfMx/p+3qM3NjRRg69dsDsAP14C2T7rU+sNk/+3dVs
    fMYFZMx6ILfi/PftavXXLGu2Bm7gwhkA0nAPlv5ZS2l0qHHTl+CHaZvymq905zPxfxEYqT
    NeIKNEJsXYOBIhB77FaQMmqWJZTk7WEwYT4K7z5Gbhq71rkdwUyBLCY5YOiLf3CsetbSG3
    JCsz6Md4hB3ANE0CHk4tBN0DS9nig2m5AiyxUZsnFOLPXWSHnisUOWMuIkkFXEOIzhJhXl
    XUyhWCzdv13zMVvvl0hF382/NHRY+oqHXPXAYcYMytJfezJOzSZgXjj1G95HwJv327vSix
    LRUUusMxlCb9jMPDBjV2EslSL/KZuKCpJkjJ5p6+BQLVVRw7Z3fQUQDDKTsSVGynVd+BI1
    tBYebF6IIzQKjzADi1Djlc6/0FfY9/vYyv6iVF2o4Q0qrVs9fqoWrZASb8iQ
X-ME-Proxy: <xmx:36PZaqLicyqJ0QxoXPjvRhYpEFcnZxiRNtnj8pZinzbJE97GuBx6RA>
    <xmx:36PZanWZi8JGNVzUpRVB4Yn4nhDRA0n6WKox1cedtZru44jiJx1ZAA>
    <xmx:36PZarly4w8gRXFMqg9aj91RCBAPXlbgmD4Zj17Dp9pvH7jRAxYtMQ>
    <xmx:36PZallfOdCYaKJySbWD-PXnpJ0sqeGYAFukTZ_swuMBFXTrHzTfYQ>
    <xmx:36PZapcBU_3hNKvU1G7CP1ZbI319GK0wjxrxHZScc_7SzqhLtFnFihTG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 01:49:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,
  Jasper Mayone <me@jaspermayone.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 21 Oct 2026 12:28:34
	+0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 22:49:18 -0700
Message-ID: <xmqqjynajndt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series finds the first upstream commit since the fork point that has
> the branch's version of every file the branch changed, comparing only object
> ids. With --squashed, a file that upstream also changed counts when merging
> the branch's version into upstream's leaves it unchanged. Timed on my clone
> with 65 branches, this takes 0.5s.

It would be very surprising for the unsuspecting users to loosen the
behaviour of "--delete-merged" like this series does.  As requested
elsewhere [*], do not change the behaviour of the "--delete-merged"
when no other "please make it looser" option requests otherwise.

 * https://lore.kernel.org/git/20261019044005.99247-1-me@jaspermayone.com/

The attached new test illustrates the extent of damage.  We add a
file on a private branch while the upstream adds two files, one of
which has an identical contents to our file, under author identity
different from ours.  If we run "--delete-merged" in our repository,
we should not lose our branch that we never pushed, or asked them to
pull, or anything.  But when applied on top of this series, we do.

With the following applied on top of the series, with all changes to
builtin/branch.c reverted, it passes.  Of course, later tests that
assumes the looser criteria is used without an explicit opt-in will
fail with your code changes reverted, but that is to be expected.

 t/t3200-branch.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
index f3980106fa..adbcf937b5 100755
--- c/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -1925,6 +1925,39 @@ check_branches () {
 	test_cmp expect actual
 }
 
+test_expect_success '--delete-merged does not delete unrelated branches' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b unrelated-topic --track origin/next &&
+		test_write_lines 1 2 3 4 >file &&
+		test_write_lines 5 6 7 >elif &&
+		git add file elif &&
+		git commit -m "add file and elif" &&
+		git push origin unrelated-topic &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 >file &&
+		git add file &&
+		git commit --author="unrelated user <uu@example.com>" \
+			-m "unrelated commit adding an identical file" &&
+		git checkout main
+	) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		test_must_be_empty actual &&
+		check_branches <<-\EOF
+		main
+		unrelated-topic
+		EOF
+	)
+'
+
 test_expect_success '--delete-merged keeps cloned main without explicit push configuration' '
 	setup_repo_for_delete_merged &&
 	(
