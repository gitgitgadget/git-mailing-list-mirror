Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749167;
	b=jgUxWaXWVfoD0+Dsx8er30t4QH0HLGRAGRzQv5HK6QQ6Qmv0VQuP6FCLlO/InI5k7vOc
	 eYrtVk2kE5OiH12cpnB0tunFl8k6e0Wixg3cto4W9J5YPxm3CUpXVoA9n0juKJtkRB4SG
	 4jIa1f8bfbYyNQKKxLcTFKFbyZncw/03xFaIv69aV0hWvWEJaLKBQvNNzhIhLrPYAHRD7
	 mz0OcfJFhkdWck4b1j4m7N4CTHpBVXcyl7l9ZhUGNr8x2RyWSmkKZrZereOzbxQwmsymT
	 G41DdiUoS0g3gkLP+7sYCaervI8chnZ3uJJfr14j0yRcgQfYTtBmRS42s0mDjylPLHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=rKHqyW27COSxfq1dZ3nyrNyZxbrbSlH3i+k1Zm91iqo=;
	b=f4OKglZcgfc4ZmvLwJY5BVkCOsVvowjQo0Q0v30bjjh62GUAnkSy19X8P676713orQf0
	 Tf89hHeHP/uPFdVuHtld9VVW8OgaFcz4PRlCd/KI319cQ3+3vvRCsp0l8xCSorNy3JVgL
	 aptHRlLeiYzCoO6tOXldl4HSVdXyCtazFBKhkbUaaXle8F+IKbmlYvXU0s4FdSSgvDCwi
	 NjVBRXoPp29cJvd6B+HR/0f90L8oNo7zuZgM7G2XmvACvHRlM8ZSWBOCcfJsTFpl9w65g
	 GtFSl7tTnNqA51zw+g6YcJlRS6QsDolAvcflEBo/Y5ZXBE7Y5gs4zOPZ+b2Mk4IoHCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gTG9JsNo;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD6606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 23:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BECD6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gTG9JsNo
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so370355e9.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 15:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749165; x=1794353965; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rKHqyW27COSxfq1dZ3nyrNyZxbrbSlH3i+k1Zm91iqo=;
        b=gTG9JsNozJaQiN8MpqXAOdBGZFgsVyEolkqD0iKt982vxNhncrYtWRoUZDbKHFA6w6
         RsKaFJG2dKjt7ENAzmz0FwwCdgQuzo9hUa4Bd6i2ipt/tbOoOKT5hKz6UrbgoJKQRgYE
         4RHZRf7Ido6T9CJl0Kdbtq1biomUdK+T5mBNmJmqxuOamlzUlunJbFKPvX0QgHOZCJ61
         0hAD8qQpu+9X6yNeaSivI8dQtyUuRF+33Mui1OcbMXOkVWVPaVw72xCT8uJhrKQXC761
         JNbh6W0rUWP9BBiINkBvvi6h7gmBL9cys8AQP/2PWFSM8S/nUKRh+lT3zJR+EH3IaerB
         YBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749165; x=1794353965;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKHqyW27COSxfq1dZ3nyrNyZxbrbSlH3i+k1Zm91iqo=;
        b=tgLB39XtP5Nb0a2J1YsvhfG1woz9LZ089Wcd6IMfSwKJY2fwYea7zg7t2G1mZSbMEs
         5Fbe42ulq6SrixiBp+KJSq5AjrWtyL8CwUvA8O/JYXHcLSTPEAuhPJ/KrMyl+cKrseDQ
         Q5JmblwQiKmZJy5nlNCxnRAH2zv98+OFRvdK73nIuSKkdvfJV9crqoPIMklPWIptBgam
         9lE52bciDE6KeKqFbD0ooCGVjbxIXFVN8GY0RZAHUR8aJT1mFvBmWNH5GvJBJU+zmVNv
         zu4IUsnTfSjctom25KIUu8x+R9Y7EOEZrw96C2kD84dUiIP3Vf9eTf3hWl8gXDQw4Irf
         kUXQ==
X-Forwarded-Encrypted: i=1; AKwUvBySVq/MiOMXaSNZv/bpafHziayVY506bJPi4TCTEzRmnwWA6x0KMiM+VFAcNqeBnNMcVJQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+87n+Y2a0ycYfS+BXx9M7weQg4WhnY5EjDZ0mUvaioSOutpUif
	+EoKSExs+iuPUMsAkslQAv1ByqnQ/mIyqQ5xCRaVliH7l7reOWBcHllDwfnIScihRzw=
X-Gm-Gg: AYBFou1vWdk+zKAcT8yGGbDmS2Fslbouyp+JgRJC/XsodDJxWnGic5P7da1GBoxm3WW
	7Dfk3RrZA5j+EEpUaNtpm80n/eglo8VSLwsNUIrY24ghG8f8gxipuyHvYlcgLt6xQ8X5ZhAB07l
	aQ4qJO1DWy+p05ZtIRkNFKayqUAPEuSw4sl7fDZzFpkLzpFy70FdbUJxVmvcsKzTp8M7ybmaKU2
	s8rufHbVBOTc9i0pSd1h7KxNzwGjKBUiI0mAw9QoC+S2zU4CeEZibbWAJxsXOrf1dGAKqugvHLe
	7i99SrOcklxWxh1IuJdYBGcPt+zCE+ZTx5mKRdwiH9eJ/520sZ/8bXWq6nhKhAt6VNjBLYhsAki
	TCG5gcXvUCMfxBr7ResIBT38lI8a7NknZTHe2Gbzzt+2hWfSJ4q8whJKgIonhniHqIh4SeCWPdw
	pONdhVtMAcdKgwFem49uzc7ASJoI/Dq/jsyi9DNuZtPXIBJFq7JjKqgzOiaBdNsGuBz/AMkH1xD
	I568X54Pu7QhEvLG0Kgyp9NI+w3ZVcOVEMkDx9aAmzz0XWFq2pTEi75htD4+zckUJ9in1+iW4Kp
	/UKZq6WKLdEZYCTSURtk7pVl1lV8AtLIFlkogPMej0HUQfCiEnu8l5u2DSi6bfCfm7+ajI34n/5
	Y1pXvSsDiY6hO+F4YABD9oNp97UMIrLUqOgb8C7uYAoT9Cyuy33rfBUJDcZkJFGwb/VEI0B97sq
	hQUSKrbl3Cmh9lcZq0bpLvPn0a22Sb+bNyMtdPj8TU30bDQpNyDKR1
X-Received: by 2002:a05:600c:524f:b0:4a2:4d1:c49 with SMTP id 5b1f17b1804b1-4aa8a0f4e0amr477009245e9.3.1793749164971;
        Tue, 03 Nov 2026 15:39:24 -0800 (PST)
Received: from localhost ([2001:818:c665:a700:a4bc:846:cdd6:3f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20521sm582489f8f.53.2026.11.03.15.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 15:39:23 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 23:39:22 +0000
Message-Id: <DMLZ0DCQXG54.2FD3JQXSJCWPD@gmail.com>
Subject: Re: [PATCH] graph: do not indent visual roots with columns to their
 right
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Caspar Duregger" <caspar.duregger@gmail.com>, <git@vger.kernel.org>
Cc: <pabloosabaterr@gmail.com>, <gitster@pobox.com>, <krka@spotify.com>,
 <karthik.188@gmail.com>, <chandrapratap3519@gmail.com>
X-Mailer: aerc 0.21.0
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com> <20261103231153.289762-1-caspar.duregger@gmail.com>
In-Reply-To: <20261103231153.289762-1-caspar.duregger@gmail.com>

On Tue Nov 3, 2026 at 11:11 PM WET, Caspar Duregger wrote:
> Since a34c00d96 (graph: indent visual root in graph, 2026-07-14), a
> visual root that has a child is drawn indented, connected to its child
> by an extra GRAPH_PRE_ROOT line.  When there are columns to the right
> of the root, this breaks the graph:

The patch looks good to me!

Regards,
Pablo

