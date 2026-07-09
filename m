Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D04492514
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618037; cv=pass; b=qFwq6TBY5ZfTHx3D8GoB5r6VS8E4LajSrv2WkjmneUec+zOOeSJmgGEZigehdhc3QbZC7ADCigGo2oo8qb/dL0yyxzUEb4ExFOBBsNfNUviwJAfWBBkzfDcYnJqG6b4k9aTIA2cknYBAS6eqZ90ruAvXFeUwaxubUQcF28ySKxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618037; c=relaxed/simple;
	bh=Rq0oPjc7Vq3sxZL49A1tX/h6k2sXGn1q7rwkMoVCYn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU/L2FlsRfjXLdOiGAEaw3VazxQmP9udho2yEX1Bo3JUpyIZHfCtibQVtGHrBff6Xza9roN96Siywtq5mIeOvBXp6+d5mH1kfydzdZit0p70/0yohwHal05AXCoLyVFTUVKpz6u/jYdruVNj+D0APpQEkNu38GJyNHXSefFduaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX7ddC6X; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX7ddC6X"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a1160a2c42so100768eaf.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 10:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783618032; cv=none;
        d=google.com; s=arc-20260327;
        b=FEHV8ibOR/XP5Xp3Rgek7SjjuA/CtL2f2hc52J5XzodreQxzEzscUYay5+vWrOo4ns
         jKm6lfRdXk91Cl8nO8QOPWCnVxzXboi5VmRzmevDF3FiJqOscjNA86ir8dC0JvbMBNae
         yNa6ZfkqpdlCUzqYNQ3yQDlzqevcwHoZ29800iKfSs7czt++W5HXHS0Hk/epLiC1rXWH
         Pj/JS1tWVh1WiCNTQvOB4jKm1O0DNkTpyCa9g1gXK7Fl92vSbwjQryAWR5Mx7/qJ+5Fy
         C9TICBbKm4V3KUmPIs1voUBLvkhniZSpClu4J6wM/GqKIasDraRvMeWQeViyRU1Ojfax
         Qvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+KthjLmyaiQYL4thEEl3aHpb0ZvrpoeulFq62afPxg=;
        fh=1VWqBrrWWbw8khmRXHyFB+4NfFT+qsncL6RGh0yNhCY=;
        b=iRBiqTTtCwExdZHpyZ+WQ4ctb7i2nyhscbYCB+xVe9+8WsHLS01GmXrp+N/DfkHndF
         AeTytOFE9IRS1ezrphy1LVT/SeRfdeG5lmWoV/BGAcDHKZcRYoUis0WNPQS+H+ULFTDB
         qPWy/Yg9fJzrpbOSDUtxR+7yuCkNYDwg4237/756lbMQPvvBGePBQmE8+0AMds+yT35B
         x2H683TxOHfKp3xK4zcBVzkzFrFcATzG4CLKQJH5RfaGwHOUtAOGwlKkE4sfzKQPSiTb
         EPjGLKXmJitRmpj2vTdowEp5ztTkRlBixhPreik8M3bO5gQOqElh+o+rH5WRS/yfKKVe
         rnWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783618032; x=1784222832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v+KthjLmyaiQYL4thEEl3aHpb0ZvrpoeulFq62afPxg=;
        b=AX7ddC6XADt3sS0E9+J6R6Wj8pfxzkQKNR3OKUVdKd489EN4d/G1PpkWcoE+F+KN1m
         I9gNRzksCtKGXGDDC+hONPiVQp0rSbGvkZxMUa/q2mLaDPfbhENm3dFRwh7KMiiXNR0t
         3hretc0RbVbrRhc0YzPGJ/zu14ENK7f3q/tTwSmt0LXRZJZEDFW6PERpBA2I15DlqOVH
         iLBFmOnW2UDfFfSCKq4HSbdPK8dueyhCVa5TOofP43+ncAnRZosKvndTB7Vz0Y9PZWnQ
         a7S7gmzzpnI6MnA03zfKDX1MPsmuORE28tsxLtJSaK7oUQEYWuuiRPImCf+zwKq+iicT
         AqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618032; x=1784222832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+KthjLmyaiQYL4thEEl3aHpb0ZvrpoeulFq62afPxg=;
        b=MA6Y5Fvgyaz5T7B0TBweARZE6JJr55usBWOyjahh2czd4ef8harPZ+7I4v1USgg8Of
         pkPE4OEG4YFDg6PHE/ggDFi5khH3xr+/IIXsn6YcTFn+xne+Rr8e9VKWq68Zddb1ohua
         rF0cVxZq10IKid0CWAFWYjpZdEtoJWyO0Y/YT6Prsp4jKdzDubfa1uxWN/ZdRp/ra7VZ
         95lHpPFagY5eeu6pQrbDk8VQjuk8G+oV0f0V5+htOWDzViLV+s3O/vnRoPeUTyX5OtXU
         LWopSdb5x/x2553217mAI63Tb83ZQyyh0Agpg+mis1bmd3l4GrFOE8m27xQJ8ZVhScxf
         lrug==
X-Forwarded-Encrypted: i=1; AFNElJ+OYBfhsOJ+38XOOLuMEfXvn4+mFr98qrSopvKJoEg/oOragFx8brivb0AOZ7dq3LHn6HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwImhCyyhUS3kF5LA6imGgHl5nbWZeUbP0XBD2Is3n/MznZepcF
	Al0v7ThrhqFWHjqD/wrOeoFz6XRoRYL7eFVEKKGoG4h5T+UlVROMl+8sUWwR1zU8TW9uwBGGsrZ
	+mOMckyMKZTWXyFQb6VPMuJI+kXKuXjI=
X-Gm-Gg: AfdE7cllEAA1BHBZqD0UDsdbZG5zpvbefvAFQPpe1ALsTFLpYKdLg38LcbgMTdJ5v+p
	miot1dGuZDOUTr1S9vlYYxPB8E7kddMe4kdUMe2gL0y5o8YAjG2sroH3a1A0ur6HT4BiWrmM/Wb
	PlqAZQg6jmyBpcnzW39X0AsbaBegQ1Kko/PIU13J1+nFSc1dPhyq0MP9hH1KwatZ2m+apcQKa3l
	qpdMlQr7IFmtKke2RddYQc1lNp2QfCx4JT6dF/Gl20ry03ER9omgxPis8YvwGjfPZzx6s/L8Ra8
	mt5+3ssV+NtpW5tSd1QC0ZxiTKG4PCRqB8O+0VbVKTYXmAIEhFG8UfM61kqoHNb0acq9QciS1gB
	WFKacXTCayCCnEGM=
X-Received: by 2002:a05:6820:2604:b0:6a3:8b32:3ecf with SMTP id
 006d021491bc7-6a38b32494dmr269134eaf.12.1783618031673; Thu, 09 Jul 2026
 10:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <9f48aa6d6ddea681b700f689f0509c4b30a7007d.1783479584.git.gitgitgadget@gmail.com>
 <xmqqpl0xtfyz.fsf@gitster.g>
In-Reply-To: <xmqqpl0xtfyz.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 9 Jul 2026 10:26:59 -0700
X-Gm-Features: AUfX_mxj3Sr-BjekXn5x_bso-eCSuxkWRMw0Q-zK2RoEEhAO-4ZaGM9SOT-a5Q0
Message-ID: <CAC2QwmKeu5edJ=d_sT5BpT4q_=ch8HhUJaLuT9DkKWB22hhzjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t/lib-httpd: fix apply-one-time-script race under
 concurrent requests
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 12:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > +#
> > +# Apache can run this CGI for concurrent requests (for example a parti=
al fetch
> > +# that lazily fetches a missing object while the first response is sti=
ll in
> > +# flight), so the helper claims the marker atomically with a rename, a=
nd only
> > +# once it has decided to modify the response. A request that loses the=
 race
> > +# finds the marker already gone and serves its response unchanged; no =
request
> > +# is left emitting an empty body, which the server would report as HTT=
P 500.
> > +# Scratch files are per-request ($$) so concurrent requests do not clo=
bber each
> > +# other.
> > +
> > +test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
> >
> > -     "$GIT_EXEC_PATH/git-http-backend" >out
> > -     ./one-time-script out >out_modified
> > +LC_ALL=3DC
> > +export LC_ALL
>
> The original was somehow inconsistent in that it forced C locale
> only when one-time-script munged the output, and otherwise the
> backend was run in the original locale.  I am not sure if that
> matters very much.
>

I think it's still the same after the rewrite, though I could be
mistaken. If the
first `test -f` fails git-http-backend executes with inherited locale
(analogous to
the else branch execution in the original), and if `test -f` succeeds the l=
ocale
is forced to C and the one-time-script / git-http-backend run with the forc=
ed
locale. That being said, I think forcing the locale to C consistently would
make more sense. Depending on what you think, I can integrate that into the
series or leave for a future cleanup.

>
> Ah, we assume running one-time-script itself multiple times is safe
> and does not cause issues.  Our objective is to avoid returning
> modified output twice.  So while the first instance of us
> successfully renames one-time-script to one-time-script.$$ and emits
> the modified result, even if the second instance raced and managed
> to run the script again, it will fail to rename with "mv", and
> discard the modified output, and instead show the unmodified output
> generated by the backend.
>
> OK.  It is a bit tricky.  It may help future readers if we said
> something about this in the proposed log message (i.e., we consider
> that it is perfectly fine to run one-time-script more than once; we
> only want to avoid letting the second invocation's output used).
>

Yes that is a good call, I will add some detail about this subtlety in the
log message and helper comment.
