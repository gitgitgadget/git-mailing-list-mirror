Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437562;
	b=gutNo3wh7B+NwmuG5CjGtaaTS3MjCg8rKNK2AKi2s5ZB0h9Aa+TbQruobdW/a4MS6IIN
	 dlnzh+HrjIlc5kfwR/vRsHbMFmT0/q0iQjKKOkiMxUURTs/qQsR6GrCYmOlMu9bR2zmFS
	 Q7SIeKIBIlUj18W6qRml9Rh3xtoiDMsvtEeOZPdn7JuFialAhYq8UHIeqrDx0Ayd39jqC
	 MIdVdm0yygMcsz4nss6OsRPGcSIu+8FfyVVD6tKE2d2QW9zv2AckTcdcaDnJuH2iFIWCa
	 XoIda3B0Trqyd4klmfv5o4odCoq0Vu+2pRnpU4QlvnySwdtZM7T2KEWMg33I02NP7bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=QkfV7L5aMMXC8AKA6NRrf8/hrYG4Wp979UEJCkAjiG0=;
	b=w81nBJig6C+8q6f72bzLxtMrTzidyVAAmDQRs592YTcQYPy2on18IfhVjfwUt+rCAQEi
	 8cfq41w0jkeEJQuNvFRBnClY6nZ1pxvgQOJ1YCRCIcmjOmPqd5c1WlANeHhg/FZh0fQYd
	 c8dH1+3uY+sm5cmnzqziRJt5RjXE63ICdiMTrnAokFSBNTvhOrDWeRePUnHSYHe2j4/Ee
	 Ns1TGGibEdLgV+z1FhTYc72qymR50+gbfdLhCVMUMaktMCzh8XdRILZRPlHJ1Fy9mC5Dd
	 XJBg7AWy/my/K9JEzrh7qHD2RSeO1bip41SYiz4pSoamF8iipRk3SEMc3sCLlrTybIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QE61ix9V;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5560A2627
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA5560A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QE61ix9V
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b8306b9f8so38076686d6.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792437561; x=1793042361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QkfV7L5aMMXC8AKA6NRrf8/hrYG4Wp979UEJCkAjiG0=;
        b=QE61ix9VlNGutMgxMIpFo9WVRMPGxFQ6notmrhhIZ95ejtjshJtPTr4A8ddlSDoQd3
         4zFyhOijfoJe3AJbSJlY3cGIp62D/Zl3pVVAfcQmffr83meMgiUOmdxSPGHlAkPymZvF
         Zd/1TEetkzazftSzsAuBcPrx0uN7JZ+wE1+rDGftepNZdvgJhp5FlX7eOhnDSRdtBwRF
         3VQhN2gtp9OKYU93IhlmEqPn3siH0AXta1bdCWzeaZmxNTeu1RNJAsWfr8QajBxotm0n
         5+SFGJhjONXNzch7CY9TS8f3Pb7QX54vTBqDdpaZCxBbNWCrW0y6BjGpI72oabC/9ncC
         hfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437561; x=1793042361;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkfV7L5aMMXC8AKA6NRrf8/hrYG4Wp979UEJCkAjiG0=;
        b=jKcDttqnoiHWB87g3QXSzQg0CH1C6IvFyZbuv15Z4Zr2NOJGbtwdVPvDPKfmAXDDeJ
         pAo0NL90RSZ9ssWAzKDGBIbwLVN36TuOL12rioohob1KMokYcfgWLtn6Dq/cqI4mEHxt
         /iHIqQQW9pGOhHV+rwNpHy56f0uyHMPU7LEPhdDygPNvf/a1UBL3NpopcdJ+QKyrtuZT
         /Iof4vSA8MNuvXBj5IyUATg8D+ndY0pMo9xm4aQlnWjRNxW5WotmqEhQ1He0DwCiLUxb
         VhyLtAX6Abmg8HdZJgpGAMX6IvPcvp8JP42cYclhR5zVWTyEki+hy5xsGIYgWvSxinYt
         gLqA==
X-Gm-Message-State: AFq9FYLj+89p/y0H6hN+75VGOWLF/DDy1zmkJNuhgqu2gZtzgKmPVupJ
	wONPFCxA6NBE+gX/QVm9q8WXrlsaOjtgvXu3hjNISX0oggbliHnVF7gsZL6Q0Q==
X-Gm-Gg: AYBFou0H5QvFHfAQ1/sjQt/LGbRZ5iyjkN3u/Fd3xFyZctj4uvR4Tdh5w4Q6IHx3Xg0
	ZRENsKx7oYVh9DYsJr5/eNmS4njtP0O1fcK5gAN1wG/AMHnSIyMkGPRh8Sg9++p1uWl1t2ZU0GT
	0PyDXsQFsOCMu2UMnKpM64LUvoPQl2z2XIvKNqk25BYehzztRkSpqGff2qEv5viLWlA3G3DTR4f
	M7rCC6EqLY2ED9rGHNR43LSa7dXeoxkp7iY1WJlPqunMkhdTbtfaATNCaTTy9ZSBaxW7BRpKk/T
	VThKW9ssvi9/8sHWNl3QRBl9w8rsSx+T0EWNRs9iL6yuo83/4lZa+nFu24rA1IprPIzRzNYw+Gw
	hwEDNkUlWMD77XwjWn/S1KxrJTwKkaoTlwuhKg9rgjUYnuQoaF4NL9DXDuvxZ5qCsPYZklXXXYk
	bIa4lMVb0PfqWQyAmHIqUjD5QMfze+T38Hr2O2vKK/aDIof2XAz+hfwIGbcaA7y04RJdT8LgVAe
	wC/W0VNUSVf3vPP8Wv3HUx8qQK0H6EQDkoV2eW6Bb/x1Nmi20BfIN5kl3A=
X-Received: by 2002:a05:620a:1b88:b0:93f:35fc:5253 with SMTP id af79cd13be357-93f35fc57ffmr1040672785a.31.1792437560681;
        Mon, 19 Oct 2026 12:19:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.103.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b0a0192sm33993285a.25.2026.10.19.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:19:20 -0700 (PDT)
Message-Id: <0784c16134e4b2f9c969e46ffac241e1901b264f.1792437558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 19:19:17 +0000
Subject: [PATCH 1/2] imap-send: avoid leaking the tunnel command
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

