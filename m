Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566477;
	b=QZbUtRqPu/6J8AOI1Zzwn0J1157NP9CdIhigHz10R4GILDmn/txKMCtNhqO4rW1N5LHU
	 oe8Riv3qbFn62Cq2wm7tGje5Licq5N+6iC+eASjW7+5D3cjjXR1BCO3eZgfxlVF4y9VmF
	 /FKEdHLE3VXg0//X/FA1tYb2Hl7vRRNcBPs8mNGFfyIjiR9uiSkk/XkiGpPDv487aopV0
	 l2Poq2TNd49+EA3LA+0KBOo30YN6o9GQ9tozSzi+P+enQO/sw9FtUxGTx0v+3CyrquMMT
	 +bSFzFx79YFXtSAIbrX/6+xAPUJj1HZ1TxRlQVG2jG+eQbMplYIitm4iYu2o2yw4kGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=QkfV7L5aMMXC8AKA6NRrf8/hrYG4Wp979UEJCkAjiG0=;
	b=xe6Q2xR0X5qmodyhze6aG6fDiOgFKK5li6qRHNx3+UO6vLhMFKzWyAxBzEYfdQ0pGXGA
	 jsimLm2khRJe8Hf6cDDjwN8Jw/Wg6Oqc4smvEPtnDt0KUzattOBx8gqdncgmsRsS6VcYA
	 gk+vay2ILjaI1MnGMbtPk/VhVYwASMpbp/Cg7r5rUrkj1hf9qHN628jkV2eszCwz2yyrP
	 bHWT1LVVG1pvvbpCVKTzhTyMru7SvzkbFj72Xi/+GV0tQ3BXzwLEkWFZCeVdOnahRXYoO
	 Nn20cXLiSi7rzBHiUPyXgAGGp5Gi+F6YRX7PJaY1W73MaSYvq1cUGVRbd+HFFdiQ+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sn3ibbBs;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E504606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E504606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sn3ibbBs
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f48c750afcso264487a34.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566475; x=1793171275; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QkfV7L5aMMXC8AKA6NRrf8/hrYG4Wp979UEJCkAjiG0=;
        b=Sn3ibbBsemGVMZE3HK5LKWaGIexgOHen18GMOcJX7kXAxJpSpY7DYdb7d5a6PkA3qU
         Z0gmLle0hp+Zd+qRdmT0umvZ1N01FQVlS3CU6KWXEZRJ0yaoGC5TS3pen20cfb7M5sBk
         a6YbqR49JsMH6S7LP11VeabzRA4XVYgEiZDdynoYrIaDMck0sT0yPAaqoyqa5es/sWwU
         r8Y0wi0Z+daLgPyVNFbst3XARnsoSwK7z4MBISAZk+vDdBDdH9V0VznlqTM4mqUghFMb
         8dSH0qr69R2J8zUcoT2ZY/pW/007/FQHluqDE9n5Z/1jAKG5D7eBZNOrgjvyt69boSX1
         eDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566475; x=1793171275;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkfV7L5aMMXC8AKA6NRrf8/hrYG4Wp979UEJCkAjiG0=;
        b=BYIl8p+LA5x2TtM6ea+H2OBhhzrKJSCoB3lRhYuVEi+/UWLWnWSDpfhvQwQPJDyeaU
         df07z3LkClht5QDs2PWhYYu1y3QbZTz6mg3AWaOWkvBkG5Dx3i9DIIt9wb+vcqpTl4B8
         7pOkgUxznyRr+3VG8RnPQTOGckWQqVnmj+TpMsY3UTM8bR/qp7/kcBZWTgBb5YLlhjfU
         GW1WIvX17lSFZo88W4mH3Q3cEjNIHsrZ29eUixNoofdl4uYISiBdIvf8/fBk/oLO7YP/
         h6ja1VG0ja5hdhsGWIpI0yltK2H3jf4zcyacl6dlUbu3j02+0O/rXKsNTPeqFecrQGdg
         fsNg==
X-Gm-Message-State: AFq9FYJrVrNYSBfRk8keG4tagAMEsxIHVnPkrDz+uI4rgSFFl9BB/1oi
	S60N9W6zRTgKjNywLidU7dHkDN2QUN/WkDM0CdlDpthNwDcrZETLIjg725jA2w==
X-Gm-Gg: AYBFou1MnENF7NOT/R12dlIA4Dv2Duy5u6iMZt1AzwoqxIAn7E7yrFTP7uXJMhXnfZA
	1Kyy3/S99nSF3ZbrQ8NIYA67dh1ALsQJG4gMgrPSVZ9JtZHfT7XRKdrSnCy1qXAHqBIEBBAmFtJ
	Mkm0Bqlqk/R+LsEr0Tw2+eqPfTF/zjnplqjIqNG8S/XcMXJ9pOHv+iZl/Kbghna0xNcmdKwtMD4
	Q29iSv297DHy61MHOHjrsecRFniwapX/jP5MMsSb5WRDBjhf03wgPKTalMu0mCPSs9UnFPmCFp8
	r9j6Z2DRfxfptKtyHrJPPLdVlyOHxp5UQWDos2lPNHcoJ6M1uJK9PFjBwgYBowjiRCHuuRPGM1V
	nAux+/rfOtfGXPSyXuclWidbpS3JoQnBfFAEtBzDNqnm7yFxdIU7d7PqmgAnBbL2lt9UqWb3lsC
	dVtHQhRwnzx8oQaxfYu2AWzsVvaKykW5CTUVB8AVpdjHnYaea+L6LSoPMtpc8dGlXJ5ao9oxbRl
	eFxqI7jK7k2UFLLWXy4M+5Rph2o4truZMWC1CsX2UwRiTZemKyFyxoIKgY=
X-Received: by 2002:a05:6808:f87:b0:4e4:4b49:3a2d with SMTP id 5614622812f47-553559a23e2mr663281b6e.19.1792566475529;
        Wed, 21 Oct 2026 00:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.81])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b87cc291sm1266942b6e.16.2026.10.21.00.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:07:53 -0700 (PDT)
Message-Id: <b170b1f6d33d42b9441585fa8877a9e24d8d37a9.1792566469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:07:48 +0000
Subject: [PATCH v2 1/2] imap-send: avoid leaking the tunnel command
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When imap.tunnel is set, imap_open_store() starts the tunnel but never
releases the child_process used for it, which leaks its argument list.
No test sets imap.tunnel, so the leak checker has not caught this.

Only the pipes to the tunnel are needed once it is running, so release
the rest right after starting it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index bf1d2cf74d..6f76bade35 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1176,6 +1176,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
+		child_process_clear(&tunnel);
 
 		imap_info("OK\n");
 	} else {
-- 
gitgitgadget

