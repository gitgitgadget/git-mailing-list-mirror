Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762077;
	b=GA4vQ0eY+2nWqg+jrL5y33yY7qf8mgD7dtDxlMSH5oL26n8X0o4ljlzq1fSo8IOaGvUh
	 xgoP5ozrKhAKNjvMfM+wK04ZO8N3zDaX8mfULWP4jgnWN/My+qu0IQwmuz/L2TdwBaWyO
	 wF/uvmycd2hJCD5IfBGVFXOxCfKZbWNmSXf2HsJfXJLQbA9BziiPk+tYPrKTyejyHBLxQ
	 oIY8wIx358xX+GzSo2RjtGozAPmpTc1O0v1wscOPrZsCTskGdoUCm62q4yMeDvN+e7q0E
	 LgSQMiRHWoyzP2yhMV5BENu24/OGqIVSbuSahcG3bk7gUhRAmPIay+YVY9KvJwsvYXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZiCrwfJvhGKIskYGCDYikrZrQXypO7VBKYxNATiWUzg=;
	b=uLPvfXnB1VvGL807DRoLuRwXJTdWsnr9R+ix0zxwmHhvy4Jugbi/VM1wz4n5uCTGzN+A
	 ib5J5lX+6Eu+Xc0mo1mncD16M54APaHwfbu5WmHYdnhuxSBkwPtocKSWuF8cYJ+W5of8c
	 IYGBFSzmLT+v1nTLHbi7E/GTzxUeGLV51W0Hbo4snVa3rawc8O1+Mm2+tgao6ZBzybMdk
	 Dv/1y/3hUrokbSHiXYO6mcQTBl0+BD1TkiZAwbT63GsbgvlEzr2uqcVRtxFRek+qdsLYM
	 NLnJZswVNXtpjWDUbX989aoR8S6GaLq4wE6ZaDE6me8BH+VrqqvF+PvHUVWqlphtigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TmotoELF;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57D606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD57D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TmotoELF
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ab38a051aaso8555297b3.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792762076; x=1793366876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZiCrwfJvhGKIskYGCDYikrZrQXypO7VBKYxNATiWUzg=;
        b=TmotoELFnRLZS0pPJEDKRJbgS/G/jBaHqK7qVQR1gK0Jv/R2WN82486o8Qmd1HDmE7
         IkRhCNjxZZ0J3yGDKvOqnG2JI4jpEbiEFoQ4G+zpVuy538HK2oQql+Eo8xHnOCJSy11t
         XTKenpNXqz92PKl30JTY1Ykr2pUmw0YEOlsTmDqxoKRdmXwpA6V0XZfEY1DAEkf9IRk+
         mBx8AvttOuP+iHJ72IU0jztfauL9gxDQhiJDVFl/3BMN1ROtSiRmZYbTlGJTswykBhcb
         7snP/5vwxG9MZI9hC1bWzcwOmZ1tnPnXGlfwgGbAp7FInU0wroPZquznGtfetaDPh69Z
         FByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762076; x=1793366876;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZiCrwfJvhGKIskYGCDYikrZrQXypO7VBKYxNATiWUzg=;
        b=tcp/fgtTV8UrXl5cpv+hJfvgm+zFPFn6uSVUV6OpvEfJ4SrLJROgSM3cMD7a1OL5R/
         Il0CcWE5ySB2Bn333nQFMu83SoT+7RUUjeEg6FAkZ1vy8VnZ4As+tbBeSTaZNMOkbfpt
         TXUcvzJVfqxPrEos0qp3+4vk5NhhalW3nj9OJgGPSATISalWWp1Q95orXxKJVw+bjlUI
         HKxPkDMM9n1IFPxT3gGxIk5ulDzdg1IB0w+1MlEQcsdi1s6xUpRQvKMbW6m3IDZk7w79
         AeFwuSxcOac9l6o9uc5b599J2NGn5IU16Wfng3EZf70lJMajzzlN+9FgK/UxoRFM7HM9
         oX0w==
X-Gm-Message-State: AFq9FYKfsNg8XP3e0/8lNdNP38CwSrdyY+InqriSIy/Vxm0jDDmtWh5t
	N7x+KxGnyFF267U+rJrqkLht7ByLar7yDzEDjJ3Bt//ujhRlxc7+CzOVF3Np3q36
X-Gm-Gg: AYBFou2SDmkmNrngsdsQLQU5j1+7IesnKEnRLA0bd6xFB/7A/CMxALw3hPphwhFJsgM
	3HpdcfgzmseNCA3S9vX4gVcAKSNNXf9f2pBmaRuIu1EOZFpgYflG9q5Ngi9MzAQrAM8hWG4JLkp
	dTYt/9KoGvCbgb8uptx7+9NotByP/HPxju8BwzIdJ7TA2VByfpTEYhK4bs5XDpSVS/mLKwBTfWE
	mv8zUbxGy7IPdtkoSZ0UlAOgPQx2ai82nZfP6n7f3ClyjUO3+2bF+Er9cYmPtNMO2NiHOpUdxL9
	cGid8m8hacsF5XUnnd9uQwbC9/OqkUPXlX5V4oPRyRd8f+w1lixOCOmdhtkA7UvmZi8NN4uVh0f
	1OZ+Bmk2dS95j1xKc0IoXNA3UwBMI4TNwVHUES1miJXdG53MbOTu7A+JANPsgtHAjsVOA83yGGQ
	Iuc4Fnx1RKw6H1yC01JNaFg1VOq3t2Tce1VUemRxN3Vnw/LuMgZcs+JfC2uothSH7jWOkMV3tNk
	tbZ9zXCb9EKi+rCE+CpJm/5PVLrziKTvhB7hvVa/9aGiQDOQP7tpFi62/e0CS98As6tdsnxokcY
	lbZeqjlkgowHsxwXupBuf7lCG7YksraI2+sW40MU1qqD/mlJQKb0n9tsax0SMVRo0+Aju/4zUKJ
	XPic=
X-Received: by 2002:a05:690c:4dc8:10b0:8ab:4989:bc9d with SMTP id 00721157ae682-8b157df7ef3mr12654007b3.65.1792762075807;
        Fri, 23 Oct 2026 06:27:55 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9d17:3000::3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156183032sm12898647b3.34.2026.10.23.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:27:55 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] completion: simplify stash subcommand completion
Date: Fri, 23 Oct 2026 09:20:51 -0400
Message-ID: <90d36b64450a21e9afed62c66fd3f72e4c4d429f.1792761643.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.237.g5414b88716.dirty
In-Reply-To: <cover.1792761643.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com> <cover.1792761643.git.ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The stash completion helper contains a hard-coded list of commands, but
git-stash provides a mechanism to list such commands
(--git-completion-helper). The pattern for using it is wrapped by
__git_resolve_builtins, so use it, bringing _git_stash closer in line
with other completion helpers. As a nice side-benefit, this also adds
"store" subcommand completion, which is missing from the explicit list
of subcommands.

Note that we maintain the "save" special case†, since it was removed from
default completion in 0eb5a4f911 (completion: stop showing 'save' for
stash by default, 2018-04-20). One might think we need to give "save" to
__git_resolve_builtins' 3rd exclude argument to prevent it from
showing up, but we don't: "save" is already marked PARSE_OPT_NOCOMPLETE.

†We don't complete the "save" subcommand unless at least "sa" has been
typed, but we do complete its options if explicitly typed. With this
change, we will complete "save" if GIT_COMPLETION_SHOW_ALL=1.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c3a49e2e22..d60e85479c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3553,8 +3553,12 @@ _git_sparse_checkout ()
 
 _git_stash ()
 {
-	local subcommands='push list show apply clear drop pop create branch import export'
-	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
+	local subcommands subcommand
+
+	__git_resolve_builtins stash
+
+	subcommands="$___git_resolved_builtins"
+	subcommand="$(__git_find_on_cmdline "$subcommands save")"
 
 	if [ -z "$subcommand" ]; then
 		case "$((cword - __git_cmd_idx)),$cur" in
-- 
2.56.0.237.g5414b88716.dirty

