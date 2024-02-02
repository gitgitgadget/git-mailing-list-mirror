Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FB605DB
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867991; cv=none; b=cTT2RLRHp4RrwP45Fo+n9Q7VzulYdsg1LmqpGaVwphx0Sn8wTku9DY8fbKHDuP19b9sEop19kTcPTj1mZJVcWulpX0VJNOBFSS2ViAFpjAE1eSfvrg6UMlLavn2pLkZGF1fqWKOasB42bwPC2Hr4YwH8k+R5oqvM09Ra7q9APUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867991; c=relaxed/simple;
	bh=UOS4JEc6Hl4InjPGu05+tKpxR3so9ANCdZvhfxw7+yo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=gSd+CGqjlP3MKGtclHQvk18N+8/1PhEcF4RytQoI5+HTorW31LJdpNQ8JzKIcVa2uTLm6gPQ3lruhYA6/F/NFPZN/U3upkm28DwkOKvHb1xfOf+SU8Ip4SxpFuvrFPi2H6jIlZcYQRAPFQROcbbIFfaIy1KEI7qqfyVvLy0XLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=veryflatcat.com; spf=none smtp.mailfrom=veryflatcat.com; dkim=pass (2048-bit key) header.d=veryflatcat-com.20230601.gappssmtp.com header.i=@veryflatcat-com.20230601.gappssmtp.com header.b=tiKDMdRz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=veryflatcat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=veryflatcat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=veryflatcat-com.20230601.gappssmtp.com header.i=@veryflatcat-com.20230601.gappssmtp.com header.b="tiKDMdRz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b130f605eso1138858f8f.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 01:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=veryflatcat-com.20230601.gappssmtp.com; s=20230601; t=1706867987; x=1707472787; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbi/1L8Ob5J8dNQxdgYn+5fw4c3sByILuRDQsKNHq7o=;
        b=tiKDMdRzjUYd0AoP4EbYn1wlLT6vYmXbkX+UwZnYV0Ncbnd/Y2sJJO/FBcEATS3VOv
         C0AWsDv2a1JgFkiqtEnRSMvN/+vBI3QmfF+zEsoM8cBVfnvZWQEhr0K4Pvg8H1Wl8WD4
         hEmRtvjinXOAIZYKhy3jXLJKzHQ75tbKbyAXVt84dPRP3Vb3Gc0xe0SZNevWysUuqclG
         E/qJZlON1UrjPi12HONiED+uMe7VZbiCBA/wOV855EwrCRftBFDP95/MG5VJtfs4gn/6
         NvCNjiN2Ita/OMMoXorvqurHcdDBD3BK/7bY1rBUqNgpiNHXAnJJs3POzCWmJ7TJFVvF
         eA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867987; x=1707472787;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbi/1L8Ob5J8dNQxdgYn+5fw4c3sByILuRDQsKNHq7o=;
        b=EIBs0ZwoPDsOF8oaLZ/8h/Tipoz/DPDtJgDCBGUbB9T0lfsjDyQYSYXRhPJGIRU4hI
         yiJjcU+jOcb7kbWsY6uADE9qo8CVVy/pXFpQroNBPmusI34IXVnnN2gaOhUcmyp5RDox
         as3gocbyV8gtFt3XkVQf0C/vj8z42N/d9siVlYGIjMwQlLXaoje1bcGWuI23qJUjX1X5
         GuHxg4Opq79kV5pabmtPTZfJR6F+QGcTXw2a9+7+WyxoRQf8Fl9NC486ZdMBxKSIfeiS
         lQlKfXxPc04NvoLYjrukS5hhrbkk9IQz1Mfhe+h8w41lYw+GlPnlTNF1pCve3oVMVMfr
         shuQ==
X-Gm-Message-State: AOJu0YySxkD1WEWjWLJjHaTFN+kXR8ygRjyU4lBa3ClomxuBdKkVzemd
	AgkmH19hDnDebeVPIqhvg23yH+IxnyDb0X1Jg1h7wiT5kGJHjAP/VXqjE/Bd3u5lPuSoPDUoU61
	7
X-Google-Smtp-Source: AGHT+IG/+8ihBVI4oydEv2kU6JKkJc/TfPAarN4znvu+QOULBjmnpXexmDtuNoO+RxpdJqg1xaK+tQ==
X-Received: by 2002:a5d:4f05:0:b0:33b:252d:ec26 with SMTP id c5-20020a5d4f05000000b0033b252dec26mr389046wru.65.1706867987274;
        Fri, 02 Feb 2024 01:59:47 -0800 (PST)
Received: from smtpclient.apple ([41.164.20.115])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5224000000b0033afcc069c3sm1549162wra.84.2024.02.02.01.59.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2024 01:59:46 -0800 (PST)
From: David Weber <dave@veryflatcat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Git submodule ssh command recursion bug
Message-Id: <FB27DE07-1C5A-4E2F-8BE6-8AC958365C9B@veryflatcat.com>
Date: Fri, 2 Feb 2024 11:59:33 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)

What did you do before the bug happened? (Steps to reproduce your issue)
I attempted to run `git -c core.sshCommand=3D"ssh -i ~/.ssh/my_key" =
submodule update --init --recursive` in
a repo with three submodules. The first was a public repository and the =
2nd and 3rd required the private
key that I specified as above.

What did you expect to happen? (Expected behaviour)
I expected all the submodules to be updated

What happened instead? (Actual behaviour)
The public repository was correctly checked out. The private ones were =
not checked out and I was asked for
a user name for the repository.

What's different between what you expected and what actually happened?
I expected git to use the private key provided and not ask for user =
name.

Anything else you want to add:
If I did the following then the command worked as expected:

  EXPORT GIT_SSH_COMMAND=3D"ssh -i ~/.ssh/my_key"
  submodule update --init --recursive

Then all submodules update as expected. I assume this is because the `-c =
 core.sshCommand` is not propagated
to the underlying operations that perform the task of checking out the =
modules.

I have the same behaviour on Linux and OSX.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-14-generic #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon =
Nov 20 18:15:30 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]=
