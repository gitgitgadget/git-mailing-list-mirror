Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026785;
	b=pbGFw6C/bmgnvSsdUmVWnKLxW9YFLA4LPTS1ptgTjZ+krEj5RVmmG1Ib7HYu9EE5xEhB
	 3TLj1Vvkao+7po4xbZWZgqBmWbKXpktkTnZQfaR//CfVCi0Hs6OhLl+NhCEBRSKE+yd0b
	 8shF0R7fGLDBXf5gOV4EHGd09Wf7q0gSwdoJHVFQQ1mYpiDqCYIdhypt0dT7A/hScOdAZ
	 EbpmKjs6SVgWSNG2iEu+DXBFnfgBA8MdALs8o2vZ6HBDOfCdj8c1UcU/oqOIdrsR6PP24
	 CAYREZKjttyu1SmOHGE2XLlEcxR3fDxsEeV24H4KZn0iHauszZJ0Fjd5spgDde9ny3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026785;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vhs2jMBUeqwrz0GgDmWp+Kh7ZfDJLPQPIAgGE0siuck=;
	b=A2RM62+z8yh9VHYvNLMNDiUeZdR1HLc0XD/OWTaUSuIM6Z76z0A2X/Gw12SrKkilW1At
	 yZzQNay0yQwGWnOLjl0i7EXknYW2GWo8CJyqbGD2K6C0BSKwOjxX90zW2OaEfjp1XhVMk
	 SztYXQZVJtIQk0AOPfu2UUtOmx7oBlwR0vOZe52hcICVkQGF3admN/8UajtbP1/NfpOrL
	 vLbhyfHhvCsqWIT3m+G567RPdp4+Af3xvzYoAXHbsIJmdcMONyBlUwrxM5YStAQb2gLEY
	 /Kk328qS/JnYJpCH+RxSTGYIAm2V9jXbcljvdVHcVPyhMuBZhYQ3bxIn45t0uOWgn5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DL0UwxYd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aSNvXTpS;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B031606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B031606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DL0UwxYd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aSNvXTpS
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0AC37A0012
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:59:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 26 Oct 2026 10:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793026784; x=1793113184; bh=vhs2jMBUeq
	wrz0GgDmWp+Kh7ZfDJLPQPIAgGE0siuck=; b=DL0UwxYdSTL8GgHlZxyDwXaNF/
	IfyYhlsjMhTMKGtVZhWVdlI5a/yFXZNeq8y9UVtVdqI/ozGz5GLisYhTpC4AV8vj
	btVZRjqOTzuNmOuKYqXloAUlA7+KWepwfdhK5CH+dzq2BOxXlOSA2Imqt9SwwGhh
	Of99Ka/Yt3bG5eh/HMGCoJKHVg0tnodFRQgWkbBTUP42ltxskDFf/VDyYksz+BQj
	4vtQ2a2es3ZnegK2BQsgwDg0LjC6sgkEeA19UNEOaQY4Tv6+L8taiPCJ5s+mNsbW
	zJ22wFpXLbt5cHKxl3bSz4D4A+3WrbL6p1nGDUqRLkSmwvj9DaJhH5/U0pRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793026784; x=1793113184; bh=vhs2jMBUeqwrz0GgDmWp+Kh7ZfDJLPQPIAg
	GE0siuck=; b=aSNvXTpSQLRVPfs0N050BG5k4wpzdpWqyYbe5QNDEDL9TPsENVC
	KRYrzMTPcRUF7EWxGmmuUvt+zNCdiRnUo4qsAmV/Dc8feZ0G0DKBVUmVW+LlbguG
	WxB0omV9zkjNhHurEBfangj/h7TQPjPKz8O0tTsKS6ciW8BCcCzEQd485oxqFWPp
	kbQ+IyF5gK/0nRfoY3x38kzEi3dH6syP3YBug3c3W/TXwARGJocLKlkPjYh7+mGx
	jUG+BQOzwdrnzJ66SM3h0ChF3GAOhvTI75T9U60Y0/yzZrN9vdV60EcR2DSCWfJK
	2YvBm/4w1C+rp/GLOocd+c3/pIE/clCee5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793026784; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GVdpbctoHvAUidTV3/N7oDEnh11LwjwD+be8Ar6yP2jzRhQ
	92srzmNgwLHWzURibauiam5nYzZPnHAXIWpYL3E3z8XnK5nZT3CHRRjKT37Tl3wg
	LKKRMLw/tGu+XS5RLCoJozB8I+xN2omBssWHZiSND8tLFycyuYa7kvOOtPkid4cH
	rru5SJ6RdT8zLk90/Qng1WkkjkdCp9q1yzkBg8RHmg5RiXvSwJitSianR1uJgFK2
	a3f3u6oFBy5t1iftYB4XRsWgFL5AH2UYCbfB6uzoKbFSG41evoc+vsdCDo8wt/4/
	tAv5LP6WP6D4quH7gfQrBwowmXQPWdNInxMszfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DMeoEyVWiy1D6skd4lsXkZLqveH1FpNh/Jz9wmChsB4=:PB7kt/9bnNsnX4S1ZDeanpq3yXDQHAfsn0POKPlXw1w=;
X-ME-Sender: <xms:4GrfarsYPTzqgEHpSeSeBA66kTj54hrO7K8yQU0jq6p_76xqZVKHrA>
    <xme:4Grfaj6BcTK9pVVh6u1oSaWJxLFHhzGdnNOFq_I1_hpZ9CqUGpfjyxwZkrrwi8wtd
    fDxOToHO8h84pGay3KEFhhYDl8S_a2ppCf7g69vtYIjibsXKcDIxQ>
X-ME-Received: <xmr:4GrfasLDF5KaOZMOvK0XY_bmUZta-7jfD04Kcm27ZvDtYfJYUod2ke5DX-pkG7agxa-sPGTpzZRnfTBrBHYBDrovvkTG8dDoP003>
X-ME-Proxy-Cause: dmFkZTGD1l8L39Sw1Fh/GfwNQs5SvVlAbqlmXfGImH59yFJnkop4JjnGpnGf84n/8B9dgR
    6ckFUamI791Vx/77DOv6NhtooPUaVhepD8dKsOJCfwvnsXCyTHipv7XGfcsp5d0GfsgL/d
    e/j574pGDymtVqQM4+Td5gl9PW7YHk4/o1wvCUzFsHERNEgicWTFiEgQmTt9lh9JfIIM8H
    ITOkxmeG2SLN4sEyUvK7DKp9yEGaIPf2Po1C6WhS+fKAknbZKABtFC+pgFmREsIrmk6B0M
    x+5xdDE+7WnGaIv60SUsnSmtitPQUlGqXQCd8j5sDjhGlG+aord08EOuFkCUT82zLQ9Be7
    7QrovFuiF0BTv4i7lXOtoeUfIBhskACtRusN30jhnj9I+cQ17l5YIor0ZkMkVqKFTonTRv
    Nt/x3McifSCRHjb7LvPNLZJg0mg8kygbBy6kW9eopNXzbh1eMJzlem/U/04O704Ye6vErY
    xlVSl0lLRd5rXvPGncqKZ6Gf4idaMvwAgY9Y3EXYHIX9K5nE+rKekqZnkTAwPRC6kvDAuc
    JibUD0Y9in8mz7xVPRmPVNW+gmrL8691PspR7E0NEstCg5OMlk8VlQL8JKtLn+BPi+ogIt
    FfILDiBmRP8MVns9l9rP2IrUDDmimF8u7UEm78/5J+ugvFNOyi+Doqqacklg
X-ME-Proxy: <xmx:4Grfaj4poSnmjxxRx6-Lrf9IeDSwKPd_frbfBCBox-vofXIAh-Yr9g>
    <xmx:4Grfavy-Nbi8kv2qu1i-oQqWPXC-KO2JZAD6sbj_gXahQ02Cn0Buvw>
    <xmx:4GrfanY6WlsBKvh8kQQ4YQ9ywt32YTfIn5igqhL0ECRYxYVD8wwTxQ>
    <xmx:4GrfahTyi5x3ILdcXSVqmudMiCgTxwi-pChUt_da0lFNMCrFfsk0wg>
    <xmx:4GrfakBm7H_mwDbrejzQ9kQJq8pRww8kYyi_T7xdD7gzzqezXheBgvdl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 10:59:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] config: honor file permission bits
In-Reply-To: <xmqqbj8p7okv.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	19 Oct 2026 07:27:28 -0700")
References: <xmqqbj8p7okv.fsf@gitster.g>
Date: Mon, 26 Oct 2026 07:59:43 -0700
Message-ID: <xmqqa4o0v76o.fsf@gitster.g>
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

When dotfile sources are kept under version control, you might
protect installed files like ~/.gitconfig from accidental changes by
making them read-only.  This fails because updating a file writes a
new lockfile, copies and tweaks the content, and renames the
lockfile over the original.  The original file's permission bits are
ignored in this process.

Teach the configuration writing machinery to inspect the original
file's permissions with access(2) and avoid replacing it when the
file should not be writable.

This implementation targets configuration files rather than the
lockfile API layer.  While in-tree files like .git/index do not need
such protection, out-of-tree files like ~/.gitconfig and its XDG
counterparts are unique in this regard.  System-wide configuration
like /etc/gitconfig is typically in a directory already read-only to
normal users, making the issue irrelevant there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Only the commit message has been updated to mention that this is
   deliberately done at the configuration API, not at the lockfile
   layer.

 config.c          | 22 ++++++++++++++++++++++
 t/t1300-config.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/config.c b/config.c
index e0bb29b53d..2b84fb215c 100644
--- a/config.c
+++ b/config.c
@@ -3066,6 +3066,28 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	if (!config_filename)
 		config_filename = filename_buf = repo_git_path(r, "config");
 
+	/*
+	 * Do not allow updating a read-only configuration file; it is
+	 * annoying and alarming that "chmod a-w $HOME/.gitconfig" does not
+	 * prevent the global configuration file from getting clobbered by
+	 * mistake with the usual "create a new lockfile, copy the original
+	 * while setting a new value, propagate the permission bits to the
+	 * lockfile, and then rename it to replace the original" dance.
+	 */
+	if (!access(config_filename, W_OK)) {
+		; /* happy: we can write to it */
+	} else if (errno == ENOENT) {
+		; /* happy: we are creating this file anew */
+	} else {
+		/*
+		 * most likely EACCES but other errors also indicate
+		 * that we cannot write to it anyway.
+		 */
+		error_errno(_("file %s unwritable"), config_filename);
+		ret = CONFIG_NO_WRITE;
+		goto out_free;
+	}
+
 	/*
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e3f8064889..876d376cc7 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -3019,4 +3019,34 @@ test_expect_success 'writing config retries until lock is released' '
 	test "$(git config retried.key)" = value
 '
 
+test_expect_success POSIXPERM 'refuse to "overwrite" a read-only file' '
+	gconf=custom-global-config &&
+	test_when_finished "chmod +w $gconf" &&
+	(
+		GIT_CONFIG_GLOBAL=$gconf &&
+		export GIT_CONFIG_GLOBAL &&
+		git config set --global some.variable some-value &&
+		git config list --global >expect &&
+
+		chmod a-w $gconf &&
+		# "get" from read-only file should just work fine.
+		git config list --global >actual &&
+
+		# "set" to read-only file should be refused.
+		test_must_fail git config set --global some.variable other-value &&
+		git config list --global >actual &&
+		test_cmp expect actual &&
+
+		# traditional "config var val" syntax to set
+		test_must_fail git config --global some.variable third-value &&
+		git config list --global >actual &&
+		test_cmp expect actual &&
+
+		# "unset" to read-only file should be refused.
+		test_must_fail git config unset --global some.variable &&
+		git config list --global >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.56.0-369-gb8347ef8b9

