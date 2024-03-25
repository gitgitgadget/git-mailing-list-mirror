Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD97CA40
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388742; cv=none; b=eQkAhlQIdbVgyxCkGfIyUoDJ5Vxbw1Qer1NAGqN49p7NFucoMcb0JtKJlaUXcAEQdzBHSEoZi4gyIqfK48pI3bUxY4iYdS8ixsrCGg9cokjPZmcSF3LFrznmK0Hj3a8pItXTrsrd8WJOjk13X+uhnhdtpsc4LqMlUxrvey1Hwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388742; c=relaxed/simple;
	bh=exqfuZ259Lok/XYFcQbRczEbL+JtcQNfYayeVKiDcN0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=JIfxb4mPQzX0S2Bbni03lu8cn23HLGnlF+ZRRFKYswQOEddPDAgYaVsd2DCVvFxxdMnyj+xWvYLiU17dYVwTQ5wDvFAkp6SAjjKAYCSAJkEzLRzGCol6cykEJ9StiuuPxchuO8pcAKtdZev/FhbYQ5wlV9AqyZAVuv44UxeOLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIKZucs+; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIKZucs+"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a49261093cso2302655eaf.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711388739; x=1711993539; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxJ7R/DaHWir6iiLIfODCy40ujDCnI2RU8dSuJXc17w=;
        b=BIKZucs+DJT5BEAfvh0oQABQN2J3j0kLysA/fzC7f4P/cp7rEuzV7KuY428ua6BRMp
         jhZBGlkWVAGp5XVTV0siYw7wTrl8bqxk+aIt1jxVikpBqbF47ekt81jxJn9LbhA2ep3K
         wbBmoHIHmg/sRhn/Hbj78KXaBfcFDRUrDEus/9glfylqxjrV3uVsBXuTPFpcXC5ErKox
         oqfPIavUvqfyRE2tusGBqOK0gwFU0Yg0x+VYpYOVvdG0GMzEFylJFJM9XeQfLRG36itp
         UPzMdbzVx5VyhOB0Kggu6rsLJFbj6mzLqCEnodTzC8aLhkzVUGD53GS+M/qByEAquvRH
         T2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388739; x=1711993539;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxJ7R/DaHWir6iiLIfODCy40ujDCnI2RU8dSuJXc17w=;
        b=Q/vObae1N3dSqAGn3S7cWciMXkg2ixuuPPR4wxD/uA66ATGiD/eT7XQZ+XuoS5d4Me
         XITNomUfxjcyukbZcwjEyJ3vrNtxeqLAasMGscFEbigcPM6GHammS5c5rfc3st6iddmC
         /z8GJVYCvPBdx06bDjBQ+kBe60rL94ymWna1flUAuvV5HRaiLKOb8vO/REyq0WJIoMhk
         bDhACidNljk8z9UjLn52pZX+FcHykQDYnrtiLnlQjxmNduwYbedKxKKBD2zIM/C+knSH
         +89WMHQ4CQ7dbJT6jkQgamY0gXv0eJGkGGIEq6PG0ol99bl4nwGYmKm8JsSP2CM6vd/l
         js4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY4NIwJKJCn59PtzsRa6wB+iE9ST+xZmfVaMVHUWsbNy2n3wozVuKSPRsOaHHdvgYBwEQQA03zHzyDuGlocN3EjDko
X-Gm-Message-State: AOJu0YwRw5OCW8jCPB0s4c2Q6ksXZkYFeT3Repbey7vmayG+ZS695Vk2
	ZfiGhW8HUGe260QLJaba3w/DVU0wwbUZYH7jl4jchX5wagJBBvYAYA6LX2OGY2l4wHNkQ8yR0QA
	BNg/eJQbPsIbhQIaeTRwaBXOAPWviyrsIySk=
X-Google-Smtp-Source: AGHT+IELhO4YwxD1mE/6gW4jhkmR2JD2IH1DHn4c1dZfer8C45o03GlbULeCPQVSB4e9tMiQTYXkK03gz3sRXDcOdjo=
X-Received: by 2002:a05:6871:288e:b0:22a:2446:353f with SMTP id
 bq14-20020a056871288e00b0022a2446353fmr5285534oac.11.1711388739384; Mon, 25
 Mar 2024 10:45:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Mar 2024 10:45:38 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9MzVWg@mail.gmail.com>
References: <CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9MzVWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Mar 2024 10:45:38 -0700
Message-ID: <CAOLa=ZRqkKhqUPjrYQWmLnLAf6Cmt17ZSMJja0rYLNWifUG+og@mail.gmail.com>
Subject: Re: GSoC 2024
To: Aishwarya Narayanan <aishnana.03@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e2537306147fbd82"

--000000000000e2537306147fbd82
Content-Type: text/plain; charset="UTF-8"

Aishwarya Narayanan <aishnana.03@gmail.com> writes:

Hello,

> Dear Git Organization,
>
> I hope this email finds you well. I am reaching out regarding a
> Request for Assistance with Microproject aimed at improving the
> integration test scripts in the Git project by avoiding the
> suppression of Git exit codes. As a beginner, I would greatly
> appreciate your guidance on how to approach this task effectively.
>

Thanks for your interest and reaching out.

> Here's a breakdown of the microproject and how I plan to tackle it as
> a beginner:
>
> Understanding the Problem:
>
> The Git project utilizes Shell scripts for integration testing to
> ensure software stability.
> It's crucial to avoid suppressing the exit codes of Git commands in
> these scripts, as it may lead to errors going unnoticed.
>

Correct.

> Identifying Problematic Patterns:
>
> I will examine the integration test scripts located in the t directory
> of the Git project.
> Specifically, I will search for instances where Git commands are piped
> into other commands, or where command substitution is used with Git
> commands.
>

The goal of the microproject is to help you get started with
contributing to the Git codebase. As such, it is recommended that you
focus on finding and fixing a single instance only.

> Learning from Examples:
>
> I will refer to the provided examples of bad and good practices to
> understand what to look for and how to correct it.
> Understanding why certain practices are bad and others are good will
> help me grasp the underlying concepts better.
>
> Applying Correct Practices:
>
> When I identify instances of suppressed exit codes, I will modify the
> scripts to adhere to the good practices outlined.
> This may involve replacing problematic commands with alternatives that
> properly handle Git exit codes.
>

I would also recommend reading the following documents:
- Documentation/SubmittingPatches
- Documentation/MyFirstContribution.txt

> Validation and Documentation:
>
> After making modifications, I will ensure that the scripts still
> function correctly by running the affected integration tests.
> I will document the changes made and provide explanations for why
> certain commands were modified. This documentation will aid in
> understanding the improvements made to the test suite.
>
> Seeking Feedback:
>
> Once the changes are implemented, I will seek feedback from mentors or
> collaborators to ensure that the modifications are in line with
> project standards.
>
> I would greatly appreciate any insights or advice you can offer to
> help me navigate through this microproject effectively. Additionally,
> if you could provide guidance on where to find another test script
> similar to the one referenced in commit c6f44e1da5, it would be
> immensely helpful.
>

Well, you could use a regex search to find some of them. This one is for
finding tests with pipes used, but do note that you could get false
positives here too:

    grep -Er "git .* \|" t/

>
> Thank you very much for your time and assistance. I look forward to
> your guidance.
>
> Best regards,
> Aishwarya Narayanan

Wish you luck!

- Karthik

--000000000000e2537306147fbd82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 333559825546821b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZQnVFQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFNpREFDWlFlVGFSVkVsU0VlYTNPcWhKT1c0TE5FVQpHMVh2MUhab3Fu
V2pKc3dhMnNJdnlXSm5EL3FrNXNpU2dBeTFlSjdQVWVrNWFOUUFjOUxUOEVOazV2c05pUCtoCnZZ
ZUw3K0xiSjFTMms1Y2FoSWtrUVFJdU5SeVVWRUlxYUhlSG0xMmtMbGhSa05jVFdLaDVhWVVFTmdE
bmQrZHYKU3oxKzZYRkVWeUNheSsyRjJDdTJNMGtCUUJ4MERyRWIvK0M5a3NXc2pyR3ZVc3c5amJq
ZkhxdDBxNGFIalh2MQpoM3JzU2o3dWIyS2t2Z2pWZDlMVXdrcmtYcUxsR1hscWMza3BaaDFFNEha
MEh1QXNEUGdLNjNwTnN6anBiZTNHCmlnSnk1bFBzODRvVFlES1NJT1FFdk8rT1cySWhSZDYxSGY5
OHNMeVBHU1hrQmI3Slo0Tksya0VleEdnWmtWMTkKVzVxMndBVmhpZE5tK2dRazRzRE1yd0dGS1Bo
U0lFZVpQdWFTa0Y4VUlEM2xlcXBsTUNQai9NY2Y2N0d4STVzcwpFakdpK29YbTdKTVZRUVhhdVgx
Ykc0anY1K1RpVXM3Yk13RGNWQ29CU0FtZjNzUjB6bjhCelJHamF6NEdQVnFWCkUwRzQwUUpHUDVP
NUM0ek5IZzFjaDVPNjdqblhsbC93TDNlby90ND0KPWtyT2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e2537306147fbd82--
