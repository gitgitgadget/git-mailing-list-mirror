Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C32C80
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819287; cv=none; b=NZLj7MqfqDqPfeT26HgxR/Ccy5Mt9jVuFuh8b0K+KI6vCgc/lI+EnBzZkgUUsvZPYLqYdQxEd3N15j17jbRUDeWHxlGmf6YoVn20UrWcsSM9YQFOH3rcnLKShgT9PGx/rb7U19pZr47tWiCFSmS9UM0yTdyzjwdsLL26RoQDwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819287; c=relaxed/simple;
	bh=+NzSrvVLsgObA6+c4WX3MQCD2eqLecWreZD06C40D0I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=H9m2CM19ppoC57mFElGGtnBvDC27b/8Qv829yP3H9WBDmeHYGCIJBIGcltQbQI3450e1dnGdBsYzZe/qQ+LVH6/C0DdBekzdneGOTV7qNd8u9bAenv58tkQHCL4MZl3lJ8eRhFp1/6G0iIeOya9FX6yjkGRZw++ucxye1fK+u7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoTJXLSM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoTJXLSM"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39133f709f5so2247851f8f.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742819284; x=1743424084; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aFJn7tu7zwp3zHtOwSXduwu+ijXKLS5GOKRr5ZHhxxI=;
        b=UoTJXLSMdD2ydc3grpnTM+AAfVmxkCEmOPxnMDQRZJz+lRcV3/N77yaYjY7yKJctJi
         87/bquFg2ccjwYb5z6WFG6wQKNqQ+dVl4kJ7CKF+NvWY+/q+U7ljJuDMakU2pVr7M8y0
         FGmVQix4GWUyNYihWxpGtxysO/rjqo4OTdpG5HrCrX/zyKzBBMVKAm+jDfvKKmH4AIQF
         bakJydgoBgDsLkVTouEDujZ6opUAwbQdLaH9TN1P8m4UrCNlIF56vxTZ2MFxEtyKDYiv
         VhQeTltMMDNTTMRo1U2PDFO6AvossYUhwWzh5dMFQevFSrbzqr7JFoDQJDwMvbtEfE9S
         TAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819284; x=1743424084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFJn7tu7zwp3zHtOwSXduwu+ijXKLS5GOKRr5ZHhxxI=;
        b=k2sbazoFHnQQ2lJB4I9g7r9VKt7xXqpEJ03JutmHSutFzajpiIoGVzwjSwNkDc80aF
         LQ7iz9jY4h9rupYyGxmek+S/nDVLvQSZmSp9b2kR5FMxkGvYIkPQ4uZenMCpW7HX1RJv
         CZkNVirCIIOIvkDEOyeLX01opPGxMoBD8DIyG8qHWfdpLtvJpfrpm5AmhtgA8LyT1qlL
         crPQyw/nlves0LdTh4Nwm+V3vnksCQda42TNNZ53e+kPszg+p+oRH0X6aiUEsmRcEnUg
         pE802bCt8gi0vQYYCMCOiGLuwCS6oYR3i4Tc+5GwnuGrck8ZfhA22juFdPX1qV4cgCGJ
         cLVA==
X-Gm-Message-State: AOJu0YyrivU+7IWF2wXR0oAZ+lhQLnPlJIkCYAQRDxCbu+wHcAfro3+T
	dx3iKOl5OJCcNxQTbxNyuBTtE6ljF15QyWlU6Gu4i/vqk2+hVX+le2hLCw==
X-Gm-Gg: ASbGncsuqq1Z0pTLWG1mZ/E1W7fIgNpt1VfB3x9sLFkoktxjbIqN4FAC38oDHcxCaHd
	2+ddG3lBfF0bRdVH3xM+mTV4bUV94yCMy4vUeTWOciyRMjGwqJlZHT2OSQvKRqe6NzRcowohA5I
	XjDcSSVCV+/KQ+1+RDZYBBj5/A8lEkr/w+dRSadkLYjByr8/0UP6WfuQy5mzvrxaRen3q6pUKXF
	fcX0Qgbi3rbbpn2bqeEVOFf0wSN1E2sphb3j305RipEK1wsfshkDGA+i8a4IapzCremOR255M7a
	LyhoRRX6PaGduXgecWg5+X7de1tqKpE+K//Ifm1433uGGw==
X-Google-Smtp-Source: AGHT+IHHncal8UrTxEkjPtQydMlYJMNrRQZa9/s+sZgbDVV9tZ7YLpGUJIGq0s3nOQGXe3kqnVROhw==
X-Received: by 2002:a05:6000:184e:b0:39a:c6c1:3408 with SMTP id ffacd0b85a97d-39ac6c13529mr244649f8f.37.1742819283473;
        Mon, 24 Mar 2025 05:28:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eff79sm10926794f8f.95.2025.03.24.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:28:03 -0700 (PDT)
Message-Id: <pull.1886.git.1742819282360.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 12:28:02 +0000
Subject: [PATCH] imap-send: explicitly verify the peer certificate
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is a bug to obtain the peer certificate without verifying it.

Having said that, from my reading of
https://www.openssl.org/docs/man1.1.1/man3/SSL_set_verify.html, it would
appear that Git is saved by the fact that it calls
`SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL)` already early on.

In other words, that `SSL_VERIFY_PEER` combined with the `NULL`
parameter (i.e. no overridden callback) would _already_ verify the peer
certificate.  The fact that we later call `SSL_get_peer_certificate()`
is mistaken by CodeQL to mean that that peer certificate still needs to
be verified, but that had already happened at that point.

Nevertheless, it is better to verify the peer certificate explicitly
than to rely on some side effect that is really hard to reason about
(and that took me more than one business day to analyze fully). It also
makes it easier for static analyzers to validate the correctness of the
code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    imap-send: explicitly verify the peer certificate

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1886%2Fdscho%2Fimap-send-verify-peer-certificate-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1886/dscho/imap-send-verify-peer-certificate-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1886

 imap-send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 6c8f84e836b..27dc033c7f8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -324,6 +324,8 @@ static int ssl_socket_connect(struct imap_socket *sock,
 		cert = SSL_get_peer_certificate(sock->ssl);
 		if (!cert)
 			return error("unable to get peer certificate.");
+		if (SSL_get_verify_result(sock->ssl) != X509_V_OK)
+			return error("unable to verify peer certificate");
 		if (verify_hostname(cert, cfg->host) < 0)
 			return -1;
 	}

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
