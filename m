Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4916383310
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447294; cv=none; b=hpAGN5nwW7QfUqHSsvyAC7iCtfq2czoDfJiWubaHbRD1VFujd4lhEkQkT0Il5wEaeKdpTl+kYkGg2LJwGCJf5fiRowp6N5k4s/sfmVucF/rAEasrsN/H3KmBwwacpMs21rz3ukgs7mghpXvWyuMU69brlrNajbRhPe7MC934gfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447294; c=relaxed/simple;
	bh=BWTUJaHKgWEMk07Ej1VijB/0JjJFGAhlR+jyXTkxJyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heB+HPDdY9dW5Ny+hAe6GPPtbJG/o428Ql13f54qQxAGfmbYXPwwTMRLoF6wjgpAL0VQJk06Nqxfp3Qj6hII0hWozn/WT8j+NbbTNQqiyxhsrGI1oPEv7Kab4jZRQ6uPqXVo0JOvDZQFOuEuyIAFmWxDRvb+NeqE0p0V91Z792U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hyqaTGnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMM3yHfT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hyqaTGnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMM3yHfT"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B57F41400077;
	Sat, 26 Sep 2026 14:28:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 26 Sep 2026 14:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790447291;
	 x=1790533691; bh=LV11iMzfMM3a/UVKYv+NRcaW/qu70KgqfI2N73ZE+kE=; b=
	hyqaTGnHh+y8x2EBZ26AdXHd0wXveJNliSOv2CAeoFc8943iQ4b+4vgcuS5dREfh
	MTVsyXYlw9Bgd0QJS5eLzCKXl5qo4S/vI3D+JrD9yKFvMrZ7lMehBZlHzM1v+tZt
	J0M1x/Kk9ev7MytNBAqgYbs8f15f72VV71QiUlYYw6bzn4+lEoqgAhgBTyNxuXd4
	pRuzMVZxLXWSwP9L2OP26jSOQ7t8ko3EBWFtfudK3DVU8M8SbW1eAtg9q3Q0IbxU
	SfQwAG3rF7qUstK5xMzqUzXJnrE0ohZ4jb7jgvvGJ83C+R/xVxdRvZkGgLVvMXBi
	sLm6IyBkH0Zqmlebo6pSCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790447291; x=
	1790533691; bh=LV11iMzfMM3a/UVKYv+NRcaW/qu70KgqfI2N73ZE+kE=; b=f
	MM3yHfTpIWkxoGvAHmtDQij0QDzA2YfrZU1b2SRvgIZu1ko5U1P3qn9jYQjz6q7b
	7Xa/KL+u8bC4tr/UgntOjCggA8SZRF7PI94OIlE5RY+c1WR3IBAGQ01i0C5FN4kp
	W+RRYX7OiS1fLen+/p58JO6jUWOOqJ62RJo7o1iOwpp0B2TAQz2IOgDor4xLX8UR
	ThV4whx9BAnNq+0f7MWc6eouL/W0pJ9f0XIf/iE2djof9nb2QNyzL+wkzYEDDWuC
	4YfVPp+PeD5zetf3AGcYa3b4wfMWpb/+P4RTc/WQT+n8BDnJr8F9HsgjR8+CnRAA
	gcT/vCO0Mun6yM6FXUJag==
X-ME-Sender: <xms:uw64ahLAbRyGaU5cinlMtId49RqQiaC37oGmUqW8sUgDdDGTHTE2g28>
    <xme:uw64akK0EcVnL9ZXyhMsO5ky-L6-o3pJgEqfo_pKc_kry3AQlKv1M0_QgAiz9vIck
    oJHo6c9LYKLcZTY9CaGZzzYDqguukz6CnLNosewF7bX8G-VIYBi1g>
X-ME-Received: <xmr:uw64ausZP6em9w11oBvLt28jgDFDYG-yL1R45MXoBNFoKsNQM6V_b8LEI6XzCig7EzhnufHUuw1d_1Soqq7IFo65E5shO6pfd8jO673W3thtnwOG1DICt14>
X-ME-Proxy-Cause: dmFkZTFr/NEPTwvB1098QkONP/xQ4mW/Io7iOd852zPxE2Ju0djBUUWzud0oyAGLkbCBhM
    TIAZi9IGy4m9NgpCFwdjYl6PiL6hM027vwzwihDoT946IbhTME7nwxjyW7CxFZmR/LKtHf
    F175y8mWAi1Ozf0g7zC6+Uvn67j6oPxM/+50NXHYN/MSPVNKImPZ3Y+NaRsLr6PG/E98jd
    QZIauZ7DuaoIkwI3NSC6GqHNZ8CY1+/fTrN21jlUjSApM9+DYGseCJvPNPuU8SqzxsP6PM
    cgVUsRPkgBDWLWtwEqP69fdWhrlZ7V5WnBwdTldzpfH/oD5VPTl9IiEeWgs0vsVIp1NxoU
    6TRxk5AYCUjeEuy1wt8c5Thbl6LD1Ig0SeSaWEbRQE36gpjZxg80vt8nVxdlH1DKwQvVGM
    ZK2ri3zMlGQQzEB6pK4S5Qby+kprkMM3EFstTXh3pMa97IhEKKUlh30D4tKq4pOmnKTZ96
    KfWREehN5UjkEGq2sMlH47c4IrI99/n1t/jjrmnYWiYff8d5OHqZDAd3RKXBRyRyQKRJvt
    fQScbOJAb8PYxO3iwc0J8+6ENgt01cF3LoTx4jYdRTSdx8BWvm0eKV8P1aXfRfFQjKVo5+
    kmtMzuXR+BAhglXNcE5b/ExlVxpwFweXPAt8dbUjEkp3WEuQok+H8JeCPDDw
X-ME-Proxy: <xmx:uw64ahQ5624zOwqgH_0gQ_oZThPnF2OWvutAimwJkmtMFY_6-IljOA>
    <xmx:uw64akN7IDP5ujAhk2bqcruRyiu-P2v8g0BFfCj1Z3NI8DQEZ83FRA>
    <xmx:uw64amb77P1jzil59G_8rUu3B9vbuW8xg1YLd3VDjCqTiLi64JlmHg>
    <xmx:uw64auzBt8V2Tay4xtaMj1EOMUJHw7wVPisMhU5MBNxLDpsc8Plvwg>
    <xmx:uw64auOzQpsnO70sZWEaURdItb6O6coGN6mrwByhGGslLbko_AB2aRuj>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 14:28:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] format-patch: simplify get_notes_arg parameters
Date: Sat, 26 Sep 2026 20:27:45 +0200
Message-ID: <V2_simplify_params.cdc@msgid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz> <V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
`rdiff_log_arg` to `struct rev_info`. I changed `get_notes_arg` by
simply replacing the first argument with an access on this struct
member. But the second argument was already `struct rev_info`. So I
should have just simplified to *only* passing that parameter. Let’s do
that now.

Now is also a good time to format this `for_each...` line since it’s
gotten quite long.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (testing):
    just compile tested

 builtin/log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 350b35c5563..560af00e2fd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1333,16 +1333,18 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
 	return 0;
 }
 
-static void get_notes_args(struct strvec *arg, struct rev_info *rev)
+static void get_notes_args(struct rev_info *rev)
 {
 	if (!rev->show_notes) {
-		strvec_push(arg, "--no-notes");
+		strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		strvec_push(arg, "--notes");
+		strvec_push(&rev->rdiff_log_arg, "--notes");
 	} else {
-		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+		for_each_string_list(&rev->notes_opt.extra_notes_refs,
+				     get_notes_refs,
+				     &rev->rdiff_log_arg);
 	}
 }
 
@@ -2404,7 +2406,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&(rev.rdiff_log_arg), &rev);
+		get_notes_args(&rev);
 	}
 
 	/*
-- 
2.55.0.793.gc667de3f2c5

