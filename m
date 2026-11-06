Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961020;
	b=ijR64h8IaR68Hd3uqxjLQQAca4taHKtwGG3MvM3P7cvMh2ZrLvh8KqidMLo1PgvrX1i5
	 tJf6WnMzD3Jm8oY7tsSAEqnXghangl1D8ZvtKPyiajeCvk6vf6WWSHbV1/rzYQuvFY5pq
	 H9xyjtvfoJAqOu+R4glO5cXh/l4wbAiwWT+thIHJqqZSiukI1KTLwmgt01VkmT1Gm01xJ
	 onyqKyewilvwqMU1/4NIVgd7yWX5X7W/pCG5GX0U50voIsfIaVZ6hyPqwKbEkkc7XkzoY
	 zq+rA8H35ecJLZbqLWJuaFop/MUEmuyXJ1U2oD+vNlo5/Fb0ocEeYldSq52er+y9oLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961020;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xDyDq0Oqy/7p6vKPaEQeZA0s1tLzVlYIg28Z/fex+fc=;
	b=nGA1A1heoSwHulGPzlmD51c00bW7rpwzuPMzcq3HM8XH9OklZSUh5k3/r6gzaxwZK483
	 B4yJw7UWDpN1tkKFj8p2VZfQV6/XWYbxBS1HlkJpWNvHm30zpRUgVwhUg1O3HA69TV130
	 Tdpx8Wd4TdXFF3f7gfXtfAh0mAc9yE4ZzYVis1nfnZLOGudpf0jprs19p70TuKJzpfVYX
	 JENcHYhDHJC2JRP8iZmUVp1/SevumzJ7qdBK9wXQAa4rBWtHp4IG7iYnUeWpUGKOnQd3w
	 C+rhzE6GE7clnP0AisXOOlwL85u26Lxalorhe8MCdNmAI1X1ZYnRvkBO1PVDnE4J1xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dKnRVV9L;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kfK12Tar;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5F606D807
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D5F606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dKnRVV9L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kfK12Tar
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DFA6BEC021A
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 05:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793961018;
	 x=1794047418; bh=xDyDq0Oqy/7p6vKPaEQeZA0s1tLzVlYIg28Z/fex+fc=; b=
	dKnRVV9Lu1lUZ9ux4UUxfmBw/F2yyLEt8tOpHLk6ZR3QUfLbo6kWILV7mHYC8Ayo
	4w9fE40ZId1z+YGiRfBMtEkotW4FiHKPWUKzOBhbKdrbwKLn5RlpEOlksOG3COHr
	+LMkOItEmSt9kXm+ruKgbVKQg+/DL1p1FMrVFGW/32DQilWNbY6kh1R/W44fHhQY
	VFW5A7a+fE02M5xd+XxiMp02E/xmGm3BHYFL35vFSM2Gw6qGnE0EfKnwhcjERRcn
	rcJcvSdhYP9fHHhZfunqX+snu+7VEqiqBm8neIknwx4voTAEttRXDZT2a95eSgzW
	O5eipB3gQHNImTap+F50Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793961018; x=
	1794047418; bh=xDyDq0Oqy/7p6vKPaEQeZA0s1tLzVlYIg28Z/fex+fc=; b=k
	fK12Tark+VWJxUKXw67+ljUtr61qYgrtJCjHZtRWvP3m7AhmC9oM4D9tn9EV3H3Z
	rNhBrFuXzviHqFlavRKmE/Qeo+jLb7V9Wz4lWqYCNPeb/sM8PswaIDMGitOiZ5dF
	6n2/sp5VLIeKHXao/dmQemsidmSrYIz74gBgIBbZPrwN7neZmvBG+QJ+d7Bx4Rgd
	RTLPVCP2FYo5/U2932Y5CWZZInd03ZO5ysaqA5NRsLAtDjl2xQg1ePouwHemBB/G
	XbwVPVj1BUQlGqboF1apuOLLeNa1mfRlur5HmqInPUaV0ReqSNbwKOE+jVF1es6V
	tokS/jP5CZ7Bliq0x1rQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961018; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:TEKZdND/2zgIDjcDG/LSiH+aWZr0iVc1GgrnsVAxWRB8/A6
	qySn92EZuH74C6zNfGnuwQP+m1j6oXsdO7BQ2GLNhXi6j2GiqD+9Un0rhVxdbHh9
	hY82+GGnMZl57WoE6BzIAfycJNZ+eg1xkLP51kR8nhAL3dJHRp/yPrEVk6pi/VN0
	+p79FsllVcKF+I8kx9Wq1rgn5zlz5tiycRF3NuqWdEhZwUd+bfYUPuIDJ9ZhI5bJ
	9oPkF2D2TWsqUkvT9K6KHcJ0RVxnXLse7WKEP3sFd8+KAAWU3fg3D2H1VJ4YUWkS
	vMu8NVMaGSc0E/ic3S1X2QXanWDuoPbN71F8IkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QGd1YC6fRw8y5qUTWXLziwPu+iQe3K9jW3Stbzxcroo=:IdkaqBtA1O98YjGyaVcRweReFYz2gUX0rHXhNaixLyY=;
X-ME-Sender: <xms:Oqztav7IfhovB7Hu6oxXn2J2lwd3MjGBN3xIT0ThaFb7kAEyzaMfpA>
    <xme:Oqztaq5nS5eOxC7G5SRz9gXWSO7fdFvm5dvjcPAipVIT37AUh7y6pB_6QC5DwQ_5k
    BPQ3nEZKnw-RX5GcQIl_vXdsUZ_feuCqd14h01JWrJeFqxF94HoeYk>
X-ME-Received: <xmr:OqztakFv8taK5E9r9YEwef5HMZ-FHPTdCZXXmFeNXxvyJUBxQDVUc5TTudANv7o9J21v3w>
X-ME-Proxy-Cause: dmFkZTGy77yXrjJS9/3QcuR7pa91rjJ1dPHPAmws2vnFDxHmVCZo6/qAJbB8zn+b2xX8hx
    2jNUqL0gYmXt9xXzGKEDcwA1blLEETl+6XVOGQtnMu+Ta9t5IU46E5JxbMAmgkNiHg1MGN
    VAG4GvEz1F1J+wueIPkWbgt24Ugo1ngfnHYpa/Z3EAxOam9qrqbygvrjFqLNScL/8IhS+8
    sTI/RoIWbNkQFt1lWWykvjNhwEwEtIvQSYAsoyoJmt+rvTiqMJnjy+sOSK4vZskVf8VYle
    aeqGxJm9Exev1XYrfNyRB45oA9OHchQZMN9BaUT+E5s4Qy1+zrAarY0O0PGLzMMK99ucX5
    /sm3woRpKsySg8gzIXSVkrh88H2Em13nDX5/9r9zNQng90na9x58agBeVN53HhSEhiO7jF
    5Z4CyQtkNKqCuD7ZwWFhh7qxBqtDLtPk091kXEBkkU/KPFiuBcuOSHb+EOtqKYj9WgLFeq
    WTnajzQ2HqOrSbu5LNJqcmodzibgxpbZLQZ0pQydk8X1TvRoJchk5jRYpMThJRgoK0EitI
    2ujlIqOFd/qwxQCwt1R+uQr5/zvH/MakRgK8C7qtmZbvoK+R6x9GViSJPbNUn8ihecDl+q
    35WtnmAioRcNp4YoDqaK/IkJFU39A0XRT9/igTb/YxCeDY345JVxOyWb7scA
X-ME-Proxy: <xmx:OqztarQN9GohmoB0i8ciS0j37zev-EPVbQMYvmH-QdHVeFbV12lTaQ>
    <xmx:OqztalsL8HFgcyZIhT_D5tQGYiiRg2Eksr2Uj4uWJz_3m_LdelRt-A>
    <xmx:OqztaiyD5CyQiV2UDK5pL21DGh_bvCfV55BNVsWrW3giLMDEOhFfFg>
    <xmx:Oqztan4USluqpKsfNWd6JjnHLhQr7EwKE3viRQBQgzS_KJWp0CUH5g>
    <xmx:OqztaicdLp3z9LonHSAiWIu8f5NkWvu3cihwfRny4x4VadzU3XNPddd1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0a5c304 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 11:30:04 +0100
Subject: [PATCH 4/7] t0027: optimize how we reset repository state
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-4-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

In t0027 we verify our logic to convert CRLF for all kinds of
combinations of attributes and configuration, which ultimately results
in 2600 test cases. This is of course on the heavier side, so on Windows
this takes more than 10 minutes to run.

One source of slowness is `checkout_files ()`, which gets called for
a lot of our test to set up the initial working directory. As part of
that we both remove the old files that we care about and then check them
out again via git-checkout(1), but we do this one by one for every
single file.

This is of course rather wasteful, as we have to spawn ten different
processes every time the function is invoked. And on top of that, we
also have to rewrite the complete index in git-checkout(1) every time.

Speed this up by instead using a single invocation of rm(1) and
git-checkout(1). This reduces the runtime by about 20% on all platforms,
and on Windows this reduces the runtime by ~2.5 minutes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0027-auto-crlf.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 49dbf09da77..eefb346d11f 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -303,13 +303,15 @@ checkout_files () {
 		git config core.autocrlf $crlf
 	'
 	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
-	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
-	do
-		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
-			rm -f crlf_false_attr__$f.txt &&
-			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
-		'
-	done
+	test_expect_success "setup checkout ${ceol:+ with -c core.eol=$ceol}" '
+		rm -f crlf_false_attr__LF.txt crlf_false_attr__CRLF.txt \
+			crlf_false_attr__LF_mix_CR.txt crlf_false_attr__CRLF_mix_LF.txt \
+			crlf_false_attr__LF_nul.txt &&
+		git ${ceol:+-c core.eol=$ceol} checkout -- \
+			crlf_false_attr__LF.txt crlf_false_attr__CRLF.txt \
+			crlf_false_attr__LF_mix_CR.txt crlf_false_attr__CRLF_mix_LF.txt \
+			crlf_false_attr__LF_nul.txt
+	'
 
 	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
 		test_when_finished "rm expect actual" &&

-- 
2.56.0.500.g5d06dc02cd.dirty

