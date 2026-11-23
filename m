Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472030;
	b=IKf5GFhDM8SvRDA3tldv8EP1UGM4cg+TIubLpZjqVcH82bRdDYFiBqBiCmbAvx8okADo
	 y/V4hnC7XQaFcPCwEsRi1kqGkxg1dJLKtith8qqFRhuN5+Rj2RtpcnESNYOlpn7cWpeJv
	 mdLYa0dWWRKJI8cIMymLPN3jNIQiGWFEwX9Miq1LSmOHHtTOkNS2TnyxwQKW6Qe4dScom
	 Acmx/AfqMe6CNhMia+UCvSOddtS28iS8nTU4EzeD1PBdasdENS5+JQEVGg4eBzUqZJH34
	 7x9nNu94wcW7J5rA5u8P+iaJ5n7KNB1l2jD8Yf/SUS3APX5w/VA4JHe//YLM+CmbssA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
	b=QKr3wfhuK/1NFC4MndpgsjOLRRoXWowbxPvbKoIJqePsGCM6QHuOq+vo77ywjtT1Ajyf
	 nAQR8jW/s+ko8GmeV3gTpDlePNOcz86iSSQCi1eFfkH01QphahYKZAlaGpAqKniLRbdpt
	 7nWKR3bj/dgJAKfQx8ZiZnBy86HSbl+VAKYiZOM8GWKxa3MBmQ/0C/nTu3giXQfMy+Frm
	 SAoxxkwKa94z9UWFXsS7+PQyUQY1XJlQkE7DA2ArvXHkuJTwK7zoOz0M9zSm610fQyOuc
	 RQ5eRqmdKSboZdGPhg1v5LdMWRQtoZBGLaqgo/ja4pfERcnlIOPLD36Y7KpVLc3/bQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wR7KbN5t;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF4606A32C
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71FF4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wR7KbN5t
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385c497bf94so3182326eec.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472029; x=1796076829; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
        b=wR7KbN5tk4Z5yGxeNVIb22AtgnlGS/yVR4ITcsWoJ4b1rcz1torJ8L7+bYUCzAwxkw
         ZCPp4pz4XsduWIAkCXGLWNlndP1VcxfOr/IZ4rFeAiR489gXU2CAJH6nGpoz2BP7psvf
         +Liqaoo9+i6nIPXcNkh/PLM18twXI6ZU79cihff7gH5FAN7wJM8lSQQiA3ZPz2Nnm40L
         /OJNejG0snS/mL0MeL08ngB5vKAmRRUR4Vs7dZQf5BBgG//LsXSFVRUV6fNKKScyXHpP
         7GNg86UsxcZbXJTJgXrSY0dORqWW2jy/RvicOdISBcTn1uwljFp2DoGXRBsTWvYio0Tm
         kuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472029; x=1796076829;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
        b=UGVIgAFp5VqeSsohHPcRYTm6C8bakNwL5qfWYgdpZi+9OM9qDR/zOwTa/6aa+nMagE
         2A3eDTanjJ2S50MtgbceHwQjRhLYU5WirktMuSn7TqY6DALgHxKO7RziLC6wNJ900YTl
         icaYON4bHgh9K2nR+LlHZVGIlJEIOT8OM2QMR5vQKVNChOoxZv1RO1hRIhNoaPu/pJAs
         VeyoV+0+V/6UGl69oE2yI/FcFPAxq9IrV9V6VGYwstU4yTonxA47514fmuMR3pBUytfz
         BxPI4LrCPbpOuUfsG17I9HQsylE4UTA7FvKonc3RT8+cikgoxf9q8C6GnBHLxKvIbjlX
         Aelg==
X-Gm-Message-State: APuU4Z/E6YIYLjv08MOhIG6SRMKdnieQ6JugOFT9vc1MCb2cIyqmZgac
	scyCdjG/wvlx1BVT/lNjtnYte45UJLRIGz5jF6lXFLxqzLB3wEWrttHKxlWSAxuP
X-Gm-Gg: AZFdTZfK/Z5IMNwVFsowMx83z/eopzxNeegfo+R3FEm93Sb8QZgCBXpUZsmccmdeIDr
	/krz4eaTZ3Kh0rrPc9RISdz64+Ifg78oTMaGkhIhwNSe0RHywCyWZxj8Ex4jzGehWbtOlePqsw/
	Jh6HjrrKer9GdTI5tMx88yrkatdg0TKIYYqKg+6Jg8+q6tlp/1bFAGVt+Mq29XDip5LMgbBiwgP
	dMoPtfb5g7G3DVEtXQVXKmt0aVsaHHEOTmDKtxq7novX4qUTUtnwwWOdTdJFywRCeisO/Ja5/6u
	kP9N6NBZdCbiE3KYAuIr0iuMIiRwwekHPtsqUigMOwwyiFA8tORkjM8lRULg9yY8h42Ea95IsIi
	sESBbKx8dEadZ/GA1XSdGUjIqcu9XOAvrGj/23z9iIiL97mxHKQw+Heac91XlYbSppE3GonxBKH
	yKSKYkIvqRYhC1FkFrBtUu/F9iEvhEFYlb34TppU4WlOcQJhoX/1xWAsawF7ycMAlK4m8sPw6mx
	y8IKwIp+U33OJ+UJrWxa2b8pIvV0QE/DyAWIgADd0ZYYYdrBiZbHhe8wv0jWL1Y0cfuvubpPgeK
	lu/RTdtCAKUTWGxqWHgTaZJp/71v5VuiCq1QdmEMeEBaudwPsuQ=
X-Received: by 2002:a05:7300:f0c2:b0:386:688:7f25 with SMTP id 5a478bee46e88-386068880f5mr12415190eec.18.1795472029456;
        Mon, 23 Nov 2026 14:13:49 -0800 (PST)
Received: from [127.0.0.1] ([51.57.82.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm15146194eec.18.2026.11.23.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:13:48 -0800 (PST)
Message-Id: <bb8225547fb67224a199137ff50a24720b4e506e.1795472027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 22:13:42 +0000
Subject: [PATCH v2 1/5] archive-tar: guard get_path_prefix against zero-length
 input
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `get_path_prefix()` function uses a `do ... while()` loop that
unconditionally decrements the `size_t` index variable before checking
the loop condition. When that variable is 0 on entry, the decrement
wraps to `SIZE_MAX`, and `path[SIZE_MAX]` is an out-of-bounds read.

The current caller (`write_tar_entry()`) only invokes this function when
`pathlen > sizeof(header.name)` i.e. when `pathlen` is at least 100.
Therefore, the bug is unreachable in practice.

However, the function's interface accepts arbitrary pathlen and maxlen
values, and a future caller or a maxlen of 0 could trigger the wrap, so
let's add a check for that.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-tar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..2da6e55484 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -210,6 +210,8 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 		i--;
 	if (i > maxlen)
 		i = maxlen;
+	if (!i)
+		return 0;
 	do {
 		i--;
 	} while (i > 0 && path[i] != '/');
-- 
gitgitgadget

