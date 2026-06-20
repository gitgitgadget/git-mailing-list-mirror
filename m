Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E7233722
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781989135; cv=pass; b=bRLgKbaOYpQ9u8ytzzLFcYX787mGYBAGizyKjhbLZT5ESXNddZeCXNyXSkAqgqNixYW6EijjXCQ0DUTuCSLbllGCa+ntTArPHioYneJETseu5Yrb5qwAnvij3csr8cpON50g3ccMMFTo3njtCGMigrSlli97cm7e0caBpgAtCxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781989135; c=relaxed/simple;
	bh=7twAZkvqhS9hNYlWyAStTBE3uXAubLmPo7gCkJ7acJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPdvgODScUT7sIwLZ2BY9WYYtqeVPHsuYk/lKOu5sUJvtJBMBf3A5QSXrjX+0r7WpS+bK+eiagPzU6eP4/Ri1/+YfNwWcblmLpCE3E+lnWYqHtnJsQio/H/1ldoNhYKl69HqKCZLk6EmelmFl2miGT0uA+EV7eeXbUZPRUjj3fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaQZIncT; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaQZIncT"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c88b7c92577so1384372a12.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 13:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781989133; cv=none;
        d=google.com; s=arc-20240605;
        b=AIoovLVd2Fk8gklnaJ8KrNZlk93ywBZProqU9J32IWBY05fXXaXnceVFV+GG83nNvM
         nwnq6lTJwknQeMepcYgkSpssaAx/X7KEAE7ocDqenNAMO/tHhQUSaLaChDgu+yLdPOOo
         5QI4u23ip5RTw4wiFbx918D3CYAKB7fzTgknm6ohmGTCRyQAzBD3DpmHny5leJlXcX6I
         lKQ//F986Ax3B/81MtYSlp61G2EsDJ+UQsNevoTknNqyzhrcSpLflZJGo/kZwjEcdlHu
         tFG8rd7wtsRYWfb6NUFNdLeh1nJ0KMnBn2/TTIftOSJllUS/XwdAuX85q7Whmg+V7Wnv
         9aCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lq98TYRF/L4e7XALX0rlBPglZ7Y6f8hVg6UeYccXDwA=;
        fh=4ke+hPmK70NKGfwfogNl9bljbHejyhb33fdDeehLf9A=;
        b=KY5RksjTbObxZ11vk8evjrkP+A0TSmWkcmyQfU5/0MV4q/iMIgpNkHbAqSvjOydOCD
         pFtd91kkiCYYFo2I5EEmFwR/+I70IALEz35cmZBJQlylsrwtJPxqUmBaoejyBbtkyGRz
         cxe9d8+cTYQ1Bt4VJXvpjwVkaU8Vko23+9eoeEWbrcnZcxsj/C1kJlBKIaVdk600Otc5
         /KMfEdw+G+k1e2uWWDIh8/D2q6xPFqXObFd+5MsXBUMplencNjJfA3C9WKomcr4u/Eiq
         CoYH99xILLAFXsyx6HHdvziEUaomGe4hOrdj138h/DTwoV7Gh67J/+y4CR0nTBZOq3hw
         Q8UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781989133; x=1782593933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq98TYRF/L4e7XALX0rlBPglZ7Y6f8hVg6UeYccXDwA=;
        b=AaQZIncTZSyfKq7gbrIRTW2oJQpHY6g8njs3ZzsZg+/9Ih4PkLcjVaKVA4c8JT2lUo
         yMickdYGXAixfLCWgidAZU7gp7tqA1ymCv6LvOxkVV4mcSlAlYoc2Qbo+43XYRHz+PmJ
         SbrY+cqV6IF4cDP/nRM/GFz9e+w67CrMNCbQTeZoVINAwq0vBPDVqV/QsOBTCRRCGIHH
         Ww5LnZq2hHApWvhZRiHMxPF8++eJm+tmTqZUBAJw2l/EAYiHTMnq2SvLDzc4s0quv0Vp
         9UYoTGewPnrUY3nW0cF5u7uN6V5V4zG/WaNKjgE3TdtAjYVbyRqjGy+qQq6flyBdG+U3
         4iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781989133; x=1782593933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lq98TYRF/L4e7XALX0rlBPglZ7Y6f8hVg6UeYccXDwA=;
        b=BnBgIZvzVAOQnXimX0w2vBDa70Uf302TPCs2XWEL+EXJie0LtCB+63Mh7EurVriW8z
         7pdRPtu+urGiJMQob1Oxxn937j1kggCP/qDmom5z3tSGvH7Z8UJku38WJiML8QXOrUmu
         AWoQc+hgrMd3KcH7EHDYNEjvUp8uUGIXDpgMJcW6+gjtrHpuEt99RoHf6tmXKLoGeNpb
         C6nkzvetDFUEhSCc2mC0V37BhqX3tdxEUmmKEovkthJg0+pSnJfxQx26uZziUdupmZJo
         kAreB0Q8gENDeSNhYCAdj1SACliKbxxlGA0uizvd0FhdHp54t7L5QTqSrWmzK85tm9nT
         9KZg==
X-Forwarded-Encrypted: i=1; AFNElJ8YhGv/mUR62iOmOpE7peubxyxFNOMTrxgEKtSFes1fo1wGfQSUsFQLuxDONxmlb0kCRlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OsCHly2x+YvB/gXNYlgF18LLnfecN11EMHKU3fEDiSJ0epqp
	1QpK81deTQlBzIRb9XbcL6AORhNLxWQAmoD7yslLRS5E5SlPwQjHSpuT6clpVxGX0/NGsXqDox5
	cAoXV9p+IBD+xb+vsEmOhkNHG/Svvszk=
X-Gm-Gg: AfdE7cnip+ZxmIPGy4N/BLce8O50NfkaiW35Sh5WC1b1pA9Ad+c5bwWdwKnKzcMcd7T
	5pzuLNCybWOR3VOo4YoC5d+NogkHM93iB7Tigm1Cw2RlNAAVvjsO+zdRxyyyH3bz94gadw5hMak
	cFWZVzdjjQ+Qf2ga6EjSC/BozOrwN5seKWkFTKEsZU82LgTOa/bnljq0/XL+MUVQYLI0l2ScNEe
	PnWMWZdDXjDD1o6A8EJgJFYicCT0h2f/0fyw1isDTM2NorDtk4MADDbzEKcMYNQ3exbECJNvXNR
	iUXtwQtCOcBhchm0MOmqZ9dH5FKcrVPK/RU7T+ZTGouIN0umiKneg1Yz8ggU90klCLAlc70xdQr
	4QRY2JmAGiueGb3w=
X-Received: by 2002:a05:6a20:9389:b0:3b8:268d:5208 with SMTP id
 adf61e73a8af0-3bb3497fef9mr9392678637.42.1781989133501; Sat, 20 Jun 2026
 13:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
 <pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com> <xmqqv7bei2tf.fsf@gitster.g>
In-Reply-To: <xmqqv7bei2tf.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 20 Jun 2026 16:58:41 -0400
X-Gm-Features: AVVi8CfLp-1zIlGF7S_70RpKAVgnBmDnopYyWRCwb_qubPOZA-VXfW5utSlg-0Q
Message-ID: <CALnO6CAgNdkg0PnN9Zy=zLurLUSb2hUXYAGe_qB0oceZNy_=gg@mail.gmail.com>
Subject: Re: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 6:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Building on macOS with Xcode 15 or newer emits:
> >
> >     ld: warning: ignoring duplicate libraries: 'libgit.a',
> >     'target/release/libgitcore.a'
> >
> > Some link recipes list the same archive twice, which is harmless.
> > Quiet the warning instead.
> >
> > Pass -Wl,-no_warn_duplicate_libraries on Xcode 15 and newer, whose
> > linkers added both the warning and the suppression flag (ld64-907
> > and dyld-1009). Earlier linkers reject the flag, so gate on the
> > linker version. Broaden the existing -fno-common version probe to
> > also match the "ld64-NNN" and "dyld-NNN" forms Xcode 15 reports.
> >
> > Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> > ---
>
> Yeah, this looks like what I expected.
>
> A few things to note.
>
>  * Can folks with different versions of Xcode (or is 15 sufficiently
>    old that practically nobody is expected to have anything older?)
>    test this patch?
>
>  * We only patch Makefile here; can folks who use meson report how
>    well your build goes?
>
> Thanks.

On one (old) machine I have available:

    $ pkgutil --pkg-info=3Dcom.apple.pkg.CLTools_Executables
    [trimmed]
    version: 14.2.0.0.1.1668646533

On said machine, I don't get the duplicate warnings on a Meson build.
No issues with the patch when running make.

I think I have seen this on my other machine, which is much newer.
When I get around to trying it there, I'll report back as well.
