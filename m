Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F1335555
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361991; cv=pass; b=bQnFwFmTO+bF/7qtUw8luJHVlhqN9WkhinRynpOIk8GadN9w5pBSSsOkqISLFwTrpfMhKlNpe82TfrmzNr5PJjDZmS5wbwPn9ovjpfzHfdEhMsbR49LHnUOBbOXtg8Ds425XZP3M7XUGzjg38szt2CqY5RO+EWY1/NN9Wj95n6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361991; c=relaxed/simple;
	bh=qlKCY1CKMjVOOZbC+Z+dOc8ozykPfNLnEtPQPk8lSHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaJbehREBP46FGX6QfSa7+QlAVYbSDotedvXHt5WKcPSwby646RT6lEw5q+xFDx2mgTBXeR6hEarjKStu2jVeAlRJuNRpUSRzC2cRypScUm5Gi4pO4xCCIKaHNAmwReXmc2BpHaaeVANTJiHadSthzfmzhw1effvG39610bSW4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FynB4Uft; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FynB4Uft"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1670dad7a8so733892066b.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 01:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784361988; cv=none;
        d=google.com; s=arc-20260327;
        b=BVmKQSTNBC9faRQMMpjXINYU5fl51ey/Kb18OFRno3XTrECc7ExJ1Pk4/8FArpXfDH
         axVuazA55mU8NW8DujL4aXqbPNIs931u7f9qACT/wWNHHWwgKBpZNMxE7l+PszOkKt7W
         obsi2owP/MaA+Q97ZOwHlWICZ0NrkropdVLKq9JtfkqYGxWyGgmBglS2J7HvxIFwaElO
         LpQtLMdZIb/7fH8d3hsIM2Ay7yj2ymJJLPU/Y/o23R5A9nVoJH8ss4qDEYcgSokTE5AQ
         jM/6wy432E2D/3o5IkGE1idlAeoY4nIEQR2hB/pR1dqB8Y+cwUFx4GmNIIXh2X8l/6bv
         y+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VVO7zddHXUCm/r0qGzdYLkySyNX5PXtWVNmm0avlw8E=;
        fh=TuT/6feVugnbynNihU+MwG1Et8PY0SGbHUzduH9WzBg=;
        b=rwmiPxUQaJQYZhjBRSfscZpu5s6IcJ+jkX+FiO05Qv0FO4V4eSU9NP2LQT+zBhPpD+
         9MeR7VG46Iej0Sn52emdZEtUDRHYtyfUt9RmbxjIhw877bIdoDP0IRlxYcU92+hrWxQa
         e9RjWkqAsqZAR1TjfuGJymSeLMspO5h3eCMC4ayoa/bBc7x+/CN4xNeOIEKvjRQtKIks
         zFCwWb8RwKCvpWnlGFdAEKdewk3YfqKnVRpHY2a5iW6lymmnIaAOJuVdlw9z48pgSEkG
         oMX0BZKwToRGk/uIYkBLkb8RlyRppVWIEpyDwXvmv8SrzTgKrewkKneBiJXoLNx+UCzi
         wzLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784361988; x=1784966788; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVO7zddHXUCm/r0qGzdYLkySyNX5PXtWVNmm0avlw8E=;
        b=FynB4Uft6/8GriXH97cYgOy5spIszqKht/t/mMV1hFHNrVlknO9s/sfFYSSFtp8E/M
         Rc3SHBLi5JlOHBuyFuhK2GXMCN7ctiGUR3m04tTeuOOlJs6r8LXNlM7qqSBF9WyKz4Eg
         5V9WUG76HX5LPhLPLdeKwY7LQvk/bBJAjq2t95AMvtkL2vWfJJB9mc74PHlc6NUHCGfj
         o7C9/nzvIJg3aTEhwfl3yXrT3mw5BLp/TmCqLd78V4UW6QtDwT0rz+aHXgQCJGaJ6Ns+
         yTTRhNiG/jhgwn+91HdXlJiUUw64Sqe5fsJJGVKAk4J0tMgL2gkSDlD3uBIOPgB0euu9
         lQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361988; x=1784966788;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VVO7zddHXUCm/r0qGzdYLkySyNX5PXtWVNmm0avlw8E=;
        b=JXDoOkJJHxhzTE7K4xYShBIDOypw+xEiBzfEmV//cn8d34zMliBtfSWLziSo413BWG
         IlxioDdqEWLcbx8SVz/qjF68MIOUluVvEwQ8mmjKYC49NeOnH5dFBEQyJ4j3mhQdv1Qt
         sdq3nAcIcpmuh7TZq2EhDBl54Mi2GmTSI9XiBIrkm+cmnloypjgXi3pZl63PNLjMxX/5
         FwBiKEe3ovInS+HB8kC9nfP3cIaDGuivIpk0NBz1R9J1f1U0sPMXwBqR8Rw5RS15Ml5p
         HCdb42NbD1Qby/CnzzFkWrs+4A763tgThoPWF/RIh0MNYDY6Vw6wVX03qcgwYKqqhj+u
         jDSw==
X-Forwarded-Encrypted: i=1; AHgh+RpYM++7QlZEN19uz3BWRl9E7OL75kmBSLL0ok539tCMbYCNEJGlcv3cCNfk4iyWJCSECWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0dOOcTbzLxZQJa1H0YEGem05+WE6S1bC8w5lgoaOIzBizvv1
	9Pv4dq6cFi/BWUq5forvn0eICPrG9tLXN6zzF38feWqMIJVqJKYwuuQR7EaMjf8Dfqrz05Z4uPv
	mvJaAo9KTcbo0rqvtNwvkcQXS4soo6Sc=
X-Gm-Gg: AfdE7cnR5OFk/Hgl0iWv1oLFsZnP7PPiwfZ+TC7gbhM5qHIin2oHf3KxUJmFsbdjCYR
	G9BWySga41vXvWbJK6dyBQiXQSNLvAUDsDUVSKOPhWe4UqeWp2jlbnHwzz0NwVtfdWTR7DfQV7m
	y38wsxkmj6k4FvplWD8jVEr2HApS8CzdvxzMz7e465rzgJznDZhjN469AAFhjfanPuHhM4fRZzN
	Psx7J2wd7GshrjXBQCtYyqVV+wN2P/yml6/CePcF/6DB5H4pfT4W/V/0uXbRg==
X-Received: by 2002:a17:906:4790:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c16b4752c42mr259856166b.14.1784361987851; Sat, 18 Jul 2026
 01:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
 <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> <xmqqpl1q2xw5.fsf@gitster.g>
 <bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com> <xmqqo6h9z7e6.fsf@gitster.g>
 <CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
 <xmqqa4srnwfa.fsf@gitster.g> <CAHwyqnVy=4oHBTmtDJ6jX38Kh1aLYYXHR-_12DdiiUxpXZ5kNg@mail.gmail.com>
 <4d150f21-46ea-4bf7-b516-c1763c152b34@gmail.com> <xmqqmrvqhmpp.fsf@gitster.g>
In-Reply-To: <xmqqmrvqhmpp.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 18 Jul 2026 10:05:51 +0200
X-Gm-Features: AUfX_myaUCnSQCrv0aFh6cHmp7b7t0PQTArwycaotjkdJv3Xusw0kxWeEMAC-Zw
Message-ID: <CAHwyqnVwDsdvvg6a2BtAYw+hYRdgKvRXwHE+uzAZjherfu5B=Q@mail.gmail.com>
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I wonder if the workflow that benefits from this "if exec fails,
> give up and forget the whole thing" behavior is actually quite
> different from what we consider the "normal" use of the command?
> Perhaps the user is not interested in "rebasing" the history at
> all, but is instead running a check on each and every commit.
> That is, a more expensive version of:
>
>         for commit in $(git rev-list bottom..top)
>         do
>                 git reset --hard "$commit" &&
>                 do the exec command || break
>         done
>
> that just happens to be shorter to type?

Sure, that's exactly right.


Harald
