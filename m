Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793379216;
	b=4UQHq0+YT67JvUmydeLTeUhIlKQb/jAzOytKtTmqfKbgZoLApCOwvBf0/hByWzZdgHU0
	 VKd+w6MZy+UNR4ULw4cVJ3p85V193SLfBlUnRgBSRBwR8RZjiq1XrcA2mJqBv+k6op1Pd
	 s2eqGp4uAqsG9YAFy7DLLhzaGdgLpUlft2J8nRYtgGgNW/kwvJ9VOOVnALSk3L1fDHDKN
	 WVhG8KIRTav2S/OfruZA7fjcTROZgsM+1EE+4uS2eNnihWcBuxhtfYQ2yRypuN6Cn+oOu
	 MkhCVuIdySlBcxD8RPeX+2JnzP7NBOMGkwVOgS6xwSLVUnFACCLOnxDag6gxtXCB+Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=H6SBINXIlFWhQpkTo6PT3DA0GoN2Nkj7JwlLLx60A9o=;
	b=TZ2SgL732J7rNeHIjTFWCE+QGfl3vkWz4wV96jrG13MtqXG50nEBLKM0iRnERrjTh/4O
	 WFj80ViCn+Xc4JMLoZOLnEqKH+GiG9HwFljsF259btQgN7rl5GOCnK0+Pq9ZSjKnT7wJg
	 w3/STEbSQYXzA7YDGjRaVyJpVlo/5oINfO7UgT4J8/I8vxNYSz7g9Om6fxHhf+1StbqWF
	 QiWFdqkdQJC22KiggB5o6bxz9HSXjxHgsoQW9tes4xDqwaX4XZzuEFr+69Xd/gtTFcLnD
	 PBS0btL9r/YJTqDUXbfvTJkT0RLIG3zmFWv1yydF4mt+mwYLLW3WCehQQg/KgX8SyOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UfEAEHMi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444DD606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 444DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UfEAEHMi
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5337c7b9937so375651cf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793379215; cv=none;
        d=google.com; s=arc-20260327;
        b=Nhr2rRjtu4I0vJvdfSviK8tb0Y8j8ja4o/OhuBWA6N7Rrcp/tIIAUxzqiHAiJfrIUV
         kBSp4Z6z85BIib6C0OQGRICvVhBnaYlWQ2FUJZ1Jl9Pk+xl93yFC0ArKu58gMltOv7+c
         21XlSoxyZ1sUbxnuYP2ELxgeKuaXZKzS5KltveW/oo9dVq674qDzULODiddYLGRaiAIC
         hHFbGAUOBsbwmt+mCSYkbi0yV6tHr4mKNrOZrsfKJqg/vSbmkRJrCUwUEUSfBaPBfnKb
         WY6W8EiMHErGolLwoO5GHpymtYZAtLIm6nlY5tE9TVnVaK2cqT9/DRoqvH4O/raKZk6Q
         Z1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H6SBINXIlFWhQpkTo6PT3DA0GoN2Nkj7JwlLLx60A9o=;
        fh=pg46pIlhEyxPcQkwUKMJmUvrALZyFHjefyjnUMZr95w=;
        b=VOErQ5OONE9aqCEDsCuJ+9pkiO3vluAXCJU0VozeV57SHoJ3zfXuRKBdJZaodR3yF4
         bJt/IQxWdWH6At7OY3yzUdQGE4fqkqedf401f1T+5dDLGYL7tSC578R/np/g4Q23+//e
         IPLlUxvYc5LiUjX8Bpc1xrSRYXH7oXYsbio6De8xheeutgH2+CVj3aaRlMeOsOXt2xt2
         pciTyHE20P+RDRc3NWouybnyOjMe5U7HoiO+T0WsI+yRRkOqaiGzGLF8G6NCXCeJWevT
         DzRPFcWx/zeWLtwnhfpHdUlXf9oTaERvoOteHaoQ/9d1sJALbIJGwnBmDon9jwnqg3R1
         YL4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793379215; x=1793984015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H6SBINXIlFWhQpkTo6PT3DA0GoN2Nkj7JwlLLx60A9o=;
        b=UfEAEHMipeQMXmekgKIuf96Rb9iJ3RuGKLvYlcwq6bbViMBqHQ+YKlV8CFK7HVoXyG
         x+T3q9t+L3l0rN8yX+fvWbjh5dum+P3utG5brpxToy/8+0IKA7na7jyN0lnrm7K+towr
         veM9EopVoctEGS48bNrusZzO/vqwLUKeZ5kvdfBQ+I44JMfMr5XlUjV0XIuJ9LgYl/rd
         rVR/t/2An3hdiUCQwmvrgGDcF1LHGh3CHdnQYfyQlnlfd61Z/0xVJBE4xUvGo6mAUaMZ
         3nWqSLWX8zf/YZrpIAE5hz/2Erf93y161ALFjoh+idxoQNFaOOQEMBZLB4L+oSkc6W01
         hBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379215; x=1793984015;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6SBINXIlFWhQpkTo6PT3DA0GoN2Nkj7JwlLLx60A9o=;
        b=DhAMipeJkq5eDnb/mXWKTcXPhL1c45UxxSxtjOAC1mLju5hpslxuTf9s9KdKeJM57W
         CS6Ze2ABO/x5fBVU+aVEZsN5ihPjkzoz/DflO0ngfI5PW6TJPKrcCwMS7c0/v1cqU0/F
         yEKTvIfLebdwVc9SEjyITp8nRhnafjx6/aS92LVk77/NGO/PK6ex8QjIpZkrTyYW9SCW
         q6gIOjT1j65ceIRH7D+NJZ4O0HbVRQ2eUKsMZcbmxye5zg//CHqyqxWFY0b9lf9fNoyS
         UyD7nc1J+8UJf1t6b6sOLQbslvAEAqo54OnkLjmTbkDBwMjHzc6otHtJ4upQqSokTSJX
         SikA==
X-Forwarded-Encrypted: i=1; AKwUvBzgDQiyz3CcMMxLBFaQD3zCSkaaGx09fqHxPQz2ae+eV8O5ngfeTkVN8rkUTfsb46595So=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOXLllI2Ty+hOY70fA5abJtUD2bV7qfZrwu5wP5AjO6yAY5Qkk
	n86lxUKrCyvoNtKNx/hRHWFFy0TzDSSyoPkI0kXiQ2aix0azbEQHaWvNLwA3ahqF6kwyoyzvOI6
	Z3o3Y0Yy8zMvVNcUAStmcaXcS/iUWXO28mz965ISn
X-Gm-Gg: AYBFou38n5ftKKqljYpk9+vRlqmDiViY28Ds+R+GvcIx2qPTslwx9aN7Cg06S6mMKHs
	TMdXHlEXTfakwii2h1HuOO4Q0jBafsjIchkN43P+tB5+kerpsup+RqRs3ki9KFA5hsRUoTuV5cY
	Bq/+6h8cgWbr8M4c0o9/K9aXBpZ14+bKnTG2Yxv2dZZJSr/sRgQaFeR5R1QMN/VXtcG4aDvhadX
	3k6/A2iKsJbgvAkLSOaU7z/JfgpodKJMNWR55RGkrdpx0bv9p/TPwjgWk5MPHlGnNzOLXQM1cwd
	eg37Gs4FSjAcQ8ke1P/8/GEQAca47TijWM6MuJd+XlnjpUGHVKtsyjopMPzuNmD0ZlhRdkAwHB/
	cl2jhfdiYGUC+dTEUhkdvCfmHPOOq49qXiraA+03BMWrzR7dkNjqPJKKZ3vdAjki3Gi7H3WAk4V
	MzanJXDB4VcedWru/NZW9gXG55wrLturi/Rd/Y5VSlX3M=
X-Received: by 2002:a05:622a:598b:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-5414e501baemr47195681cf.10.1793379214287; Fri, 30 Oct 2026
 09:53:34 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021200341.378978-1-emilyshaffer@google.com>
 <3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com> <atqTWKaRQfvH0Xbm@fruit.crustytoothpaste.net>
 <xmqqecdhcolc.fsf@gitster.g>
In-Reply-To: <xmqqecdhcolc.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 30 Oct 2026 09:53:21 -0700
X-Gm-Features: AclHuK-H8QgVc5TsIaQiW2noGPMBzW37-cKzi05E7s7Cl4d1K4ksp46ikV1_374
Message-ID: <CAJoAoZnSwNKfbc9Eyu0fSBQmEfwPmQwr2-1Yc0SB44L-zM1uDw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 4:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I think anyone who was at the Contributor Summit or has read my emails
> > to the list knows how I feel about LLMs and how I vote as a contributor
> > will not be influenced by my employer.  I do think, though, that this i=
s
> > a reason that votes should be secret because that prevents people from
> > having to prove their votes to others.
>
> Thanks for raising an important point that I did not remember seeing
> in the proposal.

+1 - I will update the proposal to include this, too. I agree that
even in cases where people are employed to work on a project, and even
where their employer pressures them to contribute in a certain way,
they may feel differently themselves and wish to vote "against the
party line".

>
> FWIW, I do not parrot the company line of my employer, mostly
> because I do not know what it is for each week ;-).

(Thanks for startling a laugh out loud from me in a public coffeeshop
this morning... :P )

 - Emily
