Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941366;
	b=rjUk/mRpLVphhLqTb2wmovQMn1jnON3lKx9h5S7yUcj3TcUobCLXSKVXpzat3L13FpeH
	 QSi81kDwPTNwaSibusGyHw8buMsBOArRqzuDi+TF66NVs+zz5Oi2AAdGHBGsPWT1NK5XG
	 mA/m/abPJfk1/iAxU/XGxzIIZVQSwNokiEMzU9IssjIrtXPAbIWgPb0202hngRknYeYoJ
	 3I6xgzJ61wb/VZxX2V1TOasfaXg0JqzAln9njSxJk2ID7T10bkN6HiMT5kMWnwLH05rFw
	 tDLisIn8Y1+0taC788v26dtEdv0Zm4Unj8csROa0TJTVE4L0GIWGExvnwL3oBTFTGhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4uSIe8PNj+KSuWSW8AHj4fnrubglBgrlxLIyDUbxq48=;
	b=t4H1KiFpI/s4iDXeAWhuPCtgJeeV3nnoStudE1mk7d4lVwF3Bb0i3NFg9Dm/S987FQIb
	 8ksv485tAZIe8RMn9vj8URPg7Ks5aLmS3lRLif1JG1jhi8z2R0cRKiVg2jA2iikdHob4A
	 EvLxWVCOm9FkTsEjg3PzFiY387zz6SoDJO0MI2CM2iUdooYV+WMrD2sKW62aOhY/ZUS/I
	 JzexsyZacSBJ/cFsPw/OAmsz7+pjKno9rhRAr1yVyIAjHcVNhSPHMYTjHdqv7sk2BI+HD
	 az2PoU5jhamnK10+CphwY4asTbFxTecP7H3cLeqAUrHSGa+6odiBKINnJxh20MjEujg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Fub6O30/";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CF606A884
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9CF606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fub6O30/
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so1837815e9.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941365; x=1795546165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4uSIe8PNj+KSuWSW8AHj4fnrubglBgrlxLIyDUbxq48=;
        b=Fub6O30/KtOnGkIzSaqc5qGJkScoQ26AZKHJQUuJwduKopQFU/yKPE3Dj/qsl91Ufd
         VG9pWlAVcBtI5dpNymjZOm4psYRN+0p9KXhumVOfcLQeP6I4jjICRH68nHFV7mdJlKxb
         +pDW77r3P3/otaWcgEd7loDe4+SZM/k44mGmQs5zoOs7en9lPEN1lqPDLMV5pO02fyTw
         321Fr7eUvVRYaduHJgwG40WPAhWP6wPxoQVvu/hkXQZ5RmOE2MBK1TIjlXEfkkzQnOck
         ak+bKh3i0LLO4WAQYGnhHViv0SAJVuAPingI3MnZAtxyk7K/iLEXylDKAqyzWC34WkFo
         X5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941365; x=1795546165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4uSIe8PNj+KSuWSW8AHj4fnrubglBgrlxLIyDUbxq48=;
        b=wQAuJPWXmzk8leT7e9LwjzVJZ2vvLVV6bqDso3YOCliehx/qIEsIBRQPwssi4Rb5Uv
         TZzFlUio+a/a5CKGtpoC0xQ3SLk3nvp19zHCyXExQzTYS2SH3Dfc0Tistqpjq2yDMUha
         uWBIvOBTSLlbmju8v1OrriPubECmP4RLeluTMUJdlwT6rkjrQ/r+vgg+ygTsa8AV4WSd
         QoyUGoSkV4OXzmCu3uG1B+Kf/8xkmTjvoEqjDUDdnks/JrP4rOgYbBvPujSMrOCNU+03
         z/XI5MXSUOf+7oUZ0bt02XDcQ7d5Wdf3cisKOg90RNOmUrggUhkzvpClBYZ2DT2XPWFJ
         KIeg==
X-Gm-Message-State: APuU4Z91wtavQIjUp0nGripyM07Gocaqdp4YnfvfGqbuKtrQy8yCiITY
	Xr9xHhG5wni5En8VbrrDBf26DXvDUe1IfKDge/rOMu/6FGNumDXuCrCQLooUX3d7Y74=
X-Gm-Gg: AYBFou0B7ZME9N+3gx2euxF62YtlMIMGz1MXKixeqsHHofHNpTe9UXX8g9lj+01cS5d
	zmSSIanCbVX1Y+dRiwTMGXTSJYl+DNtiVFn/AAiAwV590eNz3wpmuTRQ976hlwLeTMZKWDREE+z
	c/YUNXrsoHCql1XzyAg7oKOnzHwbtOX/eBa87Hj38VwxdGHytY3AjFbXFY2lCTSIE/kn4RklS95
	LFwcUsK8TILrAtuGOL50akarxxVqTyw/sY94m5Ldr0UT1ghwiuePBCWxIT1/LHcVXTisDa3IDS8
	Sx7uPAazbQxJqAxGIN022LDOrF+yCs3ZiluDcsmVNKOmT4GoBe+QizHpeT00vhUy/mOKwmiFj91
	LYHOMa76AqleIvLfABTRkC8n+aEKo2eyYmsX2gkiXEiHn2DqhpkP6P+9PkzuvDAJCvVsaBLeJt7
	pfbdpGWwD2ZWxvtMF/e1M22H52u9uyQldC9D6xw6DdNIEUr6gh4IXVPo58Ou3ZCuIL27KuHxTzd
	zKmqpE7lf+C3DgaS0WGl05USaT8zcmGK6HFL71awhDjdn+UVZGlOqff8ZsneT/cqiL8BC6qeW/t
	Fr10xLdIkRIhC2/ZRPkMkkvSGtwbZyZM6QtkjIqeuziBx6iF7e60EX4hSeYVkmhBE/eYIiY4v1j
	8YPBbJiVVr2KoZyI6iHJzs3+/7KzeHvw/DFBeWAM8bpsTcZCB6WIDjMeMYPGLgSXMQV7zbF48S+
	LMyc0SNh9CF6VVqthncRzrtvu3towo
X-Received: by 2002:a05:600c:3b17:b0:4bb:5df4:685b with SMTP id 5b1f17b1804b1-4bb7da36071mr1392565e9.23.1794941364522;
        Tue, 17 Nov 2026 10:49:24 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2aad96sm3480415e9.6.2026.11.17.10.49.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:49:24 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] MyFirstContribution: leave a blank line between mailing-list paragraphs
Date: Tue, 17 Nov 2026 19:49:12 +0100
Message-ID: <20261117184912.9491-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAFpMFfBJdBukP87oX9a-GMvOncs_US-LbqqTHP6n=7hv-JUJWQ@mail.gmail.com>
References: <CAFpMFfBJdBukP87oX9a-GMvOncs_US-LbqqTHP6n=7hv-JUJWQ@mail.gmail.com>
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
This is the documentation change mentioned in the previous message.

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

