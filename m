Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA01D63EF
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771168; cv=none; b=Vp7pUKO61BnAkJ263wLx3AphgZumKwIgEbo8ACbZd8PacKvLzhL+yd7hYurvvwajlgFq5HN3f0tb4zMeKW2fQw8B9frYqZaK047U/dCq28XAvLIMvuizGadke5FhZmPnBCiJcG35ZoUrl4eGHwsI6W4npSLvAYdq0z97PuxW4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771168; c=relaxed/simple;
	bh=jUQNRiCLjqmmD2jcL2vljuvbuM0ZsZqaLe+EXHjY9nI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XRLGig13b1RpHxpBgpNi0NkX9Mfg3gAVRCAPXGtBycvMRi0Dnd/84UyA+mIEVgCYwXUPbBAEUDkcjSPVCXS8l6RBnuchl6lKfIGo8IKNdo+qKJhSXm6PIOHe9mJtUBBeIoWg1sO0qfsQ2z0a5MDZPpwzZ2RGPs3l3/HwMSHkKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=oZwZK6xk; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="oZwZK6xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771164; x=1760375964; i=l.s.r@web.de;
	bh=LEprkzfE3JoUmx3PddStyPxG9giaxMFTyKeUJ3mT5Ig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oZwZK6xkqEBIyZXE9VB1KZAuGIEA87xQRY1kGG2vQyeyN83FcOBlm8WXye41tWRR
	 ttdNoOTbA3KfzffBVfNqNiXUcM9FxANP5eOIaA5nQz//RxHSFMZG1ws5s9A846oPj
	 wVfK0GqKZc35AEa78L7g9dol02o3iSKQ4zlhvLZvwet/1/+xy90alYU7LIZHpshBJ
	 XGf8aDF2m/ZAwSpa1yualj2sPTaXq5xFHuspbB3Ssssu5mASwAoBbuxq/yi/JQR5e
	 cbYbGdhBRDh4dMInzyd77ozK6rLXrPTIEnreRhkoOO6DLzR4TDgMfRogHtItSpp7K
	 QAhMq1FSXUShpeysAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7epr-1vDDur130P-00D7sE; Mon, 06
 Oct 2025 19:19:24 +0200
Message-ID: <b5034851-65bd-49da-b270-48b68d9210ff@web.de>
Date: Mon, 6 Oct 2025 19:19:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/6] add-patch: improve help for options j, J, k, and K
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Language: en-US
In-Reply-To: <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dErHYygEQmqSKp6GoL/OigJhC6vhgj4y1UBE8zdkPp3WU3ZKJXC
 HvWDpnpJIttqH0sw5aaoPmfhy2Fca7a4YENWtiiQpkSwd+aHbVm8pxoq1TZeb4eHt0H9Zj8
 KiN1vZpgXTEHYwsUfoGtHKYgIHUE85UPoTrdDDBMjl7flHdFgKrmsp5EYRyeKi9CCvEDEcc
 G9bfztvvZIs5t933gotfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:foB7+ywttcg=;QkRFpeOzsocin3DBZcC1NWQizzj
 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

The options j, J, k, and K don't affect the status of the current hunk.
They just go to a different one.  This is true whether the current hunk
is undecided or not.  Avoid misunderstanding by no longer mentioning
the current hunk explicitly in their help texts.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc | 8 ++++----
 add-patch.c                | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index ad629c46c5..3266ccf105 100644
=2D-- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -342,10 +342,10 @@ patch::
        d - do not stage this hunk or any of the later hunks in the file
        g - select a hunk to go to
        / - search for a hunk matching the given regex
-       j - leave this hunk undecided, see next undecided hunk
-       J - leave this hunk undecided, see next hunk
-       k - leave this hunk undecided, see previous undecided hunk
-       K - leave this hunk undecided, see previous hunk
+       j - go to the next undecided hunk
+       J - go to the next hunk
+       k - go to the previous undecided hunk
+       K - go to the previous hunk
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
        p - print the current hunk
diff --git a/add-patch.c b/add-patch.c
index b0389c5d5b..912266a3f8 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1397,10 +1397,10 @@ static size_t display_hunks(struct add_p_state *s,
 }
=20
 static const char help_patch_remainder[] =3D
-N_("j - leave this hunk undecided, see next undecided hunk\n"
-   "J - leave this hunk undecided, see next hunk\n"
-   "k - leave this hunk undecided, see previous undecided hunk\n"
-   "K - leave this hunk undecided, see previous hunk\n"
+N_("j - go to the next undecided hunk\n"
+   "J - go to the next hunk\n"
+   "k - go to the previous undecided hunk\n"
+   "K - go to the previous hunk\n"
    "g - select a hunk to go to\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
=2D-=20
2.51.0
