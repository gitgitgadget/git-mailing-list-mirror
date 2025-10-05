Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF934BA39
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679721; cv=none; b=lrLqPL19S8gYLBw647PNPW1IZ4yqESCta7LLcphNfZVsjBKLH2DZ2qbKFSVp0zRgk++LGIMQq1M8uab97dYyaqx2xhJW0dQW21+keh9vsscuN/LuTUObxUyxS8jIJDUSL/UqgTSkl/WZ6laOzA+QW92Gg/HACMHbd1Gl7WFANRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679721; c=relaxed/simple;
	bh=jUQNRiCLjqmmD2jcL2vljuvbuM0ZsZqaLe+EXHjY9nI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZjD0XhAmXDCvIfIhmUNAVQjkiVcLsZ+L7udk50PLYPt1OVAB8srnwTHwzGJnLndtUC6T9zy9ORfxdi0Wrsh5b+Yj0j6Hxcme45JvkE1LPjQ7bhRkOlHZv3BFIfuEH6JIGvPz68VzNKieUELZWM6udunrVhf7iWpXXqulrYCU8PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=muW1eUwm; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="muW1eUwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759679711; x=1760284511; i=l.s.r@web.de;
	bh=LEprkzfE3JoUmx3PddStyPxG9giaxMFTyKeUJ3mT5Ig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=muW1eUwmdu+Xg0LHUFoGfs6zuNtgEP0cebNtPwB8TMcTOOgpUkjHq0eZ9up5vLhD
	 z8LFzSU0Jf9bMNbF4ui1O5Cd+dH185QeZJNUhQ1eOeBquMHcvv33aIKW0sprXhUHB
	 HScnYKKyhp0lQwTTPU+t0WDbvjeXXK51h/hVbLwHWxa9vSeSLPWHfHYhmdxRx82s0
	 wu62zhy97X455HjrIajtRfVTD9pBLKI5LlHm2snFxldkog4aAB7GiKnF0rY/S3VYe
	 usvaFQCsLkQQZycRbzfXXfrgqK/PcZaWBhurFgBQzWdR1pK7hqvs2fjZs058NigYC
	 whwtmwoflQcLylRZ1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xaT-1u9uoO0wnj-00s4l4; Sun, 05
 Oct 2025 17:55:11 +0200
Message-ID: <75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de>
Date: Sun, 5 Oct 2025 17:55:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/5] add-patch: improve help for options j, J, k, and K
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Language: en-US
In-Reply-To: <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g/rWltDSoTF2ItBudeivZW3RsoO6tXvpBPU9WPttqcUDzN9L3e6
 4t35//4ttYiW9znOKXbUe/aYdpZvuuHryTyeNliMkZkvjrj6/dJ08eYN+H+HY1z69hKeJjg
 iowQSD4FnqhLGV4dO7669gkg7YeTlqH593t7o31rJBl06yujnVJRYYm2HD6qSAxkJ7luUbf
 h5HZSMEi7+nMadcUXaSww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0fe9GrePArA=;i+dI5c+ECgXLfrsGEUAaxBvRaZ/
 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
 aU6AJ6PK9NaINb/KnydYo1/2UE=

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
