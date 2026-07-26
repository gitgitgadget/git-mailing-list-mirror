Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78317B50A
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097076; cv=none; b=gpnyJug2XV5vyY4Mo8Mor3n9fQnCIBHcGvFOl9EdXzW7PjxIJF/6CWY4epYFSKfDktKGfYmRRzKby2rUU41OxmRvUPBZjtdD0c39AYwv9uTgK9itDlY+R8cMsZBQc8M50I7V/3pQk1Ts+ptuAE38ZTS+fgdz/FGbobXcCG3T8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097076; c=relaxed/simple;
	bh=WrLubwdvmUVv8AiNN0UuntNVd06qaZmsvUY8Obecf4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DK31nnuqDzoyEL3Ja7nv+LdQxv8RSNhwqrWKlRPdcBgIL/a1OIkyqyIl4G4aHIU5UeHImM1v1KR9Kz7+cS+YnDTlAFoPWdafAPB3eWNY19UKXNuW7h+6Di0pf9VKDFqvJ8//DVFA7GL5QV5n1XodAqUiAZhqbG9Oh4YcK5CAWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1IRzeja; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1IRzeja"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so20554206d6.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097074; x=1785701874; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=O1IRzejaZcSJuZ0v/u48DcPL1uMv/TkUmHXVITR3pZLXDYHMR3ihMhN5R/VSclP8+j
         X2TIBlyLrxBtCjV8UULUhPv1Xaj05ke2N5j60ri01fDk87iQ8jYoqVb2KhVxOQt3tdsz
         SvXdi16/iiG9WzySUCFT329XzXcup5Mu3sFlQWOhBbA++/V2LC7MC1GVHHITy9oY8Sn3
         06Z7ieLFdoUkFCg/fsiU22ib0FPW6uf7GE1FYixW/DUIMOBFgXTUOsOX2UvDZL8gPsJV
         0f6iaCvWwyeHi16HvfQh68JoEXne7Bqg5ysNm6w0SelusRa4S5FAHZ1PEnDUvwlYzJta
         +6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097074; x=1785701874;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=WYDdyZHyTsR8Jd84z5NeNR6LMKss5oBaSi/B3g30lsepC5QpXofSDqFDoeOHf7BoPU
         gG9Hs7qFszdsxNH7edyRGZp46qPl4tc2I0Ur7J4yTJekgcurlsmg0pC7WK+2I0ya/l30
         UnUXzBgKyTEPcHSMZLRmE2aAvTIVV/TvLmahfrDnhD0ElWSWknNfTLbAyjk/EI45NFG7
         hG4W4Onw2tCihL/sswpnWpxt8FigMYaEq7fcZGEja03GyC1LO/BoD98pbRKBvaqTIX5Q
         X1GgwGZw/RXe043kJlme95YRYUGaqoBepx1hDJm+MYh8uVTCKijy/V2yP5Pzo+Gws4hX
         eSBQ==
X-Gm-Message-State: AOJu0YwNLVFWyFU5bIStG+zkxfUvx6/Ppvft3g11ssCsXlfoSGXwhpjg
	NbTEKtHMJuFUpmrMNqP2HU0Vb8ODt+/yJr355fK+g/dRymZ7pyvLQbxkn83c3g==
X-Gm-Gg: AR+sD12t3ngXz4qjehNvwqwFS5eBQlv5Ml9+z0TdvleUEUb1S8gWHyXj7oqH4aL/prm
	PfbMSF5ef7XShcWs+vKA08ok+ETtO8JUmwMfj6Wbzvbyvg3Ug7sFxZY0TJWGlu7cdVpjTetQ3rv
	w65EQ0xBZp/oOi5Kk84gASoMri64lWyS08xQ3uogxvCdBpZYTkXY02D2AIsjCg0w87gn8k7Bndv
	bEA3I3SiY6DcBjOmc3NS/kFOwMbIGJC9ZqBZRtNgbPqhizuIGFhkaMd1Iga3qV/bXh9K7Wpzsvt
	vt4lgz2nzAQaNkC83ZX4ZMW+CHoN5GIkDPaCr5oEfxOqTjjxtBlzFXQE2ghf4jq69WmlvLSleKV
	NF+SU2ZBvemYryCuhOV/pdj/yeNpGFHBbIxgAmLgJo/s4PqqNrmZ43J+PcAD13aiXHJF1zlD/MM
	4mnkIY
X-Received: by 2002:a05:6214:469d:b0:8e9:f5de:d631 with SMTP id 6a1803df08f44-907ec898b6dmr79655416d6.50.1785097074028;
        Sun, 26 Jul 2026 13:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86a1b62sm48429546d6.26.2026.07.26.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:17:53 -0700 (PDT)
Message-Id: <0d67da588bc86c5257ce366903ae58e171159b8b.1785097071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
References: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
	<pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 20:17:50 +0000
Subject: [PATCH v4 1/2] mv: name both source and destination when rename fails
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Pablo Sabater <pabloosabaterr@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

From: Lucas Zamboni Orioli <lucaszam0@gmail.com>

When "git mv" fails at the rename(2) syscall, the error is reported
with die_errno() using only the source path:

    fatal: renaming 'src' failed: No such file or directory

rename(2) returns ENOENT both when the source does not exist and when
a directory component of the destination does not exist, and errno
does not distinguish the two. Reporting only the source therefore
misleads the user in the latter case: for

    git mv a/file b/no-such-dir/file

the message blames 'a/file', which exists, and gives no hint that
'b/no-such-dir/' is the missing part.

Inspecting the paths again after the failure to determine which one is
at fault would be racy, since either could appear or disappear between
the rename(2) and the follow-up check. Instead, simply name both the
source and the destination in the message and let the reader see which
one is wrong:

    fatal: renaming 'a/file' to 'b/no-such-dir/file' failed:
    No such file or directory

Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
---
 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a82fc97a19..35e504484a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -549,7 +549,7 @@ remove_entry:
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
-			die_errno(_("renaming '%s' failed"), src);
+			die_errno(_("renaming '%s' to '%s' failed"), src, dst);
 		}
 		if (submodule_gitfiles[i]) {
 			if (!update_path_in_gitmodules(src, dst))
-- 
gitgitgadget

