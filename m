Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990730;
	b=J2sTnDywa7TuAmaKWLtjl6O1khzFX6y1Z9PgAgk6f2aZFqdtF5B6euHT+LvCqkl7tuwc
	 IcZka95xELB6qxyJ0/gMWqSrqwAiD+hCBY1zP5r8KtzEQM2J1ZPNZ4zu2GT4XlDlqrJJv
	 HaewST03jS25ENGzkpVXTMQMiEZr9knxVmkcbtmiLr0b2ZLpFON81wSe4VcQt9cXT0eKp
	 6Lnt1VX4JZeW4ueqalp+EvT1vaOnoFKu27QyAWXbrJKPaL+ukSdcWUqPPSQtagDRvErP1
	 QztmEHdvBvMkyO3yuqPuPLFEmjXzL7UCq16Bj4i1/0ObVrzDTr+n5GZFYvvXyeR1ZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=7r3xK+CMyPUpqGqJ77IMHQzLjuf+1DNhJ1DgmTFBrPc=;
	b=d8YzexpX8YfjIOldm/N8Arn1F4k7uqJcfFaraF6jRzRvsoISUJkq9tzWu2jNfDYwulS1
	 noNZYhBBVFWNMErArcAIX7d1ifDTB2ZrgMUcjemguVDGVWa5sn0eHy7TlkKePt9DxjLQ9
	 Y/hCR7e2HTl7jDlSTf1wN2m1yghs4YhtV0Yxav5eMcEqCUmHEatRjkVaSvKMh4IuH5C8k
	 P9gaKP20HqxrXYEch5asuhHI2Dx1CULFIBPVkVFo5jUJGs/kb0QZhUWkstKczIDxl2u2a
	 J64MgtSlL07Ib050uq+fRL0Haq2a0u4kskVVr9azCjeM0VshdqUtsA89SGVn3zB8gyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M3eDBiQC;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515B606A32D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A515B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M3eDBiQC
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b244fb7fffso1620703c88.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 10:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990729; x=1794595529; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7r3xK+CMyPUpqGqJ77IMHQzLjuf+1DNhJ1DgmTFBrPc=;
        b=M3eDBiQCFAvP80jZVrPNsyY/JshOwrXiPL9jp3AJEdXqHHHs5OL5fiPHjmosJcbDbw
         O9FRgPA74G9/junG7qVC4WGqaScJ3o4r8rX4sfilSby9qHieAUC7y2PTSB4/DtO65uQa
         /O6HXfrPrje20JRDe5HHijpdA27IURDDJSLgFhQA14h5HXWAiBPT2c4QK035g7gx+e/W
         i/xVcorlI4h03VH/M1th9pWm3idjcZbW9zAqgFIrUK+YQWa6YWpyOE/GPoR4cyg72Zgx
         P8thyLUC9yRYHtMyaqk7dbpGtK9yLuMiVGpSdKLk84IuNDFECiENsmT8dar4Bwwc4EYf
         0t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990729; x=1794595529;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7r3xK+CMyPUpqGqJ77IMHQzLjuf+1DNhJ1DgmTFBrPc=;
        b=tpX4ndU/qbuQX715FleseFlZANyjNZaU1KETTijjQSXpiIRHmKAnXJ8R7YEh66SwEN
         GDCTXSNLeconORhsp4FuolKhuCsesDFUYDut459vO6NJbvTI/eYbX4QO2aaSLD0hg4fP
         oktyEk84VIQGbWrtsqPYdKJnO/kdFq8pEqybvlBrZHtfjTPeLAQ1Mm28D3AXjPn/buzp
         nkW4LctoiCxEr1IgWt13FDfVMHZBjjgB5D8UyhQv3wv2cFM/gJWwPNLHaZgrm7j2GRmC
         u9K5rnpRYcs7LVmSW1J2p7RPdX7Tcv3o2uga7OlSd/EtEwSXWw8voUQ9Cqmt8bGRZjaT
         wUyw==
X-Gm-Message-State: APuU4Z+3Z8Fg1Njtx7kyB8BJff+04SlhQmI/wKxbRjeEj0cyixYZjNTF
	p3nMyiQ6Hlz6z2uZ65ZurkqUkjMProykUt1EpqzH7bU+VuKQ6m9wsLoEp/LZ8RnPlHypWw==
X-Gm-Gg: AYBFou115iTu++JyEeBlJrdc1fCTnWj7Z32k+TQMAvfZCg4RmWP+1Xis8VAseRD9KeO
	dIywIlUxBn/+u822E+OpkHAwSQiuei85zDC7oX5ESsfytkmcpvChp8S6YITPjflC8oFnLsTqoDK
	3OZo0EHrDdVPig9OQ+XwBjG32PtVxCfkZn1QELpU/JhiyNa4QcDMO0SCrdge9yefBN+nBAcRauO
	WAju5zAg/wn37I3Kgy7XiNWn9orL/zLNuh6Bwh7qCLHvppyhsTVaJ5tDbOF5c1hj6MFITD5Se0g
	IJhG0MN5VFNeVC0J5hvEqP98KIV5GxXG8aPyIsLmItVbXBeDNCDIwf0DyBWE07iYS8hj+AeEgpk
	e+mpPwAwxlfDdgd3Plq6jsz2B0wpapFhgCLEek1xNFMwTG8OrB3wm4gjoMRQpuFbUK5Y+/9kqHT
	rQbq0of2d0dVpzJqfYcMl1vhFW9z7sUXBrUQpnGpd4SFtBBicgyt2/0fSqqduCLDOw8xQYO6A+2
	FpXuM4Ihws4Yxrr8Fz/WbskXuQQ/EYSxhi0EwMEIyuNivH1nwKNN4Y1ys9PWsohJmLrXHtbkoby
	t1sdB4hYnrYfYHOhnJOl4aInJZdvUzut
X-Received: by 2002:a05:7022:f513:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1b25d3a268cmr3076396c88.42.1793990728332;
        Fri, 06 Nov 2026 10:45:28 -0800 (PST)
Received: from localhost ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm14439883c88.5.2026.11.06.10.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:45:27 -0800 (PST)
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
Date: Fri, 06 Nov 2026 10:45:24 -0800
Message-Id: <DMOCMXGWSKK6.13UR9RHCJY3SI@gmail.com>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>, "Patrick Steinhardt"
 <ps@pks.im>, "M Hickford" <mirth.hickford@gmail.com>, "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>, "Jeff Hostetler" <jeffhostetler@github.com>
Subject: Re: [PATCH v2 0/3] credential-cache: fix two races when daemons
 start at once
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
 <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
 <xmqqik2bybfk.fsf@gitster.g>
In-Reply-To: <xmqqik2bybfk.fsf@gitster.g>

On Wed Nov 4, 2026 at 11:39 PM PST, Junio C Hamano wrote:
> Farid Zakaria <farid.m.zakaria@gmail.com> writes:
>
>> - Not changed: the socket is still removed at exit through the
>>   tempfile API, which unlinks it without the unix_ss_was_stolen().
>>   There was a discussion with Junio about this. I can do that if it's
>>   a requirement in a V3.
>
> Sorry, but I do not recall having any discussion on this. =20
>
> I just pointed out a potential problem, and you sent this version
> out without responding to my review, so I cannot tell why you
> thought it was OK not to address it.  Which means I cannot answer
> "if it's a requirement" question.
>
> Perhaps you had a solid technical reason why the "stolen" detection
> is not necessary, in which case it might be OK.  Perhaps you were
> too lazy to think the issue through, in which case it might not be
> OK.  Or there was some other reason why you thought it is OK not to
> address the issue.

By "discussion" I meant you had flagged some concerns. I considered your re=
sponse=20
a discussion :)

It was not clear to me as someone unfamiliar with the codebase whether the =
complexity
of handling it was worth it. It seemed like it could only occur during
upgrades (old git version).

My comment was meant to say: I did not address it but I can if we think
it's necessary.
