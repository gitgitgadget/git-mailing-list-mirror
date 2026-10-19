Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442631;
	b=OoI/kH+97zIP3+CprLzcYOE8hPR/Y23F5gKc4WuHIRiAsl9DBdeIk+4UkfRqSYKSitX5
	 cvu5WhGFFe3PN/fvyuUuBWCC2BXWq62jB23nNfUqTNBgJWrHrm8dJzhRimSty7ouvPSie
	 +ZapljlnBf/HOXb4404saPyNxvjxmK3Hz/XrewKl/1o+DZn8OMmizdC8a0s6AFz35wi5D
	 X/P28i2jnV2ck+Nu6k+JWBD99DipxrH3+lmuUzvoEB/BbAjznyJSZjwl8cI8nWGaox99F
	 xjcCqqK3Of3bjXsIdTPnzvXHm0q3wTNUvYE+XnXwtuGRtaMG2xwxvrw+/7GRi+sECQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442631;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:cc:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=uEGd6EZaiDqhcptnHj5abBAJRd1nl+nyOdQ+ux72gpQ=;
	b=P70kjW3DOp79tZK9Kl+BYFPMBM5t2hHkp6odwS4bRbN9D5yfw1gX8yCirtSpCYx9YMql
	 PQNgrfTNb07WOmmJvTOEkQHDVeUA3qG96xjgaN/a1kSZDIFyACWhldRq1FSpatoSrgYML
	 731Oi3ofkvwM/XzQpY9Tjsbv2p1fIUXl5DUKl/YOOFvgCG2+wwVC0/IXmncMcz5zim9qT
	 fW0Jl9IwjjxjlfdSKJnxrQUJizvy/fLtCMhtdMdt2BeiJdJ/JxJ6G/sBKSTZHoaj0y5OR
	 5Kvj7dyt4xXOEIBkZzFWtxhNxDauh7DGOhQXsKutWmLRLm1OHMwOFxg/tD7IioNkspw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=moP4KsP7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FUI0anbY;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A10606A329
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A10606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=moP4KsP7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FUI0anbY
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F32A41400083
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:43:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 19 Oct 2026 16:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1792442629; x=1792529029; bh=uEGd6EZaiDqhcptnHj5abBAJRd1nl+ny
	OdQ+ux72gpQ=; b=moP4KsP7INHn+XDB3sXFmZdSy2d++i/K4hPIWlxSmsej9TG0
	c05d0ySCSdCkTGF4UbqgxxmxNZ1xLqnv80A2yDMIV5uuN85Ttu1LeUU6tkScv66R
	Ub2VGL6v+u8LFisqzwEBO0qJ8lQbB+KV0T6WR1AsrwuaAzfFe6Zbe0nskSzY2d08
	XhWJRvYyWBl+rsW5ykI0pERanoLpNn9S0DjGDmhzboWrldbI/UnTQ802zCELOB40
	0bjhEOipavCw01tLNxlrt7SZserqLjK/pX49+oUn2qmd9Xr1LKcGqsOLeFcDZJ5Q
	FJvkZY506Bty7Htl6AMd23krVoV0w8YLcTlQrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792442629; x=
	1792529029; bh=uEGd6EZaiDqhcptnHj5abBAJRd1nl+nyOdQ+ux72gpQ=; b=F
	UI0anbYs9RnV6XgXoe7oaGxNBd0UVMTMjbZbJsGOkDHLenMqm77FSN+W+ncI8MR3
	y7gxNVdH64LmYpbkVZ+oaRDhJadz7DAji3TriByredLbLUDn6O6PkmBoIwvQ1Xan
	5DFH+792HmCSrBUw0e3H78biuSlR2gwWSfuUG2gfPwe5NsHYLoGB65dPJKD+SgoV
	wmlfPIwXuYjUSUNWAbZImAXvHog+LihJ9E3Bx8S6lpuZNqT7v5Vi0iHEP0Nz3wjx
	kCYkexYIGoPoBdsi4PzP4n3SR8Wtzdf749z0TXikJ+3VNrPeMbynMbjfJrflOqYh
	t5/IxtDkjGHTpj0GxGNfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792442629; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XQ4UnwC8W1I3WBmJ3KdMOoUcFloP2K7WACozC6clmdek+EW
	X42WcEixh+h8wMwTXGZhnRB9h1Sp9SPfov3Ib1+qHtzznsD5rswzSnrWITTSOQj2
	JThaYYxxX/8FZ8tPiVyC+ZNk5rikfxuKijgOyouYdN+43xmiY1ogDy7UhIQzxFdJ
	hoxrzg3oApnRA6sWpX2F6UG7dTaXCLLqPIgZk4W7fjkvK3XDj/nVUgj5bHGqvv5z
	gTiplkqB4cIGj2Jdfxghtc4BjjNUW0KGoRYamxUcs6zwBqzPY93bWuky29VFqMi/
	frPiuqCroND9NAosHXLpXnNVJ1QRNNLTW1tNwhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-type,date,feedback-id,from,message-id,
	mime-version,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/zsaXEO69R1EnZnes3patALVdmEX9YZiO5KsLWX3ct4=:+gzwr3TKPFVttHBiTZ04XEIUAt4gbGJMN3feh6FOPBY=;
X-ME-Sender: <xms:BYHWauqWU5wa0AI_X2MLfwuxg3TW18Q44h2cil_FvHKACN9gA_Palw>
    <xme:BYHWajo-FBjBciADmUX7nZKLyXgy9moOgX6_y1GqWi3M0s8fWSc3FYcfi6TkznJXB
    bm46hxqOKT3lfRhuB1K4VtEjtfeCwGh_AqdFpeB8dOaUT9H4J_Pjg>
X-ME-Received: <xmr:BYHWaoOo6If19VOboayz0yDCIIJwLvabpjnkHZr17OzK_WP7pttZx6z-JFmY5qE_NtLBuy4dKOMByomOszpl79pfsoiDf1lsD1VF>
X-ME-Proxy-Cause: dmFkZTGfVXggrMy5pvHSV+p47gkXjAslwmjYdKIfQeiPgX65Qq4sagzst8OJ035SqlrOj/
    MCo2weY7+BBi9t4BFLnczgXdCavz88i/07z4EL2K4PTTeEbkrW3QpnkkqDaN9amWOuF3G2
    BqErxcQ3RliQ7eVfE5O58CvP9JSE/0LUMsfrY1SEmdGSBYOMlhktivVGzP1Xhm6O765YjM
    x/Kb609JK+tUm71x2H/ovO9ImXaIQrbuKUDhfQTdDXdb5CrxUCnirfuTUAwm/P1oc5gdJD
    yAACqXb0Bl+2tCX7sTJZ8nzfnD/i1/zI1P1Cmsvc3T631TR85FAPO1jVYCp/Tk9mjGSygM
    E6GWSbNQGH8TW5q8k0XTWfUGmBL9XJEVXv4/zQhatWPoATQTMJQVM7c4j+wItOjKxrXpr6
    SzMD6OpqhJAvUoygROW3XmaBbmUHDIVTYu4iykaBJuHsh1qiZf/pORBAPG+30P3NSDUyDS
    9Vrb1s2PyXdXzwZ0zv1BauYK/p4B+mDp93teKOh/ZezikN5Hfy3DhmYrc5zM46I4s+tLtm
    ckDTE5laKrP5zNxkBUfI4oJjgHBkFYbuVM7mnNKLOIGq3m0OHZDog2IZgh/bR7CxRUkOuY
    iOViXiQ/gujPtOqJfRcRTtPf51zxX2l0SGXL81fTcTrSx/Y5mVcJmtR8cOiA
X-ME-Proxy: <xmx:BYHWasx_WbFTo7rhxTk9Yb_ZWJx2elG-6Bftc6QiU9U0dcAaYy6ZKw>
    <xmx:BYHWapvnPVGYdFv5kT1KZUscXiXPY_-6LiO1TVgDjqbdf6A_Ggfqcw>
    <xmx:BYHWat4s63Ao60Jx_bm2O_iyQXa9GXmoFyaZ1bOrwjkWk8kpCr6b7g>
    <xmx:BYHWagSiBMcvSHt8YTLkXr2tpGnFHcLz9MFpBebBsutJFkj0TB0VBA>
    <xmx:BYHWauw32SSEJ_yYRIVrF3pDFuz1RSjbwO2dDH-FpzO9D-SXbTmZdRgJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 16:43:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] MyFirstContribution: move preparation of v2 after review
 discussion
cc: Patrick Steinhardt <ps@pks.im>, Emily Shaffer <nasamuffin@google.com>
Date: Mon, 19 Oct 2026 13:43:48 -0700
Message-ID: <xmqqa4o94e0r.fsf@gitster.g>
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

The text in the MyFirstContribution documentation tells readers how
to send v1, how to send v2, and then how to respond to reviews, in
this order.  It is unclear how much blame can be placed on this
text, but it somehow seems that senior community members need to
tell new contributors not to send updated interations of their
patches before having any review discussion on the current iteration
more often these days.

Here is an attempt to improve the text by moving "how to send v2"
part much late in the text flow, after discussiong what should
happen in the review discussion.

Strengthen the language about not sending the v2 out before engaging
in the discussion from "It is a good manners to do so" to "Do not
send v2 before you are done".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 265 +++++++++++++++++----------------
 1 file changed, 137 insertions(+), 128 deletions(-)

diff --git c/Documentation/MyFirstContribution.adoc w/Documentation/MyFirstContribution.adoc
index 34bfa2e3a9..296ff97262 100644
--- c/Documentation/MyFirstContribution.adoc
+++ w/Documentation/MyFirstContribution.adoc
@@ -1171,87 +1171,6 @@ prompt for each patch that's about to go out. This gives you one last chance to
 edit or quit sending something (but again, don't edit code this way). Once you
 press `y` or `a` at these prompts your emails will be sent! Congratulations!
 
-Awesome, now the community will drop everything and review your changes. (Just
-kidding - be patient!)
-
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
 
 [[single-patch]]
 === Bonus Chapter: One-Patch Changes
@@ -1348,29 +1267,6 @@ Once you are happy with the result, send the series with:
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
 
@@ -1438,34 +1334,38 @@ substantial rework, and mention which parts of the current series will become
 obsolete so reviewers can avoid spending time on them until the updated series
 is ready.
 
+No matter what mechanism you chose to use among GitGitGadget, `git
+send-email`, or `b4`, members of the community will have a chance to
+appreciate your brilliance and will respond with review comments in
+due course.
+
 
 [[reviewing]]
 === Responding to Reviews
 
-After a few days, you will hopefully receive a reply to your patchset with some
-comments. Woohoo! Now you can get back to work.
-
-It's good manners to reply to each comment in the mailing list discussion
-instead of letting the next version of your patch be your only response. Tell
-the reviewer whether you plan to make the suggested change, keep the original,
-or pursue a different approach. This way reviewers can respond to your reasoning
-before you spend time preparing a version they may not agree with, and later do
-not need to inspect your v2 to figure out whether you implemented their comment
-or not.
-
-Reviewers may ask you about what you wrote in the patchset, either in
-the proposed commit log message or in the changes themselves.  You
-should answer these questions in your response messages, but often the
-reason why reviewers asked these questions to understand what you meant
-to write is because your patchset needed clarification to be understood.
-
-Do not be satisfied by just answering their questions in your response
-and hear them say that they now understand what you wanted to say.
-Update your patches to clarify the points reviewers had trouble with,
-and prepare your v2; the words you used to explain your v1 to answer
-reviewers' questions may be useful thing to use.  Your goal is to make
-your v2 clear enough so that it becomes unnecessary for you to give the
-same explanation to the next person who reads it.
+After a few days, you will hopefully receive a reply to your patchset
+with some comments.
+
+
+Try to understand the reviewers' points, and ask questions if you do
+not understand what reviewers suggested.  Reviewers may also ask you
+about what you wrote in the patchset, either in the proposed commit
+log message or in the changes themselves.  You should answer these
+questions in your response messages, but often the reason why
+reviewers asked these questions to understand what you meant to write
+is because your patchset needed clarification to be understood.  Make
+a mental note that when you send an improved version of the patch,
+make sure you explain your patch clearly enough so that the next
+person do not have to ask the same question again.
+
+Try to find the best way to improve your patch they are commenting on
+together.  Until you are done discussing the current round of reviews
+with your reviewers, do not start coding, let alone sending the next
+version of your patch.  This way both you and your reviewers will save
+time.  Reviewers can respond to your reasoning before you spend time
+preparing a version they may not agree with, and later do not need to
+inspect your v2 to figure out whether you implemented their comment or
+not.
 
 If you are going to push back on a comment, be polite and explain why you feel
 your original is better; be prepared that the reviewer may still disagree with
@@ -1501,6 +1401,115 @@ changing history, but since it's local history which you haven't shared with
 anyone, that is okay for now! (Later, it may not make sense to do this; take a
 look at the section below this one for some context.)
 
+After review discussion concludes for the current iteration, you will
+work on an improved version of your patch, and you will send the "v2".
+
+
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
+
+
+
 [[after-approval]]
 === After Review Approval
 
