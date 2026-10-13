Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C82C3FF886
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901543; cv=pass; b=Vg2kvvjXuDsMGF2gtRRtXwUhI9E8LP1HRAs29/jmqcDCXjhuNgfoWGPy+HsFWBQAMJ7+vnopLj8kl+45TWpDJmhLkHGR7pg+SLoFFOt0WJRL2iSDahbDkmrPe1v+lBPRFRTzlvyRVLR9jMq7t+L3VKAJ35ugBJlm1l1fk9Q2sHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901543; c=relaxed/simple;
	bh=5hQm2yfemFxBgil2LtLYVeI5+OdpmX2DerP5GPi9KTo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T1O94w7MnZMXT+pdF1vz4yHwRTVbZVj74kfmBNz0D+ZUZOa3baiCicX+MIquVDPZWO2+qvhaphRhSLjXTSqvZK/yarhEbGmDkfdZL9qqlVKMDOrGw8ltGwXMYTz/URYTF04iwJ//g8LTvT19NNH3sUV9IHJ5PzwXxADU09ZpBfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp8fThvI; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp8fThvI"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-677b5148acaso2892709d50.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791901541; cv=none;
        d=google.com; s=arc-20260327;
        b=UGVuDaFC2+kYXW6fOcJ+fmBrvbk2uMgpsGaATxRvlxM6yBQfSdhmAhZ0vq8kQNfzcj
         T3KyWSb+qxf9npQosop8RxGBOgF+2fu2uMOzdhcEDbgSFKCT4gLbDbL59InegjCwT0J6
         Alh/SAfj2DlLw9xpNjJ+6sYW9CRbmAIlhVgiz0/SzCeK9vXqpSJ2wQN1LWNel4if2Z+c
         i8+aZxyDHWhmxRQhML8vqL/BgCYdeYrl3dmcr7JXbvYyzV+wKjIucAx0dcRNpvTAwzVK
         aNsVbPUejQ1TtsAUqn8bG3r0iljiJlGZ+QIAV6H0HdyTZ35g9TwqQiwfMnUtRmkUVa6A
         woUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=a/ib9jJuA1yH0U/28XFMbUrHpywr1QXtoRhO5d1+3TA=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=VYu27eE/Rdg5QFU4YTPUNLr8QQ9s908xn1tlwVRgy8bJ7RhhHWHw8iZXraLoA4od5x
         ZWx7z3dugN61MFRzmsGnLKLqBH3bVW4OGkC8pompeVe+60PdtRoDzpFxJ9V+RaW6rsOk
         Je+ptqr2cfA5Xp4D4Pki1bZ5V1f9moZliewpgENd/89GfnaM6VMX2q0EOeNsjmn3K/ns
         2KsWLJ+VYGpPAeeqIOB/weKxa7BaRhjSivPMVYW7RXbJVzFTw/7uRCYC1xh6X09j44QF
         bc2MIQENDURksfzt3/D92i0GUNg3/ysfVr07bXJe3e2oLxCPuQrSo5C/HD66htjYzH6I
         QIVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791901541; x=1792506341; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a/ib9jJuA1yH0U/28XFMbUrHpywr1QXtoRhO5d1+3TA=;
        b=kp8fThvI4I7yAw0gA48Tm6ZztBELnjjtcfr+VIWbmN2fVFkoIZ1LgjgypGkOzbv9D8
         W/BbrPRNyjHwp+lofAHDffYau1+UJKdSRoUFQgUPaib4bfzRs/CYLjafeQmhijaC1DG3
         LdDxrG+a/KIRF1Ky76TJbenHM14HV2pxS637y9dP4wQ0l3GUmZXjjZRmVmMKHvVB0uz1
         3fvyidB0HXzIC0nHBPqSg3XskCfaqNIE9AL/1gYXtTl7f1vcmuqeZ6lnn9NOTz06u3up
         TxMeS6j6ZbrswFZMx2ea62Z973w+O8ZWbjKWjDDTGIrO07DWAVGfZbKq9v6ZE92y+oiG
         pUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901541; x=1792506341;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/ib9jJuA1yH0U/28XFMbUrHpywr1QXtoRhO5d1+3TA=;
        b=dngXfhMowNqJYq5eXnBgKVGW2Flc9wq+C1dW7bS4sHdUSpE+U8zLyURfldTaNkuU/K
         yQWeXUDKwtwNk5nWbs15EcxaLxdDFEMgWoiy2dZbEmDHvmR7qWtQprjq1r1aGlkcC6b8
         5GVVmRDBHm9M0gi9P8wPvdwKUCeDK2v4KOJvrYiH0lN6dVdyl7qHtCl6rFldTY2VNx+f
         G+4VG6sOHCMiX/RxzwjVB3SgctUipk26/ART7T2EKkYz4VRIry3LMZqbIL3M0Xp5bDI2
         p35cLPFfMmJ8c0MFAOj06k67Nmssxv+kOb0Plul1dncFy9d0lnqUNnArUt+DGxb8isJS
         NesQ==
X-Gm-Message-State: AFq9FYKBuy+KKE2XOdTzzA1XovBCNesJ8814gsqZnxo7b4gr721YhkGk
	myCHG3Sh0t5517ESCY7jW2lQTAAvv/mSN3YRGxeB3WtC3MEHNbOdZdT1EPC0OHObf5W4Y4gGyOy
	S7njegPp2VpOKblErEfr8er2aTST0yP6D2y0c1a2L8Csw
X-Gm-Gg: AYBFou1Eq2U6eVajRM+S4JUaP7JYM4gJfOYHsYqkO8n6Uvg+ysao01L1CrU2p5nXFgz
	wLOb5GAQFuE87ONHs8kT7i5YneSyRpEy5qgmz2fgiPMfALlrRBcuV6k6pOHcxzEqSI3h1jSoFlT
	HVaWV5mDEMUQvHj2zgxElYTJbpobPlhEGRSka7X5UPF+e6C/qXSqD6HBt/eU9CetVvPZ170W1un
	a4ikXbgEqW8IE+1ZrbfKjiiu81s1nE0u2eQ/x4QfTYJajXxPiTIE22BPIVzykr3xNSKtvn85Zn1
	s3SCdes7ugMP0edMUJaomzAMv+DA65SHQgZnyT1LhHak2+NEJG28V0YUZzsH274dqatfMA9f/P0
	ycxQJqac8dIjFJb2iea3+14VyHGzrffDDireEUjfw3rcUncSiLXcxy1UtdQaZP1TFVyAYAhU=
X-Received: by 2002:a05:690e:4401:b0:672:ef39:5fc6 with SMTP id
 956f58d0204a3-679362d0cf3mr1834635d50.147.1791901541260; Tue, 13 Oct 2026
 07:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 13 Oct 2026 15:25:29 +0100
X-Gm-Features: AclHuK9XMy9caKMvJRH6Du4bLCDpdI7iw2m_yxxxlT0R6a9GXO1DBSmY339sDyY
Message-ID: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
Subject: [Outreachy] Introduction: Okhuomon Ajayi, microproject in delta-islands.c
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My name is Okhuomon Ajayi, you can call me Okhuomon. I'm an Outreachy
applicant for the December 2026 round and I'd like to contribute to
Git. I have cloned and built Git from source and gone through the
General Microproject Information page and the MyFirstContribution
tutorial.

For my microproject I intend to work on the "Fix improper pluralization
to use ngettext()" idea. In delta-islands.c the progress message
"Marked %d islands, done." is marked with _() although the number is a
count, so I plan to convert it to Q_() with singular and plural forms.
I found it with:

    git grep '[^Q]_("[^"]*%[id]' -- '*.c'

I searched the list archive for delta-islands and for ngettext/Q_
patches and did not find anyone working on this message. Please let me
know if I missed something.

Thanks,
Okhuomon
