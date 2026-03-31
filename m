Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6B346FB5
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953275; cv=pass; b=aHrauHiEBe1ao4HdaK3XYrU48PXaZOEdirH0BuM2WmXqqKHcYj85B1oLyqUx79uQTyk77xazNXnuVPAtbTbhNY7TjNa+Y29MsBWR9SSfTceZrR6fKzHuGAVpSXtTulLQFHHTJe9R4sucdvC3pD2ry8hg7VLxBsYxXwJeLag/cGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953275; c=relaxed/simple;
	bh=cMQRwKbTAn8mvfjesJTGCVHu2XvYWAt/u7KxI5q2pAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChRnMZupsVQyL5eneV+aZZ5rfezZYaheAJugCxFF61zSNVm2/XRiU9Vzp4ZcTNurPNX2ulnDKNEz/o0d+orlX4Wb/hy9gThQnAeIGsopn0vCiDxEm8ScREcwfuspLz/jv14DTq/EEGu/ndcmIhzSvLGaSUq6YSSAbTRxQoOptvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbB/NEDu; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbB/NEDu"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271257ae53so5489406c88.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774953272; cv=none;
        d=google.com; s=arc-20240605;
        b=Pa2MNM7MBb3Z/ObYMju2P9Wx0iG9L+gI0cO+FX6bS1BftO1UKIcHAzf+VBhmwN/2l6
         c+8OmA2sVFALOd9+fLQK8BdjKYY6ssQrURed5mM9+BlQ1gExHLHY6xkbB0QMPBTUA2mT
         +uisl4BfoPjRMQ2Zj/ZkIuxOjeWNWbcijxnXj6xVkrb2ve1gDUY28fPp5KdycwVN2AKY
         bQ/3V27J7fQh2PZnL8AG3XoUag0q9rYBGMq6qDWpVx5ZAYaS8Ij3tnFbyOht1MKevV4I
         1o++IZ4ku6xV79O8nGj+XO0tSH3ON1BskCF0aobcvdJ88kX9LzbXPIap1LI2XKinSQkL
         6uQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2E5IbxaqxkUpWU2Eu9Lq8+VNYxVHdBlMGIYNeyfNyE=;
        fh=kOAEXa0IhJ6qL7TEC4RpDoaUrJDJXwuT6+ehvtXEBb4=;
        b=Ed0pfTQX6JemCoAqmu574jz+kKO/KZB0osQN1RpXINzNZBpMizLyr9VJdVJ9WFba1t
         NxV+g11Cj85ZQlsUaPYdR8Lb/k/rdbp4eXBIkA+wrdlQRRY6iJ3BxOJ99Nz/UEXOyrJF
         XcXmJgbzrE968TSpqpfOWu2sw+e+NVnYp6ylBdoNaROJlJXuIigrP8BzStI73oD+YQOG
         1KehFSXo9E3xJ9jlj6ZH5OipATrhirUgkFxniE2kOk9vSjv8dHXbucvY6K3+ZtlTYwVx
         i10ARnx10IblhYvqBIF1RxBipMCzN9/jjZKJ+eX3NaL+waeBqm7YsNOOeC/WSsukXRrS
         Z5xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774953272; x=1775558072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2E5IbxaqxkUpWU2Eu9Lq8+VNYxVHdBlMGIYNeyfNyE=;
        b=TbB/NEDurLnFAUPEHzYG3J0i6T6eADajuANHX6DIrCHk8q1E2Y606SOGXJ+7BQhsMo
         bPrGd3FuohMTHi8eUmGH9B0eLO0rAQ6Ap0arASCEoBfwDfXucWmfkYu9IElPFl+cD3vo
         Vtr1cUmWgfCyYtxo4Lvo3us9lmtj4B85gtz6bHtpPF4Um/akRPxcxpTWZpUcYpjG1RYP
         6PC9U1YbOrmhbhWU2kO5Us6SKwPu+qi1G4xXzGHwMnrMPv3DasPtDD4jLK2OSCPOPPwG
         1brP1LRjGnvRXiPSgQ0THOX1g4pDrevMbpSLWqBF+t2F+nK8i2z5AWWbS7vPwPsevxOU
         /ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953272; x=1775558072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2E5IbxaqxkUpWU2Eu9Lq8+VNYxVHdBlMGIYNeyfNyE=;
        b=jXa28kOW1UciuaAdSx0vLOoT7oHQ15emMu6OV68G9JxdCSuEOsiFa0gxcaPi9FtKnC
         5dRQ6vnCxpySuCaQlkKgQtTOIl8kB2NJeiYcMl1frUiwDK4G4/Pc5XqWNMseJh4wr9ix
         4aSdka7+UNUC7Xwou6jcz8U6bFxytWBRtVnBBSL7wgfjdnyVXwOX36J42v0iDFhL+wcT
         mTYpk/ijX7qiSsCbvuDTbKWXr5oEU3CU8CLfP/BDSDCbprE0DewSvjEh5QMvnpk7XonQ
         f4XuvRU3+Q6tHcX3L3BAPfQIdHMqTHcnLDWI5y29685uvtxSEgZ3lQ7/OwqgA7vx4HsY
         2Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCUCeyVcshz/W9RDVvR3nJyRW4gj4lP0plvRguW2+Yb0gekvsjaTHxKi6GO8cW75z+nYBrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWvZzRWtaWzrp5sRksfCOAdo4kdqbiaoCIVrvwA1Ri3VN5NvV
	R9Z5kuCUwK1cUXA/ImQMJUwont1esZJR7JJSAuIIQ7QsG6vDhIsEddh1sB1D3WltH4OYwp8NkKT
	EZXmrO8Rn+onFNMfjn5x6HpU8qs/x+2p204b+
X-Gm-Gg: ATEYQzzgVe3CoIgUsb02q4F3e0x2xnkoQ1znNmFgoDhQKECo9KlIWFE0JwtVvfHB5Vj
	3C7//IY/7AY3QU1rKDbcHK4xYMH1MeZg6CMHToKy9EZe/+wxSNc0Uf9wF9vQiQmx1v/B+d1LmNr
	9F+IA55gU57M+GR/Uf9XMp4Q7h785tJRHGW+PRGzSiCaNMrPyCySoN5szPN6BbBOT+RgnDa1E/1
	OiLtt9299iPBe1fF3/iSxazPoAGoElp/vu8LVilqihWztOkbmQYpnrlfMXphUmNTo/MnoaF30Hw
	6mNxWrU9KTct7pKLF6dYdL4YD6MZDKGoJAuwAMgjil5rrx0LG52z9NFvoHhBYva8eZ8N
X-Received: by 2002:a05:7022:eac2:b0:123:3500:b688 with SMTP id
 a92af1059eb24-12ab28dd345mr8123055c88.19.1774953271897; Tue, 31 Mar 2026
 03:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
 <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
 <xmqqtsu5xaw0.fsf@gitster.g> <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
 <87a4vv2ada.fsf@iotcl.com> <xmqqfr5lkyq8.fsf@gitster.g>
In-Reply-To: <xmqqfr5lkyq8.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 31 Mar 2026 12:34:19 +0200
X-Gm-Features: AQROBzC6Qg1zqLndbDzmRNm8g57HJlFicCpOip04VatwTZxlVYnfv4fNSfJMVIU
Message-ID: <CAP8UFD3P2Gs0J1FNyKW2URwSEW4ZaTrVO7cM1V8sG+zzXctbhg@mail.gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 5:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Toon Claes <toon@iotcl.com> writes:
>
> >> Maybe something like the following could help:
> >>
> >> --- a/Documentation/git-replay.adoc
> >> +++ b/Documentation/git-replay.adoc
> >> @@ -23,6 +23,10 @@ instead get update commands that can be piped to
> >> `git update-ref --stdin`
> >>
> >>  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> >>
> >> +Note that `git replay --onto main topic` replays the topic branch sta=
rting
> >> +from the root commit, not from main. What you might want instead is
> >> +`git replay --onto main main..topic`.
> >> +
> >
> > Definitely would help, not sure it needs to be part of this series.
>
> Where else should the patch to add such a note to the documentation
> go, though?  Without this patch, we do not is because the command
> will not take such a command line.  With this patch that adds the
> "now we allow replay to take a single tip commit and replay the
> history leading to the tip all the way down to root" feature, the
> note may become relevant.
>
> So to me, it looks like it is either we will never add such a note
> because it is irrelevant and everybody should know the consequence
> of passing "topic", not "main..topic", or we will have to add such a
> note as part of the series (if the note would help the readers).
>
> Even though I am on the fence about the need for this specific note
> in the documentation, it does not make sense to me to say "this will
> help but we are not doing so here".
>
> My comment on "might" in "What you might" in the thread still
> applies, by the way.

Another approach with this is to consider that in the first place the
main issue is that `git replay` doesn't emit any error message when it
fails due to a conflict, which isn't user friendly.

So if we are about to fix that main issue in a separate patch or
series, and if we plan to emit something like the following in the
regular case:

"fatal: replaying failed due to conflict"

and something like the following when replaying from a root commit:

"fatal: replaying from root commit XXX failed due to conflict"

then I think it would alleviate the need for a doc update.

But anyway even if we are planning such an error message fix, I think
a doc update would be nice, either along with such an error message
fix or along with this patch which allows replaying from a root
commit.
