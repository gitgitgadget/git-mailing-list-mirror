Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098039;
	b=unkv4A60+HH5mcbTwbxzAIrbTfKrYrDav0GUonMIbrO91z3kNqmQRcTRXoaclYzkZF3B
	 8iYxzPsMvww0gX0s+QtFwBsBidB1+Xh9dXJcqjG82NvBrl7WWrIwOx7JBdUlIEkHB+Qey
	 wcmsyP/iwaQ7sT/CybY6q9vfeFsy9XxXVIjYgJaTJrcNn9OZ2iy1HcRCXUxFfFAQbZx1D
	 bQwmwiE6XlDwynIga5sgc2BucBne4EpOjM0tZtLGFKRROmvFDJek8X+9WN3iF9fjPO6aT
	 uSa02ijoT8p8Zn1xBBqDSrXn9uerZjJlukPmgLPN90oJS9h3nYBh/buoOKxTjKl1nGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098039;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=KTwlGEAnXisE2gpV/1+9kqO7Ngyg37cEd7BXod9L/WA=;
	b=e9Gom68g3tNTBLDs8H4LZsn2Ae2qj+seanBWoeUxAT8hukR3H4nep6L3yluFpDiI21gG
	 sGla0gaM9Ul+WhKhEnTC7hjWoQA+MwzDJ+ZiMblmKrooycUD5jR79dkmF13W0BtCUAQmH
	 4CVREtgNh757R+p6gymJZmHJ4k46BCimIOacmOeNr4ispJwBItkXVVAV5bo8XgWur4lJy
	 x9hEQhaKHygYOI4JNuFKWmMmJMtIhnOkhXO8LtNPNx+hrreruxj+/iRaSnNt69DeSIAyv
	 E5PScVLUCHXB24gqypatrjOvQFf7nunb0qasyAvNJDbghvWczH/pPHtdexIxYeh9dLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="d/LnQCQx";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XCzIDDEI;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7424606A326
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7424606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=d/LnQCQx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XCzIDDEI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 492361D00139
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 06:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098038;
	 x=1793184438; bh=KTwlGEAnXisE2gpV/1+9kqO7Ngyg37cEd7BXod9L/WA=; b=
	d/LnQCQx2XvtxoY0+qiKEKaTa+6VKZ/6RSBz0tc2BjGGqKNEbLmv11jMrksG2PiQ
	w8zTMGHTWDjb/yGtqSQnLAYDJSF/Yjm4u+TRiEJswLpCl5p4LvqOXlm7gZ+jX4O6
	weQqv/HcBA6Y8N1ndIlcoYqqS3tQzJV/QxkQ0vDDVTvvg770G7tkPKJyRx0qQS9O
	eh88OGFSjyxcX2Fzq4fqyO0/swMbHrDwYfZbbyYnrndhpSve93Ry4KCeUD9GpS6G
	splrwLZ4CjTIOZGxR/ZWkh8fnroxsu++yn8Uj8EyXKYCWAVV9tAMlmYWonq5qoKk
	NBwsi28xcZenn06nPNFdIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098038; x=
	1793184438; bh=KTwlGEAnXisE2gpV/1+9kqO7Ngyg37cEd7BXod9L/WA=; b=X
	CzIDDEIpGbLCalqokksSzcCmOhfW/1BeNK5TZpmA5Qt7eRxgTWBHeTTSWSbSiV4Z
	BQsjyacm+1Z3ma5sx1e9l7StLUmzyjn8krCk/QkVZU90x8uQXh/u3VROnEuN8I3Q
	eAAsA1+xKtnR6O53cBpGbxIM3dn6kikxhDCLHB8C3R3Kr9HU/g2Aopd8RKpevmwm
	4jmxTLWQnR2ALKkjAYS3hxs1NfMfxBHVICer42ikbfG3Tfp3LTWP6G6bLq+0IE1f
	NHiXJlQ1QKDhQjLkRkSIrS2xxt7jNss8IareX3wYsXDT/EgIkCU5jTOl+x4YX2PV
	UOJMXzK0Qd3kW0yDXAOcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098038; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oVEp/EzlhMMF6SzqgFza/ajqFP40hSI1tuL6DZruUCo779A
	o/c7qa3q1jijTeisjMfT0GNLxy01Gb88JaLa3D2wlLwzn/Bpvx1HFA4yJjQNYLbb
	4Jv/oWKUgwt5ZJel+Q4Y7t28yygJxxHakYwsPnxkGB3X+M8c3HfHdImiTZXBYtg9
	H2biFoj/JbwkOv2ThKRCkdUuRGTg58k6Wo66UGEdOq70t8obuIsJ4g3AAFS1VHkM
	gFY5mHRgIvP0niGSsrwbk/wcDNUWLcVxrxOk7R3VeSmvT1Q24C8K0DE3lpbbTR0s
	dWR0G6ZuuC2VkV6/Pze1D8oHzwrRM4GDK0gXqcQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:p42NK4+wAaAIk0kTBEA/KiXwLmGyC3ZfIVSzWZSvV+g=:5XEhz2lOC/MSIPTQTa9K97EUZybi4n+UIXqd/TZ3sPE=;
X-ME-Sender: <xms:NoHgaqhVyLB1Uo8du3sd4Xjbc_jbU9a7NpDLfNQNMtanxj8ryrcAGw>
    <xme:NoHgah99wY-mbUc2EUBDSo5P50nD__1Ig7kS3CJwmJyM3Akm8paBUu0qG113H-T_z
    pp4R5pL8EACSgj4EG1y5pw_jCHQLXo6WYvIhk7YNZ0J_40ek4sVeA>
X-ME-Received: <xmr:NoHganuLgsLQzgKj54LzEd1OiZqCZ0bGbaFnxWsjVzpjVveVjYBvCw>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYIR
    nHqxXIqFcB7AM0gKoI6VVPOpcdlAQMCQ03Pinhx5w26VOCW5F5vmEDp6b1jGd/8J4xOx0S
    GlDkXrff7H8IFac5EuhBOLLQp7NPEp+QAYqxbxTWe3uKVJE6LPGUXITlI2Hff78sln7Vxb
    mPqQJ/0ifNdemmYRnQMN9oAV1myEbEi+qMMkgxD7gcMIyeR8XgYQyck+wuv1WW2CLd1Fgy
    cOIStJlmjJWVxXv7e8UepjGKQ/due+VQ7FSRqpEGsvQn17ZCbJY1pkZ9bUNVebfzuXBDQw
    VNdJiEZSlSg6832jeM4DZwyKB7MM6UvJSTC0ARV/8Lr3pjYCul6kXn3J1Z/A
X-ME-Proxy: <xmx:NoHgaoZmv8LnNNRXEK4rNqYwrLwjU6u_pXxpMQYOCjk8m8lAsis-FA>
    <xmx:NoHganoASDoqvtX518X1bYIcSHqTwci-aK2dVQAHydFBYjNHvlGyQg>
    <xmx:NoHgat-8OH863oCT0jM5JWSDHkVSYBh81fdRdFcaKG8cozsbfcGRkA>
    <xmx:NoHgam_Oa7NPaa77Z6yIdjfYRJvJr-hT7JlE6DmAK1C3eO5WlKv41A>
    <xmx:NoHganhjEgjjsmfq5dmbBjGyrD-KUlEQz3ciMXCpmJrlv_nQn6tWVqWE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ceb3d30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:49 +0100
Subject: [PATCH 06/12] builtin/rerere: turn "clear" into a proper
 subcommand
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
Message-Id: <20261027-pks-rerere-subcommands-v1-6-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "clear" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0f55619bf62..96e98bc411c 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,26 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_clear(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_clear(repo, &merge_rr);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_forget(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -107,9 +127,8 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-
-	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(repo, &merge_rr);
+	else if (!strcmp(argv[0], "clear")) {
+		return cmd_rerere_clear(argc, argv, prefix, repo);
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);

-- 
2.56.0.341.g393f52fd96.dirty

