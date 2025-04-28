Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852C293B70
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870536; cv=none; b=sjb0FEhxKmzQxCiP/qxPy87uf4glaxHBAXzwowHvfrQaHB49wjj7DSmobe1Xr4BSI4W/l8eTn71UiNlEx3Y3U2MNyjYd2aYx/L8+m4/IDB7S7KzgkSZoCKabCNSVg75+l8uYXVs5/KVoh2LFmsv9o9E30QIaUL05XXZWlxVWcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870536; c=relaxed/simple;
	bh=+umY03qwi3ZZlQ3k6I/ak3+sbECFZVFDE6qN/+vPS8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ41sifpRVP5LAA94ZWYCUndAVJPsVKA3I6qw3hlSILUZcPUEdYDiWIqIhlkK+yMQ/hnSKTgGCnjKz5f/hv6gw4FSFVGHUkTuOaZsshacXRzXAYOb+zBQrXbCLQxytDdkuC8Vkyc6csaHWHgBvC/LbFxY/atQ1X1zyOC6Sg3aMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIC0O6LP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIC0O6LP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c9376c4dbaso591971585a.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745870534; x=1746475334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4YmCYJAbi8IeypszUAVuJ+wj03LeokGDz7X7aoygeo=;
        b=UIC0O6LPnMAM4saMylG0IP87CHu+IbCJQ5VSCyRgzitfbQ3o/jk2N/oRxBm/88smqk
         PxhPMNn8OXiV/qumMWxSA1W7jc56f5+y2KNI4XFwgfPamrj6kslTd6aEc3Mj+QN9SIqF
         XDQtRhUWNCfHhHb2SA2G+PUGxIRuQVjTIQhmEFnDjCRaBtrLRrdKkEMx0e3PuL5SLXJ6
         jRA65rGFznOYhbCTyRAVWUQkmSJHbBa4h9FdUDIL/QDVecidaCo7iE4EbBnr827Q2t4D
         Gjf4/z/VtKdeujMbw/EtI3gPTKTaGpZzLYf2+jnsBW3tbxjBmd9OcR8aY1sjnWkXY//3
         xWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745870534; x=1746475334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4YmCYJAbi8IeypszUAVuJ+wj03LeokGDz7X7aoygeo=;
        b=BOcZ6tmMhosQVGFMx1JPBZZaDu9h8ECekhspLU1JbyTiB/q7cp+fIA4DVC6Bawwotx
         sMpNXX8enE0Qy8AT+MIyMFRxV0fimle37OO0IzZuR9F6U1n9oMVObXF4tJyzNexLusrh
         Nz7qtvZREBMrRp4jpbeb6iqVqk9tv4u+8xmFaU4oW5jEy2n2tdacFtAzYw1QwjSBIKN0
         Elc7bTvBpNlPAxI9b/zBcEk8xnPDPDNrVjGKECPCbgG4gjTDBc5uhensqlScm8rv/2rn
         AMGriXZxPA6gsM1rdSRQ9XzoIwhXLC/7siiWAxH4VG6cVAYKE+8n/mcj4WPyMLFwVAL0
         ALrA==
X-Gm-Message-State: AOJu0Yw/dlzXH3PefwLVnQAIiawzokThDUI481TBrXPyIKuOyDiraTU7
	kdv4HQGT7dV0zeRNYoud/NFxLPxD6uyme7y/NfMCRhJj5tYjeCN5mPhQzlbBYnZJBX9NNRi6Zkm
	9ejb6JEWmW3uiLM/8c0ZChjvzegQ=
X-Gm-Gg: ASbGnctq6f45+lP1MwUHdoa1vJyVsH6khf6sz4710euqwdIdhYrdSMxA0sxFwsIT0tY
	aKmXZ2ZPyXMMUCSRQClLSz3t95cRHs1HRSO8FbKrcoabbGAHLqlq8UyLJbmYpWvd36/bcjB23/k
	/6rcFkZzfJ56jYUC2f+Lkhww==
X-Google-Smtp-Source: AGHT+IENDfOAsOJBBBCYqWEe/kds7RS2T1h+H6KRMBhEcV7TNK4uBGUaqIkK1McrsA+2JcOSHitAip/+lPVs2SuIjps=
X-Received: by 2002:a05:620a:4e5:b0:7c4:bca3:6372 with SMTP id
 af79cd13be357-7cabe406916mr92179685a.0.1745870533830; Mon, 28 Apr 2025
 13:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com>
 <ceb84ea7-6359-63c4-e02b-418d9d313b06@gmx.de> <CA+7SsOd9jtjQT+zg8XttA-bfONG2Jpkg4uBTTdys87e_jEX1pw@mail.gmail.com>
 <01e30386-028a-b115-6550-57d598ba93df@gmx.de>
In-Reply-To: <01e30386-028a-b115-6550-57d598ba93df@gmx.de>
From: Junio Luan Pereira <junioluanutfrma@gmail.com>
Date: Mon, 28 Apr 2025 17:02:01 -0300
X-Gm-Features: ATxdqUHx9Rm0b1GdBASuIX1PJKs4emke5DQjlqmFDuDpH4dlRAX97qi3jBysRIw
Message-ID: <CA+7SsOeYhzBSTXt0V21ghqdzKBkT49GxZZU0k0MavmNrriv8pw@mail.gmail.com>
Subject: Re: Error on using git update-git-for-windows
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello
The "Curl option" is set to "WinSSL", but the problem persists even
when it is switched to "OpenSSL". To confirm this, I reinstalled Git
using the Windows executable file (without uninstalling it first) and
restarted my laptop. Now the content of  "C:\Program
Files\Git\etc\install-options.txt" is as follows:

Editor Option: Nano
Custom Editor Path:
Default Branch Option:
Path Option: Cmd
SSH Option: OpenSSH
Tortoise Option: false
CURL Option: OpenSSL
CRLF Option: CRLFAlways
Bash Terminal Option: MinTTY
Git Pull Behavior Option: Merge
Use Credential Manager: Enabled
Performance Tweaks FSCache: Enabled
Enable Symlinks: Disabled
Enable FSMonitor: Disabled

Yet, the issues remained unchanged.

If this information is helpful to you, my current cURL version is

$ curl --version
curl 8.12.1 (x86_64-w64-mingw32) libcurl/8.12.1 Schannel zlib/1.3.1
brotli/1.1.0 zstd/1.5.7 libidn2/2.3.7 libpsl/0.21.5 libssh2/1.11.1
Release-Date: 2025-02-13
Protocols: dict file ftp ftps gopher gophers http https imap imaps
ipfs ipns ldap ldaps mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps
telnet tftp ws wss
Features: alt-svc AsynchDNS brotli HSTS HTTPS-proxy IDN IPv6 Kerberos
Largefile libz NTLM PSL SPNEGO SSL SSPI threadsafe UnixSockets zstd

This is why I was unable to use a cURL binary without Schannel.

Sincerely


Em seg., 28 de abr. de 2025 =C3=A0s 08:22, Johannes Schindelin
<Johannes.Schindelin@gmx.de> escreveu:
>
> Hi Junio,
>
> On Fri, 25 Apr 2025, Junio Luan Pereira wrote:
>
> > I discovered that the problem lies in the schannel feature of the curl
> > binary. More specifically, the problem is not in the curl itself, but
> > in the feature "Safe Web" from Norton Antivirus in my PC that, in some
> > way, blocks any attempt of curl to access sites with a public key
> > validated by "Let's Encrypt". Turning off the Safe Web makes
> > everything work properly.
>
> Interesting.
>
> One last question: do you have OpenSSL or Secure Channel configured as
> your default HTTPS backend? You should be able to see this information in
> C:\Program Files\Git\etc\install-options.txt, under the key "CURL option"=
:
> If it is "WinSSL", you chose Secure Channel, otherwise it is OpenSSL.
>
> Ciao,
> Johannes
>
> >
> > I am no expert, but an AI I used suggested that replacing the curl
> > executable by one without the schannel feature would solve the
> > problem, but I was unable to do this.
> >
> > Based on this, I believe this issue can be considered solved.
> >
> > Sincerely
> >
> > Em qui., 24 de abr. de 2025 =C3=A0s 10:05, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> escreveu:
> > >
> > > Hi Junio,
> > >
> > > On Wed, 9 Apr 2025, Junio Luan Pereira wrote:
> > >
> > > > I am using git-for-windows on a windows 11 laptop with the Brazilia=
n
> > > > Portuguese language.
> > > >
> > > > Recently, an error occur every time I execute the git
> > > > update-git-for-windows in the following way:
> > > >
> > > > $ git update-git-for-windows
> > > > curl: (35) schannel: next InitializeSecurityContext failed:
> > > > CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - A fun=EF=BF=BD=EF=BF=BDo=
 de revoga=EF=BF=BD=EF=BF=BDo n=EF=BF=BDo
> > > > p=EF=BF=BDde verificar a revoga=EF=BF=BD=EF=BF=BDo do certificado.
> > >
> > > This command is implemented as a Unix shell script:
> > >
> > > https://github.com/git-for-windows/build-extra/blob/HEAD/git-extra/gi=
t-update-git-for-windows
> > >
> > > Could you edit (in elevated mode!) the file at
> > > `C:\Program Files\Git\mingw64\bin\git-update-git-for-windows` and add=
 the
> > > `--ssl-revoke-best-effort` option (for a full explanation, see
> > > https://curl.se/docs/manpage.html#--ssl-revoke-best-effort) to the tw=
o
> > > `curl` invocations in that script, and then try it again?
> > >
> > > Thank you,
> > > Johannes
> > >
> > > >
> > > > Reinstalling completely the program apparently does not work.
> > > >
> > > > Is this some kind of bug on git-for-windows? Was it reported? Shoul=
d
> > > > it be reported?
> > > >
> > > > PS: I have no knowledge of programming, developing or debugging git=
.
> > > > Ask me in case more information is needed.
> > > >
> > > > Sincerely
> > > >
> > > >
> >
