Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFCA42643C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925726; cv=pass; b=Yh4O6U4Kw/ZzUpkuotqdEsaqmoW3eKu1wV7rb4M7A2PxjHFPIopqZMo3LRYn1F4EbiK3693FHG/w4aeF5t9hVXv/zR5FnB2MR5Mpd994yd/9dwEHvvf0rNPgHdASm4sJlGj51rZu/1n2wqrCXRZKXkjWmgi5DkT424hqKKhe0/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925726; c=relaxed/simple;
	bh=HL6PmV3AX4/l+4kTBnuZRN4IdqbLopsy4tN8b5vlaow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSIPjl4dQkwUuNYmkT+9cSjrs5sQ9FREsIM2umQ7Bq5Ou60NQcX1lz7/qe/sRjr4txVeD0Zxe//dXoqKBMq+InNwwVdnp3+kWgnASpz44jRHXMnIOZP5HDjhLWeFpiZoGB/1RuTRAZ7sAQc7DEgDzU6uo7crBd4JyMwG4MX2Etw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtvCZpcU; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtvCZpcU"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso11268310a12.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790925723; cv=none;
        d=google.com; s=arc-20260327;
        b=sPwlktAAaKzyWQ1s4K9tBxLOYQsxMQgxnuIoLl+W4WQVAzKYwrrXJBEwmYTZ7CrHYy
         eUJcMRgvzn3OPgWfgGxi14HIbM6kRsG97dR1e9WhooFC84d0fqAfDO28iCGozqNG6qie
         NS6NmWu6EluPgfu91xdOToCGnnzS4W0Ksb8+Xfn0GLoCy3mj3uQk7DQyINhnkCrbeqbM
         /4IU2K7fxEl6h93MZETNU4FqW1eO4Uu5QaQ88JOHBSI2f4FbpSQAwkK6ZAveSU0so36p
         5ny+YnfYLgNUsYSY1JSPhI58P2vFj0lGQN3NHIF5CAA1fOavlZfA7B8FcdhGxRHNntBB
         5DtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BifWnbvMFqEYHdXUte57ztIjcfVUf5/ZoyyaQBg0E0w=;
        fh=7h5sAX4mprrgJ8aR+k8OHqZR5/6Eziag1AADdvxt3bg=;
        b=hobCo9godht+UjHV1W0UvnfECpE9uqbaFaSPfF8P4pZkqVK/oRtKePf5Hw7GF5uXXN
         B6DZ+tubzAE3lsWEntQ0orKzMNm/q/O2R0nOMw8ba9MNX+iQGSHlxXcmWJOnqfveJrbA
         I4jV9W0nUvQWKX5YnmA61xSkQGiCllizRaLX8kNhz2p3mbDM16UUE769Au9MMuih/3qD
         6jD/vbmAQCLlkIUf3cTSR/sAis9dXKCSPiSMY4Uz2pH3SY8NvW32k4iFSOJgDZ84GjkE
         K7DSVac8Y1PUK4Z47l9hpIAoJuKjg5xcnUEuAzXzEy81GJU76HQsujGY2edPvav2z1Tz
         HWeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925723; x=1791530523; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BifWnbvMFqEYHdXUte57ztIjcfVUf5/ZoyyaQBg0E0w=;
        b=BtvCZpcUkdBiSq3kG5agy0aqG/AQCBo72GyUG9T8sXZ/XWPKvdAkXTzcWxF8DHrX2C
         Mk2klaw/oKXvQko8qRQvp7uKiqY3gsQePEpU/Kk3a30oNe/RcQm/OjymGR8qgpEDAWEB
         t824Ljt/q9w1IjrEG7YwBDOT/58p0AxBW5bWBrwwWliGgYQLvgJ/vSzoOtlCs/FOH6Hm
         bcK244MVv8PIXrq7aDSf71/heFMebfJnBDs/WRr7618U3o5geSPoG6v9Bd/6jJKlPWfg
         W+y34ai6SrcqEEzKmwdvzM6T/KFDpfBeQftZ4IWQPDOUyvUP7EQ/UKsFHQdHbimzNaSN
         V/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925723; x=1791530523;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BifWnbvMFqEYHdXUte57ztIjcfVUf5/ZoyyaQBg0E0w=;
        b=cwggmlx5MH5O+PbHYsmMrcBC9bNda4NY5F6/+1NPpu33m1mamPexbSH1F5H7fRqoFG
         MQZb/4+f5t7RW16zC9rQeUzWUq+28C2bxr9PjxwsZ0Z+RFN5HnjCE+7OojxuSrIgu6MX
         cjJDxEMAZMuSR4hCGbFR53uJSSnzQzT5p+kQCgqynBxi5WWq+gwGJVbLUor/EMrfDyn4
         j7EMH2NbMX+JtZbEw8qeQpqO9h1r2QR61H7VkA+b5WBjqV8k3HGoTOqFXpmOW4kwggbE
         pFc0fx7RD47F4qcJefTC5sE/SgftRXE5Oi1EbDDR6aq4lQ9/+r8lepvzjvKXgrndk9OD
         0yHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTLRFGjHKebQpM2tvp+iaox7tkdN3vb96WHsM8i65XNdDlf0KJjZCFxPdLIxj/j6mvjG0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYHnnzGvNkzziHoHix3wszoNRvGYCy3nGmElcn7HITDmLDAwSF
	0FsRGI+xV0QxKtbEgo84APXteLMkX662KjNFemE54+xgtEIyESqDzlUadBtAFxrR/U28rv7Xjjz
	hXwb1exFsUh6O0cKD2gzGv/UAB70fAPk=
X-Gm-Gg: AYBFou39UOCrtq2Pzy2s3tHw8FUstanCkYQpZzk9yZ1gq5b3Utrg2oxO+fxgM8VR46N
	o+aeHyOZX4ZGqGd8xqzDjU5EujKGF58ak+NPEzEd7zU5+tOWKr9LbmL2bRmPlMuSAh2B6qVw0D+
	v6iLmUWDIr+9NDTLuX6j560xLGVRqxUks8o+l5Olm3Oks6yopwytKGsTN2pmo02AJE166XdO5HH
	U7Kph7JqeScER52w4HacVZxddddUICiKxVs7AE9h88vuATsIpFCIR7PmcOrG0xv+2BLTKsJGh/I
	TZS8w7OLmzuez4/dY94TDtJfuhj4vrXbidJQf4veJ34vXkiiRfnnSZyTVNncZ7jEMQ==
X-Received: by 2002:a05:6402:27c9:b0:6aa:f0e:a15f with SMTP id
 4fb4d7f45d1cf-6af9e34833cmr1072310a12.38.1790925723121; Fri, 02 Oct 2026
 00:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2430.git.git.1790801929375.gitgitgadget@gmail.com> <xmqqfqyq8lwj.fsf@gitster.g>
In-Reply-To: <xmqqfqyq8lwj.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 2 Oct 2026 09:21:26 +0200
X-Gm-Features: AclHuK-MqMMXSc_bvW9wyJ1zNNXha2QfBSCFr-fIPSBs4hRlLHLwJXu5GEh1_4Y
Message-ID: <CAHwyqnWQUHi3d8HKBAWzEgHoGwqSRfUnMy4jkVT-m2NWwnEizQ@mail.gmail.com>
Subject: Re: [PATCH] stash: allow custom conflict labels for pop
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is not a new problem, but is it just me who finds this
> "feature" more about "because we can do it", not "because we need to
> have it"?  Stepping back a bit, why did we add these three options
> to "stash apply" in the first place?
>
> If there is no good use case, perhaps what we should be doing is to
> remove from "git stash apply" these three options, not adding the
> same to another command.

Let's scrap this.

Would be interesting to remove it from 'apply' too. Can we "hide" it
by keeping it but just not documenting it?

Maybe that's a very bad idea.


Harald
