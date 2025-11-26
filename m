Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE734A76E
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178712; cv=none; b=Ao/Ea/PWI5ZEcOp7wQ7xWE/fvZ1UmBqgGi2mJvF5IlM3M16FVkUXmdLjPRSmIt/r5gzo8HxWgwEa76LbPRVsBMhUxR7cWkEEWzdjdGdDZ3kkpRKtrMDBGSEhFLcXt8b1iHcHGWJmDSak9CBxLZ3MnHtO3cmsz3LvheII7iPHx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178712; c=relaxed/simple;
	bh=gM6W35RWnDMd+/b72NNcQf8KkFEoZGC+ZVqbHK7KBnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcCRKo7+P1rpAOtiweyxaBXcwwQYPu4IZiJHNirZ44led0JBhPkoPF0HPtTV9KtNuJmee9ARNcrMZHQNTTyOhTM4+t1FbLXbdZQip8/w6T0sZjr7+kdVD4+fi1AKOQUn7y04W7BMuLPvP4FRo4wU+oUS9Tt/qi1K8MG83vE6HF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2e0a2ffdaso18785a.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 09:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764178709; x=1764783509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gM6W35RWnDMd+/b72NNcQf8KkFEoZGC+ZVqbHK7KBnI=;
        b=bwPytTnU36zUXFxVSg7V2owUbPnGM5nFBxx2kyFwpk9yeovCqfAL+PUuiPs2kiLZmb
         0tf9TI6lURZUrna9FrcqobNU/rIfvDYtxO7HrApUHKlzrKGddxaBXak5BStJmB+UN6CZ
         8ckycp+No1Lps+B6o0sWK5mElTf/AX1R2QTGzyryI7RzWRn0+lJjCLLSpJNjwzNLUxX5
         chc+dEQliTSp1KQKWS10EfZ8nJUNNDsMlOu8KyYkPv17K57teFhTmJiBWFosFhvGLXQt
         EKd+JOjMI8VFW4dZjk2cfwnmtlhHFVQyTXB5LPeJjTnx+7qNdr8p6QE+4gkGnUanwa3L
         0DDg==
X-Gm-Message-State: AOJu0YzeEPDuIOpIm50twErG4Yl1kW4lC2sOydx/f7RZS6+plh/WR4+q
	sJS4vAT7ndX2YHZRGSLL8w/aMMV9iKhAZk5wvgeTaMheqlz25Xizhbk3MeK3363tZiNPPWfzUE6
	AN5gCNP34hN4JfnNlvjR2j4qzrkiNNNKQkY34
X-Gm-Gg: ASbGnctG7qnQA3mTY8DqAU+SKdwBi2LuIHr4735M9C62/7MZnE2ioUrYl6TbCKZVyUx
	G5Jg6yEeaCmRuW+hmtYrELqKaUy/4Uo/CoanWlg6AM1kesixN45HTO00N2N7UDdeO6ucM2IfBmr
	FuJITe73sZtLfTg7ydftIjjc15HOylGf2EQlyfA4IR2z/wedcN/xYV4qOyg3N5P/fppy0sHReIL
	lxX4puo5g2ZIqipxIQ+wK1Ao1d0R1RqBiSsVabHbDonlc/hYQHV3YvCZg17ki4sEwOjan2mC14i
	/zMhHQ9a46p5myLuo+trFThcXsXe
X-Google-Smtp-Source: AGHT+IHzvtZ+lnC51sf8/gEHE6937ipOB5OdAF3bO62yyV+hJTK2KWU/NLJmQOMY8lkFU3YBJZRpkhibHk79VNq/mbg=
X-Received: by 2002:a05:620a:472a:b0:8b2:9aba:e884 with SMTP id
 af79cd13be357-8b33d27431fmr1906296985a.6.1764178709055; Wed, 26 Nov 2025
 09:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com> <20251126-toon-last-modified-zzzz-v1-3-608350df0caa@iotcl.com>
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-3-608350df0caa@iotcl.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 26 Nov 2025 12:38:18 -0500
X-Gm-Features: AWmQ_bmFBEK3NZ8BlPbdoor0muKhA0w4Gnmh4UWX1WowU9W-0qiCihC9WF72MDQ
Message-ID: <CAPig+cTueuZZ-_51Eje3MMgtvvuDBzv-9yRU2xBfJQUaU-vFJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] last-modified: better document how depth in handled
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:10=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
> last-modified: better document how depth in handled

s/in/is/

> By default git-last-modified(1) only shows information about paths at
> the root level. This can be confusing. Clarify the command's behavior in
> the documentation.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
