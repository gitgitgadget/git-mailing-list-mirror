Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0CF4B826D
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827488; cv=none; b=IOHUMOEfHGG6FxMgnhx60pJ48qM2nVrKQzWUvcoFt2wUHnnfYMTPyu4efIqaZ4vjacPFVuAFWFvsKU+Oo8Y+YUz3WH0TjAWqb3mn348Wncg0+rxxdbyc8R+BWZgBk5WX67ad1J7jmOYA+YDkOHOE1z9kvM/NxOjyurxWuASx9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827488; c=relaxed/simple;
	bh=CIxx0baMcQVLUGTq/TjMMY6x7zQtxa4rbkk4f6fFZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J++p1CKkg0jqzKMGXMZcA4MgX8uq6ifNwMpiBVb3zqfJpzvZWQ89twV4SBNkigDz/gGAmUzf9K8oVVk6wIy8/myeriBD6heo39OsbPdcNQmVKxVQJwKrM58+mg3hQk343GK/ULDCQfrqM0tBTw75Dl01V9vuK5M+BfLL5mLCyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbeCnHGa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbeCnHGa"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8aca68653e3so3720647b3.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827486; x=1792432286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=65ZYC+BNH8WLjU41wPCuBYgKZmKDjcBX8Ha84MthzOQ=;
        b=rbeCnHGaxkJUfyJ+rMNiRtNfBwGVp2+wnK+5I6M/4SAFKBoFfB2xud5FxzmRCM1AAm
         0fFMUGJQfq3W0XBcCRvBina60hbtnlqoKB62FJir8Yb5GBQHp+T6fYm3AzisWncPcDGb
         yvImluK53fnoTa/eF+yekWvM0FQyCPxbM6X9yyVLbs/cin3s99BxbfutjYbnHo2vSf9q
         HV1pI1AhlmYSpy4ozt/8N1athmpoiV8Styve1+d88ItS+zLoJ3vR1FOLt1tlxINco6Tk
         Reu/pqN6xo+wP0ARLYoN/bkT22qBXo7xaUhu6zjjylimtcGlbGRsbGyBaNRUSQhpGK5D
         xv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827486; x=1792432286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=65ZYC+BNH8WLjU41wPCuBYgKZmKDjcBX8Ha84MthzOQ=;
        b=Uw8wyzb8VV8+7GirHKSYGORtBRzsF5f6B8WsdRQrL18l9Nd6Isu2FNG4c/5D7xWjJL
         riXfVWWAZvIri6uPjLqBlWX+dJGBSQAicMNsmWrxalpfkLxBXWgtRcs75trUG7BgB45c
         ksiZkeTFw7QCKQZHGAp47akYpWQU+8Zs6eyzORV/Wbsul5/kWWk3PL1jvDsmHcfB3dy1
         RgPGZ1v0Kj//gWThwjkg6grFHnxIkTHlK1jyL2SWGi7BZkzDFtXgALUjor2i34BbPWUK
         ofc5yFtQFG1cLN7z0lgtLcYiY8gNgbx6H+d6e7WZagi2jpoZu/HdJKb+iztKLQbt2uzb
         +z1A==
X-Gm-Message-State: AFq9FYI17wzJ7qE2SZqnUeeId3VN3OjN3X2mQlOHz/1tnd/Cbcis5Edw
	HPhFzsWNvnE+xdSvSRZjGIDNyllQQ+WamDI277hMxWUvTs9TDZo9ybZzvkXuFPrm
X-Gm-Gg: AYBFou2DfzUUIH4djFPwC9ztKBQYggu4nFwipd04DwKBfYHL3l/KZy4JAMAn1lHqJ/a
	jMjpAr1fRY+ChRAsbukpEyofE7aFRYNiY9J+/hF297tF66unc+507sB93zXv/RF7/ipgq7IGFOW
	308SbO/J694EokwXysVv6E4Q//L1mL4uvAi8FsqTFCzwyEByY3qHxx494jhlTMAFdkN6WvgZ05t
	/hQae7Wc/cptCxPiuJq+YaB442JvFqaX9KQf9YplMtASWCDjpedD0geqvN818aojsFx/6qKy/Pp
	nCbiF++RG0bwC//9zmAyja9z5f2OVehTs72LiWlplaEQBOZDAeH0Sfog03YZhXucw+bphkUFoA9
	0S7oSpSLfpash+prKhhahpWBhBsCq1B4+E2LXeDZS8c8NGXGThF7aJU3B90gPFAtdKc114WhyEW
	kDbSKqX7GrQsJSc+cSmmNdHKnkVTNV2VPBm8BFc41WC8OnuDe51QNlEAXg9idYH1DR3XA7qVbWQ
	FEA3eWsDcCO49MEmUHpJB8n/1AoerG/IiT5G5JJF84/WNSR5+n3cZ7ScYQWbOzU42kH6QWD+HlH
	EWdIj9Khow9eblmtTriinw==
X-Received: by 2002:a05:690c:e21a:10b0:8ab:4834:5025 with SMTP id 00721157ae682-8b07ee28eddmr27734647b3.32.1791827485668;
        Mon, 12 Oct 2026 10:51:25 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee8603fsm36797127b3.4.2026.10.12.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:51:25 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] completion: fix Zsh handling of stash names
Date: Mon, 12 Oct 2026 13:48:29 -0400
Message-ID: <3d1cd00dd8456aeaf8259767d9e33b7421aef9c4.1791827304.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.184.g5a00b4a6e9.dirty
In-Reply-To: <cover.1791827304.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Git completes stashes for Zsh, it eventually invokes something like
this (via our redefinition of __gitcomp_nl):

    compadd -Q -S " " -p "" -- 'stash@{0}' 'stash@{1}' && _ret=0

Because of -Q, the braces are unquoted, and Zsh will leave us at (for
example)

    git stash show stash@{
                   cursor ^

From here, the list-choices widget (on Ctrl-D by default) will show
stash@{0} and stash@{1}, but the complete-word widget (Tab) will just
add another brace. Zsh things we're trying to do a brace expansion, I
think! Interestingly, using menu-complete (Ctrl-N) does cycle through
matches, since it's taking a slightly different completion path in Zsh.

We might try to fix this by passing surrounding single quotes (using the
-S/-p arguments of compadd, which we can do via __gitcomp_nl's other
parameters), and indeed Zsh will generate

    git stash show 'stash@{
                    cursor ^

but completing here won't find anything, and I'm not totally sure why.

Instead, though, we can let Zsh quote metacharacters (removing -Q) and
everything "just works." It changes the output format a bit (users see
stash@\{0\}, for example), but I find this an improvement over not being
able to complete names at all. menu-complete is unchanged aside from the
extra backslashes.

So, override stash listing completion in Zsh with a working version.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d5c526665b..2aea7770d2 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -135,6 +135,11 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
+__git_complete_stashes ()
+{
+	compadd -S ' ' -- ${(f)"$(__git stash list | sed -n -e 's/:.*//p')"} && _ret=0
+}
+
 _git_zsh ()
 {
 	__gitcomp "v1.1"
-- 
2.56.0.184.g5a00b4a6e9.dirty

