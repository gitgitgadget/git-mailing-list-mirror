Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E522333D
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825755; cv=none; b=izT67EpiOzI4dq/jixNIJpFsOGKYDl/iw6A1zIgOG5bCItbKDP8c6gcLUHLc4yKm79AvKvuvLG13BHkVdZVBj31SifDihBK7/nHdLYs9Sf5oRYNSzw/Al/8QUWLEByTEH7k9hnWmsoWSEPEbFUOd08RjDd1lSl4H4WFYFPfv/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825755; c=relaxed/simple;
	bh=PMME3EGaA7VY2PGtbBipkWEnrtrwXX4Tc77w1ZkgQAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH/xsGuBlaw7i3D3414MCxJQD+7UKH5HdEDtPq5rvB2V/+ODSQEOzInq+K5yX83QU5dZE59KvG5h4XZNtbhyCI2qergYZsWniFW+b6OdXjA1dPP5QSspTQULp+MzhRU+La3RaA69bHkE+x0CGHWtP140CInh3xFo9kqbC+M/yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAWr2Bwu; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAWr2Bwu"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5816442a91.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753825753; x=1754430553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMME3EGaA7VY2PGtbBipkWEnrtrwXX4Tc77w1ZkgQAM=;
        b=gAWr2Bwu/OXMETMR25dqRc2pekdRNUm3I0z651fB8d6dqwsAGayZhQ7cpeXW+O6qyX
         zi8Bzjs06FyoWsiu4l1FpwwOF0V/jZnlAcryhjIeHIHCT9WSSa6XafcCRgQajxhnO6DV
         zv/X4/yMs0PdspCoIHkdqB7MQnPGW9GcA++huVZPu/fOqlXUTZeI6sXG5j86KgyDqumw
         oNLih9VglwTz6bA5eVO8BEWnE07P55hU5kJDp4z6UyLG/ptWDfHQAOj5GlIV0VZnFUBk
         okI28Hd2mRS5M2rr9G2ypVO7LKiyjeLpVlyJBg+JRtTRymAKUEwD7A+4Pq5Nxl3sNu+t
         gfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753825753; x=1754430553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMME3EGaA7VY2PGtbBipkWEnrtrwXX4Tc77w1ZkgQAM=;
        b=rVDNsJ0qoetmdsQVrspkbAQBDY8fpE9WjSBx5JKV9fvSCxDm4tF8pNm1hRhKEz3vr+
         1oFG1qFXVGiADxjTHpWVx13pCK5HAgx2lJKRdsgr1imy3QviuOYnbGefbd+Gf1ip1Egx
         okGEf1aG5g29s9zg1ndcCPKKunqM3AgN0MzoZKv8u3uHq2G+ILWdOKu1wXx1Uy9OfDZb
         RvRJb3TGIKKJ9U3VEVe8duhXQxMyD8VRrRnRXMr0uMC5j2jR+E/vTOJIuXxdk1rq9PaA
         NynOwY2ZYefA0heHNCD45ilsfpMvrOkWRgykad6yc9fy9N8fVP+mD5druqw1KTZMJV0o
         28bA==
X-Gm-Message-State: AOJu0YzYEe0ocURoIRgXz4FK1LEc2FNSJ+nxxAZHxdCBH/rjsqLjRRfn
	+sbjavAj6HUl0BJEpnOEr122PYJ/NqFDLez24dmYLe5tNg8LZoZmjUBXMhyafjt8o6sY1OjkbrQ
	Wa/+eBmoxaN+TJa6DpFQhKQjOu4RxQgU=
X-Gm-Gg: ASbGnctdYjtuu055SLOGZK9+vNN3qOu1so5wIYXCQS8Q//ukGlBi7kFkCUKFaQeBU70
	2n8I6sFyMFIb9vwLW+RF4Mi8Jd6iMWLCWCnEkpZ96QQqfC0O7KnW+EH/h8bERAfAIBzFnr1kB+x
	VC92D5CPWp70HOK2Kx+0yoDH4sLfFcDgoV05am0jwIVNtOcvTGImCuDiB4d5hVu+K7DGZ+of91R
	837hAzd
X-Google-Smtp-Source: AGHT+IEXQLpwmvCC5h2Eho2aDYRc39FksSo0OIDrDV4vS1JM1R2O5IdGsd+qC31b14Df7XqQ3zbrN6CD1JabWc2S9xA=
X-Received: by 2002:a17:90b:3fcf:b0:31f:485f:fab6 with SMTP id
 98e67ed59e1d1-31f5dd90306mr1361608a91.4.1753825753311; Tue, 29 Jul 2025
 14:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753804956.git.ayu.chandekar@gmail.com> <04d6f682a6b2257e14682e809a2fd01ccfcf0d08.1753804956.git.ayu.chandekar@gmail.com>
 <xmqqjz3rospl.fsf@gitster.g>
In-Reply-To: <xmqqjz3rospl.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 30 Jul 2025 03:19:01 +0530
X-Gm-Features: Ac12FXy4c5KjfsfBhIz8OcXY0SY0pPbTb6syD00BvsjZdba8GLt1XMAoDe8bO_U
Message-ID: <CAE7as+ZUcqRbnOC11DQ7=b+YB+9HTfjfqCvxzmz+mpSH6DxkGQ@mail.gmail.com>
Subject: Re: [GSOC PATCH 2/2] builtin/fmt-merge-msg: stop depending on 'the_repository'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> > Refactor builtin/fmt-merge-msg.c to remove the dependancy on the global
> > 'the_repository'. Replace all the occurrences of 'the_repository' with
> > 'repo', where 'repo' is a pointer to 'struct repository' passed to the
> > function 'cmd_fmt_merge_msg()' and thus remove the definition '#define
> > USE_THE_REPOSITORY_VARIABLE'. Also, add a test to make sure that "git
> > fmt-merge-msg -h" can be called outside a repository.
>
> This also moves the call to git_config()/repo_config() after
> parse_options().
>
> It generally is a bad idea to read command line options first and
> then read the configuration (it is a bug if such a flow causes
> values from configuration to overwrite values from command line).
> THe current set of options and configuration variables may not
> overlap, in which case such a questionable arrangement happen to be
> without bug right now, but it would prevent future developers from
> adding new options and configuration variables and make them
> interact with each other in the most natural way.
>

I understand it, but how do we tackle if NULL repository is passed.

> In any case, the reason for this change of the order between config
> and parse-options is not explained at all in the proposed log
> message.
>

 Apologies, I will mention it.
