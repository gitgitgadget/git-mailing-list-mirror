Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29432F3608
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045430; cv=none; b=pCbDp0dkWU9V3m/0RJGoFQSYUqPS0x4X4hfWjM1fnypze5y3LQLvDHFwipl7/o4be3b2q14mQaguobqs60zzwBP3m4/1U6isTar6vs4fI/7Fm0Fj0IzZx/Orl/CaLUp4UlVeSt/5BRCTgH3V7oTXbYkKlvPb97NLtZo/U7BYsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045430; c=relaxed/simple;
	bh=LbEz5c7FY4R+fbWG74pb7D3r3cWsYMtoF8gFI5nEle4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTFu8gbQI1JJJgnH/MLAg39yumY8UoPT9JcLFNz0/a7ZhCUGTiXG3EJvr15hrNTUs/zcZj2zdeM9FmfuqiVI8HggC6fxtp7tg3C4jyhYa8cJC/s+E6Gks84RzeamMrj3Tq2Y9JrCkW4j4ZYNvp7fPaVQj+5zs2Di/IDX4dzutGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy2b/7YZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy2b/7YZ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-591ec7af7a1so645340e87.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761045427; x=1761650227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbEz5c7FY4R+fbWG74pb7D3r3cWsYMtoF8gFI5nEle4=;
        b=Iy2b/7YZqU507E9RxVIV19LSEdiaqFt1iDjkbwap5B/suVvL6LLpq0IpgUkqwjhLB8
         //lrxVldzl0gFDAwMDzUeshLkZt1kxUseONlzoiZX2hOqFIhpgpaC1/6cM74Z4xOYYxt
         LpxbiIQl5wR8vnkKJlyzMmAOGmxJRBlYubICn89lQcrx0y3NLI7KuUtLfBhRuUa2vNkh
         wdsIjI53eRZuDlG/QHdMJfmnmoqiW2qixjHPEoI163+fqHSoXjQ2+KJ+zmC8yJBIDt1+
         sy9f4NcCCC7eVLX33Oqnob6GiL4egv7N2ALrBo5pOXZJuYZ7COgJob6qs4aWu7TA6XhE
         AZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761045427; x=1761650227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbEz5c7FY4R+fbWG74pb7D3r3cWsYMtoF8gFI5nEle4=;
        b=CAY6DcSIKuQUHt1zR+imQ72PEHvVYs0I1EsVMtN6iJOupB92vt5AeAjr4y+plMxKXx
         CXnkfoI2kDLrc4cnX+lYNrGVYBFoeutzHUdqTmUc8ZUx8sbUlhMM2kidtgLyyj4MC1Zw
         /8Sd/I5f1Xz7QuNncCBC5pAZwXHM6ASjLPSHgNCgMbPYpca/+M38dcwRzl6VmHZ0jmsx
         xbM5+bg0QFI3X1Ea4+50QqI1YUYscfWw3dA/hBDTU2NpFSP6A5tMxm9eMij8TJQsIRFZ
         bAonlTcneBWnxkPxiqNAJxGK40ir6YF3lJ/Mc4YaGYDZgR0iUgwg8yXnkJbSjrj7LP2J
         gl8g==
X-Forwarded-Encrypted: i=1; AJvYcCUuAS05jDb5xvMfUgCzREfYyzFDIBfUNpxsh3WZ79m7cClZVtiCzvxKRFOpjCKgG1028HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNve3g7h1EC10HlqKLfg2ixtkgPwb8VR45xb67m7zHTiOQwQUA
	zNA5QTNNO1hKyhxsB0M0FvyPusqTkq0YI+xeXaG2ncnGQLRYJohc1+nnoxb1XZwxBV2/Gg9ilDk
	XgocNLhXcUF6geMgbJavAyRXDwP1TONc=
X-Gm-Gg: ASbGncsCzBgxRF/CWvBDv6mniSKKhvjZzIJVbaMn8UtQQpHiNkP+OSoPwFeOLi3KU+D
	qwFczYyA9pY7SpP97LmHIy2zjzyEAiePORol0WFmqAwv1pIBdb5XT6UXJKkxCQNtuolpDyB5P8z
	7zCMq5+ihENUPjwc3vh5pQ5nJI/b4igmytLLjN76K7jKrwey0zque5HI56de4fk4vtu0cWE7oHa
	+nA/+Rm5zqgHTGOrpbP0moUWuyA1w81KHbLXcrAwvcIG99SGarXPMlKMrrdAw==
X-Google-Smtp-Source: AGHT+IHVSfOeu1nXNi3vq4/RhtHy1KXpCEnXljovUaXaswwYCf+vPKK44dnz7hyq9ga3LtL9nF82FNhWR2cYIuJTK94=
X-Received: by 2002:a05:6512:220c:b0:590:7abc:5ef5 with SMTP id
 2adb3069b0e04-591d851909dmr4668328e87.25.1761045426733; Tue, 21 Oct 2025
 04:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
 <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com> <a0711cfe-6e44-44d6-b66b-84a296e113d2@gmail.com>
In-Reply-To: <a0711cfe-6e44-44d6-b66b-84a296e113d2@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 21 Oct 2025 04:16:53 -0700
X-Gm-Features: AS18NWCm2s64_VpvUwCKf0YZ_lgj0KXnuypm0JfrSs5G1XAm-TdTMrMLJ3cOe30
Message-ID: <CAPx1Gvdd4KW=P=0te6ZeBXJPSp8NgyXnrEnJLb5g1uLcjNYnXQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:04=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
...
> uint64_t. How much more memory do we end up using by adding second hash
> member to the struct?

As in any string-to-string algorithm of this sort, there's one per "symbol"=
,
but in this case a "symbol" is a line in a file. So if files are M and N li=
nes
long, there are M+N symbols. Take the difference of the size of the two
records and multiply by this.

Assuming "sane" input file sizes (under a million lines each) it's a few
megabytes maximum...

Chris
