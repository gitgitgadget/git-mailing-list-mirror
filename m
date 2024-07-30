Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C7150994
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325597; cv=none; b=U6TyIJn3O5pvQOMMjjXFm+3AIrqn0d/aT40CKEaRo68tkksUMqV3bM2IhvvkPdDjamIEEgfvkBHke8dpgScwIJEbUyf6TFIbXQXl5iY6MKssZSJ/5daFRqr9Ppq/xZCwOrzUFR60UWm10ivFuVRUrC1lWRjprrcQguj+Da3SHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325597; c=relaxed/simple;
	bh=63e6dciuGvASZtN1dPwDCOJ8WzR1zUjIpWvAJL3oTZI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=iL6uFW3mY5BRuko8tsXn69C3yYaX7C8LKeFn556KXP82d5s+qWxultxQQ24exsbMvEIIvpBq2/hclWdcaeC7naOYwTelju1wocAnPgqMRMr+Qsx5njEpbPM8GoD1dLuPYA6QV33l1GJuxMlFEwNPFUk4tN7NX429k9nfxCDtqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a37GC9Nn; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a37GC9Nn"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so2745527fac.2
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722325595; x=1722930395; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyDNPdlyGScPhKFpBLrwZDpHKPZUgVWJeMcNchyc1YA=;
        b=a37GC9Nnl580Y0h3D0iZaBvGEX9XZGdeZ6Jokc/0JAMOLpQAZ5pIIbp4xDjzFWL6BH
         JWPHx65lIvhTM5Bi3o++VvR8EXI9lFTk8G4RtDU74XzbU4dZh07J6pI/LDFMcMFP7v5v
         hA76LL8gNgOXwOiyt9GZkrKGtGZ8JB2CzOL8HPIbZR+mbGtMABhWFqPmKyPK9ODoisbM
         hPai4rS5Qdf61FVDlefVB3NUZsBumw3OhQ6FxdtBn+YALBe14xXBywcB9a5KNKl06hZh
         Fq4+PSHC2Z1SO41CcBjCPho9dPYO5wLYQGlAdkLHvZv5Rq7T/tp35FreetbvBFQUBSnM
         NWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325595; x=1722930395;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyDNPdlyGScPhKFpBLrwZDpHKPZUgVWJeMcNchyc1YA=;
        b=e2mogw0pPqLOzDqn+7PmGOGaaAwXZeWGF8SgUfjWIfCpBAH6Z8E5TG4esOohU6q6No
         +0Ab/MglmR0PAOQs68cdInWaVf2AdKBIb5mwCQg7J5BcZU+/IxCdWErGXEJFevJV7MfT
         /9onSnFHNcso0r6IBKmCdLw33VslP3edHfq5AOrkfRw+7PnZXY1P7O84/FqvqM6oLyIN
         CuoYh5q1TiTA3tKy4DhzSfp/L9eGVtmFech11Gb61Vs0faF5gP5mfsSfdXJTinVqlWME
         nLO9kDDuIDh0VH7IASkQaV8Lbr4+9eu+St9ky4ISq8/ypva56zP++6+b5sWUgSE+SZ1M
         SGXA==
X-Forwarded-Encrypted: i=1; AJvYcCUufzcsLktZKeOJ8K172yAwyJ/ZGxsq22rG+efxwcAX0MW2ohmPXcD24I/dxNz0ddJ4gjl99FaW1kkKg3FOl6kiNznG
X-Gm-Message-State: AOJu0Yw8LO98wpDE5Fxt+1JJaijX591m4VsEs1iP+JRYWq3rfvUKN1I8
	07Eh+UVtJHqpO1Gzn47+VdZL5VR0lvoDXgUVuhJLAFtfgVby8FtRTF84FvXqWYndTiEDX7jk9Ae
	VfMXSFqKFfCcV8H/jSXJ9LpPaAbAGoQ==
X-Google-Smtp-Source: AGHT+IGvPXnQ5Ei0UQ/p46F6AQFHxdtxDNH/hegHBjDT/nXeY7xWFpEuIdeOyRTWCop2eLVA6yru/ENUwQZEj3V+2Z8=
X-Received: by 2002:a05:6871:888:b0:254:c777:6327 with SMTP id
 586e51a60fabf-267d4e9e14bmr12361238fac.36.1722325594685; Tue, 30 Jul 2024
 00:46:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 00:46:33 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAFGW38fkr+OuhpcyqNFxZNkhNDGPxTbOmCJLVHpCGUmbj05tMg@mail.gmail.com>
References: <CAFGW38fkr+OuhpcyqNFxZNkhNDGPxTbOmCJLVHpCGUmbj05tMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 00:46:33 -0700
Message-ID: <CAOLa=ZRQ2YA=AAUQE9R6K-+o3MGZ8RmcckNi2-txKONC94ceRA@mail.gmail.com>
Subject: Re: Output of git checkout goes to stderr
To: Sayooj Surendran <sayooj.surendran@bigbinary.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000425883061e722d02"

--000000000000425883061e722d02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sayooj Surendran <sayooj.surendran@bigbinary.com> writes:

Hello,

> Hi,
> Noticed that the output of git checkout command is going to stderr
> channel. Is this an intended behaviour?
> git version: 2.45.2
> terminal output:
>
> =E2=9D=AF git checkout -b test > stdout.txt 2> stderr.txt
> =E2=9D=AF cat stdout.txt
> =E2=9D=AF cat stderr.txt
> Switched to a new branch 'test'

Thanks for reporting, this seems to be as expected. Note that all
chatty feedback is routed to stderr in Git.

This is also documented in 'Documentation/CodingGuidelines':

  We make a distinction between a Git command's primary output and
  output which is merely chatty feedback (for instance, status
  messages, running transcript, or progress display), as well as error
  messages. Roughly speaking, a Git command's primary output is that
  which one might want to capture to a file or send down a pipe; its
  chatty output should not interfere with these use-cases.

  As such, primary output should be sent to the standard output stream
  (stdout), and chatty output should be sent to the standard error
  stream (stderr). Examples of commands which produce primary output
  include `git log`, `git show`, and `git branch --list` which generate
  output on the stdout stream.

Thanks,
Karthik

--000000000000425883061e722d02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 319c817fd39cfa4b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb21sY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0ZkQy93TzV5NGZXT0NmTXN3Q2s3TEJZN2RlcDFoTgp0dyt4WEVZcjUy
ZU1LUnN0QjhnUTV1TzM3ZXJoQTRJRzZ0M3ArTEhpeExPcjRxQk84aFNuVXJJLzE3TlYzZkhzClhw
VTh0bWh5TFpKUytIaUNNUGJ4bkM5a1lkWDBRa2xtMUJpUGE2ZjBWZExqaUhadDdGN2l4RVd4SlRn
YVQybVIKTWo4YzJybWFmaXZhajh4NVAxT2ppbjJJM1RDTHdMTjVwQzZoMGVDczB3aVBHWS8wVTcr
WDVFc3JKQVhwMXhrZgpwT3JDNXZoWDlYY0xXeldjTkpGNmJkOU5XMDlnKzFhU1FEUUNVZXJhdVdE
eXdBZ0RMSC8vVlBMSXdoR3J2M3lmClB3dTJwem4vNjBFQlptNC9rcXROODcwWXBPeUpvQVREbFdy
NjNaTFc3K05sdnB6UWhENVpnK3orc1VGYy9rNXcKdnp5clB6SFFiRHFOTDh5Nk9JelFOWUNTeFVV
akhzRmtIWHp1MXZTNlhOeXZpais4ckVBMlRFQnNkV1VySUhNTgp6MElFby9hL2hSMlJUeHdPMTVI
cm9BYVFEbVlPV1Juc3kwbUdVSjAzZXBSYkhmUUJnZ0JuRE5MeGlReS9lYXFqClpBb094akR2ZWJW
OWEwT2lsUDRjMjlLdUEya3Erd0xqYVV0V09NOD0KPXlTTWIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000425883061e722d02--
