Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703649;
	b=OqXmgqiKQCqK2Tg5MyG068UpZfwHmWNaiSZ23JCWZmzBOxyUqsMXiAvK/d6i54qtyK69
	 Xg93Hcb0a3FODwnghOdYukaOqtB8htViQX3TB83YAJD5eVB/G1XgCXz8TNRnOWqN4VYsy
	 i6Ocsqp2jUdMjP/Vm76g6eFyxrWcHY4x4VKW1X3Ahs0qSkKTqwISqkvdsLmCmioTV+Css
	 hxUjZfxc81oGLcN2BIQWUPJNVnws5O8g4ozoTbl5vB4FUPLw3e8mGZV9tOf+8oattIn+X
	 XkpUJXUH2GCXjfW8oYZGfP9S4UcZOFgPwlkWiChzsv9dInuxNHfBtNelNB3+nS0V8sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703649;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=D/rdU7MTCfQKsSnV0oCfg5bmhboWPoDuofq0BLLpJkc=;
	b=gfouwYOmlBE/lVBfq62VKxwP2K8JJwXyoL0pcBx6FLyoLYYQ6kn8Js5uo00t0UE77mAl
	 gpvlsA4aj3sT0fwGjSwI9BJGP309MG0FW9v6h+VauMGwRmmYyKggtw9sgkhbBXeNB2E5x
	 h8oGUm7uBkNkiMB0ire37mmgamshyzS7fOTO3dwdSBMvt3cFtpAcEPiG/dfVQ92RCpWnI
	 b7j4ytxFFyYYTEA5/WDVesBkq28sql2BCp2AldL7f0g5a3WfaUWZTOFkPChIi/3ifzRJu
	 keuZmTnq8PWSZRnoryyUiWRj+zjlTnwGiMW/ev7ogDIRWRObSgIWTdLwZfJqS9gAj1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="ix/QDOno";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="Ju6gf/dl";
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEC606A325
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27BEC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ix/QDOno;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ju6gf/dl
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 766D47A01CA
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:14:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 22 Oct 2026 17:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792703648; x=
	1792790048; bh=D/rdU7MTCfQKsSnV0oCfg5bmhboWPoDuofq0BLLpJkc=; b=i
	x/QDOnoBATdUTxd/6ypvfiY89R41ZeWU9MigPoKJNTupSqOkYyzVjM1I6wFVHvOS
	gG7v4YVfopXh1M/hvzMCTuMib0NGF/vKKdPSk5BLvvjQqI7Pzm0X8NvYqbw389Hr
	UmUnQ5LEReSu2nq2bWDAWonaORiGkSVubEej2mz+rhsS2mDt2NsBOhDJ9eMpCFtA
	k1p0WrJ1aiSGBTXyKAskRw/KYOccIQELF9yB8VkzQom/W2uyLoGL5JZGfdcdSs4u
	mYVFFzBLPAV1pDLYPf9dRm5rMKGQTZPqWqt7Is1VdKnytFkDAM3BgjcHgM+5e0Wo
	/u8ASexVplk2GMDBHRUsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792703648; x=1792790048; bh=D/rdU7MTCfQKsSnV0oCfg5bmhboW
	PoDuofq0BLLpJkc=; b=Ju6gf/dlIl5KMlaXMFDnMSKO0tEKIVH6/TIaRIK2EYx9
	4cBSnisgUTQ7f83YTJ//X/B7atZWAHCnu6/CTV+MG6ETEA56k436cgwh9/FRkAWu
	loufstXXDYdyzNQ9EeQNZBW8PgoixvnL6xmNbnDgNqwK6UcRL0qVWtzVdbNi3dZa
	/84mHhWJbgpRvfidz8jcjYlw+tE0iMPsQ39DdIEkaqWb7Z2BllTQdstICfDM+zv+
	k4NZv+qHkwaaoSQjoO0PYsZ3LY5vJ4xL/lrfTk/OsT7snFGHPd5zTNcgNgtb0iWZ
	X7feSB+BwlyrfcDqqj2xqcha9Ab4D2IIZCcLVI4bBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792703648; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LQX3dTQ6rCoYvqYTBWSPGQysMI6223bqAdLzS8OCGTTFjxN
	1qY311EjmQJrogDdvAXn1NNqqV9rGoNE4BW8mGP9EmyoBggrlmE6Xq/f+CYYVt3f
	gqwxrGDpngIG+EIPdmR22V7m2N4MtGNnfhlMHXILCqQkIwaaRhQF2a8/C7xcJJCe
	mWKZPbOSgHL5tsz183EbgVvsIPjtYf2+pOtKkN1oyV3+qDuhHuYgWdzlG90h+Uy+
	v+v0qZ3NVbxEiDB3wdRTf4WAo51R8xMbp9aZXQyb+kDJjw2B0Tk3gJE8gt8gJrUl
	8PmwrNKfgMLLRtjmx3mT28k2Rk/CxQW+gTo3yIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UV2n5j9xRMYQvJY2CG6fcPJIxmk48EqwgVSxnkWixng=:amIiN3xC4nd1D498uYXY2X9ZJl4IkrlFk2ji3+2A/Bk=;
X-ME-Sender: <xms:oHzaaptE5DZnj33kLRzRP7433F2jKKrEY_qEZeiYXcHnL132uCAWJw>
    <xme:oHzaaipuAVI9pU1ocBdXVde3qzzaJT-aqlQRSjJkZj-raLpabX1N01yr4f1Uxl01A
    ReNjpQQ55-8hS3IshhAGHMyWQVTmvbDT91T1azMal-mht47kK0d4CM>
X-ME-Received: <xmr:oHzaaunsJ1bFGTwGJnv_UQ7VfAYq4GzmGsdx_UcquYcgPB5GgQ7wXzma8rNsiYGxfX1CsEMtTQ0RzxcB5O9He2nBP3QHQL1gzzRq>
X-ME-Proxy-Cause: dmFkZTF0fMByUc88TSl+biHuku3qV1hNZsL5KCSIGvYDB0n5uZfJRFs2nG2Ezouz5A37DZ
    VwIuK24bQfu3dk3B+II/ZiYMHCS0YUDhJL8aUOxOh1SYhz3hNWghUhd0VIiTR0lNmmMNrg
    EmGQJ2vN9lhngwSsJELcpaYXWcJuXit09Qbt480hyG+LwG2snotJKyjH9FTAKv1EVsoSXq
    cfPKdqk8OsTuFeZ5jO7rOPPL4RUzoiQmJ7qiJHq64uQW7bHaEdqTj/ixGrfKA55OWft7uk
    8SeRbKHM2i2BUoNMmvqg3nVxpKc4F1OX27O8pRr3i/U/BZ83ibw2xk8aaB9iMdbPVWJJdi
    iKHa8Gh4uL6FCUTpe1Q0uN4peGO43hYlOM7ZXzOUFGK8gTY05InOWJ7cmwMnEKpX58gRZb
    gN/tMKfhmjGkWlaL5L7F1m3NJY5QJcLxcHfrQNeaAeG260jw/J+JnjevGBSsUquW2PdTvN
    B6nvShMjGts0Svdyh69enmU/+e4WV2EwVioBbcHgqV+ZxC7RmneCaKrnVLKeKwkLuWKbgm
    GEcnlj2a22Yu9WlEYgKCEoza/A+VkHlfeqz4gk+1je3IshXdniVKUOk7oMd+UkwOlY8uOy
    z9zevi5oSBsZ9nemeD3L8yglT1C84u9ycodRB7LH+0XPOchzGPI81ple6mNA
X-ME-Proxy: <xmx:oHzaauyya-zWqObVeS3DvO4kUOgi-OjAa5w8mlamMvZQNw0PyDqHHQ>
    <xmx:oHzaaukhw6O7AQLrjx3ZgbMEIKcEQ1zkxGqAOT12X94sCAIY3kfglg>
    <xmx:oHzaavd47TYEyba9B3R-vmm5VKPYzTPgwnWqD1I3FYec_CqwdRqEEg>
    <xmx:oHzaaspiUCX2DJO7m8Vh9dZmALNxvoOS2de7X9QLEIHpYfRiaioVSA>
    <xmx:oHzaasSpkl1xiITv7pvmKTfWW4J9_xw3ok9iMpD8Gv4G-dVoYYh9_tyZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 17:14:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 1/2] MyFirstContribution: move "how to send v2" after discussing reviews
Date: Thu, 22 Oct 2026 14:14:03 -0700
Message-ID: <20261022211404.380904-2-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-336-g6ca398b529
In-Reply-To: <20261022211404.380904-1-gitster@pobox.com>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261022211404.380904-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MyFirstContribution document tells readers how to send v1, how
to send v2, and then how to respond to reviews, in that order.

It is unclear how much blame can be placed on this text, but senior
community members find themselves more and more frequently having to
tell new contributors not to send updated iterations of their patches
before having any review discussion on the current iteration.

As a small first step to rectify the situation, move the description
of how to send v2 so that it appears after we have told readers to
expect and respond to reviews on their first iteration.  This step
contains no text changes.  Only the ordering changes, which are
friendly to 'git diff --color-moved', are included here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 204 ++++++++++++-------------
 1 file changed, 102 insertions(+), 102 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 34bfa2e3a9..682c797e3c 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1174,85 +1174,6 @@ press `y` or `a` at these prompts your emails will be sent! Congratulations!
 Awesome, now the community will drop everything and review your changes. (Just
 kidding - be patient!)
 
-[[v2-git-send-email]]
-=== Sending v2
-
-This section will focus on how to send a v2 of your patchset. To learn what
-should go into v2, skip ahead to <<reviewing,Responding to Reviews>> for
-information on how to handle comments from reviewers.
-
-We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
-mark the tip of our v1 branch for easy reference:
-
-----
-$ git checkout psuh
-$ git branch psuh-v1
-----
-
-Refine your patch series by using `git rebase -i` to adjust commits based upon
-reviewer comments. Once the patch series is ready for submission, generate your
-patches again, but with some new flags:
-
-----
-$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
-----
-
-The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
-range-diff between `psuh-v1` and `psuh` in the cover letter (see
-linkgit:git-range-diff[1]). This helps tell reviewers about the differences
-between your v1 and v2 patches.
-
-The `-v2` parameter tells `format-patch` to output your patches
-as version "2". For instance, you may notice that your v2 patches are
-all named like `v2-000n-my-commit-subject.patch`. `-v2` will also format
-your patches by prefixing them with "[PATCH v2]" instead of "[PATCH]",
-and your range-diff will be prefaced with "Range-diff against v1".
-
-After you run this command, `format-patch` will output the patches to the `psuh/`
-directory, alongside the v1 patches. Using a single directory makes it easy to
-refer to the old v1 patches while proofreading the v2 patches, but you will need
-to be careful to send out only the v2 patches. We will use a pattern like
-`psuh/v2-*.patch` (not `psuh/*.patch`, which would match v1 and v2 patches).
-
-Edit your cover letter again. Now is a good time to mention what's different
-between your last version and now, if it's something significant. You do not
-need the exact same body in your second cover letter; focus on explaining to
-reviewers the changes you've made that may not be as visible.
-
-You will also need to go and find the Message-ID of your first cover letter.
-You can either note it when you send the first series, from the output of `git
-send-email`, or you can look it up on the
-https://lore.kernel.org/git[mailing list]. Find your cover letter in the
-archives, click on it, then click "permalink" or "raw" to reveal the Message-ID
-header. It should match:
-
-----
-Message-ID: <foo.12345.author@example.com>
-----
-
-Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
-below as well; make sure to replace it with the correct Message-ID for your
-**first cover letter** - that is, for any subsequent version that you send,
-always use the Message-ID from v1.
-
-While you're looking at the email, you should also note who is CC'd, as it's
-common practice in the mailing list to keep all CCs on a thread. You can add
-these CC lines directly to your cover letter with a line like so in the header
-(before the Subject line):
-
-----
-CC: author@example.com, Othe R <other@example.com>
-----
-
-Now send the emails again, paying close attention to which messages you pass in
-to the command:
-
-----
-$ git send-email --to=target@example.com
-		 --in-reply-to="<foo.12345.author@example.com>"
-		 psuh/v2-*.patch
-----
-
 [[single-patch]]
 === Bonus Chapter: One-Patch Changes
 
@@ -1348,29 +1269,6 @@ Once you are happy with the result, send the series with:
 $ b4 send
 ----
 
-[[v2-b4]]
-=== Sending v2
-
-When you are ready to send a new iteration of your series, refine your
-patches as usual using linkgit:git-rebase[1]. Note that you typically want to
-rebase on top of the cover letter. You can configure an alias to enable easy
-rebases going forward:
-
----
-$ git config set alias.b4-rebase 'rebase "HEAD^{/--- b4-submit-tracking ---}"'
-$ git b4-rebase -i
----
-
-Before sending out the new version you should also update the cover letter with
-`b4 prep --edit-cover` to note the relevant changes compared to the previous
-version. You can inspect the changes between the two versions with `b4 prep
---compare-to=v1`.
-
-Same as with the first version, you can use `b4 send` to send out the second
-version. `b4` automatically bumps the version to `v2`, generates the range-diff
-against the previous iteration, and threads the new series as a reply to the
-cover letter of the first version.
-
 [[configure-b4]]
 === Configure b4
 
@@ -1501,6 +1399,108 @@ changing history, but since it's local history which you haven't shared with
 anyone, that is okay for now! (Later, it may not make sense to do this; take a
 look at the section below this one for some context.)
 
+[[v2-git-send-email]]
+=== Sending v2
+
+This section will focus on how to send a v2 of your patchset. To learn what
+should go into v2, skip ahead to <<reviewing,Responding to Reviews>> for
+information on how to handle comments from reviewers.
+
+We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
+mark the tip of our v1 branch for easy reference:
+
+----
+$ git checkout psuh
+$ git branch psuh-v1
+----
+
+Refine your patch series by using `git rebase -i` to adjust commits based upon
+reviewer comments. Once the patch series is ready for submission, generate your
+patches again, but with some new flags:
+
+----
+$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
+----
+
+The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
+range-diff between `psuh-v1` and `psuh` in the cover letter (see
+linkgit:git-range-diff[1]). This helps tell reviewers about the differences
+between your v1 and v2 patches.
+
+The `-v2` parameter tells `format-patch` to output your patches
+as version "2". For instance, you may notice that your v2 patches are
+all named like `v2-000n-my-commit-subject.patch`. `-v2` will also format
+your patches by prefixing them with "[PATCH v2]" instead of "[PATCH]",
+and your range-diff will be prefaced with "Range-diff against v1".
+
+After you run this command, `format-patch` will output the patches to the `psuh/`
+directory, alongside the v1 patches. Using a single directory makes it easy to
+refer to the old v1 patches while proofreading the v2 patches, but you will need
+to be careful to send out only the v2 patches. We will use a pattern like
+`psuh/v2-*.patch` (not `psuh/*.patch`, which would match v1 and v2 patches).
+
+Edit your cover letter again. Now is a good time to mention what's different
+between your last version and now, if it's something significant. You do not
+need the exact same body in your second cover letter; focus on explaining to
+reviewers the changes you've made that may not be as visible.
+
+You will also need to go and find the Message-ID of your first cover letter.
+You can either note it when you send the first series, from the output of `git
+send-email`, or you can look it up on the
+https://lore.kernel.org/git[mailing list]. Find your cover letter in the
+archives, click on it, then click "permalink" or "raw" to reveal the Message-ID
+header. It should match:
+
+----
+Message-ID: <foo.12345.author@example.com>
+----
+
+Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
+below as well; make sure to replace it with the correct Message-ID for your
+**first cover letter** - that is, for any subsequent version that you send,
+always use the Message-ID from v1.
+
+While you're looking at the email, you should also note who is CC'd, as it's
+common practice in the mailing list to keep all CCs on a thread. You can add
+these CC lines directly to your cover letter with a line like so in the header
+(before the Subject line):
+
+----
+CC: author@example.com, Othe R <other@example.com>
+----
+
+Now send the emails again, paying close attention to which messages you pass in
+to the command:
+
+----
+$ git send-email --to=target@example.com
+		 --in-reply-to="<foo.12345.author@example.com>"
+		 psuh/v2-*.patch
+----
+
+[[v2-b4]]
+=== Sending v2
+
+When you are ready to send a new iteration of your series, refine your
+patches as usual using linkgit:git-rebase[1]. Note that you typically want to
+rebase on top of the cover letter. You can configure an alias to enable easy
+rebases going forward:
+
+---
+$ git config set alias.b4-rebase 'rebase "HEAD^{/--- b4-submit-tracking ---}"'
+$ git b4-rebase -i
+---
+
+Before sending out the new version you should also update the cover letter with
+`b4 prep --edit-cover` to note the relevant changes compared to the previous
+version. You can inspect the changes between the two versions with `b4 prep
+--compare-to=v1`.
+
+Same as with the first version, you can use `b4 send` to send out the second
+version. `b4` automatically bumps the version to `v2`, generates the range-diff
+against the previous iteration, and threads the new series as a reply to the
+cover letter of the first version.
+
 [[after-approval]]
 === After Review Approval
 
-- 
2.56.0-336-g6ca398b529

