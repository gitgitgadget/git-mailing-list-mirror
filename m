Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538567;
	b=5HgZua6pqxz5NVnc9AchUtT8qsOdAKUaYM8R4pJ6WHN/0j4cEZamJfx9VJaDF02yrqfY
	 skxvT4gZYtwRcbMtyZig4VsmTkbpMu8fw2U9wSD0haxKEWvmXJkHusQRwXdqSjqNuZjZm
	 S13FqVZ3Gfvk16JkH/s9abjm5VGCb0z0++/7C7RCYclmynBB+8jkGEt8E4QOovv1+erYY
	 EvgdfRDMudWTb392zJv0ryBNwugawQa0pS1EAio4wpqeuDqs6xCGjRnoafst0woSMTmuc
	 AN/dKa8YCruTAX467DBd5gXPSa8hZAbAq0qyvdYV3v9ZZ4yuKci+VwHqd6KEe7mqqsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538567;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Ehgsg4O4GeSIuRN2TDB65QUPO5DFmwjBjEoWX+0UI/0=;
	b=C0taniXzjlJUsnXOIJ+QtSJKiqtSZHETtEf2jJw2FGi3c8TpxgdQKIqdrnob8W8CU53o
	 QZCK15hRiLohLWDZgEWobN+KJ9BOQX4k0rAFj/3PqU3Q1GuI+ew2miAWnrgCF5B8Y2dFa
	 7e3sXNJ7h0fkgDNlhMmad44In3dfcV3QQmqZMrPqL7uE5A+nBQ7oMlxi9MLUMwfkCskDj
	 Ou5o4Ns9fWcBHjIRM+AjaLHqkawnSPebVIQPhOdeahJWL15Li4jSktrXX96P3wsT2B0p6
	 85ztiETQ2fr640n+kZ+3YuoyV2w9fkJseQU1EafqPYzDRg+eeR/7AxB+XAljgZFDcLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JhL39ELc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c8uwyVXt;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5B606A31F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D5B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JhL39ELc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=c8uwyVXt
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D13B14000F8
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:22:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 19:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792538566; x=
	1792624966; bh=Ehgsg4O4GeSIuRN2TDB65QUPO5DFmwjBjEoWX+0UI/0=; b=J
	hL39ELcf1e7MUoEikTw1VSQwmo3VuZKZ3Q7FnM7H0/fxURbWfC8OKJHWC47Pr6ce
	ATlsT1noJKaFcQRWfAY0pvTvLyJfqmEqJONLksuM9tIPQZKEyHuJrZQSD1aaRcIw
	zzuJuAbg2+J3yBrY5qZ527dvX9jL9qQCcWjXgo48y3iWvoNNpbnE/9uGuG0ewnhi
	AnOL8KkRT2AY1xhjwIEz0FleCst7pBJdCNeoQetzn9X1qrRCNHAmEdq7hAyC0SsG
	Ox17ugZgeCdHhLVbJf8yPTiLLHyq7L1fX/gMk2rZwhS5ketjW6WFgiCIeMPC4s3o
	T6kV3cL/t3E/omQQT/ukw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792538566; x=1792624966; bh=Ehgsg4O4GeSIuRN2TDB65QUPO5DF
	mwjBjEoWX+0UI/0=; b=c8uwyVXtPdEotwo3aLBZEoOSMvnwWP7tJuCf5uF0pvSi
	LU+IFrwlC9ieJEag0A14jeP1zkM+TqwW2DCmqHghOKf2m7N2NfI5ADU/yPr2CfW2
	dVakZbkBqj33MzhjerX3rXfcpp26DYfDFiE5NWhS0ubUT+AA/03ha+bmhBM88m82
	VYCxHhJ/wkoPt+Vdg+uDr1IV1v45HMmpUikUSmXlfw4wI5gEZghv3HFJsKFmmgGo
	9uvE337O6gxCdhnI/1+UbE0v51LO+43GTYsU+OkQtdQRQlyRuBOuqHpIl3xA0xfM
	jX1mBJNI/YllbLn2L3iGIhvUZzJsC/78GpamaD6/kA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792538566; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LyeGWFoh8g63aMS7PJyFeL9YwQN8BepTDCgxjCaZj4NZp5N
	0oMGbxZC1/dVrQCaSkR/TlcWn2WfJL8Q6zX5xLlAqVEiCg/hinBxmXMLMT1jWDnc
	jiq7q4w8fcT4xOVjZklHQtEM/a2OiSEZ05C13djv8OhDnNJeFoCQR7IDE4N/ehcC
	Ch3+HPubK9GUqmKQ72My/s5yy+JBqD15JHIY/SJ7Gny/bmwMSaCmcv7wGRwUeJxd
	fWzhfSwDe0+TMxAyQZ0hvXHONCXHixN+Vy5dfUm+tfp2dymDAJ7CPTm333m0CfgI
	JKJGES2uJoTy1x2x4CtkFeLkA36/dddAJaRJGuQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ltw3xqq47/KvV0KZ2x2Y8yJsJd7wiI6WQqdvnDqMYzU=:cJlP2cx5GNP3Z7YsF64m/v9OxPxkOkqnGXNUhXPgAFo=;
X-ME-Sender: <xms:xvfXambdwkf8ZKmgIegKNAgtfZBxVf7rrmw_8NlU1MHVvH7tHx7oeQ>
    <xme:xvfXavaHfQeZQ97ZNi3W6F0i6AEJK9xm-oePM03bYyjimvjSdYuyMA70B3XT_mS_3
    8ALvETd5dIuq1T8Jj2BG8ASPXTH-CtZjrkMHemd6qOtluBjMUiKQfQ>
X-ME-Received: <xmr:xvfXaundqtcVuro3psEbCvvjxfg8KvoAkcsnnVW15JGaSWCSEMu4iqGhWhCVOTATUvGrT5DBOeimnmlPKrv0yf_7_BtkbOAy1Xjw>
X-ME-Proxy-Cause: dmFkZTFn2kAI+4nYpWG3e9KAYFvRAt2+ajepASQVL5bXm80e01mIhKm5qJJ8sA9PiPMqn9
    FX2JBA98rakelbM96TzUcqY42mUvRPof7Xr5cACJH5XiLO57qHgZziusRaCg/FkX5CoWui
    6058e4mTDkJy3iJ/XNpxySyef/D0M8y+pZCX27T2rWaF5hzu8sN0HgKZYPH7GCt02bHhMb
    3wy77J7/AetBRUC/y1iFCFRC04oNP7FwhSOJK7W0ZNJQwXO7Z33Y266Q7cUAbbUwfPpLd+
    fwa+O3UJ/kJWciOXETxFI7sIX6Ikx6Zk7zZ4aHYleXQlB4jSErcIynTm0Ib5RuPh4pCVOQ
    9JL22Or6H1rMuADJ8t9W6PN4M1i/b+FcyzT3cyo+iTba6V4oZFmHTKZPUXccFHK5VfMHrk
    PtZk4MyXp4hxmJzK6VqfZl12jo6Pq/l5LRnmxrfzLmyplC13y0ZYbIudcMcfVAL+B4BmVV
    jqYk4prlWjb7ozGb7POMdUo2vEzbZIAzfWmCtWYK+cyR81s8IvnajcHsw8ezz9H4ijLkv2
    hMGuqCO0fgzZDMVdMSYQH+1ooAIxobSE1BkE4AAwLEm27Nznteo/RUdPz/g8FVAbdnlLz/
    EPN9rPuAADqdRKgO6VRVHS6HRcsQb6RN5qJth+naWH4vvXyjc+YFc/qES30w
X-ME-Proxy: <xmx:xvfXajwbxh__iwoDxD7uJNCPA3HwM_1fNX0vCDeZLHUq4RyQ1FdQwQ>
    <xmx:xvfXakP-55BY3ljR-wvd41OK7oJRUw_8evxP_U02glIGImM0Yi_k0g>
    <xmx:xvfXavRfkz7pU6lFNoeEUzc1lrDhUmyOXj_pLq3gkE2gFUFVsLwZjw>
    <xmx:xvfXaqbFefVeDdEp-l8eVbaeiFNnOLrTl2k53b3uCa-QqXoKoSdZGQ>
    <xmx:xvfXapyWQHxzIq5TFM263yPu84Am_2mKgOkZLeAuTelVT2dlDE2bEC-z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 19:22:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/2] MyFirstContribution: move "how to send v2" after discussing reviews
Date: Tue, 20 Oct 2026 16:22:41 -0700
Message-ID: <20261020232242.2217109-2-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-321-g29a826976d
In-Reply-To: <20261020232242.2217109-1-gitster@pobox.com>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261020232242.2217109-1-gitster@pobox.com>
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
2.56.0-321-g29a826976d

