Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA246450
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964911; cv=none; b=cT5S7wXilVDYHH07Tt84NoZLSnb4YkwdP9LmhhG82ke3qLIefunjswWCqtqSR52AO9zvlANfaSgLA01hkPW1Fvz8N1kEjalDXOc6yZm428U0YPPBtOjEzUZwlmOWXSICjhC4HRbPpxaVg+Xv5VIAUYVvTOQKqdJTgLXH1v8ITtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964911; c=relaxed/simple;
	bh=FPv2JxnFlUEDBs4Uq7zBdIwq/P7NdDezwmGGMNmNKbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGWdWv/Lek8GAHTJRdVLVvGVO6iPnUKOutk7FlBonHptHOmIbDbjQHbMc1jAeduRxbNeYWGeycW4WyCKitkUEen+x4Z10VM+KbpQP34Ut+3gJowQd2rKtEkknz67wPNNvZpJKud8GuCLcCtKAZNPKNK8usFKazd03Xr9OIC68iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5cbe88f70so480213eaf.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 10:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964908; x=1723569708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eoQ0M5an7EI+6DELtKekTJqaOV0yIWXOWq6bqbpKls=;
        b=I0cZaqNM0fYwolSdDbr+0CtgyzQ1E6owVlMC48bStjWsfdm31HaK1JxqUaqHr/UTth
         876lpZczYBmfpfMNqGikhfEJnk8a5H0IjyVKubFwfQ6dXnbylywUwwkgttukZgt8/fMr
         Sq1kLZQaaNSIi0Gm5mMOTjVun/mbqttle8Vl4WQbggIfApxAjvKEe2pzcaIt6QMfNpo0
         Ag2kxP2UqNB+q/arsGw93qRz2hJTDrI5cGtMKfu5b8XxHXbOzS6YpomxBG7jhiMO4pp1
         0EZkayLnx0FELxUTvZqRHkwohZrK2RoC7bmFWpj7Hnm4KQv2HXvhB9fXG/ipR22Z2jnF
         kN5A==
X-Gm-Message-State: AOJu0YzW8/z621wGF6pzEh2/L29I9MclHht227A/wN0Elb5t0+FYPs46
	6pTcjZmWUOHqJDUmcLvEHTKRCWvJdikyLfJFbKKBqMCccy4/tezG76tq1bkYNoyXVIm8fTrNoN2
	LrYCao9CNhnUoffOfKFUO0JGcTtM6kQ==
X-Google-Smtp-Source: AGHT+IHHViiYgj9rM6c1OJ1LGpZsdGCjRsajWc0I7z1ab2ffBhGq6M7yKAyPWOvYAn1vSloT2I7LKm4aRnN75KYoxeM=
X-Received: by 2002:a05:6358:51d7:b0:1ab:9820:857f with SMTP id
 e5c5f4694b2df-1af3ba6249fmr1222894255d.18.1722964908498; Tue, 06 Aug 2024
 10:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805235917.190699-1-abdobngad@gmail.com> <20240805235917.190699-9-abdobngad@gmail.com>
 <CAPig+cSzq+6bua=T7w0M-+7+2zbzfD6ihXLkWfondZ8NbqUG4A@mail.gmail.com> <207c4f3c-c444-4405-bed7-34186efa1144@gmail.com>
In-Reply-To: <207c4f3c-c444-4405-bed7-34186efa1144@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 Aug 2024 13:21:37 -0400
Message-ID: <CAPig+cQPXh-wmNYGSEX_3-C3ydF-O7k22tAx8hB_N55ZYo-aDQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] [Newcomer] t7004: Use single quotes instead of
 double quotes
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:10=E2=80=AFAM AbdAlRahman Gad <abdobngad@gmail.com=
> wrote:
> On 8/6/24 06:02, Eric Sunshine wrote:
> > We need to exercise a bit of caution when making this sort of change
> > because a "..." string differs from a '...' string in shell. [...]
> > [...]
> > Having said all that, in this case, you seem to have lucked out and
> > nothing broke by changing the double-quotes to single-quotes around
> > the test bodies.
> >
> > However...
> > ... changing the double-quotes to single-quotes for the test _titles_
> > in these instances is actively wrong. In this case, we _want_
> > interpolation of `$option` to happen in the title string so that the
> > output looks like this:
> >      ok 167 - mixing incompatible modes with --contains is forbidden
> >
> > By changing the title to use single-quotes, you suppress interpolation
> > of `$option`, with the result that the displayed titles become rather
> > useless:
> >      ok 167 - mixing incompatible modes with $option is forbidden
>
> Thanks for the through explanation! Should I not include this patch in
> v5 as the test body is error-prune or should I revert changing the
> double-quotes to single-quotes for test description and keep the changes
> to the test body and send the patch with v5?

Overall, the changes made by this patch are valuable since it brings
the script more in line with modern practice and because single-quotes
around the test body make it easier for readers to reason about test
behavior. Coupled with the fact that none of the tests broke by
changing the bodies from double- to single-quote, it's a good idea to
keep this patch in v5 but omit the parts which break the test
descriptions.
