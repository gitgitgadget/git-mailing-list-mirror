Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD4199EB0
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136379; cv=none; b=O/fw6JfKBhi5rhrT+LFo/WhZS/5GtbEDzXMg4gRztTpAOROW9v4J3ShDkWBvyyiDVDBpoBJ6WsA4uHT4hX+DYySRbFxO7iurN53RCU3tRKJX+tkFQqwBmPtddpBF06ehjDXZSIg442dIP6kqPd+D+lrIDuRsefurjo9Wupi6DhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136379; c=relaxed/simple;
	bh=edTDS36paZkjrSSbY6vQmWc9R2YkYo8HlK9N/MtbuQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=cdzQe2CXKcWJDds/bUcV9lkPNqje8sz6QS8HM9rn7s5M/mrXtusqAsjpO3YLwKDxxKyDPzVjHdtp+fLP1Ha1wCInjOn6QHgDkpN8zR+i5tYzU1qI7aO2u0L/FOri1Xd6niJFZ6Dw1FIcJb14VqnXPRDGdHFb0c7HPjK8vngX4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1wcKmjK; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1wcKmjK"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9cc66c649so2978242b6e.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721136377; x=1721741177; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edTDS36paZkjrSSbY6vQmWc9R2YkYo8HlK9N/MtbuQE=;
        b=T1wcKmjKgSx3JJdY5U+Zp9LMzyIWLeUO36lurBq8quX3v31GcnUGgGf2+Mg5MLqKlm
         I6KLsBYxAtnRwkj1syj+4onnLwurla8Zy1JtyKitFkTOXo+IQWmD7xtzvFA4A3P8jXr1
         6RyBMK4CD8YCatKrAa75VtGVO9dOMNkH08eCq9dK2G94O+ND3vOCziDXKr+sf4VITcnQ
         Wv28jKx9FdZcuhsoaFR4U9rVF2gUL2B7khDAMZqrJqQhADWsA4N1005RVWXRXpuaWyNp
         3dyne4Tbv7Hwt5G+XM7Mp5u8x4xsbr5mN7uZU9q/3VwzzDbfx++Y+XeF3TKkqW6PxvB1
         ERbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136377; x=1721741177;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edTDS36paZkjrSSbY6vQmWc9R2YkYo8HlK9N/MtbuQE=;
        b=sYZYxUrgnwF2evtllMI5BbB33hBUaGqyrmzkpIMtsLZxdu1uq/EIF60E/VdnFJv6Jb
         KboOI9kg9dgg+somfItYMRUVVQs+tiLx1bw9HKJvhi9KtxoDh3Wp0itRCrsY4cb6Mort
         vVvUUIQqITNZQ1bTmHX/KuA6nsSM7z4RUIgO0UtbMcQMFLHwgilAVrTzyh3uYFus4fLa
         kZNXvIKVdSA4q1NVWiAHYUcmTx1koivaVdznFi0NvUSOzddpOKph2PHxFTB84w1V4kzK
         qQjWvQgh5dbsrXfQjbzrPSx3PQPRIqProm+Zicmi6Yf0kU+9rP+nP5+G71JORZmH4F9v
         I2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXp0cJyLIzkyMkv39zJPJzSdmF4pT5lfbUZ85zxe8WTPT152fV2b1ZFMyszh9W+5iighhMrjgASIAOzKuVw0MI8IAFI
X-Gm-Message-State: AOJu0Yx6h+CATdxZEh0xutvIW6zZ6thPhs0HtYrTKiDMYYyWS3YdZmGq
	YOpWADC9RTnp6SN7drAq9PFvwgw66MJ8wtPocb8IDNArvQ8ab1lX
X-Google-Smtp-Source: AGHT+IHEgnmQMW5iq2Ipg5PcOf/o2syXzGDBk3cRJp8301P3vwXBTJ1ATQZPkwM0uiEDF802+hWYWg==
X-Received: by 2002:a05:6808:1304:b0:3d9:24b1:74ae with SMTP id 5614622812f47-3dac7ba4f2emr2559070b6e.23.1721136376969;
        Tue, 16 Jul 2024 06:26:16 -0700 (PDT)
Received: from localhost ([2401:4900:1c80:9ba1:2b04:8394:274b:70f0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34d2b21fsm4061281a12.47.2024.07.16.06.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 18:56:12 +0530
Message-Id: <D2QZXA8Q36E0.1FAM9VRDCL2WW@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2024, #04; Fri, 12)
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
References: <xmqqbk31b6le.fsf@gitster.g>
In-Reply-To: <xmqqbk31b6le.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> * gt/unit-test-hashmap (2024-07-12) 1 commit
> - t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
>
> An existing test of hashmap API has been rewritten with the
> unit-test framework.
>
> What's the doneness of this one?
> source: <20240711235159.5320-1-shyamthakkar001@gmail.com>

I believe I've addressed all the concerns from the previous version,
but let's wait for the acknowledgement from the others.

Thanks.
