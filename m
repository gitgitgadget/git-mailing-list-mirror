Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A81FC4
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085198; cv=none; b=EccdLkBBLfd/EocYzjufgIyCjFF5K/9JwYGQ+1Sk9vLSlwcPG//2CRMWHjV8+YLvF8bRmI7X3xjwfJqxw7Q1D3+IzWQo8yIOuY+a31DyhCKEOSN/cOTFFb48a+u+h8067Y9s9eI46U5ilMIwe2gQaktDNIqnnCK2qCP2CGHjTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085198; c=relaxed/simple;
	bh=uAP/PUNB5+lXLTasTNG2rrOamoCdb5A4gSr5QA50phg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkRjakhyS5xkoF2jDDmSZLWq6EDUM9KpDv3xlOXV110rHU0Hxl4gjasPckC0JLpD2+beE1bamtgKhgvZkyKT9OwMsRrsOB+pumfrAEKxuTdvXkDYakkc0GXiw5jGINzj0yvP8G8Z96V4nHC7RwwxXkDZKfqWEsgpz0qtAsx0wFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUZSMq/k; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUZSMq/k"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51318531af4so339623e87.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 17:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709085195; x=1709689995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUJRtLTXVhzfV5qaOFU5PyQTXdHRhSvw3CMpZP+G1Fk=;
        b=NUZSMq/kWYA/EtwRIaF6oWbVdrB5aXpIrBSHcbQGRt6GsTxxVRIULSMNZXFSsv46dN
         wtwS936xHdh/OsoN56dOp4lRRI60HDojgj0cPLwaI9IXdHCr8LdGbBDXDEG7O2p03Kiu
         c3BlZzccKZ/a7SH6ubpnQNSjJTUKDKChECWYAd6hEQBxc8aDiSkBCNMvddLzvYGnO3x+
         oyqFLmKu/LerzvB90RBejNidkKjdDhbyEQ4guzeobicGLATJsS3NDTf0MjSTcLLj33pc
         3qKybBmUDCFlbSc2yhhGvZJO/m/W3UAuQ7FY7NJAn+54xo7F0l+2d/YUiUd9JKLalt1P
         ai5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709085195; x=1709689995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUJRtLTXVhzfV5qaOFU5PyQTXdHRhSvw3CMpZP+G1Fk=;
        b=cyzrThVxUF2X56Hy+XTncuHJqRPbbpgDT03TP4HOYGBYes0Ep+qSxojvY/3IMfkddb
         8F/tE828ayxQNCDT1fdVhWLdujNUXaUXWIf8f7xSHOZdy0vbfCo/9DNnpXLJijDQQmfA
         hAHCTftpAQd0VobYydVz1IBhlEwee9PV1BPgTut8NRkLhhzXn5rwCRwn4myr/d72QWcf
         C6YKbs7Ybjo3q9I4+3EDsESnxfZOwttWhlv5oddoqen5Aq6dfGs3QZvBlx/NVZwbulbm
         U8cb7UFXaUvd5PAXt09t4uE/6rZZPpG8M1zjrQQ6TZyHvmBdztcG9mQJ7aqdp9g6rMh7
         5xGA==
X-Forwarded-Encrypted: i=1; AJvYcCWlmT771ZOlHvY64fdu7rGSPdD2uFv5w186/cYRLjZFAtgFG6dDY1XSWaz/VKGRQsjlGDDb/Qqj0ZdFiqDzj7v0uS3r
X-Gm-Message-State: AOJu0Yzz3yYb9byVEpb/D45MWzRcLINTn+3D7daLSrbJbOZPmv9gcOLb
	4ZFwvx1+a55XgtEhI6rf6YJqs2oqNDbMPEvtbFrXbV+/4oDsseQOw/X2V9ikEBF7+l/P5Un2aPk
	Na+BbDWMheA+7UuTwIt9S5rJuq0o=
X-Google-Smtp-Source: AGHT+IGXCLwwjCVhO50m6gpQc3QpDICoVKHsZeNfe0becXl1LZlflOv2Z2L7xxUPNj3lp92n3cT/H2krIAGj/rXLpZs=
X-Received: by 2002:ac2:4c92:0:b0:513:1957:d011 with SMTP id
 d18-20020ac24c92000000b005131957d011mr254009lfl.5.1709085195046; Tue, 27 Feb
 2024 17:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
 <c071e44c52171b9b19a04d91666be48d762d19bf.1708072576.git.ps@pks.im> <xmqqttm8i8hb.fsf@gitster.g>
In-Reply-To: <xmqqttm8i8hb.fsf@gitster.g>
From: David Aguilar <davvid@gmail.com>
Date: Tue, 27 Feb 2024 17:52:38 -0800
Message-ID: <CAJDDKr5+3jszG=psh=kUGDjNCeTDGPSS-qDuN=JAq-3ua=bNDg@mail.gmail.com>
Subject: Re: [PATCH] git-difftool--helper: honor `--trust-exit-code` with `--dir-diff`
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	=?UTF-8?B?SmVhbi1Sw6lteSBGYWxsZXJp?= <jr.falleri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:12=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > The `--trust-exit-code` option for git-diff-tool(1) was introduced via
> > 2b52123fcf (difftool: add support for --trust-exit-code, 2014-10-26).
> > When set, it makes us return the exit code of the invoked diff tool whe=
n
> > diffing multiple files. This patch didn't change the code path where
> > `--dir-diff` was passed because we already returned the exit code of th=
e
> > diff tool unconditionally in that case.
> >
> > This was changed a month later via c41d3fedd8 (difftool--helper: add
> > explicit exit statement, 2014-11-20), where an explicit `exit 0` was
> > added to the end of git-difftool--helper.sh. While the stated intent of
> > that commit was merely a cleanup, it had the consequence that we now
> > to ignore the exit code of the diff tool when `--dir-diff` was set. Thi=
s
> > change in behaviour is thus very likely an unintended side effect of
> > this patch.
> >
> > Now there are two ways to fix this:
> >
> >   - We can either restore the original behaviour, which unconditionally
> >     returned the exit code of the diffing tool when `--dir-diff` is
> >     passed.
> >
> >   - Or we can make the `--dir-diff` case respect the `--trust-exit-code=
`
> >     flag.
> >
> > The fact that we have been ignoring exit codes for 7 years by now makes
> > me rather lean towards the latter option. Furthermore, respecting the
> > flag in one case but not the other would needlessly make the user
> > interface more complex.
> >
> > Fix the bug so that we also honor `--trust-exit-code` for dir diffs and
> > adjust the documentation accordingly.
> >
> > Reported-by: Jean-R=C3=A9my Falleri <jr.falleri@gmail.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
>
> Sounds sensible.
>
> The last time David was on list seems to be in April 2023; just in
> case let's CC him for an Ack (or something else).

Thanks! I'm still lurking around.
I've been meaning to make some Git-adjacent announcements and
contributions soon..

Until then:

Acked-by: David Aguilar <davvid@gmail.com>
--=20
David
