Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8C366575
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021469; cv=none; b=CUxnu4Dc7dLPuMJhSnE28s/3//7Y3xaAN3GWqXrTpUlHpM4xvuecrYu9lBbdw19U2V6PQXhOwutXHRCVimn79jdJOYxNO7fTd6uru3LSunSbbSeQ/330o/bJK2queNQZO0jKy3QBYbkWt4727ByCeR/I3e0tLxjg42lVfXHd+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021469; c=relaxed/simple;
	bh=jkd5hczqO2fFi6ZeAOabv/1c18Zdo4gUt3buekDZWR8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f2L4lsXI0n58+FKuynn1EL93ATm9NqOwJAQDb4L9nPcPekIlBjZ01rQ64+nVvcGYAk+1gYFpnxLZ+WfO/Czhl2p/jVbIE1sXJ3wwcFUcKieLWKPaA8qCNs6/yOwzwpYW34wwj7AaSGGDXffZw5nmfz1VM0xwpmOt+XAtr3n/iOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnGb5Lf5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnGb5Lf5"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0ac29fca1so1067765ad.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769021466; x=1769626266; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0LnvwLlu8oNQa95q78Bm8/XKR0PbQgAuTeGmlXSJhQ=;
        b=nnGb5Lf5wHLizjpdW4u7mqdLMv7MHPmoFQ1vaNzH7H3SV31Hjaou2Wbr9UbMbUe8+J
         TVw2O2IKGz8xCk6p1kRXFUX2z71SZkj2AkNZdu/lFds0VWzsgUdB+ajLDd1iOaz6CRWS
         V2rjdXx/L9BJ6ox/6Q8uVd0ldwTEaxe8OFwXbrUIn1Lxd+q41XYIgDrRUPynSpOYQbqJ
         qjV6kea+rqqAPXvB+2KB/ocZWy47ET+PMFS3hW2BgxGF0Qw9V5lUhzlz0I87dytQ2t03
         dbnGiHS2jvVwF+OfPkgw0M1MbX+taNbwd+FMYLmgrzacGUndnUvJ/LTyiFtcr/3t1Znp
         y5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021466; x=1769626266;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0LnvwLlu8oNQa95q78Bm8/XKR0PbQgAuTeGmlXSJhQ=;
        b=gnjR99g50A9ub3UG9tKTqg+zYrJy7ToKvaqPiBjMv4wq5yjI+mqL2OqMQU9e33Npaa
         X+m6UmKZ5KO544s3PA/AA/7lrXsaXCEVWwHsYvs/Js4ot1swMz8D1vEGP73UcgQkZd/p
         9NyamVqin38Dkd1bxD1nt84XeLdXSMrAgnwOOsFlmGaM/uSzrBFxOqwSQUoNLX6Ezqze
         7U0kWDke5s1f0qF7CFnI4cZ9gnfWXQ8l9pkfwXHfH1Ctl6FwP5ZwRrFSdLvthgDVYuiB
         dZFsfGUQ+8GY/VHWvDiJj+vleJyK1E2ACRkRjU8aHse6fa7h02qovP1ZVPB7pwzrwtX/
         RJPQ==
X-Gm-Message-State: AOJu0YytFH4b8tvreh80NZLzIljjGFS021E39VcqrrIjFtkKsn1hTO1d
	0UTbkn/38Mk6YMm3QfwPe/KpQ7Hh/3wS8m+wwTpjYhaWOjmYtQd3sdhD
X-Gm-Gg: AZuq6aLe1qZfLGjp/6aLi20kyyKE19YmGaBoagzZnzNQmMyq9/J+pQutr9aHHUmCsFr
	jSvqzga9yjCQGUK06/j1bjg3jaSsSKRDioI4vSTORWYc7kqLTPfeFqfxdRuaEVRpOAHgk3Q9x+5
	VclJeqn/wc7WEOj+MxKW2wSyEdxwQFZirYtv1j4Hlf0IpaYwu5vPl9V8EsEceORrVQGqj8M1afI
	Io1hOk8NYHmP2M6XLLsPeyN2nChHjFQxCVRNx1Cqf5oXKeVVfIkKzhKcFkV00rL2OasTGJlvOkr
	FKD0aZTaOujcN3eh1qy1GeaRT9EEsUf/1SK9K7NHPnQ/qQnanl3w1cgPopL0s7XdecDdfR+d7xb
	RfIfli+ukMFcXbYYfe2YjyVtwS0W6lqx9WWIvyP2GLV+bosFHK8B/o1gb8Qfng75cX3onI7u1Ab
	RuMbX9YMDDvY5hd5sp7LiXpr5U2XFNdimL8FnP1VsqkS6e+qNRh4bC4m+0Lwo3Lz07OmquBQZdt
	d3IJriTOQU=
X-Received: by 2002:a17:902:d2d1:b0:2a5:8e98:1b44 with SMTP id d9443c01a7336-2a76ad6bb2bmr53205945ad.31.1769021465863;
        Wed, 21 Jan 2026 10:51:05 -0800 (PST)
Received: from SL2P216MB1885.KORP216.PROD.OUTLOOK.COM ([2603:1046:101:97::5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eeefasm159752255ad.43.2026.01.21.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:51:05 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: "alf.clement@gmail.com" <alf.clement@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: .gitignore issue
Thread-Topic: .gitignore issue
Thread-Index: AQHciwa44rLSah1ilE+2uUtnWaLX0w==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Wed, 21 Jan 2026 18:51:02 +0000
Message-ID:
	<SL2P216MB1885CE309BDBA65860D8762FA296A@SL2P216MB1885.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alf,=0A=
=0A=
This is expected behavior.=0A=
When a directory matches an ignore rule, Git stops descending into it entir=
ely. The pattern=0A=
=0A=
        backup_STOCKS*/=0A=
=0A=
matches directories starting with backup_STOCKS, and once Git prunes traver=
sal at that level, similarly prefixed paths can disappear from git status, =
which is why backups/ no longer shows up.=0A=
=0A=
This isn=92t a bug, but a result of how ignore patterns and directory pruni=
ng work.=0A=
=0A=
If you want to ignore only those directories and nothing else, anchoring th=
e pattern helps:=0A=
=0A=
        /backup_STOCKS_*/=0A=
=0A=
You can also verify which rule is responsible with:=0A=
=0A=
        git check-ignore -v backups/=0A=
=0A=
Hope that clears it up.=0A=
=0A=
Best,=0A=
Pushkar=
