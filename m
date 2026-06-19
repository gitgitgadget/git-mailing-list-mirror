Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313140D57F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781847975; cv=none; b=ZPRiFExeiWP/ciisyTq8L2bj7OCoxMFvPbHpIl7FESTOZEEwfSTz8OMjkkyrOzGLduA5CRyIVUQFGO+AoPSRjyeWxaD1VBXQsYv6TNQZ3bMTBGaF8wTvu4CIlEON8zK/S8BspusfwpI9sAJZgzEFKNIct82VALTRcdmOVd5SKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781847975; c=relaxed/simple;
	bh=6KfbLiM/5UxGHLT4rKgsY9dF/cI8KqBiuBG1oeKHuPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Chre4ldcAkg3GqnRLKd1s9tatKwfoBsBF2ARDacMqVWkM727TJfxd06gSg3Aq41x3BEjLsc0MK03NOMRqsyeQ/Yr2fPcPLb9RBmv06eyAuF2SzWI2rdcrWiZ36/MBd0fS5RnA4XL+gCwsZU4mY8go4iEam7A+YvZ8fW8muIm+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F/zYMoTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JITgCAu9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F/zYMoTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JITgCAu9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 31F56EC01EC;
	Fri, 19 Jun 2026 01:46:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 19 Jun 2026 01:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781847973;
	 x=1781934373; bh=MbLdt7fk2qh4FLA0/CUepqO3mBx+MD0qhqC87NjBbgg=; b=
	F/zYMoTB2bpMGHqP5d1+xkGUaewAtiNp75pF+vlyTvutrbBKgtSErsZnNWiHDWek
	RPzlq0mFao6vv5+AcrMk96z+Be62azliGhpEYaRGh808HZN+7sIrZY0meWh7EtoT
	8Ja/t1UZCuQmDFfGy5FrRpFZoZqOfTUTaNDgG4sYGKIiYzC9jtBdPeReZVg9TMEx
	DggA1MEin9hsh0BLKpBR+LRfS28h4g2yuHgUBE+zhSF0FjYHqinAx6xP6JfFKi80
	A0478Jev3XSu3JorZ+NMqkQRUT7tBz76n3ZT8SH01Zz/IKtiXXHHHqFoaY8chcX1
	h3hArtIrIckiXvvwh5WzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781847973; x=
	1781934373; bh=MbLdt7fk2qh4FLA0/CUepqO3mBx+MD0qhqC87NjBbgg=; b=J
	ITgCAu9KjTMtxTtzGFErNkaHvw3DuiTA8DOireOIebVIcemWHYx+atX9ji65op6P
	J0FFR041HuUq1YbuMflKJLF1w0UCUe/FstilvYcoCw5G1s2blnhRw9XUeKzcphoO
	D3IkAjexsPoyXEqaUtBzTdnRM7K5AsKyG6Tr9n4oDPrLD6G7OOmlkfPn28IjeehF
	sgUyYw771Xz4jx5w/S1/j3p32olqMVTx+NsNCfCgdDyAk7y0hCJiSWVYvt/UJUKg
	8ljEpP7uiloYy/7J499HQkZd0wW6WmB4wHMnGLNSMLHNzUYP2XF1ZeWOinWKGeQZ
	8nieW90XovxKLzTeYSkmA==
X-ME-Sender: <xms:pdc0atDZTNhNWDdOeLldNP60nJtiejllLrv-5kPqsFJLV91CMWxGRQM>
    <xme:pdc0ai-V-wE4-Fvcz3G7DAQzcbL5N73F66O_fuADa21YvgBDgvx-O7m-zZAE4rrhJ
    trfsgmF7lvQ0IVqq-_w_PUPHHsT3B97FUVIboowaAvB7t88V4qTyA>
X-ME-Received: <xmr:pdc0al_H-F0HrberoL9ClHarzhcgO2vfhf3VuyHY9WY0agcC2JuPKMcfhRyyUfvymLRC84kQFl_rDDPhuJfYz_-ZHNQcrNPUPDQhmfFw2dbhQ7A>
X-ME-Proxy-Cause: dmFkZTGZQEK4KEvmdy5HXBpi304qWvpeR54M7kR3rn0yoepEgJ8kjc8dWFHDjBXYjGcf6Q
    hHYRCiCpFb3sA0l0AmyruiiZKzumtxQ0lSixR9NZEj2eKgXD2xYAiM73Eqe9DBG24MgmY+
    gVfT8zJEpcqqxPdvo5uo5CvgRbXz52iDVwkZ2jAzywYD1MpkaqUQUBu1fcUkqduX3ljzjb
    qe0sZzkV1D66Lzy/KIksNF2z66uc3od/ZMqWi7fH84vVTUkFoIZVvlNEvr+MEDnw3KitK+
    kwe+QswTYwm4uoT6dGM+hMxJKs7gaPqIv2k+Pc6L/bnZgbhR2wN8Pr0YJuIyHxYIgybYJ+
    sI1FCJnzoaJEAPCvgchmmhHAAz2Pd8RvnRFHF4hUuExUKGc1fkW5x8nXpRbzleCNBqXDSu
    AzP9VRZeqkRTqJld8HJAUWznzzymq9uXFrJUUziUdrapB7hd1GhCr2j7YnM2yiguBANMyi
    CamA4GXOeXbEHnbx/seUU/KHUpjmx0kDfHky4gC748QwMrqIfRy9xsYTRNp/kiWwQH/j5D
    7+FkYywTClYDBNgQzawEi0Vbq/Wr1H7y1Gq8R946Ljjg5eon5ns+MdaURi9vENSlRnjfgY
    XWOFejy4Xs1iybDE16N4uF3TzhkvFAbI03lrnTjpSPvweqD7Gh88VHV8D6gQ
X-ME-Proxy: <xmx:pdc0ahfBapwiDHE_wGNev_4g_Mvtwppjm1EEzt4UOokiBCanDCd8_g>
    <xmx:pdc0amFchODJdy7b3FyIhwmP8Fh3LCRUYVMAn5DBsD7YD6V75yOIbw>
    <xmx:pdc0anf8V9Vjrd6Yxc_8APJtfUbnJL-f7hHa7ok3uC01MlQZ6c0IFA>
    <xmx:pdc0aoFy0EC8kegNpDIDIKffPswvNJgZdXPIZ9eAoH5C2TDlLikOJQ>
    <xmx:pdc0arFGLH5tQEzNWzFVKJAKe84BIUm1jwfSWI575NiO37Cqi-p1mgHd>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 01:46:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/5] SubmittingPatches: discourage common Linux trailers
Date: Fri, 19 Jun 2026 07:44:51 +0200
Message-ID: <V3_discourage_Linux.9ee@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz> <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The Linux Kernel regularly uses trailers (or “tags”) `Fixes` and
`Link`. Sometimes people submit patches to this project with them.
They have their use in that project but it is not clear what purpose
they would serve here.

For `Fixes`: Linux has many trees, and applying patches with
cherry-picks is common. A `Fixes` trailer in commit C2 pointing to
commit C1 helps the cherry-picker figure out that she probably needs
C2 if she wants to apply C1. See linux/d5d6281a (checkpatch: check for
missing Fixes tags, 2024-06-11):[1]

    Why are stable patches encouraged to have a fixes tag?  Some people
    mark their stable patches as "# 5.10" etc.  This is useful but a
    Fixes tag is still a good idea.  For example, the Fixes tag helps in
    review.  It helps people to not cherry-pick buggy patches without
    also cherry-picking the fix.

In contrast the Git project has few trees (to my knowledge), and there
is much less need to cherry-pick fixes as opposed to either using
backmerges or rebasing all of the downstream tree’s commits on top of
git.git `master` from time to time.

This project does regularly mention what commits a patch/commit fixes,
but that is done inline in the commit message proper (cf. the trailer
block of the message).

For `Link`: These are used both to link back to the patch submission as
well as with footnotes. In contrast this project has `refs/notes/amlog`
for linking back to the patch submissions, and footnotes are only used
in the commit message proper.

† 1: Commit linux/d5d6281a has “linux” in front of it since this commit
     is from the Linux Kernel, not Git. Example of a Linux tree—as well
     as an example of `Link`—is [2].

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ [2]
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: Msg: it’s “cf.”, not “c.f.”

 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 4e8dea4eaa6..8d946e9acb3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -476,6 +476,10 @@ While you can also create your own trailer if the situation warrants it, we
 encourage you to instead use one of the common trailers in this project
 highlighted above.
 
+Other projects might regularly refer to other kinds of data, like
+`Fixes:` and `Link:` in the Linux Kernel project, but these ones in
+particular are not used in this project.
+
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
-- 
2.54.0.22.g9e26862b904

