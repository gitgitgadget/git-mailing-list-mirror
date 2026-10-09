Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A24F68D9
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574991; cv=pass; b=YIp7o5uHyKmSiLRRS1xaXtAjWvb5nU1lkGuCiGiz3rn8EuZRvTz12ANd6zlCSWLQAAdXKUs6uk2081A7PhscsrF8vwzFVIuTBI8nobH2x1i6qvKPdfwi2OjJ+h72QIJEhP4d6I3jme33jK/Gx20gqtNYsrbFlGqfG+rrq79Ty2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574991; c=relaxed/simple;
	bh=x/RFs3gpO8JR5EKGYETfOwC4zsLn8KOmOqxjI8b+gZ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T0B4HbQL9tmYxRyc0JOVBEHwGy8XIQFcDoK5bzUXGoEKO3QJpWRZuw46H5ldkdYFJ2bvl+laLgdKVtkY3DfzzSvtNtxrwqBoPZii18pG+0kDhH5CCdcuuqjdtrdbnjs5EI2BTzz6jjrjfCNLkfe759ERJLksidA2Db+ClGCCGv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsSTmX5g; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsSTmX5g"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so114915eec.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 12:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791574980; cv=none;
        d=google.com; s=arc-20260327;
        b=e6I57tjqwSm5AK+WiCyMhz+pqHS1grM1TiYFTbidtfjb/eOq0dWnVtAaLkgrfQhrKK
         JrLB4DG1gNncMPtoJoWpeND9cfD8w1UjadtQFAh4fWIzdVYN4hnVqxXWPpk9OHuag5+F
         UShdLzp3t3Z19KZSQacaQvidte905E+oDuY+8WxtYLx49kU/zw7pgogMKk59bXQ7Bp6e
         Qbke8Ey0ntnFuHkwdxl4dcHNqQ/PlGM5PVzE3nLdSGK0brP3AsiMFIS5TRkoSM7DjytA
         GVtJs41hREf27odrsgfPRU61Cusn5TklS9BzYEDvmd9O2EVAkhsE8gelLYsqa3KkhH69
         RKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=x/RFs3gpO8JR5EKGYETfOwC4zsLn8KOmOqxjI8b+gZ4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=R5GZbDFsnHpwDVl8lVaZDcOlOKINL4/zptCvShGUoWHgNt1vu3CilZY1VrPWvzNLKd
         HfnwU9J9X2zrL/r4ckfPEbjTQkCBxQvub3ss6wLk4A+/NNo859gq+mbBvPTDDtoBj0C8
         DDwa1RmX7cOjAoz694C4Vyc4jmXSjPq3KHNPLxYLF9Pe/aMxh0tjCr7sW/mjYJ3POSx9
         kQsqG67g31JWjk7blVtH7uOsC79j+oHI7GQS6CGp8GMwf3MAA3gBr0EugzlUDwpgja+g
         JJJ685+kcBpvUx5D+uUrQSjVIK6LMnZ3sKDmP4lqxSPkszjsQh+mwwVpBAWqM0T6LxoD
         CLLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791574980; x=1792179780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/RFs3gpO8JR5EKGYETfOwC4zsLn8KOmOqxjI8b+gZ4=;
        b=rsSTmX5gKDfflvauKGmmxWJm08QACRr+T8mYtPxPWGv7erZDESQWnIxq5PlEzdiPBI
         OObqsSWoJ3q4vaVUXK4kvZvE2W79isTxHl9zzTVYKq0ZXDfiXMu0s7Ihgtuk6DkaGI9q
         gmajjwPsRLkqji+WVLbQBHEJSUwuxowcCj3Tf+LlFxoIloWzZS5GLU48W6UQgTIjxbH5
         Dm8Snf0rDXWde7Sq7ViT8YB18UY7Bat1NdvNv4sAUsuOG2Gx6VDh6pkyeaAAzJW0EyDI
         Jfa6OaelI5/f5gHFbNxcp4W+4qFWboeTirZeAoIMO9PWZ7qznF1XVNn2HEAl3LBdw3nY
         yeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791574980; x=1792179780;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x/RFs3gpO8JR5EKGYETfOwC4zsLn8KOmOqxjI8b+gZ4=;
        b=wSAcUIFK+tH4sbjs7O852CFSwC/g8zgT/hVsgRHL99Tt82iaFTbc2XXvHJ61YtVqCm
         7o2kovE//UWJpN6joX3qvAuaEw9wObmNnK3g6buGPFW+ZWE4+8MTXR/7sM/LHX7IpCOp
         Mk460pPbP6K8ppgtDS5WILGp4RCHa5tFSZhg0wHZAr2eHnEX0CaWHsJSg5LggSE75YHl
         w8eKuHvhIciCGjp6Yi/a23s4nSFolTAAQEZyb4TKpxN3uXmcrKdNVq7SFrAeUesdiuV9
         MUdPJOTfASQzG7PNmqR+jHbOwpGr+U01q02lU4v/nJM+OkFGrHurSwSXtv2syFVG04+1
         NzlA==
X-Gm-Message-State: AFq9FYI9JAX316VtRj9qPrBFspQXJr1a5Nl7bFQ/YZ73R+GfxmbSeBqo
	LY/KcuSc6GwbqPXYnJySqOf/jjZa3UxC1yPDcn4EXZ4RizgooqvZ1YOtuFSUsoAfI+c+QNIItNY
	kVxBeJnUp6Nv/UuwXxaoXmH2fl1NCPvmaTea/
X-Gm-Gg: AYBFou0nHQqATggf2M8ArjqhIoWY7Lw2u1aoL9SXhth7yx4Jrohq/lHt3snFWOEymke
	fGbbAGgJf+KRAjBIA7i9iKZCrurTBXfd7ou+iO7TNyBkzdngR0EjwQ6nUVznQ9blEFOnnHR5vcZ
	J91HvxVDJj1MbHAJpHAaBoYZaLCGvIJ2a1ENptrHK6/a1tFMYJVHSobWMt4jXF7V80Q2JQIH6bx
	m8fvV8c+pJ0Pfe6r5c+jaCYuf0PsWaSs8caQZAWrJHYYrXu//yk52Rx7F3f82WDR0s7cRzDaIfl
	engpafzOzBSYXP8CcFZF5JrvYeBvEY5jGrMHY65JochuXq0pEW2ZpD0=
X-Received: by 2002:a05:7301:488b:b0:351:51c4:a296 with SMTP id
 5a478bee46e88-3537dde56bamr3722365eec.4.1791574980212; Fri, 09 Oct 2026
 12:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ramyres Aquino <ramyres90@gmail.com>
Date: Fri, 9 Oct 2026 16:42:42 -0300
X-Gm-Features: AclHuK8TcWuREsHND9nEwqOeQ98J7f1JxQA4WnvQKXO5IPNWwpg6Rlfoa-acejI
Message-ID: <CAHwebOBCY0PsbS5K_+hNkrbV+PR0D+HPE8F0Dy2JHcWBdtWM9g@mail.gmail.com>
Subject: Git svn unable to connect to a local repository with path URL
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What did you do before the bug happened? (Steps to reproduce your issue)

I created a local SVN repository and checked out a working branch.
After a few versionings in SVN, I decided to migrate to Git. Using git
svn clone to clone the SVN repository to a local folder, I ran into
the bug.

What did you expect to happen? (Expected behavior)

Create a folder with repo cloned

What happened instead? (Actual behavior)

Show me the message:
```
D:\_ARQUITETURA\MigracaoSvn2Git_20261001>git svn clone
file:///D:/_ARQUITETURA/MigracaoSvn2Git_20261001/SvnServerSample/Projeto/Tr=
unk/2026.4.0.0.SaaS
testeGit
Initialized empty Git repository in
D:/_ARQUITETURA/MigracaoSvn2Git_20261001/testeGit/.git/
Can't create session: Unable to connect to a repository at URL
'file:///D:/_ARQUITETURA/MigracaoSvn2Git_20261001/SvnServerSample/Projeto/T=
runk/2026.4.0.0.SaaS':
Unable to open repository
'file:///D:/_ARQUITETURA/MigracaoSvn2Git_20261001/SvnServerSample/Projeto/T=
runk/2026.4.0.0.SaaS'
at D:/Ferramentas/Git/mingw64/share/perl5/Git/SVN.pm line 148.
```

What's different between what you expected and what actually happened?

+ Expected a git repo folder with the files of SVN
- Error message and a empty git repo

Anything else you want to add:
* All setup is local
* Windows path url


[System Info]
git version:
git version 2.51.0.windows.1
cpu: x86_64
built from commit: 4d21a77b98af5cf479d8b6f863c2aa94257cd4e1
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.15.0
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 19045
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]

Atenciosamente,

Ramyres P Aquino
=F0=9F=92=BC Empres=C3=A1rio, =F0=9F=91=A8=E2=80=8D=F0=9F=92=BBDesenvolvedo=
r e =F0=9F=91=A8=E2=80=8D=F0=9F=8F=ABProfessor
=E2=98=8E=EF=B8=8F (62) 9 9936-3640
=F0=9F=93=8D Goi=C3=A2nia, GO, Brasil
