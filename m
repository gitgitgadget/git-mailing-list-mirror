Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2A3C9ED0
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162937; cv=pass; b=MmkLkbnSOigaHVPPAI5svhbZ3kO1BxTITLfLYqfgH9hxeDQLmLJ6sl13UbpiaouloE/TBKPSUb9bEfOQFADOMRc8ojSi7JTCkvCpmw6jx2nvpJyKu7U/s4qTFKON4kj8jU48JPA+FMw8/hGqecO+1tyU278eXcNj4sLOQLEZbm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162937; c=relaxed/simple;
	bh=Fio6VefbVVe7z3AJOfRy0y3NbI1+6h6pvyxLLgEqTsY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KP5B9SmdG6NnRddhTnaZdPLyAzHc+nH7k1WYUOm5EL3fmgZi+jTspIZYAXr77EdQ1dXP/CC9GO4OwTOW2KXj4MrUmuOD31beBVZ4p8Kh3WNKpJpuFtFWTXhmUOBzuq74T2z3kHtGxifgyiGWz1/b2E+sVVh+yD44XODwDlQuimo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFX0ymxM; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFX0ymxM"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so7883997241.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773162935; cv=none;
        d=google.com; s=arc-20240605;
        b=FuH7QoE12kLB3fndGKcMYzN/YIRx4+ZvWxXTLeQwmI47tN+h6d2bcZvwbGM5sRaMdz
         gglRxlydj92Q+akhifGFE0zUSpzcvRm7OHeksJk/IGEwulC2aHXT4uP/vx8yejg5Z6WG
         C8O2cnCS+AsuNrafkvO7iPTk+8uSglJ8xgAtgYumXmxjE6FRY8ObFRTN6RQ5OIjEIVyG
         a+dOsYKUsFIRNnR79v33dUt8VENYIZF0QQVyNL+wZ2Cwo/YNHSVzi15C9wEK11aDkMzS
         psevoEaGSN4oGTMkWC9TPlNcMXokLDZ9wAW0GHhQeyBu/n8UgumQhkUVVXZM6Kr0IvpW
         aYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Fio6VefbVVe7z3AJOfRy0y3NbI1+6h6pvyxLLgEqTsY=;
        fh=FdiNIin9jUuA/H1sQg+HxU820reYxyiHtxczopsMEC0=;
        b=Z41g49YoOMBmLTize6M2AbgeH78R45FA3YMREIRnd+NJLw8qwZY1E2utz5Py9wiK0M
         fOCcedqeA13zu4GSh1QzzT2JnpMeoGJbJuhwG96ZJ9hmL2Ibd+ZuklqXT1HvLPY2MgtV
         14KrOkK/hS/HE4e4fa/R8TsE8r5J7KFhsKXgs4T8tJJaQ63SZWBNYnvRjBwUPLERgymV
         1qYjSaR2Z1b7rCvauaACFHDj5Qx7iGBAkJOiBbpCsxgylHl0k06WP2c/+y51dlJxVIVV
         xBopiPczYy9eNs27Q0MoImHpd0NBNsy64LPz7+D5JWWRZbDIoBYlCuawk/ZBSX4aJ2rR
         qm3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162935; x=1773767735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fio6VefbVVe7z3AJOfRy0y3NbI1+6h6pvyxLLgEqTsY=;
        b=AFX0ymxM1wrUGGZfCa9PHHV7rg3eG6x0EtepL0EA35n8+9ZqEfrOkgIr9UbOFSCWxW
         ZoBsEyAYOhsP17WMO/HOK14XPzg0eIHwJlvGSuPT2zbD8V19Znfs2JkURcpF1H0S43Om
         oTdBjEd0NqgX7fzCKCYVXRGNDv3i5NqU2PcU/DzoMK0WRllvT7Gqp0lLNS+mhikSBYLu
         ecbNJa3pf/OiOIPojLKTnicFOHTj9Ocdea2aEHeVMwdi1MmWB+7BT6fK5gWx5Eat1hLk
         euPYzLAh8DVH7lx1hf72EafuE3QCdJt60DXWy4ZwNsXWCEpcibQ9n7oDxb9fDlPPAtii
         Q1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162935; x=1773767735;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fio6VefbVVe7z3AJOfRy0y3NbI1+6h6pvyxLLgEqTsY=;
        b=pHtFEaE3LlSTtdzI48+CUGsb9w6SE2ijYPhfkGVaGlmuueobcd6tcW4vzBSvJzXKYq
         UsPYBa9CIOWY3Mxjblh9NYlEoHI0uSELjeJnzENUIPYDzEHy9KDQi/XblZosLSf0yToA
         Eehuzss/Nhav4ocYs5x27l31NVripWBYqHz1fH5xEDFc/a6ANnBeXjoDl3O0sLoFYFyu
         HU8dNDRSuCnNKitzUToPudWKvAjJcpm0kSD/wrgowxVnuasN2IQ9ss/myY8kE9A+NhUb
         kuozI2WVKzCnFKGDySHkeLmv5InKJV8u9DBil8hslc2Tq7AH/YYseWRas6C7++BeiSIU
         35hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNjaWP+aDkzUH0rjhnM77m1qgwg7ZqtANyHmrxci86v/+wc+c34V+YR/WyQrQ0n4sanvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEVZs7mYHmXk2dg1hCQSy/JZVmQfJKJ9lfX9aOvIia9jUsjyV
	4j52/Lb81LlkpsQBD2hVGdjsyFOYPtHoWbEGesJHLwg7U3xRXUJIZawhqHb+pXrISauVdQ2AzNs
	cU7QIh+NaZxe7FCZsbzTZKpVfmGhgklU=
X-Gm-Gg: ATEYQzyhY//eyMnIOgWzT29fzDAcwnmgHQHoHLJigQ+Y8p46ld08WGpv0ngqHXQpgb8
	NCMC64YuJFqeas11mQk9Iih/aLntZM6tAA0ex5yZYuzIWBNw0X4gJB4zrdpMFjC733lB3dk66Uv
	G5euwMQpCFidYJTQMZuPo/l2Iwjm5f56PiMwvj6WU7qLeyqBxRHdU8ne+hiNG4tlJr0jWIs2QK3
	Fpb1HdeMFlhLa/+A5XsyOUJB3gd6vGlUK2iLoorIhPCK6NMPOu62S59od4/ivJpuzV7LD/xfLqu
	SD0vm4R1nELovGF1rZJQcXKg5JZFg03Igwt679Wf4fy4e3ql2o3t
X-Received: by 2002:a05:6102:1656:b0:5ff:fa7e:396 with SMTP id
 ada2fe7eead31-5fffa7e0b99mr4080982137.37.1773162933253; Tue, 10 Mar 2026
 10:15:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 10:15:32 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 10:15:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOAgETOcivRUskCi4PCLnXzn1qGs9jx39JzgBA0jE=CirSkZJQ@mail.gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
 <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com> <CAOAgETOcivRUskCi4PCLnXzn1qGs9jx39JzgBA0jE=CirSkZJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 10:15:31 -0700
X-Gm-Features: AaiRm51jOSZf-nGDKFWrYLrC_Ad5WN5nZAsFhqZ9rspD0l_6WKKuYpBeeAyEUmQ
Message-ID: <CAOLa=ZRRFWyvX7fSar8R1WYOQOz+mz_c_S9ZM7CDe9v7bbQeQQ@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c41403064caeaa6c"

--000000000000c41403064caeaa6c
Content-Type: text/plain; charset="UTF-8"

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
> branch switches
>
> Patrick Steinhardt <ps@pks.im> writes:
>
>> It is used in "add.c", but not magically so. The function that you have
>> introduced is the only site that uses the new advice, but the function
>> is never called as far as I can see. So ultimately, the proposed change
>> does not have any effect on the user-observable behaviour.
>
> Thank you for the correction and for the bottom-posting reminder.
>
> You are right. The function advise_on_checkout_dirty_files() is defined
> but never called anywhere, so the patch has no user-observable effect.
> I also looked into the existing behaviour more carefully and found that
> unpack-trees.c already handles this case and prints a message telling
> the user to commit or stash their changes before switching branches.
>
> So the patch as written is both incomplete and duplicates existing
> behaviour. I will rework it in v3 to instead enhance the existing
> message in unpack-trees.c to also mention 'git checkout -m' for users
> who want to carry their local changes over to the new branch.
>

I must say that the patch itself and the responses seem like they're
generated with LLMs. Our guidelines for AI usage within the Git project
are laid out in 'Documentation/SubmittingPatches'.

For GSoC specifically, we have laid out our expectations here [1].
Please go through them.

[1]: https://git.github.io/General-Application-Information/

[snip]

--000000000000c41403064caeaa6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ee62449f9e48ee21_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td1ViSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1ZJQy85SXJ4Y3J6NTcxRWM2dHdBMkthaUdQbThQUgo3cVNTRHNBV2VB
bElOSUxzVG92Y043R0RpenhIM2xldVhYdlhSZ25pRUY1OEdpZnhRaEViaTlVVEliTTJGcWI2CnBk
Z2FJNEV3L24vclM3dVhBdFM3V0hZdGFjTjI5SUs5R3FGNzhTNDg0ZEZGQXhNMXlVay9RdVJZdHUz
aWtRKzkKTERZMC9aalUrSUx6ZXZSYy9HcnpGb0hhRW9jRDBZSmVwUXF6c0JDUGpXWTgvcnRrNFhl
M296YmE3Y2JSNFhlbApJMDR3QjVwU2U1NVRoSm5ZTlFqSklySVA3K3dzeEl6OW5rZEE0c0U2R1dC
MzB6d3ZOMUh5cnBFanpUS21oaGhiCnlFVTZsZWMrWDJLWkFFVUVwMGtLb3dBcmR4dGRYUWhUT09J
a3pkQXJNVVRNeWtpRVdZTmxCZm8ybGhSM2VDQ0EKcXR1bGZHaDc1N0RvcEp1c2JzVWlKcytPMng0
dk9TMUt6dE1SUnk1WW1uSkRPYlNCVjlKMW1LNkdwOU4yL2lmawpRdXIydjExcnpjcG45dUhhUUxs
Z1hyQmJtODkwNlVDdGhvbFRla1haSWxMb0JpSDEva0lXc0htUW5JdlVqRzBxCjJ5dHpFNVFRckt2
TjczVDBiaWdtR0NkaG5zc2hnSDRnRHJwRFN1UT0KPXk1VHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c41403064caeaa6c--
