Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762091;
	b=nKl1o8ksCcH7IJx43qD7Y2hxT2+NoxXXKfPGl3DKdnVHWLF9Vd8II+DP7cxVmV8Ldp6e
	 r2mTddvACfbjmy5uemN1otdr28huvO6oG+Hh4DljxJcn8T693vN2sTfrvxOQpvBtmX8TC
	 G7G143mVRBE9tKQUopN0Q992EHZxCofnnFksvdryaW/aRM8+Kah62UJlugpnhpYjlBmK8
	 XTfRQ5tWEWPdg7CtXYrMGIuwAsr79KUerBMpkSLrU9wuZfF3VjLp3lP6w1BspbWMmR6o3
	 X9fJYmHfMNEs4TqzFbjDmUKHQIAMR2z2AA/tm7cAOelEuZftVj0bMqviDgz62TeC08A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BySLGHbaqxd+DW5FE6ypU4QepdF49RXNEv4aDFdGOd4=;
	b=2HS8pW3Z51MNbFxfjsnWpSryfUvdJqDVISAS2KFgs3/QCPVwnPHdd8p9kcpEyHDWJMiv
	 QBn6hzxyu8zAp1M2Ty86T5QbAIIg9ZuDLG1JuBNQQfXoNoZ1a4DK2uqa3wcWCkMuSPBOh
	 G5GqbZSz3NZZglP+WqepEzjWAITRWJWCGoJ/MaXlcZj7d2dx7TYu8dgGC2RfEWuAdyBaL
	 raLZtfU5V725MVSym0w0uCh0ekiT5TNi490BC3xWWH6hltXQSvwYttQq5B2s4zKeohsYV
	 YigzBKK3hw8ag0/rocS3ELNK5OFR9wuTr/CvONkgHUCWcTQ9NPr8HQubqxp+6Aig8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CYvcgJsI;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BE606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD2BE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CYvcgJsI
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ac9d666d4eso7583597b3.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792762090; x=1793366890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BySLGHbaqxd+DW5FE6ypU4QepdF49RXNEv4aDFdGOd4=;
        b=CYvcgJsIJblcl24C7oXZr99YZBP4O5CCOioeSCx+RXcxj9KuDJv/JsymS3bRxM1Onz
         ax/rUlk33uhj3clBPsVabSkdQshUwauVZwlLYcYbdIiO5OFgUCoQfnBKme2Y56Upuhf+
         oAlO5jO3Hfq9lliO/y1Z5zxk8itRb3DVrd7QzX1O89hBJX3Q1Mn2cSeQXCuKwoLFLz/+
         atOc2C3fWgeeFdnkHwQd5l8yIVA85zcTPq5LGuCvtaYVgkOQubDcmZA52TiGqAxbtQA0
         boy6/7vttIdMSphRQ/UWMvKNF7jwj/BuwYVLaRVcETRE1VTt/GrwVuseUxE0CWCWP8FD
         vFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762090; x=1793366890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BySLGHbaqxd+DW5FE6ypU4QepdF49RXNEv4aDFdGOd4=;
        b=a91SHCWpp4JkP7t9NtfrENQ646zVbOKCqFpxc5CfKmAgYvuQfNP3qaOCSI6TOIlG7f
         vA1vRtIg+eFzUiCm17IwS6ihJOj/iDk69Gk3a3jzANgR7npnI0+kfqBLLnC6r1wkCDmx
         zliNOXMmYgRcjteGayGhIw0BZPGuvnMPm7TSn+lQPYw3KD6MczgUzB7tBI/7abrWKouS
         xUf9nn4zX9sgXS8d+qTE9O2KaVrFiZQbKX2jYavJ/OvCQlrB2me0Fa76Z0MJL1Yj4C7S
         458pph28ImKC5YKjY8/MIHdYqrgndHm1SR+7EZW7dXxc5U9ca2tXbzIGnv8rl+U+3D7F
         HLEg==
X-Gm-Message-State: AFq9FYKKbgDXOg0efO61padIdHDu/d41Wk1P+2QYDvqXk59LxLn7V+V+
	DDKWLIXzTn4X7NpJtOjBdYkWa9dZawHlKnCglCeLCIJzBiEnKyyovg6GbP1gdQPl
X-Gm-Gg: AYBFou2kbzxhlt1gBtTv3hETRzWwn31X41uAF27aD3GlxgcERgbVaS0xWuQ1wYkCxQO
	F1IxfOcT70M/dI7/CYQQ0LH3yKw4UgRby8zhJpXwhnkbyjcpvJ1ibEX3F2ppB+/PsCACJSdof4h
	DEhYBtBgGq/O6umL+6psrdKdPq+nefl/N7ZdFyrN+wTGKHZgtkkqP1Dl6d4Cz9xQ84NsTVmXrAD
	hzopD9SCoYFoV85Cbdq0TGsOiHce6vZmIvpVxkX1MW+aKwq39me98QkhKP/8XnBpTJ+eWDETzIm
	H4M6Eh0nnZKreZhR8nX+AmrXRuzjTr/bNDtKI/SNJqzMYSNXkyItGWid+cnobeXrJ36WgHhczf0
	SCcKeeU6Ki4E85iFMwxhV763jm9zEgVx7/k59BTeS7wvuzzBCuT54Usb1quSyiGqKmre+gLkGWo
	k502MwEx/KOqhJXN9YO4GI9AbcOnOyUbZCKCxySB3ZX03VyODhWML7JlYF4MzFNYAmo1sz8439q
	zq3EZCJDcAPo8qmYcu68/XuLVkauVnF7adiqFgOrgHoOHQ+LQUYkt70dCs2rutHQkg9ooND9Pjj
	Jb0aaEXIxTOfJT38tM03mBiYLzknGDd3g8CQX4vIlqMjlDCnVA54sqrLy7kwm5RuH4zimdJMiSo
	/Qg8HvEN2rmfyvr1KA/7NLqzx
X-Received: by 2002:a05:690c:dd6:b0:8a7:d69f:3c41 with SMTP id 00721157ae682-8b157da805amr15875587b3.17.1792762089712;
        Fri, 23 Oct 2026 06:28:09 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9d17:3000::3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156183032sm12898647b3.34.2026.10.23.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:28:09 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v2 5/5] completion: drop "stash save" completion altogether
Date: Fri, 23 Oct 2026 09:20:55 -0400
Message-ID: <0266646fb4e6eb4932ec728ce425af9886e5f146.1792761643.git.ben.knoble@gmail.com>
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
Content-Transfer-Encoding: 8bit

It's been deprecated since fd2ebf14db (stash: mark "git stash save"
deprecated in the man page, 2017-10-22) and the previous commit removed
further documentation suggesting to use it.

Since we recommend push instead, stop completing for "save" and remove a
special case in completion code. It still appears for "git stash <tab>"
when GIT_COMPLETION_SHOW_ALL=1, and when typed explicitly we still
complete options for

    git stash save --<tab>

which is helpful for folks with finger-memory for save.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 697fef5462..9cd9c7cadb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3558,16 +3558,13 @@ _git_stash ()
 	__git_resolve_builtins stash
 
 	subcommands="$___git_resolved_builtins"
-	subcommand="$(__git_find_on_cmdline "$subcommands save")"
+	subcommand="$(__git_find_on_cmdline "$subcommands")"
 
 	if [ -z "$subcommand" ]; then
 		case "$((cword - __git_cmd_idx)),$cur" in
 		*,--*)
 			__gitcomp_builtin stash_push
 			;;
-		1,sa*)
-			__gitcomp "save"
-			;;
 		1,*)
 			__gitcomp "$subcommands"
 			;;
-- 
2.56.0.237.g5414b88716.dirty

