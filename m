Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110523;
	b=qydGtZxgvFz0giW8L6BQbONmMeSfdCStHe1m0emrRUwvDXVBNXMR01i6VZEQif/NYF+T
	 +Zit8xxCoirSo1dGF/iLnnzmDPG2B6NqDY3Z2NkZxJSmG8Xr+jwCvarLpa/FdJyvHfD1y
	 OqBtz6VWFuynS2VXHG4DJuosu4ShxOeUq6iqGvpt15zLRCXhg2lf9H52tmXk/cP+7zgnx
	 /Il8vIcatyC5iKXwlHhtb5USdf01gQhUYIoKTLKd3G0SmCwkL2Vy6WKhZvmdDI5qb2x8c
	 /u6eV9rdZA3QnZRIF0US7i7WzySqrPAiuz7FgOzznleZFZuI4tsAw4OJC79oIz9HrHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mTxbOHr7AuVU7MS57iaWFEGoE2fOJkqRnUbiP/k9wz4=;
	b=QyNgJoa8MSOyhXN0P3KU9boX1KKV0AKNtGumr4o4PwvgQ3WDAoYn0egGvOH6fMolg/pt
	 howNh5ckojQoAHnjisssJ6mRSGfMomutt+FwDpkdVdP/zHW3FwfEFc/99sLdHGmAkWXyQ
	 GLDixeNRbALd1U+x+1Xx0zxkVEbHzz8HpiBdjJf2JD29g70PtTPGq6avwMA3DP76dz6Ma
	 Gi5w2JeqcQ0DQzQqi20xb0WKIo1cruqRCbKkUW8lNAFSa4mMKcRXgb8svz9LElAt9fUQa
	 8+vXsYyvg0zaiEIB0yMX4lH9ivTTF0JqpEBJXQNNF/YiG8pqzMJ4EZjiynz9FOMLJuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=az1TFB1o;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68340606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68340606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=az1TFB1o
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491846221ffso2097606f8f.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795110522; x=1795715322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTxbOHr7AuVU7MS57iaWFEGoE2fOJkqRnUbiP/k9wz4=;
        b=az1TFB1ogD3vG0wIJTDLZI2qvunAE7Tsiu78++nGTj93BTietqEIh7X2eMfSCo5hlj
         aH3fVCLZp5Z4BHl5HxSgIQaAFTgJC6WbBvp5aIE+l2mxP3s/LQagMZm/MB6YzHiZ3kl6
         CbL25Bd1RXnGclwtyw3q+8AeITd6c41aVF6LEpD9gr1X6I3wun+ZwrwIlmNOTgmh2mBq
         7tNByxR3G3fQuD9Q9bDxCHFuEfI/7Ip+/eqcndgTIzq0KukQo/Y6pp6SXrAHQu/MKe3A
         VIlLDShxfLIYREKOMHM03t2NWOR/TuX2TUSzrv2HKkByEDNULyLwHHTeR/3PfnnLvc+q
         14UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110522; x=1795715322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTxbOHr7AuVU7MS57iaWFEGoE2fOJkqRnUbiP/k9wz4=;
        b=osPQ7Zt8WvNwSEvakYVwErthc+g6aGF5fOwOtb60aqOQAqCuP0L+oVs03CwEiib5Y6
         97FPSx4g2s5s+i6WgZzF96AeMdZFFqmDWeAWTmgbYnLcb2hitRqsieOYwONfzbiqYbnM
         JX4lekTwwCER5Kw39wMbEd8GpCIvxM8+jtpjgl+WjdrGvqqkV7a6v7nD3m8U05UGMAoh
         LPhJfTydIpWSkWO1pe4vpo1eDWMeicUixbHsdQeuwdJR3O0ujCLMWvIe7kdK2K4RYBXo
         Vhaxzyuw02EQN/tXZjrOvarPYjpDZXbe4wTioC1cWiJyZL10RGFeQbJUKFv2OuuwZ1ke
         sDEw==
X-Gm-Message-State: APuU4Z9+8JASXBEFINuXeU9je5PqdrtJi8GYNBtNMaePrj0pjjctxdAl
	ZMn5A5nLKxT/13gAiJ6e1nceTGzcpv3+/FAUTTqSoMnB9u5XU4t/1I9JpX/fGg==
X-Gm-Gg: AZFdTZfP2Abp5QFUr87K8C7LJvDvQJXqDXgVcDp9q1JvuoTUwK8xFvDtvFdDaaJj8RG
	HM9kQEGA7SpMxHHEHsuW30MuQzTkERczmzwqlMNh11AyK5cBoVQwvqcap7aJPSudAeH9OpeOxAk
	8vrJbthjFaC8e+RYo9SyQIDZ1oQAGMewXXTmh9H+glKAFv85mv8xshJEpp+14c9dXOADn8Our8N
	tmfjT8N3Nbcgyc8VsoY+KGlk6lJ0HIYpEUWKzgPB2PsCfUAlFzx9tAuyuIJoXpT/9+tjWdxE62d
	K7Z2Rz68BK9zb4RBAgvRCf6abI987n8VBk5O5OuPQtWgkmkcVS+tO4cHMJBQDLck6J+us0hBvAx
	oTSFfenO+tSIea/C7lejQK5aB6rJhBIotLw4nS8hezoe/WXXNUlCBeJIFwbJchAsMeYtjLVoUrb
	+gh6zCAIVJFVaXSr8EIS6Be37emTqeuGK+Iata5tV1XMc3cjzo/AeSRrQ18sFar+GYLd8h3bwj+
	KdEIzPik1GsvKIJ26/6BesW+jkb4A8waXya1U2/X2Y12HpLlpwJPHaiUN0WGycDXmen5vsDLQ0X
	BwR2C2Vt6gtgNFq7IQll0LX5tATwdLNSKGntMcKAe96UJf4Kgty1ZYsri/xMm8A=
X-Received: by 2002:a05:6000:46cf:b0:4a8:98fe:5f9a with SMTP id ffacd0b85a97d-4abb1d93a03mr135761f8f.18.1795110521598;
        Thu, 19 Nov 2026 09:48:41 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm849109f8f.42.2026.11.19.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:48:40 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Matthew E. Luallen" <m@sph3r3.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] archive, apply: do not truncate files of 4GiB or more
Date: Thu, 19 Nov 2026 18:48:38 +0100
Message-ID: <20261119174838.829420-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <av7HMbnylHiz_MVz@pks.im>
References: <cover.1793524457.git.gitter.spiros@gmail.com> <20261119065711.827536-1-gitter.spiros@gmail.com> <av7HMbnylHiz_MVz@pks.im>
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

On Thu, Nov 19, 2026 at 10:53:53AM +0100, Patrick Steinhardt wrote:
> I'd prefer the latter. So how about you send a new, rebased version of
> this series once it has landed?

OK, I'll resend the series when needed. Thanks,
Elia
