Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082203;
	b=wT7CNMW9fP4clmY9LO8h07l2xDsEsS8XRVdBsmoy4bIA3NltS1JHBQful2gp2V4m1cDK
	 JzZaoGz7Gv/xFAzSA7H+Xvwu+4jhDQsMq/FTuUB48DOM8KrINZhHaVyi7GAqKCFeiSHVZ
	 qeuNW8FFYnuOCRA+4A//vT0U1CBhkr1UeVGUPuQ8r+r5lXOhLRW8RGdin7wjNRNjyZ5DZ
	 x0V7yUQ2JTIN0OtpAgK67vEnQq1exFu9p9hic8FdOyp53RyWcUY4qUrGf1EeGjME1c3IO
	 1OKf+jlwvi//cjYF6NOF5XMFpe83SNFS0D9pSfNGDc2ZSSI5r4YNNAa3l7ryDevt+YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:MIME-Version:X-Received:Reply-To:Message-ID:Date:
	 Subject:From:To:Content-Type;
	bh=hVtulVhNk5gIUzI8TXzSBi+sSPKvGVh4aBdwto1IB2w=;
	b=jpo129S4WBIBSyeXfGOi+MacQct36odcJJQRpy4vRAxpGM0zRk1sCrdnVBk0+9yiktpI
	 e+FiEfkT1vx39qT/03fIOv2yxPkyCTRHnU6b9Hu7SXXO2cKdtNfNSohSrtUJQv3o/NKVc
	 TLnN7jstxdLog8tAzdinU2frlThNFlhGcbxXU1mcYzYz0XLmn7FUH1CeA/Lz5mknw1nK9
	 cfKoLU+fC50B/vqxdLLj4I5EbUK2YcvnmrXnE8eXRjS/gM9aUrFB5ux+a2uzTKiM9k6Ok
	 ZTwg44Wb8LcorXxxtfGMltaEW5+BNCjz8WpGm+2yHRbm6l75oGoTuAKGLB3XhnLX2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxtYVRHC;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD81606A33E
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD81606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxtYVRHC
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f033dc37cfso2403895ad.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 01:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082203; x=1795687003; darn=vger.kernel.org;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVtulVhNk5gIUzI8TXzSBi+sSPKvGVh4aBdwto1IB2w=;
        b=XxtYVRHC0jjHWyScCZ7jggRW2HHrrXgvGdfHSRW6XnDrvVJup/opHJSb95yTEg5ZMS
         GNXV3tmn/Wt7HFvH/taxTSeKGxxtNL/ZYaCB0hjiIeRrlUw+b6YqsMuW1702rfppX+kR
         qGjYNF9cLjN+tfGki96ZIYsWscBex36zZvWGYohjEPQ0eYnbbxtLbFCPzOqQ5WVdLpu8
         x09xVoKWrOCCceTxPrSJxGMGuyCANvE5mjs1ZHsAYWaVvxvlwe7RWt1iPt3k3Slsanww
         KvKEnJMGlaKgQ8w7V7DLci0Mua3+kVnGWkt9s/vJ9k5HTLFxMZGZbYgTX452UwQE5bK8
         KxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082203; x=1795687003;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVtulVhNk5gIUzI8TXzSBi+sSPKvGVh4aBdwto1IB2w=;
        b=NSDAq1uF9KSMvFgFAgdbSD7VCUUI2mJRscEstLEVLyl0NPgYqGUMIj0HaB+wC3ZeIZ
         drhNOALUI0Cr6XHYPlY/1mO7+JorLgq9qFygpIqpH3JheZijSd4pjtYqwh1N/7dcK2Up
         uMyM60HrUW833T3cCrym0hnjovb1f0Rc7jWT3z9jHajODf0tgsXmmKP7SoDMphCDkcV0
         h6y0aqzsde6pgOt+LrN0sIkyGQVcT2HVAAdwv81tZLACJjtv7rRlSa1pj39hscn9yY5y
         8ZSRuQny+8ja9aLqv3GLXDJQA2kSvsVACAxWyYdxSESIdMmidHnkcD/2egbzTGhhgRql
         4gxw==
X-Gm-Message-State: APuU4Z8hcE9foIQnzAy7Z51Ud636Bzig20gaRyPveMhaGhQg0eM8BZsz
	rVv9sPOW47INfke1ueS/bQ8E6K8QdLB1PU18LA9LAH+ks62iRH4t4XTUGM0DJ28mGwPzKhscF56
	rJnA=
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a17:902:e550:b0:2ef:ddd6:7176 with SMTP id
 d9443c01a7336-2eff7574d13mr48552185ad.70.1795082202857; Thu, 19 Nov 2026
 01:56:42 -0800 (PST)
Reply-To: editorsisos@gmail.com
Message-ID: <autogen-java-802e5e3b-dd4b-481b-94d7-f9d607b5254f@google.com>
Date: Thu, 19 Nov 2026 09:56:42 +0000
Subject: Regarding your research manuscript
From: kaverip620@gmail.com
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Dear Author,

Are you currently preparing a manuscript for academic publication?

Studies in Science of Science welcomes submissions from researchers across  
a broad range of academic subjects. It is a Scopus and UGC approved  
multidisciplinary journal, currently active in Scopus 2026.

You can review its journal information and submission details here:
https://sciencejournal.eu/

Would you be interested in taking a look at the journal?

Kind regards,
Editorial Office
