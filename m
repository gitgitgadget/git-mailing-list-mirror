Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339495;
	b=b/NHHYe84tImu+sUir48Zc4geqV/Qfl10faEp2YEqqZ6m6KljrlW/2IEuAV3vZsj1Am7
	 PxLhkwOihXgRZnCPrixWPnVI8PzKF08tYs4v+Acwy7LPxOwZ3dJ2iDi34TOyIFUGtDrRr
	 5rZT0EsMLo9QdqEzXGu2VcNmYin+WK31o4DnmRBzVIzmuSFeQMwzDAZXKIWnwm5Fhz4aw
	 L+Vx8QKffrFivdvwl0MmfgnmaQ4z4mzLMu5/aHfnNAyVfnuxx3IHFU2EF+h9DiUouUG7z
	 J23LEwVUSh3ORQ+SONl3u6q2UXMekTaKYJO5jlAPbnbUho17f/hDnS6rLaMzOvf7ycA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1Quyu9NETKOnbuCYOhi30NTmZ4VrrM58Yk3ixKs9Rn0=;
	b=UVT/1bMFhYhesYOnu1fS7ZrWaGXoALds6PQZA4XLCvinOFsr6lNCJP1E3Grs6Tn9tLHD
	 bcgqNLxAADNHYM6/IoRa/rwvgg6ZqKej3NvYWKgI01LrJYsAKC/8MXYozbmNVGYRmWLkE
	 Dfbx8/Ok9DAXkDX0jk9g/LcH/lkdhcu+UJL+oKgFdSw6Al6XnwZMdzCLZ7x8KRyPbmjIe
	 NABhrM9zzj+AvlVwFWWmIv3xV5EUXkHA8wQdVjoXGXf9V1CLTj2sfmLUtpZcLLygArdzQ
	 QyTijFw1M6fTDlz+l3ogUFmLB1/mD0wWaT31RKr5tDmcmXIuWVNPhGDfEDe+cnxfSYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNthxq1r;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274B606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4274B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNthxq1r
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so3959627eec.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794339494; x=1794944294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Quyu9NETKOnbuCYOhi30NTmZ4VrrM58Yk3ixKs9Rn0=;
        b=KNthxq1rfyXfunb84hFuK9PGiBL/Qk245p5LQ2epzQXOljghuUB5ruZsaT8soDt6aV
         5m9nCW0Y49lkByx0terJ7KKoYxp8PzQdVoaL6ADb42dR9FDhseHO1kfHleAmrlue98XO
         V1RtUwgRtTHVatAN/o0n+p1sEzkQhAxcR4rpjzSB8rGRTX/Q656/Rt2/Ws3AS7qq9irZ
         RFNMwqC66SczqZrx541Fh+je/6MvgmK82hHnrWIFtmtozP0LzW0kdjoGZFgi2FY2q9Jq
         kGOnAwq4jpBozM9p07eJcpyGY4O/Jc7G8sST/TlWVKyTey1bdYGCkzSVcd76oBlyqBX5
         Lvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794339494; x=1794944294;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Quyu9NETKOnbuCYOhi30NTmZ4VrrM58Yk3ixKs9Rn0=;
        b=JC/LISQWZI9eqkAXJIa/2/asxesPwxYzt1FAu7M+u612wgJsIZfKtoDDgU/iTE0oUH
         CgFimpe+PXO6JA4npOeb6Q3hJdVIV5GWENl8bVczUsodiEiIfd4TpMxkrHH2rK2Nh//0
         gFee5eFExxrUp7cnohRYh/LL3wRRhzkBhFj7a49t8dw8ZWwi7tnkMI5VwP8+FdJZZNak
         ffeX1C741O10VE8o4LBrZoynt9Ky777uppYq2GIQ4xCL2KoGBeLNtIY4DZtMfZug5cKm
         vobq/9oSlI7BsupOZk/Srh267vNDic+vO8vho9UHQ39t0F250qgsJ0ooztK1aPajxN7Q
         Ti5g==
X-Gm-Message-State: APuU4Z9mZ3Kw6Fcw2oIwLLqvM92DcByrr0rl6ys1AyzGJBWjPHJa+ehM
	uZFK6kjzXkKC5U3+lSgphErH/QcWCDBkq+1xxwhrEtmrgJZoGPC/7ChCTE80URlg
X-Gm-Gg: AYBFou2vdJ13oyHkdsH7Thwr7Q3cBBH+jDgasRfKIUAXLwC3KIee67+Mxjx1iRrayS+
	lMBadPA4TAcba/N2RHAPyph9WYMuIYfnn3m2NJONq4HXEjIjZEpe9B05HJFKQFJgU/PK8BEioOa
	tHgdMCLwsBsxrVrBvCigBzO+hyMERb+etSot2kHDGcq+GCZtL78cENQru74UXcN2MlbuL+knjXx
	S76Gw/lpYeSjFKzOJXrk39688JVL7IGxF1+4bEqpcNByivX1WcREVtSpHuelqbXmJKVG5WgTzwY
	wwW4VIUik9OGG+VpJVLE01iy/+wejszSMqhd8tEWz3cK/ju9B8Eh5N6LgRp1IKmnHcB1bP/o7dI
	dO3/5cJDkyfYu7YTSMLKN+AV5K9P6a3hL+sIR8hyckYU0KGcfhC/QxHwX4f3qnKpRVbC9pSY2Yo
	7QwSW6omdBXw/3RC2OM0dNGRTrfrQsPRdPpSOOxJYRDerkyova/uLNdejPY+9UKali5B3NwlBeP
	3T1gndW1bazu3wOfJJN2SS6LRq8JEutmTRGXoSIeFW8031XtnYIYHpau9zkx5o1NzOnVpsh3ikn
	WrQM17idZlZ45yrsGCrjtv28CxGquMwq
X-Received: by 2002:a05:693c:414c:20b0:376:703c:8819 with SMTP id 5a478bee46e88-37687211c61mr398359eec.38.1794339494086;
        Tue, 10 Nov 2026 11:38:14 -0800 (PST)
Received: from aeron-host ([2401:4900:883f:8cde:c644:1fab:a79a:12f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm16494823eec.16.2026.11.10.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:38:13 -0800 (PST)
From: aeron-gh <agab0323@gmail.com>
To: git@vger.kernel.org
Cc: aeron-gh <agab0323@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSoC PATCH] add-patch: use Q_() for split hunk translation
Date: Wed, 11 Nov 2026 01:08:03 +0530
Message-ID: <20261110193804.76958-1-agab0323@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The "Split into %d hunks." message uses _(), which provides
the same translation for every number. The Polish translation
shows "2 skrawków", but the correct form is "2 skrawki".
Numbers 2 and 5 need different plural forms.

Use Q_() with singular and plural forms, passing
splittable_into as the count. This lets translators provide
the correct plural forms while keeping the English output
unchanged.

Signed-off-by: aeron-gh <agab0323@gmail.com>
---
This patch is part of my GSoC 2027 microproject. Mahmoud
announced this issue in March, but no patch followed:
https://lore.kernel.org/git/CAC5WPUdYxm-7Pjq4oAddLKXjSa7B0YdK8ashyeR9vhCQt+wvPA@mail.gmail.com/

 add-patch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index f27edcbe8d..4e75e2ceda 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1942,7 +1942,9 @@ static size_t patch_update_file(struct add_p_state *s,
 			} else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk)) {
 				color_fprintf_ln(stdout, s->cfg.header_color,
-						 _("Split into %d hunks."),
+						 Q_("Split into %d hunk.",
+						    "Split into %d hunks.",
+						    splittable_into),
 						 (int)splittable_into);
 				rendered_hunk_index = -1;
 			}
-- 
2.56.0

