Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795434033;
	b=aIoUDprGElfvj/fLhPgatYjvEKrNVTsmHRWAait2T9Lydq75q3k9P3/yyoss3vJW7dkz
	 J37bxL2lF8bkj+bEZ5D0qlXQdCtQYkRmABzyNYLR8BK6v2ZSfAaIaiuK2hYh6PGOAGA7l
	 7nkhDRzOri4uN3Zg2xs3j1+SesCg2iIojdww8It3T2cizpvF6Kxr4cYcYtp+KHSvRgmBU
	 VeorGXdZl04q1caP7xMjJnl6u0/rSv1p83qP5p1loq4rmdoMeD8OqKNnqS3hNlOffVfbk
	 6o9uz4Hnsy8XUMUAua+5nUp1KOteUhf6PGRh9+EqdwfapemhGeokY8CBRPVtasxK3iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WXNDzzsl61FRHDixY/v5ZEuuodlZuf1I3XjcDwS8izQ=;
	b=qZRJuGWDnGiYdeCWnv55DvmT3QpJT1gZgk9xWmI3xjq4GBTI1si7Slwr2oa7B2AoNiJQ
	 P9Kr8pYFunmGjIhLNCIK+I5CD1xZ2GeVf9+leXkMNr9NOTFTjrmkp7C+cm0/t5Mp/mIpb
	 tE7U4GDBH91Q2sMBmuC7nJ+Ans/2BUnZCoBV5kSfSOj3uhfVXesNMsUJXzFQylpxrIWU8
	 NiUzh0jWrQCiYNIkHf6C+7KAomtZmoAPUxwdmQnqs9DLRjFATV2R7ga9wa6By5Wp3Spnk
	 2n8qDez+d94zx3DR7GxHZQav1qVh07bx28S097o3VBWVXA2OjV47qg+MxbOGs4ZiYCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTJhmYzk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C61606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTJhmYzk
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2943063c88.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 03:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795434032; cv=none;
        d=google.com; s=arc-20260327;
        b=eVyBwY1I5paC72ChIPdvP10bCM1WMtVyxs8lNi/J5MUE8od81gXTyp1rZoqtJ23n2U
         j26WA+a/HNSuRWSXCEUKmJ00vwGwuPRqbj1W+yRZzoJD9W6u3SJsmR6Ah6SUdQn7TpUH
         0KItuR26QwQGCRl5JzEostOR6QKJuzdveRTdQdbJpLop0xt8nGYhkQKRCod8OQh54GG3
         M9me41orm0Z+mYx6RlkLJXfmkN5cXvNAo/g2+JoWmRQPWDMoDrHNVxTIYgD0nQFFLnO+
         TSvN3Emudk1hf0sCZoMxh1pnn/G5J0/LrYFFtEffPNii9RIsW44FVInhukcc94JhIKnw
         5CBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WXNDzzsl61FRHDixY/v5ZEuuodlZuf1I3XjcDwS8izQ=;
        fh=YgaRJzF75Ia0o7riQB7IkokiNn0XQS4TuWBxJ5rQKFw=;
        b=avl6fXXKjV9fGRsfMV1Q5cKcGeHYvkwgP7CftjA5vWt6nu9THHY3lcd3aemyoCY48Z
         Ufczrvga0rAwG1ybX+F0sazU4BmKXY8/zp2pbxDwNwZ0hy4erzN7qa/t3C2upa5HvB+q
         Mv8diIOKbtnb8pNYjFhVEAW7riLT9N/dwupNLhhy/yadeHSrOp3FX6PqNMITQL/LDQkP
         pf/jkPbYOd3+bmGUz6yUWa4yzMRKPDAeOryBOPptE6V2QDLjNA4DbPDQ8dqfE8JU568n
         oqmf8xxByRtdevEGJx4pDJABpkTrmA+92SmV9e5CCnqfNdefKfmgJl8OM7EisRsWNl/+
         GY+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434032; x=1796038832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WXNDzzsl61FRHDixY/v5ZEuuodlZuf1I3XjcDwS8izQ=;
        b=vTJhmYzkayKgOWo9z1jlOq1AaaenGLqRWkUGWdubWIkR2sRojvveZRZ4AbKWc5QN9a
         79RMSa0gCDqzx6UgV3o74YbK3NeIp18NLtAoZSQK3NycH4NWN7YFBOG7b3CGmc8/CHwA
         auKrJYahAy+2xzac7JkEf6gxFdjweA0f4M+zYm80jjranp3OVZec49j64HttdMs94WzD
         SrBxB6CQfSEbhr1MunlNjHrhI4CTwnC1hdmuZswAer4eHnVLcuUdPE/nA4FbJaNIwZG8
         mdYovjQ+eppkjJtq78cTZ8S9/uJ49uXV2OSdRerLhQeT7E6H/eqkRXX3b1vwXlvuRcjO
         8b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434032; x=1796038832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXNDzzsl61FRHDixY/v5ZEuuodlZuf1I3XjcDwS8izQ=;
        b=h47sdWrjqc18cXP6q8ifGHexnVZIrC1iomvisNgn7Tj95xowfa3NPgAe2Q3r3XOTkE
         Du/MuaQegqHo9zbKw5qudr04OyN/T0KOt+dUnpYr7N7+opbHEWmswrgjiMHvgxTDc/jY
         +7bJgr2fV6Bunu+N8/GohawAFal5Ikj+nG7OX4YN8A3TvL45WzuLL8QSTitqm6ZdWf3N
         daYmx/FwS5xnWM4wE1+MEWMjUguJEx7NOJjty7+stRwMXIqnVvQAfdkHvWg9QQRTGgY9
         516pxgQ/dAMfxeS7QbRfk5L0DGyb5563xwMF0vYiodOY3W2NulGh4fROD1ImubpbQZbD
         GZLg==
X-Gm-Message-State: APuU4Z8LXqkleUPRo4KyMg5+O6+DPL/X6jdtcD7EIS6h/eKqT13Mr2qr
	fpECf8+VDwTCfdgF+egd+yZxDChL1Q0jRybqg+fJgGj/n0wds3lguPGSc+9XtVxvmtHWguqrV4X
	OBcI3O0a4IgsAYAzsPsqh1XiYzkZ3gU4=
X-Gm-Gg: AZFdTZdwgrxGSyQph5omLoQGJjfFNk3bdiKkt4CZ5hJ+NByz1S3/QNRlYt5znTDl1Pk
	vgJu6IUemErXR/cUg86hTb5tNey+tuUtR6A4F5cL+8ji0BtkdzapVqf5wf6RVdKzkpaqmdNe51b
	qk2rek/+8Z0ANiqXHAy5LBFE81l9iMD4d9lhgy9gnpvxoEu6lm2vQf3/fmCOgaVKc5ycXXeqeHC
	HsjzkHlxh8qcFnLoH4SmiyXnWKRjWyo+Z/8RVvHWUqLrcJUdlMhlsW/z8grjL7hOVGCnzgWv6en
	0Ggv8H0DGx3yNLKaM5Gshe3b35XfW3rIc/m8wUurxsMlX1vPfVmkqxN+qs3KcKzzWs1Auh4ceql
	yEpCReH85ViHwtB5kMgMvcDhbcxSYrIYX6s4P1/GUvPX9NkMzSlGN1MrY2uQr6KFlpsOEvI7cxx
	PPw8PRYYQf9v8PaEhRmWc9CZOa2hXpYyabtzd6VII2GnaU3aYvX/pxyRn0mBPypGOiqxnJuEgzj
	F+8miriDNllVIWuQTptDmqi
X-Received: by 2002:a05:7023:a8b:b0:144:e535:3ef6 with SMTP id
 a92af1059eb24-1b5568ef837mr11856299c88.41.1795434032339; Mon, 23 Nov 2026
 03:40:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793352943.git.gitter.spiros@gmail.com> <cover.1793439137.git.gitter.spiros@gmail.com>
 <b27ef2a8882c2badb88d257ca28ed38b67c13c1b.1793439137.git.gitter.spiros@gmail.com>
In-Reply-To: <b27ef2a8882c2badb88d257ca28ed38b67c13c1b.1793439137.git.gitter.spiros@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Nov 2026 12:40:20 +0100
X-Gm-Features: Aa3M54pCEHtUvwaLyEnyNPNKnZEYjJ8IvmO_Jfx4QBSLD-TeCWaPGKFdwZc5jKc
Message-ID: <CAP8UFD1VK7AUS1BrLMZpiY=Mq6sM=kteeq65FjsZfsFD+oprdA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] diff: use size_t for the allocation size of
 word-diff buffers
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 11:16=E2=80=AFAM Elia Pinto <gitter.spiros@gmail.co=
m> wrote:

> The buffer in diff_words_append() is bounded by MAX_XDIFF_SIZE, so
> there it is only a matter of consistency, but if that limit ever went
> away, ALLOC_GROW() would truncate the requested size, and the memcpy()
> right after it would overflow the buffer.

Nit: This is correct for diff_words_append() taken alone, but it might
suggest that this change would make a higher limit safe. Unfortunately
it looks like lots of other things would break first if the
MAX_XDIFF_SIZE limit went away.

So maybe it's better to not talk about making MAX_XDIFF_SIZE go away,
and the change in `struct diff_words_buffer` can be better justified
with something like:

"The text that diff_words_append() accumulates in a struct
diff_words_buffer is bounded by MAX_XDIFF_SIZE, but for consistency
the "alloc" member of that struct should use the same type as the
"size" member of its mmfile_t, like the "alloc" variable that
diff_words_fill() uses to grow its output mmfile_t."

Otherwise the patch looks good to me.
