Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792746460;
	b=QgNT+vSlTc+G1amvoGDZoVSkJFZgaGGfrs2LhMJZCyVtgngeKvUrwFy7kBewFArgplZe
	 Bi4ZrDN9ZiNManVlmsMLVPv2otuRR4Y+FVtbUgGgHf8EnCw+Bcc1K5MYsOP0tc9/AN7tl
	 jUIcgaLh9NpidsCStt+pepE3SCgeNuMYfFK+fcN3TmPQD3Zb+/V8g+edbrPvi5UyhYkeR
	 HGWXXUn7U4VM4M9WcTtKEY4l8pLuRgOW3amwjqPFbiXFvRlAFha4C2EtV0L645dALR1Nf
	 69XkrNUV45GQ/ZXD9RBAutnF+ao1CQidTntwfKOeFke+LvnLFXnKdl8QAulG38jk4JA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UaZBsBx8h9CEARNW00nkoearNfH3WyBFKE8mR+Y0o78=;
	b=ufEB6IEywxeXuovVDdywWkR8jY1XWyYN0FfQfjnP7jH3avtq04+OMEsYaGE0h+1zIRob
	 rJKUm3T4EvHysWRY5EJ5J9ro/cdxE+W4vVoSxMUfWK5044bcUmzwka2GRg81MiZAOfBAN
	 FQckBniyp4earR0+BviDVqAYfD0ah2LKdbTbvSS3fABkwRjM3M6afrotH15c20kzB0Byy
	 ZIy3GluEhYEnsIoFlAQp8igWNfPjcCU1z/x4ry2omjWVoQavKSHuEVuSj0dpaUTza+tNH
	 HhR0+JeWRXlxPLFcKZ+7YYZQfJ0cbq7NTMCYOizQmYXstjS1UinWY60wudV2zFaLIvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YUCh3z4T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F20606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 09:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F20606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YUCh3z4T
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so868516a12.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 02:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792746458; cv=none;
        d=google.com; s=arc-20260327;
        b=Gf6kjWKvk2e37wnFAOHvjcUyZVboEwFi+GrkvQ2BD3WR2ZenkvAu4C2NLwQi07rDMa
         cUp+BdmXIgiSn19wcVy+S3NiuuyD/bFbScwlFW9CVDbX4E7LsN6uwxOrVa/D4W71oQrd
         nAh5FnJwwOLhe+1LRLZci4RBfVzMS8OMWR3ERl+LpeIxDSYVB9Ucu7c1XfLNqMfT9u3v
         CFULI4WvpHa8A1n2VKo0RCeuQEf/TecyUuH2hGPxyVVfRsw7WtlyXtrhbNpXTaGhfh5z
         gswylgjaRvHMGQkAPvShav2FZSYPgFVG7/wc3ptbfTv1znAwXOjrK2kWMvjIa6aTOFnj
         piWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UaZBsBx8h9CEARNW00nkoearNfH3WyBFKE8mR+Y0o78=;
        fh=v3aQIpkeG24MIHgWSVAwdpjbWILcZVAGSk3G7JXkpNo=;
        b=J3zF0pz4UycCtIsNo8H8+O2EzRE3Ssb50wm/qIMnnVjM3utC0zGYUGxvzSai5qO4K/
         SVFv9uYbHb6DI0fZhTXyYJXtDPwoGJA57Ua9Ieyq4QRYv8Si4FWHe2zes0UzXhQHa0pJ
         IfyDBBQk9b+lX0DH81SCzqEFSTZvuy1f0Sav1WlrnJEnQZKCzqJxwK/iX86rtpsfmkMH
         4VcdmJ8Yq30LTJLajGRocP3B59lOwRJIMSOy66dMTl5oyF9lQ7ptOmm0w2M4IZtbpABA
         oF74zip5YWzUGq0SEzYOyFdhFd1zqFF/+1Ha98HC1YelSWKxYDclrcwgimtlGIPA+1Lx
         b7Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792746458; x=1793351258; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaZBsBx8h9CEARNW00nkoearNfH3WyBFKE8mR+Y0o78=;
        b=YUCh3z4TL8wBUH5LrJTmO/vwJnSTWreRAUQCQQXNaWjmKyFVRwhO6fi7qH6cRzwj7l
         pE6jnUwPcpEk83VosnNbh4OGlRRBXjeJXcmjzw5gTF3gXem8McVEp6RsA5xb3zW/ppHa
         4O2ZWTle6LT8QonDdxOSa1h6H6Z62cJCWHfecUrrspV2sJBBW5svfVSWgOQ3NCVMG7tc
         NWnAaoxFr3ojltdN4pKfgHSNZWN5prxXGubHQIajTgEwKmUgILANNpnogzGIAmfj8hig
         IUAxlzWgC8ZDcb7GOPYhuBYaLjB/Dbu7fED/lXEbLvlE1xTUJ/QBHfNq5vTMGf7pzg/0
         9v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746458; x=1793351258;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UaZBsBx8h9CEARNW00nkoearNfH3WyBFKE8mR+Y0o78=;
        b=HF+07mT9Yh9oUGO/UKMeffTLub9My078kr+HDLkCQYegUf43XYwg9PDt5njjVAvnk0
         16hB6wRKkFop5hBeyj4MB56fLjJPTEYguGvVFk5J1jgdJTV5xEbK34Oi18DWv8SJ/hTC
         Ep8YEINOAvNkHV6m1T9bZC9fG85ubSGkZ4hGhVjPfP3RGgXaJrmlPSaBdUopJLl5mFay
         jIQQKS5SM+0echxIFyQ8eN6NK2gClv+ZcJjjrCoz1KQ6xUXvF38zbsCSMOfU0LiPQUZS
         vbKqaLQ1GdGZ2zRuVkIzZ1o+Q1ozqpiS6JP7JrXgH356IZKekOXTzoh0OjtpUX4nN408
         ysTg==
X-Forwarded-Encrypted: i=1; AKwUvBxd+Qdgo2Qq2JT1WvAfRkUWsR9xD/hGrLMyxx+YyZCcucS/DkuX2lMb/i5KvJ0FD/xBw54=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCPnjOLXYxU9IUY5c8tzIHXy/MORNoEpYIorzEtqszlpEsVTaK
	MI0YOa1C/S56d6jLRVmfifq1amCOwrD9XUMv98n3pAXv4nDneb0IJtD4mKdbfIrc39p9VLt+6AP
	/PjcKQpBoRb2C16l0IZukLXlZAbhtInI=
X-Gm-Gg: AYBFou3XXyE84Ig381ZuLtewIEkOrM5AmYarU/bKNmUmjtcw4YzEowa/4HFs2xRYc7W
	Fz+cFIf8aq8tzaRqZ0AcU95L86hH1709wF8LkRFZ0ObVY3zizpV6y1oBb83ecbkADkDZZrliKBY
	X55Iwd5r6cZMGbnfLl1oKm8ORvqHrfbnYjhdGDXd9aTzgNjlGQqmxb2uy4R9mIYaeN6x0Kto1JC
	PPE1bAHwVIO/JVSqfzmafp1AGlFCAW7VOQyiqdJjoPQShka6Mqsle0Cc3d2U+91QeHViT3Ye2j1
	GDo7bU/NJgWSd6jIIH26U26QPTpUbhyMsqd9xR0NV2HG0jxdjH48Xd9TxNbJrbi/goQcr3DJ0z5
	o628ZeAwNA56qmQ3idbo/ireVKU+uV9cOYN1EtVlRRjfYQEbt14Pr3JP+3g==
X-Received: by 2002:a05:6402:1f12:b0:6b4:208d:21f2 with SMTP id
 4fb4d7f45d1cf-6b432b4a449mr2498853a12.2.1792746458444; Fri, 23 Oct 2026
 02:07:38 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHwyqnUWab7AhqJtWkPQzw_dh+OwxiZxt2+1TTC-r+VPx+20Tg@mail.gmail.com>
 <20261022174429.81186-1-me@jaspermayone.com>
In-Reply-To: <20261022174429.81186-1-me@jaspermayone.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 23 Oct 2026 11:07:01 +0200
X-Gm-Features: AclHuK_Pn6VHU-R-c144_KYe0L0kbS5puHehE_fGMiIyaVaoi6LCOHqzaZKVnx8
Message-ID: <CAHwyqnWCndBcrxxkDTyLoC7hM3OgS8pAP=H=gt0r2ZmmKnaojg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: Jasper Mayone <me@jaspermayone.com>
Cc: gitster@pobox.com, gitgitgadget@gmail.com, git@vger.kernel.org, 
	kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > I'm leaning toward `--delete-merged[=<level>]`. But it's good that you
> > are pointing this out. It's tempting to unify it like that.
>
> The value of --delete-merged is already taken by the upstream
> <pattern>, and it is required. So "--delete-merged=squashed" already
> means "branches whose upstream is a ref called squashed" today, and
> it cannot also carry a level without breaking that.

This is a good point and stops the `--delete-merged=squashed`, and
likely also `--delete-integrated=<level>` to keep it uniform.


Harald
