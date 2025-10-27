Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4818258EF3
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545354; cv=none; b=VQdZFAJOORnBObhsdR2W+7dSEZR3DEroq4lJab6MeWBnkFaAJpEQ0f8tCH0TVixWIJOQ/JNdTnbDzD++XXyA5VSeI3V6M4FXRFhH+pxHbPm+klyhE0rTTdWBOzPSMB6TjmxCJMCQ2pOKvQ4q9pAsOvSJGLdizVJeT1lezu7DUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545354; c=relaxed/simple;
	bh=Jg3+Y+GGRJiSdgAL/rZUIHrkGPFpSUuUVYl9cAObJt8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NDG3E8hqQhRmUtMwIKrn0uC235E6ryr7yO3JOmFhon6GHw9LQieaEZ9tXaFVsth5iJHCejbCZuicf4LTjqPMEpa2qaZ6At/Jc0Cnm+J6af+ZJrHkLGpV4FkNzcVlxi/diODvMLWvJV3KgqvePmbVpPXhz13rVXDQeEPZl3zirZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShXXLPlJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShXXLPlJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27ee41e0798so61380785ad.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 23:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761545351; x=1762150151; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jg3+Y+GGRJiSdgAL/rZUIHrkGPFpSUuUVYl9cAObJt8=;
        b=ShXXLPlJo2fofzLF9mOFcFsC84kvCIMTAKgvAoVKU8j/cpxw6A6jdVC47M68oUZOrq
         0Fcxq+Hqc0IKJHICJKKU3fKWTd8wAYZ53YsV/F1pGYj+Etq9ONI/2Sg6wG0WivdC8bod
         ow5618m7VQWG7PgRDBV7EAO2sGa1aaV2xFPlV1ZyDIj/FSuvZ0PBaQjF76HQNspxfcVy
         afwHGjdkDKKW0XAg9g5TkoFkLKGVaarn2NQPr7Ow1Hc4FWsvLW0T8jDwNQjGc3IRyd6W
         ajn98/aKKwP/Dld7d+Q8xcQoxLmYOSVzDpCh6Uvt25HLQVwykpDYadENN+NmRbabNOZo
         osyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761545351; x=1762150151;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jg3+Y+GGRJiSdgAL/rZUIHrkGPFpSUuUVYl9cAObJt8=;
        b=fVCApfFR6UYfOeiOWr8WnAUqeOYos6n/vtvPiNK5gcp4LZ1K0lFWEv2qYEXNTlstUr
         wnjaTrTzC018kCl5TZTrdqHylEtwwIELb7fDDHZ02y/Ji+2k9FATWa8jWGCSqhA+r3kV
         ZiVIIUC+3IGjKqVPJtFn+2n41QP7UXulO78jCzFarwmYE+7Rl6LxXnRU+j0OWnLpj4oC
         cucWvJLK4G4SsLAVx9jAcvGb93gtg5OAFF89H65rnlZIefrpKeubAvBjgR67blKVESQf
         loevYTvio3Px/w3QtwPWn3/9O3FcLq9QClLu7iZUfD5tp/bIDsYi0p5j55AzUo0JT+6v
         a5gg==
X-Gm-Message-State: AOJu0YzyH2juPOEYfCE0T3vh5M/uy4H2e8U+NKiCwxoytvFA3TyarPXh
	Nx+nq+8WbBhMnEruEfPhNFIqhm4tFcgAtXTxTdpxB1ZDxJm310R5VDGRVhIdWVMSBAWdHvSxnfk
	fWlowNhUpUhSsUTxwKOvbhkdSr6FiKm8g5D78zck=
X-Gm-Gg: ASbGncvUunRtUj3m5oj646u+VDfYpsgoEIk1pQWJMZnRAfVLInhj2ttfNDN/AKvtY57
	xUUqjIOJtyB7tCRBBRMRhDvjKKNfACR7vm4yNysY10CQf7ymVl2HezmtG/ZkPWciRcDn05OYGLt
	P//inqV/RrW/0D3mBtWTyMtSVPHiYFvwGnr3S/qMQPggUgzZRTiYORpSl6nulp8p6DeqKL6mOy+
	5bLoKyDC04WWa28fpJxsezxQ4GA3pByoJMOqSvBVilfNpTiFMTled2Ls5KtivCtkft5rFaD
X-Google-Smtp-Source: AGHT+IGAA3dsoTZnhvAO7Fhgxzpe0n8GWjKkeee+GKz6Zm/g8wMfWo0WHotDeBMdlnQKzu1MN1upXK8YQ9tZ+QDXi1I=
X-Received: by 2002:a17:902:f68a:b0:292:39b4:e785 with SMTP id
 d9443c01a7336-2948b9be076mr152925395ad.26.1761545350676; Sun, 26 Oct 2025
 23:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 27 Oct 2025 07:09:12 +0100
X-Gm-Features: AWmQ_bmSJqR28dlKE_DLXTfWexZ3_q9FwQE-J5Z48STGr2J8br62lFcKMtdWIjE
Message-ID: <CAD=f0L-Pr9MtQ1=Wrm3tybZFWKDUtDpVcOahoFUgdVcGKJm7Vg@mail.gmail.com>
Subject: [Outrechy][RFC] Request for final application guides
To: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello, I hope you all are doing well.
I'd like to appreciate everyone including Christian, Junio,
Usman and Kristoffer for the guides and assistance during
this contribution phase.
The deadline for the final application is in exactly a week's time.
I'd like to know if there is any new information on how to submit
the final application as the Outreachy page requires us to record
a contribution by submitting a link to the contribution and also
submit a final application to the project.

While going through the mailing list for previous final applications,
I came across this thread
https://lore.kernel.org/git/CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com/
where the main points regarding my questions were answered as follows.
1. We should use the link to the microprojects for the patch reviews as the
contribution link.
2. We should specify the current status of the patch, 'master' or 'next'
3. Send the final application to the mailing list for review which should
include an explanation of the project we want to tackle, links to the
microprojects and a rough estimate of the project timeline.

Is there any other information we should know of or this is good enough?
Thank you.

Bello
