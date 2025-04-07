Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD1209692
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042671; cv=none; b=lPrpQR4zKA94pFOLkw19M4h6YwwaU1qxJEdbZe+6krX2dTFtGtsYr30ZbsWj/zC3z2TgEqNNhLbi50bAOoFjh0AAs7j58T2MMn8d+/YPsOlAmO7epmAiF7o9v69Sx1lQb3uiNG7rfRGy+nR6Ip2cJi5qBCICe/6+jIVDtQzQSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042671; c=relaxed/simple;
	bh=nGvU5jdfxCUPe+aFJqGWD1L0unxb+GoJqXV+zfLI7oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSqxafZJaupCTqjgBN2ODIUJP10PoWiB68Gz/gdEgyaQ7URhTJuPvmXXWtWbDYE55D367fX4XZhAuWgNLZd7+tW6hQMa5RQ+QSFtPuo2ufPF18xrjRc41XrZnI1YTxHGzVRhlqRcfbDJ9ht98tvUoZTE9T+K57VnnNvjzdt/EIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c75d727c3aso57863185a.0
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 09:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042668; x=1744647468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbTgvxofBJtlfOKFEkowEXdRSgGEMXgROM6/37ryBiU=;
        b=HGZrWinI0ZRh5lCvTO06YhoA6/0ddLaMSx+27BKkw3l2h0osiNFWWuLr0RRf1HpNLt
         QA7iyBn5nKsgffJFEPv9YgYAIGQMEdtSG1jDdV9FnULJk8SGi/IimGiXX053g+DMHNcZ
         VX75/WR5LFV7wQj9Tx8Ub6DhU5deOEq+3huAhsgwpycqlfyu06tL8+Y0R6RHT89CqxhC
         6F+OL6X9ChDatcsoM9CbbhTBEJtQkcL3hrw/fks7KhfGUDop2wwOnBDh7z/YKe3hYC4X
         VIeINTwLqKf98wKCti/m3d4aH4x3+D4LlqWxi8m28TB+FkNxHtN3qHF0y51FPNaOiQHr
         AtJA==
X-Forwarded-Encrypted: i=1; AJvYcCXgsRQYHXYDyJYDdbAU4UktzD9TSEfBPlLPrK6Ln8vF8X9Sy7ec1UFHSoM9t9wuD+LdkhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHjI34el36WOmBkdoUVeheFdnF9u7OgCX3/0qus423LtXS+Tk
	yTXtZ8sEI6P4rYyPQEHAqDaTil9Ryaks3gmTBspwQefOSTvfQDcfnwGFOHsvMmHSWDNWfdZVapA
	CVHmttkQ2Em1vsk4LYZ6OfXtyUtY=
X-Gm-Gg: ASbGncvAVkqgh0hLfh42JcdHKYcKqsRKD3d72Dym8D+TNtZXA1dMJvEUQCQWzgJJ6gO
	sDcUmyseVEpmROLcRMonvfynSemto0XAXXWfcmeHbTen7zvNOolYZvGEcqtpFw0KSIoz7e8rML3
	Y7ouBQmYHfJsAuHRzjNfMjfek3oqaNtkeYuvnjo4OK8MAy45rVa0DZXs7KklM=
X-Google-Smtp-Source: AGHT+IE5KgkyWCo+6hAnDwmOxcNa8dZ+GS3Wll3E0+fnKe2CxsrGVf6jHuk6+yvGOARscfvMS32DO4j0HNCDeBKbaYg=
X-Received: by 2002:a05:620a:c46:b0:7c0:b81f:7af9 with SMTP id
 af79cd13be357-7c774d27d7fmr735203585a.6.1744042667971; Mon, 07 Apr 2025
 09:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_OEAxJENE_mGkVa@pks.im> <20250407111824.46518-1-anthonywang03@icloud.com>
 <20250407111824.46518-2-anthonywang03@icloud.com>
In-Reply-To: <20250407111824.46518-2-anthonywang03@icloud.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 7 Apr 2025 12:17:35 -0400
X-Gm-Features: ATxdqUEpBvtLK9wEfPSdCiK9JbMZ3rJ8ngNEhsGh9tTK9pciQgsLY1ZHPuOCkPI
Message-ID: <CAPig+cQ78ubvrEDtW0NKPSxtyv8-4GO8+Mxy0cjJKn2Cvwnxjw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v2 1/3] t9811: avoid using pipes to expose exit codes
To: Anthony Wang <anthonywang513@gmail.com>
Cc: ps@pks.im, git@vger.kernel.org, karthik.188@gmail.com, shejialuo@gmail.com, 
	christian.couder@gmail.com, shyamthakkar001@gmail.com, 
	Anthony Wang <anthonywang03@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:18=E2=80=AFAM Anthony Wang <anthonywang513@gmail.c=
om> wrote:
> The exit code of the upstream in a pipe is suppressed
> thus we lose any exit codes of git commands that are piped. In order to
> ensure we pick up the exit code, we can write the output of the git comma=
nd
> to a file, testing the exit codes of both the commands.
> ---

Missing sign-off.

> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import=
.sh
> @@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist=
' '
> -               git tag | grep TAG_F1 &&
> -               git tag | grep -q TAG_F1_1 &&
> -               git tag | grep -q TAG_F1_2 &&
> +               git tag >output &&
> +               grep TAG_F1 output &&
> +               grep -q TAG_F1_1 output &&
> +               grep -q TAG_F1_2 output &&

Since process creation is so expensive on Microsoft Windows, folks on
that platform should also appreciate that this eliminates two git-tag
invocations. Nice.
