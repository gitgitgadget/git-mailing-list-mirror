Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999159;
	b=QcktXgFkR9HC46Cgz0U4GOyKtBAUwlxmjhqHFtCr969lkT1wFhy5cKntgl8s29g7l2Js
	 0OMNpbWWvpdbWV+b+njRA+iuADmf+CNbEhjXEhCi3BTcj+qT4uY7hDWUnwurOZnlFKCGo
	 vCBz9+Cm679fxCL1kfebinmN11ElAnOaW7lK5CT4bNQLqStBusq+jbOX7FYZ9UV9IrmfO
	 pkE5F7JJzkVMdmbKZNAkAjnzS61Q4EwhZkhk56nwEBO1lRSaQawRST1pm7odXkwsJC2OB
	 MTMuMmyvmZGuV4P3PqBa2lfZFwtOmGeHmEBrl/+vMNRz8aP0B9tmaenLZ/oZDtcPM6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=v0k7TU+IxXa7RMc1MLK7iKi9aqfICszx1c9+ULn4ygs=;
	b=bJY9pKrAJap8X0RDgHn1CmYFCwd4l0pbWGzh3EE4XR3ctKqmzIdTv/SZuOJyUkfUrcJY
	 R7KT0ouSPiIT68SagaNLhb5xf+o/7e5LqY2zSF7Q6Gw9Cskb+g8hyv8KuYJn7SXAvnBjQ
	 EJ+jUrVaKrYMODyguS2FuqprRTeIYLwg3PMhgDOcLUiEznCZNxgwTlHPEWlXMWvf7QQD1
	 CePk45+M6IrgK60BQgNGoX7mKxPCjAgvcVR6gg1682aRewOmvH13sQIYU+ijSJJX8oCbh
	 mATmm9+M0BZ04Plx6MdeO8KH1jBODzWaxFWTmmdKBStClW0Qm/pAa6Xh8BvTNhRMpEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YkB2EVNe;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DE606A333
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 10:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6DE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YkB2EVNe
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so5381455e9.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 02:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794999158; x=1795603958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v0k7TU+IxXa7RMc1MLK7iKi9aqfICszx1c9+ULn4ygs=;
        b=YkB2EVNeErjh1VA7yMq6PfFGEUDCF5DMgzYJ0itkxbXIUHRWuBktOg+R/LQck9FE6V
         KFt88ire+O74ccmbjt4fhPBmNAsLJx/s+uZoU6Pmr6rKRlO8uu13Jfgw69ZaMFD039rr
         yerWrsIvCE5zNci+ixyJmOqpKDwYN+2w1u5yCrB8Lzhs37md7JQpIqU+TJDS66vdoxul
         CNDwUTZe9QETPu9C5kafk6bIC1wyAt1Tp0EVXpz+poNvj77pdN16Iac4uGs53n6Hn0fe
         9KT3KIaHZAwQktUi9kh9VjQxWic3JzCO07KTW+pRU94a911/Z61J/LPz+pQfk9MTw+db
         NgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999158; x=1795603958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v0k7TU+IxXa7RMc1MLK7iKi9aqfICszx1c9+ULn4ygs=;
        b=dLKBvo2wyTclj5//UmxST277GxOZY4wEKCuNKh7cJbPoxR/VJaOCYqXtnH2BWmtqKG
         Y7kQcBuoETeLF9xaoAxUCikVEszDe3xl5bEcb0Cn6AEK+VnStNNBu2FXpzXWdr9rOLi0
         2mhSO9Bi2svAHsfk7hO67nWc9Xm/SQaPz1T/hz6C5fqpz2+EDcFzc0Wem9T/9As30xcb
         H5+v9Y4pNyXzda1AT/BHRQJygj1iSWC77bRUphYCKgk2wRWwB1Npae+w+yPmeDvsPkhB
         d4sbwJpFtsZPr2DBA5DHiKwpIymR1/nkjXnhVozK/pfiBqrNy6t1ilEA19EIakwYH2To
         bSig==
X-Gm-Message-State: APuU4Z/pTKdCEXnRoqKfkfe/Y4+r+ybi7mksjORwUgT7CMf3etS9kVD3
	tOAqHCVlUPB2bZLf3jTGTj/9Yf9IErIxiwrzz4h4Ubgk51yfHS9mhhoKvrfMLugsYfo=
X-Gm-Gg: AYBFou0gO7UfFBPNZlyvdl9i+Dv1U86vZvBeE46SRNsuyO17I5C4TTjOecwwUD10f7e
	MQrDJSS8yZ187+n4pkaCPbT41CIDD9W3spvN/yj4Ags5gG6z3KgpTtx6CbGg/XMBem/aZuo72RZ
	FBpD8OxwRBia2dPypCNkA2vW1blE2FMYGEM8WJXPys+3akfDtmNZH1PEGbx0OVRZlMCis5CslTv
	tEFq5jtOoeE86FMEC7BQelH8OVdZjANhYLzRw1OqpBdyfr2nf3VbqKRUIMARACg2EuYtRyBwHV2
	vpn2d/hXR2tyaEqim7cjFK6HjiTKOw+A3kzAmW/AN/nC0EF2TCtw+xKE6Q2WejD7KIfP7ARUI50
	v7Oxp8MIBMpdIC9T7PBMweTHFd5lqHOyi6Mlnf9p+YEUfvCgMRI/6izWJykhIhoB7Ajl7XE7iY5
	foDoqQkE/AMV46bQE8pDTrCVkwGDXnh+pFD4QT4H5IaFZKnomRl+/2CwbPLobwpjTsZLYx0cYVK
	sjc1l2E00uuaxvsV1j8krsFAXHLo6zuQa/8ssBVHvGGpw4Y9aaib3HHclndRtMX2dZ1e4AWtgWd
	5xBKutEKFMvqJ0okzHdxb2dLU7F9otqY48TGa2P64WAbXwYddYANVa8V7Rr7BdxxIMRsFQcLar0
	Doys1ztfjzDbvNgVb/6oYt02anNv7FANARkxSC/4VWCO73TPFzlieh7k0dAMpArGjowP5BjaRyW
	pM7jE0UWeaR6dQQJpe+dzRsKNS6d8x
X-Received: by 2002:a05:600c:3b17:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4bb7da139d3mr41960435e9.11.1794999157527;
        Wed, 18 Nov 2026 02:52:37 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2ac6e0sm64623045e9.8.2026.11.18.02.52.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 02:52:37 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] MyFirstContribution: leave a blank line between mailing-list paragraphs
Date: Wed, 18 Nov 2026 11:52:27 +0100
Message-ID: <20261118105227.50447-1-okhuomonajayi54@gmail.com>
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
Content-Transfer-Encoding: 8bit

A short reply is hard to spot when it is packed against a long run
of quoted lines. Leave a blank line between paragraphs. A block of
quoted text counts as a paragraph.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index c58253fd54..9c189b6c9e 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1357,6 +1357,9 @@ relevant to your response. It is usually helpful to trim away unrelated context,
 such as large portions of the patch that are not being discussed, while keeping
 enough quoted text for readers to understand what you are responding to.
 
+Leave a blank line between paragraphs. A block of quoted text counts
+as a paragraph, so leave a blank line before and after it.
+
 Make sure your email client has a plaintext email mode and it is turned on; the
 Git list rejects HTML email. Please also follow the mailing list etiquette
 outlined in the

base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
-- 
2.56.0

