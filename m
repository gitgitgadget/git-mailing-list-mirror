Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FED1E633C
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475992; cv=none; b=g5+IGOrGlKM8VE9ASZtA+l7cY32zGo3jZmM3j6Jf+xDkk6tgvwKP4z/mX65RDE3SAIVyGnGTHBBg3IL0ncxxJSpPnClLnxNeSakN8ENrvRoZJYgAm6PdMAsTJIoCSdC27c8YcWm81/ViWYNczUxYWpqIN3ZvHlp7b9ngjirDAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475992; c=relaxed/simple;
	bh=OaW7YRHCWzqo8MRtzXek+Ggoz0Ej+9TPQ8QJoLDsrn8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=LSs39YcV+eaRot6RpCffhLvmbJ+/CddNdqg7WJN5EB4Xx1UIwGz/R9xlO7lzDQKVYLqHdsnVpwow//t2lgZLS4ukAJpbOaAN1yJvvQo4Hf1qQFMMh5HPFiVfq7YDCC5kRrbdmS4OF+Y7QC58jF4cO5NQrOH+GPpnOARHyRJycSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edqu22hH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edqu22hH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so3663695e9.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745475989; x=1746080789; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OaW7YRHCWzqo8MRtzXek+Ggoz0Ej+9TPQ8QJoLDsrn8=;
        b=edqu22hHUGBKN5D/DXQnpwHzw1RVxzJ0dkDde9IiBLdk1QabtfbWTfHD5dEk0Z/NhS
         EC+14/PEviH1qdOhBJT+LTGdxqT48Z9ZvqX7Ciz4mTBmSt1RJnlUaCcESfWmde+4vJqM
         Vh/wbIYO8bps+6YVWmHQBHh83tOeX8rv+WBfCchTRYmMHnrBpgJtSosCtPPlC3eHGRHY
         SsAeFtfFSkVvmgDXxmwTxley2EsJh2Mw7no5BHHJzSAynT+40AuQORwK7gwiMUEK3XKk
         l2ElsIkhlO4fT5y+B8F4YbX7jKrtAUWcf6yZi2fzO4fmr7/FvXaLMqMF0jyxNMmfsrmw
         Twcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745475989; x=1746080789;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaW7YRHCWzqo8MRtzXek+Ggoz0Ej+9TPQ8QJoLDsrn8=;
        b=IIyfyPqUEO3JJsf06HA4p3Cf2xgADuU4khkFUciZ+1rcPMrG7lzX6lCJO806o5ibWm
         BbdvppN5Ftx7QsR2D8+lWqlNH7pdlFw0R7o33t2FCsm3t6xmeQnW/unG0ADtHacaBn/f
         n1a7lDxs3MVVOUaZ5nDOJ7bzpiKEgvFiQo77aIp+zc97N4/jYuPtZbH+Wld16GkWocrX
         d0hXDPgcmw06AO4qWeGlBNBh+KlLlbDPYyZ1L4agXIziIfdRqvvAwMVY8Ukwi+nPxhch
         VcHbMGVedXXuZPuGD3YP539D04psI7hSqokbt/ruN2zc4upYBSOZime4NmVljYWup9XM
         g8jg==
X-Gm-Message-State: AOJu0YyEdi2u8Oq4XMQYsuqqdhDBqGWpeaxIMZeRF7BvVdpJRmaHh9qm
	LZhEGZMeabKATMbPEZlt7+HGyw2LLZw80UxjLoAXS42WtcDHKSavS2RF4Q==
X-Gm-Gg: ASbGnctNhXQE3dXWch9JhRF5PcL9YF6jH4uRuQM1loJAJZxNu/eBMfy/83J+wUt8uIQ
	43rcyFrK2ZsWtgnVcgOCzqNI6Ms0MDp4HJ+HmlyYB0t7rHLVkoudi3hGk5DcC7u8GUpLaFAILgc
	ANvdbOz9ASnJ90RYHpMA9lLW0f5nBguvB7Vq0i8CI70dh7ZGb73xxcBIF9fGA0FQWcq8AAdhsUj
	O2Cz2lL5Tg7knEYL1VcnpYtx6lgYf0w2Ewon/xZkToXtfIA5M4pR0sbRnO2sHR7GzZD2H5IumN0
	XQU7Ls8FOn/8lhsL7d1hu772rw3zMlM2Xg==
X-Google-Smtp-Source: AGHT+IGwtonpeay3FtTS3UIrePNovqUG2nidy2ez5uuZf/t4Y2lJx/2TGxBjicEMEa3lxpUyIwUaFQ==
X-Received: by 2002:a05:600c:3154:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-4409bd23b36mr8929635e9.14.1745475988783;
        Wed, 23 Apr 2025 23:26:28 -0700 (PDT)
Received: from ULRICH ([197.234.221.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2bfaf4sm7302565e9.36.2025.04.23.23.26.27
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 23 Apr 2025 23:26:28 -0700 (PDT)
Message-ID: <6809d994.7b0a0220.85906.1706@mx.google.com>
Date: Wed, 23 Apr 2025 23:26:28 -0700 (PDT)
X-Google-Original-Date: 24 Apr 2025 07:26:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: marietheresenora@gmail.com
To: git@vger.kernel.org
Subject: =?utf-8?B?ZWnDpHJrbcO9xI1hZcW+?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

R3V0ZW4gTW9yZ2VuLA0KSWNoIHVudGVyc3TDvHR6ZSBTaWUgYmVpIElocmVuIFZvcmhh
YmVuIG1pdCBwYXNzZW5kZW4gRmluYW56aWVydW5nc2zDtnN1bmdlbi4gV2VubiBTaWUg
SW50ZXJlc3NlIGFuIGVpbmVtIFByaXZhdGtyZWRpdCBoYWJlbiwgc3RlaGUgaWNoIElo
bmVuIGdlcm5lIGbDvHIgQXVza8O8bmZ0ZSB6dXIgVmVyZsO8Z3VuZy4gTWVpbmUgS3Jl
ZGl0ZSBsaWVnZW4gendpc2NoZW4gMTAuMDAwIHVuZCA1MDAuMDAwLCBtaXQgUsO8Y2t6
YWhsdW5nc2RhdWVybiB2b24gMTIgYmlzIDI0MCBNb25hdGVuLg0KDQpCb25qb3VyLCAN
CkplIHN1aXMgaWNpIHBvdXIgdm91cyBhY2NvbXBhZ25lciBkYW5zIHZvcyBwcm9qZXRz
IGdyw6JjZSDDoCBkZXMgc29sdXRpb25zIGRlIGZpbmFuY2VtZW50IGFkYXB0w6llcy4g
U2kgdm91cyDDqnRlcyBpbnTDqXJlc3PDqSBwYXIgdW4gcHLDqnQgcGVyc29ubmVsLCBq
ZSBzdWlzIMOgIHZvdHJlIGRpc3Bvc2l0aW9uIHBvdXIgdm91cyBmb3VybmlyIGRlcyBp
bmZvcm1hdGlvbnMuIE1lcyBwcsOqdHMgdm9udCBkZSAxMCAwMDAgw6AgNTAwIDAwMCwg
YXZlYyBkZXMgcmVtYm91cnNlbWVudHMgZGUgMTIgw6AgMjQwIG1vaXMu

