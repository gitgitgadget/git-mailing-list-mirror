Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473788;
	b=b0KmSJ/7vJAlJr0XrYRUYvy436Ivw2hsNE7NuRQOGcz59uKQ5iRbvhvOnLQ4SeiCCS48
	 2xcbMufNgX07KQy+C1CHVKmyIuTVjrEaL9DnFOIRFcrEgpkPtcsGDVeBjdMzhPfVdXhWB
	 RGbFdPzXrRf9KqYk4OapZBLdP2frXHlbMokuqmzeJfpLCt5lM2uSaDsWs5OtN1GQwOOJ4
	 VjLRSiiRDJuHvS88Ib/z6pamnV8ViSFlL6HtSNqHwU6zh6rcKRvhqEPa9TA+erRzC8y6Q
	 hIPYWlY9SUpUkM4HX+eVsCwPpYJsg5S3oSUt3eJX5OctkVDlpjFhXVIIQqoGwzi1VCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0vOFR7LAHUKYXSCeFV2IC53hAyusTNoaseZwNSXhsv4=;
	b=KjKiIRHhD8TGYx7HBJbzIvwPPDrEKId+VHCMT3b5gWLD5tIxxQlIxaOhjuIykakJ4ij0
	 feTNIkl0GFqZdHMOfFqwxliTo/S0ErrlvjoeJ0Hj8CIgAU14Li4LG0QU1hBI4d+ckvOEM
	 bRiHRdIBDLZ0nQsh0CwEhf0Wiwj7KX3eDUdIkUCkOLzZ1xBkSt+8m5eB82QqbA4Fb/cme
	 Elk/jdltfshSR02HpXxzvSacA/p59I95T1blR7j1UV+98K/CGCMX40/fm1D3wNDXM5jaZ
	 0UpRF38H9gUlop4icRgtElo074/TBQjunbkT7Lwf1p5QJT71C3Et5GaZXjSRmjjSnEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mRDZx4PE;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43E606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA43E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mRDZx4PE
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f01f296937so30124385ad.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795473787; x=1796078587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0vOFR7LAHUKYXSCeFV2IC53hAyusTNoaseZwNSXhsv4=;
        b=mRDZx4PEi1/ZVdIui6eye52f6D+qVVNa5a11ftUF60Oxm5yGkEW4khoHMOVn9FaEMh
         YXpmCs+coYONfpTKDoRsGvriEX4DOk7M5/PRCU+EQiDNf+QBpKVQuXmlJWkTYib3ky5a
         7pIEUIUXVp1eD0flQR3RFBjLBr4U6I3RmDGyTo7R0R6fktMgavCWu9Qc1vTNKUliaxOr
         c4oouMtRYyL+ika/+aVrrDe9wFR/Nk4jZ5ZQyqGxwkeW3GGUk9gKdA8kg726lsn3DEcx
         YV8pnGJ4cOugcZexc1ReOZktt5f/xnv5+Pb0u3P79iGr1+XJhgJ2iWoQpkMBW/0YE1Uj
         vuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795473787; x=1796078587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0vOFR7LAHUKYXSCeFV2IC53hAyusTNoaseZwNSXhsv4=;
        b=pmWvERcXnqSHw3Ju4bEN+1d2GP6Oua/q8IDwMuDc3n6btC17wucLBVC7ZOI+3oxFRG
         5Q1jMlYw1clEz/WR3gSed7S772bJ1dvYNKXxs/mRsax4OUQ3xsYVpggi3D+xk4P7Sp+g
         oi/XWhzfWqdh5S+6kWb6ogfopgD/2OpXM/OoDlXotIY9Q4xmrYzoFv3T1uQ1eRLSzW0X
         FHSR3yUUQMrtqZeX1r3D5s3NUQXVy59sqCWSaoN1mbJ5oBhpCyVP2+qJ70k4Hw37cAbG
         mPIHNyc5hZUyHHrIFHsdRMz4wqn5QOfxJ376D9gVvNB+ONeAhXnH5A0vsOpGmgncP7TD
         pV8A==
X-Gm-Message-State: APuU4Z+8WiftQLKcNBhVZ71xojj3ZS3pKc57ss2G+HbVaqRFU+SJkjY2
	isj+lHlrHCCIrkiKkrlAuLKhytWyuj8V0wUXHUeVf32NvwEA4gIOoftw
X-Gm-Gg: AZFdTZfYjg3KR5nVbXzHQHD1HqOMj2GajnBD6WmK0QF1SpBQ6pXVSKgeoQpEpOKM6zT
	Qpi8hJyyHNFt2tFpoIbkevj2rD3DE8+6MENHKhnEJwNGw5B6J3sCpP5Jgs2s+I9R79ZlFEZowHB
	6m9RgGhFjYCepxmYns93RmjO89lYloeGsz8fCyhrXFQudAY+P6mW0TJhZqZQgMqcgWhQph2o6uq
	abQRrw+AXFbQa0Rw7Pd9j4MttUIcA2IRLCtA0WzgeY133clQ5hddw1BZjyHjMuBe2ShpJw4aDjt
	Cr9Vb/30YdwCwtxpABjqFLY0nNkVmEUFOcyc7QypU3ijllRhwFe4hC6KeGBERxc2h4pn2soIgBI
	qFdAZYw5gPuVH3StSofqu5PrvavHToUG51rwVkOY1TiEiymB6wwmrNjmJg2Gx/VbTuBuzMQdXVj
	xOtc2O7jC0icCBAtKVpAxES706zcUQssZRn12P1zN1ZoD/hyzybJLDrfXo9lz8zzVDL5cW660nE
	6FmVdwJp7FRRkAjTW2RzTilif4c7ZHqMJH8GeIw9p4GBgpP4Dd89lpnBXo6UfqMOqeTFIpdUmzQ
	7vyCxHwJrUEFbcrasxHTu6SrngvjHw5krrpJAsO2QG6XTDsHTdBu1NfYGGZB/5ITmbUdj2gwC4W
	u/iphbq8sHdfgTUgvZo17/w==
X-Received: by 2002:a17:902:e802:b0:2e9:a16b:c251 with SMTP id d9443c01a7336-2f03efb1099mr142246615ad.3.1795473786998;
        Mon, 23 Nov 2026 14:43:06 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f10e67csm59667135ad.53.2026.11.23.14.43.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 14:43:06 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC PATCH] fsck: report the real object count in the connectivity message
Date: Tue, 24 Nov 2026 04:13:01 +0530
Message-ID: <20261123224301.14168-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123184623.64131-1-laveeshb@laveeshbansal.com>
References: <20261112130749.51747-1-aniketgupta3001@gmail.com> <20261123184623.64131-1-laveeshb@laveeshbansal.com>
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

> That title works for me.

Thanks for reviewing and checking the partial clone case :)
