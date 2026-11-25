Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632937;
	b=tympZ0ElcqMfe+lTczsmK//jO3676BD7Y/MryW1Cc7j1VOGOW6phquz9VBd/LjHoCLLC
	 aQk5ct5ZUVrtvCr3+kTzwzdMfic3cFOr+2qPms1dvIngJg2PwCFbjTNPgSNhiNChlrAts
	 j14xmu8hobYumBYL9gGG2SOFjoUFvOltQ59XjOeUDzEkIZM43E4Eb0u0qA26PeaIfh12B
	 gWQL3igTY5XpDOtJzmUyPqtMb43assOiKjJYx3FENHCsj69wdoGYOUtxXi1UwtQX5TZDe
	 irM8yZ4B5DDnbvbyP3nLnD3FAosVYddQMop0VK5adnq4HxP8tl61/myGmwaH4K+lvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=HlFG/fipObnrVg2YkZEfCrW8u3MXK/zJrDw7MISJ30Q=;
	b=w1wJNgoVArcUm/AFzHHufm94s6TrTbT6UFJTLfv6d1hRvsTFDUM0OjmWkzft2BGYhkOq
	 hnLQ+jLpMS110pEpJDHvJ/lfeuZjw5UXiyjc6E6mH5Q7lGKy6G3EXZuQG629Mwpzk+yFp
	 6IMOfP4Jqm7Wdvr7b0Cplm+v0iibENVATdoffxXS0G7/RoLc3lcmUZA4dY8Q5zvdMmLD8
	 iNVKLCWbUUEq3/2W7oCgqunpu9i82HzJ9ArBnPi6/ruVWSd4hO6UCDv4MPjBdodZsbBFV
	 LHFqOOwDUbq44NJFSOiEd7/7pOqgfoE2b8LF31jB9tjccgPjZAnlgtoSTDIvgxpc6Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBGLJh0C;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF84606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF84606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBGLJh0C
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5365d725440so55693101cf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632936; x=1796237736; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HlFG/fipObnrVg2YkZEfCrW8u3MXK/zJrDw7MISJ30Q=;
        b=BBGLJh0CCOY3N6OOhEVABo4GiS7raAibNoN+l5sNKh3GbsEZNAqbzLM3nDILT3iZe9
         rDKSJ2q+pCgtjiliONV8hB/eOBFc3rN62vxuCLP7+VPv+48/vM0q6jUeQ4fMGkZf0OSv
         qmLzailAnbvMz01mprdF8TzroNa9X/9VR5s+qV7P7YXN1Wh/RR2/iF5UO5gsTOFMxm1B
         ap1jFRmQpmAJhDGzS+nwKCnY40xhw5LhWUQ8LyOanNLV7BxNVdX+BA1dVcOplUbV0vlH
         KrjTkIkeqjQv3vwKA8xZ6ki1SpNQtYab1lHZy/w4GSNdlOOgfuelwmUPnrgEKBdbBrmr
         EImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632936; x=1796237736;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HlFG/fipObnrVg2YkZEfCrW8u3MXK/zJrDw7MISJ30Q=;
        b=JzHlKeKf1AknAuXuwQqUTekTAgB/edA7XUeWYfdkztbnPHPisaA14ATzUWbaCb66oq
         1uU0FYLndT3ONGXB7wGWuioN0Vn08NMayBUOk3KmYxYo2pdJr15pwG7Xb7V55MI9oO3O
         KzuSJ+T+umLi/5LOzqFhRfjjkzJkR0554hMWb4sCVgm7qwicrITHPEqqfH29e75cHPqH
         wmhZOoqtwO+ifrqDSsABcRIV78jOKChvFVdOxF8mQLrSicuDuoetwfjdbhPdrW/CJ7Ql
         2m0I8dTJ751M5+dFD+8cH+lyN/zufuuG3foZ5OYJM7gsimkyjumjgVu0JiX7ovPKwR+x
         55Ug==
X-Gm-Message-State: APuU4Z+5ipgb0r2wH4abVeW44audQ90F5DxI0kHJHVP/lnCFxpZcGs8M
	Oz4OCdb3RU9TsmUWctYIsr5cX/h0Ztdhp1ZGoEvqUP6phHz9i6e/NHpMS55kvfFR
X-Gm-Gg: AZFdTZeYKXJk72SNLL7xFWfTmcBzPzmEuaxQq6mlF6JRXwV3mfkJRXoBKMocWc7luFw
	FCgZMulpJUPgObQPok7+kiLtai117yJVjtnZM8Bsw+oFDtVvDivgPgD13T/J2JT4j25tK/5BYtO
	tnriqtBvt5gJwtJb1Blak3pugsjbbU+98un+mic6Aq23lTF9JPHvtjsm88Ly1ZeqIezwVPlq5Ty
	DMIl0AJPJhY94iedv/RvCJLy1Qc4Q+o9d4a+wSp3eVklMM0OeXhdP2PyJsumd+hOvXNZtstkyyK
	2dnbPKx1jajhpEtJ3P6bjFVj2WLwhcT79x+JsMgM4q61p/VoxvngcGo/xRWPaZ1AJZu7tkReb+S
	UCqsCvisMtUYtMq3aAjHDkCjNeSnSsYN3aXPnhyJf6RjwsQo7k0A/inFR0urRPZqOAmUngmJxT5
	jn3+9my0S1C6bsyn2GbKmO42FQjtMzfK0LYxyN5rFd8ts7n1TVSHHb9YvnwgBSkq8TnO8WvLKXm
	J14+S+r8QPrbs5sXKmxdyuhyjHKvCcvo4qAIYzNSC/TeqRTEKejsNrRCUuCvznrms0Vs4pCGJ34
	DGoGw+Olq98OfkO50RxNWXXpxfLdh6LSVg==
X-Received: by 2002:a05:622a:4c87:b0:55b:9d8d:f2a2 with SMTP id d75a77b69052e-55d76a27d68mr327598411cf.18.1795632935798;
        Wed, 25 Nov 2026 10:55:35 -0800 (PST)
Received: from [127.0.0.1] ([20.228.220.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f8c34sm170613726d6.32.2026.11.25.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:55:35 -0800 (PST)
Message-Id: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 18:55:31 +0000
Subject: [PATCH 0/3] remote: reject invalid branch names
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Reject invalid branch names in remote add -t, add -m and set-branches before
any configuration is written, instead of silently breaking every future
fetch on that remote.

Harald Nordgren (3):
  remote: reject invalid branch names in add -t
  remote: reject invalid branch names in set-branches
  remote: reject invalid branch names in add -m

 builtin/remote.c  | 27 +++++++++++++++++++++++++++
 t/t5505-remote.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2429%2FHaraldNordgren%2Fremote-add-branch-validate-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2429/HaraldNordgren/remote-add-branch-validate-name-v1
Pull-Request: https://github.com/git/git/pull/2429
-- 
gitgitgadget
