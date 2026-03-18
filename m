Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989F2566F7
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852201; cv=pass; b=CsJRhO1k+vnAZc7mZairK5sQBKZ1rbXS1+6BjvrWr1LnF8zPGifA0/wxPw9yr5jzBc3xhgd5CS28xWsk+Zkl2jo2bMCCefOIhaGvC/fye4JIG4+R5OfibP2Gatq16IIsSMyCDaIPKKEy7+i333FOB5Qik9Fvm5+/wxA3JGV5rD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852201; c=relaxed/simple;
	bh=W9uX8lUiKVcAEbeDNuv8KLjcTRT8oe8PWIB1vepc4Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vg+5aZHgN4H1GGJHF2B0IwlKZsThBo7O/HHg5cgAx3P1NuCul/k0BH5gEgM2YX8FtcYvrVX6LeU4l7yk/nS+WqUZLfsejcIssKpo0gKA2qzWqFVQHB3id3GJ4e4Tgpp4txxrnkeoOmsi5i/TR1yR7oH9rl+QZDhh/ciXP6nNQNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12714f01940so9138c88.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 09:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773852199; cv=none;
        d=google.com; s=arc-20240605;
        b=fmkyHjFHVsW03XJe3RBlvte8mLUMIq04OFzPApu/xhvdJDRi6ZJMkbL8DK3Glo4Nqh
         qWc8yf2EfC8X+dajTggiq1yWHA0CNFHLSxxCQ8IvPoKBZaybAWvMONh27dvNbm5yW+0g
         UGnkiaNDWzzf8O2szB16vK/UcWcNpvzd814Ahk+rrTUOJB3FaI+ZPCYLBsKu9w8xgIaT
         sqMX+fYgvSUF2Zhcwgn0CNf3eoyxBiiJWlAxUvcOL/92k6CQV02eebW/8tKadV6NHx4h
         x6EOIwraWnxJcx2UMiu+g+hDy7Z1+lB38dotkMSOEWG+zExeK0gUYcnsER8ZHi6yOcSU
         ro6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=HD9/t84UCpa8sgcQ8SYbjBCOKGoRwFw+VUdr8+jmD8M=;
        fh=TkvboFALB8KQQ1VQErW9L5qKgHaSFGkT5kqd+vXT6hM=;
        b=JnkvLqLrAfSdP7dDZttKMgRXxu8ib+17V8tmS8HvSciwfrnwxy7bigu0AXtKKXXwll
         5jaPsC03/ztgHNY4u0xM3lBbWgN2w13EBF0zuXC2VgWdWk3Z2ATO4hwmv4PHSeqBfQVk
         W91SJfX/Vj01LUtmMA8CTnf9zHT+f5dxpejfizXBIDYLLjV1MSb2XVwtbRARtC1wjkli
         Zv2mbFY7MLP2+k4A+IPfAdi08LZoSUsTlpiEnrr1NzPLO4VCOkMuOCm1u+9M4Ex/CDIY
         Zr/QRN/9BfXqkzpT7sVhjhkAT3YqzNQfp4gAFzpxGdwniDJUDUcwNvGmXQDRlK5C6TxW
         teRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852199; x=1774456999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HD9/t84UCpa8sgcQ8SYbjBCOKGoRwFw+VUdr8+jmD8M=;
        b=cSlb8Hk+KskUgXKmXF7TLmxVGu47vf708grCG3JdfPlC1AJyKtXtXMPEsKNDegEqoh
         ZQfxjpQOE3RHLbVUyqElQZ6cPpsmg8jxTfoitrcU+OOz1PE+16OXrDqV4zh5gxF45ev2
         sDP+gcaXoBDiu28kN3wEewOMMTWsH2IgzXTWqee83a6qOjZScdrAfBHK7voKKAnMoQTL
         i5gIFqfRyGw5/PJgM0vk/5HaCRISbUSkQYkfrnLhmhO9ldYxTw4qeR+28LYFY9aPF7Jf
         CaDeFky9ArqK3Lmfw+/8ufEntu7q8L5/4XiAKeUDF3YIoTFGjvBSm4Y8PQVH5vwXl8n1
         AqwA==
X-Forwarded-Encrypted: i=1; AJvYcCUTSIUkaG++U9WD0M1CSIJTPtVZsPqQXrnR33QOeMaEfqEHR5h+bH0Jk8GkJT6pn52fspk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1jT50h2+AqIccFrv4Af0kH5dh9qSbdOl6OXGBvUYZJ5rjVsR
	xd7v65D+YyYG2I1xSWKQR7vnx6NX/KauK4pe11YTlYPaKJdfirXYZ7nJjyLKmwCNIBfB+cQ53dt
	AIXBzoQWArP8xihse3uc7lKQuE3GbY7MyPg==
X-Gm-Gg: ATEYQzxPI2J3z75ohkOvlDD2TkO03dQYebnuLuJQ1+Mno47a41TqgU4xexzzJQzjJN0
	0tC98F43bxW/O5s+VPs6KskgBTdPVMIzvKtygLGao5KWyaWg39oIo3mDUzfkNs13x0e5WsROvGF
	XvfN4Bo9SNVfC0qgirY4PhOO0y7oqlaTHgoM/sCGKtt2klEKjZmuZ1YVjCR26ZAZCXi0GeYUThb
	gKmEoixHXBRshoNZSP0p4+e7pbiuJp4YZRKSVexQNW2ZhSqOvuOytUp+ft5AxkP5zMUC+52mMXC
	KhXKzEHYja0XZ/qJF15bDis+SJdC59yWP8vkls1JWg==
X-Received: by 2002:a05:7301:6884:b0:2be:6e6:e47a with SMTP id
 5a478bee46e88-2c0e4f4b471mr977576eec.0.1773852199188; Wed, 18 Mar 2026
 09:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldfql4hp.fsf@gitster.g> <CAPig+cTTgLVGPG99gsb19BeJVWS=VZCU4F-rjb25yHTAORWwzg@mail.gmail.com>
 <xmqqcy12l2ft.fsf@gitster.g> <CALnO6CDNwa8Ez4Ug0f8zNyxF1n3C_j8mLRbH7wChVioNoC5QVw@mail.gmail.com>
In-Reply-To: <CALnO6CDNwa8Ez4Ug0f8zNyxF1n3C_j8mLRbH7wChVioNoC5QVw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 18 Mar 2026 12:43:07 -0400
X-Gm-Features: AaiRm53Mzj0FWuJw0CItcvNwTUXCfA-YueY6WqBWyBrbyccc7ohA7ufXgje-FC4
Message-ID: <CAPig+cTx3Gho+uYd9+0SjE+x9GA6VMNu78riUZ=h5_QW2vUHNQ@mail.gmail.com>
Subject: Re: [PATCH] apply: fix new-style empty context line triggering
 incomplete-line check
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:36=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
> On Tue, Mar 17, 2026 at 2:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > >>  test_expect_success 'incomplete context line (not an error)' '
> > >>         (test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
> > >>         (test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&
> > >
> > > Perhaps the parentheses in the new test were copied from some existin=
g
> > > test, such as this, which already used them for a legitimate reason?
> >
> > Yes, the existing one was concatenating output from two commands run
> > in a row into a single redirection, so (grouping of the commands) in
> > parentheses were justifiable.
> >
> > The new one does not have such a justification.  Thanks for
> > noticing.
>
> I think braces { test_writes lines =E2=80=A6 && printf =E2=80=A6 ; } woul=
d have
> sufficed for the second example, and might be cheaper (avoiding the
> extra process for the subshell, which we've been told is especially
> expensive for Windows).

No doubt. I considered making the exact same comment, however, this is
existing code which Junio's patch was not touching, so the comment
would not have been directly applicable except possibly as a
#leftoverbits for someone to tackle as a mini-project or some such, so
I opted against saying anything about it.
