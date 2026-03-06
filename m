Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7F36D4E2
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774909; cv=none; b=IBNIFeptBnz9h5/OLEd1PRZvLXyJviFZMj/PJa3pKyLN42/mlcZNMEJccyuD2kh4aPgCbNIx9nHOizxLRSbUtoZS7ZPAe7WM9VE7GFMnIGZhTrHLBlfWGpujm+A9mXPrCH9R4+h4k4uzJzFpr4u7++YQPZhB3NHRLWwIlBHgo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774909; c=relaxed/simple;
	bh=tEWnlRZd0k3kH1woVB/vYsUZ2o2WaT8V4MnL9lIajs0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D1Hn3BhyAdKYQ1PF2p8DGreaic8UO7SCnZtw0k+Ulow8JAG2Kp4+2TZQxqGze2H1G3KDUy05jvSeG/Fb7QseS8tW9UjijYASEvDYIfRLUK8tTFyLIztsgFw5JijcbTJa9iDsoAYzJ8jl37NgpJqXPN1GbUA7/fk6Oi4Syf8aapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=kB/idC1+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EbtFxGP6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="kB/idC1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EbtFxGP6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01D98140025E;
	Fri,  6 Mar 2026 00:28:27 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 00:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772774906; x=1772861306; bh=UdmibFIxrn
	Ep1vi4drHCT3wfLf65c+SRvmPs2ip8r44=; b=kB/idC1+WmBZvmiaSH3Gap61KN
	lAq2ObeIFVxCAWFwD9/S4tQiSghPADP1jZ5DYWRmk1b6A8Wk0PcTvjMrwPHEJmZc
	pAgAgjqKu99B6UxN0cpMOP80BF/ZmS3XhKcfNiNSQiLNXhcP6hZ4FElP2wQRD5Zb
	HdvwC8m5F8JdzzTRb347iwsdHW5oHQtGX55EJ5WoYR0j2RMSU0ljMi0IJzZlmHB7
	JxBD0Mlwwf3NwjKYP0bppT1JI4ISSv/WY3J0salBkVBEYmft2BhuAAHaRXMrMYuA
	8Y3RyncvoBaWZ9H7Zg4L1G+d+nOB5S/InXyes6iCA15QiqnMQEZXjrg7bNtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772774906; x=
	1772861306; bh=UdmibFIxrnEp1vi4drHCT3wfLf65c+SRvmPs2ip8r44=; b=E
	btFxGP6vH5nfBuvDnNEKbUAL7+1LMKfRSzvlmTYk98Icez6Bif3EuKpNpT7bGmc+
	zMUDFIbH6gatrIdXZbHJ8ls0ILZ+1Tr/U+Bk9GP0RB4hX7wnnSBWFKTQwAGfKHCp
	6lo59HlAz7zJauHgum5VxcJBLoqPtlyFKr3dZmIo5KzmKl9qzLGh7uYWDd2E7/bl
	7huiRF2wwJgDub+GX4/1RMYHhHgN4ab4NdgHmpq6oYd+tazdbMbe69OtV+IopoRg
	dtLm8h3JjYIHw3nFEsew2wq5OckXkkbBFxyzGH0YY9NtVFqk3VB70FNTuYiySM/6
	qvYA5JpoHCqSmBwC0imVg==
X-ME-Sender: <xms:-mWqaVfTAqhBEwI1FIXz7uE5UNVedjlT1q9u-nrEIdzYx6ucN63QnQ>
    <xme:-mWqaeD51jS66y46JNveQPiuniZf6bsoeTpYCjDc5aux7Ka6JCX5tTZi5DFAfS_Ml
    02XRrQYqXv23Cfw1gfD-XQTF70tcjxgaI6ejOK2_oeypGctGhU3HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhi
    sgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnh
    epleejkedujeeuffetgeevkefgfeegvedtffejhefghfegieettedttdfgtdefvdefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrh
    hisgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-mWqaUK-FA2p9LOPtsJnrgtP1F9jkottVmH9WQN2kb3_QON-Xbs3og>
    <xmx:-mWqaSGXdv3mrgM_oPwnBT3dUbrw5VI_Z847DWKw3udPXu9vv2H4OA>
    <xmx:-mWqacR8eFEkpfVJb-TXV17Umes-I521AI8UT4sj-AUJnVQtZZsS5g>
    <xmx:-mWqaeEirYq1mcpHVsbuG5Kq0E43Na19SobBITuCxi7YkJEB26aoew>
    <xmx:-mWqae8d2SEDesvtBT-i5OQ0KBPRlFpgbNk_NAPsRYMijy_7dR044uU5>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE4462CE0072; Fri,  6 Mar 2026 00:28:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 21:26:59 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <339285be-38e8-426a-add3-b91e14a8be35@app.fastmail.com>
In-Reply-To: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
Subject: [PATCH 1/4] git-gui: run auto maintenance on commit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This implements the same behavior as seen in builtin/commit.c:
run auto maintenance between rerere and the post-commit hook.

Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
---
(This email was previously accidentally sent with incorrect threading.
Please ignore the dup and bear with me as I figure out send-email...)

This always detaches rather than honoring autoDetach (unlike
run_auto_maintenance()) because I can't think of a circumstance where
you'd want the GUI to block.

 git-gui/lib/commit.tcl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 89eb8c7b73..4b07cb3bbb 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -477,6 +477,12 @@ A rescan will be automatically started now.
 		catch {git rerere}
 	}
 
+	# -- Run auto maintenance (e.g. garbage collection)
+	#
+	if {[is_config_true maintenance.auto]} {
+		catch {exec git maintenance run --auto --quiet --detach}
+	}
+
 	# -- Run the post-commit hook.
 	#
 	set fd_ph [githook_read post-commit]
-- 
2.52.0
