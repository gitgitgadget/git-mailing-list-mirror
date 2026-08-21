Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66917A314
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315275; cv=none; b=j8bawKROn0agd9PSojWxy/O+m6SeesNlMMq65UbBm3ZLBJTpFRhID8lW1hoICaasuZcTf+TNM1EplLgi35cbEilz5KiTN8zKtSGk23kS+IsbKJybEt9oSg1JQhHFOTETWZ9Eo1qpodYuQKctc/CJTzPMY55rbjqINrI5x8awWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315275; c=relaxed/simple;
	bh=5IX15MZ/SAM6bmwioDa2V3DZmm3MC+scpXHfJ8J7Las=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hu8HRA+o+Lqru4KCQnIw1zNq9rEa1AoYJEi15RJwd1GVkOdWaziWGQ9qNv/domLKYMo9VVpHL2Nhw/Fhcndfc5C3fgnR1RVLRNU3HH4g+AYrwA8myuDA6Y6PjrAM/HwV34yg/eCsaTcSTwMw/JB6lRy0wIpXccihEHDaVT3I0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fahldieck.de; spf=pass smtp.mailfrom=fahldieck.de; dkim=pass (2048-bit key) header.d=fahldieck.de header.i=@fahldieck.de header.b=u/Wf+HLj; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fahldieck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fahldieck.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fahldieck.de header.i=@fahldieck.de header.b="u/Wf+HLj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fahldieck.de; s=blu9537877; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description;
	bh=VCpWp/w8ptZoAxuhPOgMyXO7xK+3zcWUAXDFd3O9zD4=; b=u/Wf+HLj0t/SNGxFUU5W6NY7b+
	N3U0YRurdoO2w+ai07zUrE3mwdODmiqPLBExKrwfX/Mh4bzs1uLT6KMRDC/L18fVjtED7jq5hAD5L
	fogqc0fldEK938ZHW8FpU5g2UUURA4Bs9bL+xxcgr61/4H7TcyOO8uUdrhwFu0ymJTcIJtwb5Bz3u
	AB2hm3qlPiRwr5+G6J8BZ9bcl/qZNsZh02G3IQyRZwW5blzYf+WR6HZRtqL72qA+LwgJB4jSNG9Hm
	tJFmlu4HY6T8hT05SxgY/VAwud/PCfCqBUe/ggJWkBZJeYKIZHyEaOTJ7DAwhYqBo0jmqcBmtpXf5
	AvL+TpMA==;
Received: from [209.85.128.178] (helo=mail-yw1-f178.google.com)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nils@fahldieck.de>)
	id 1wxLRU-00AoBd-Sz
	for git@vger.kernel.org;
	Fri, 21 Aug 2026 11:21:40 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836cde02992so9819047b3.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 02:21:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrb3W66LeDft9r5WBglRz70JNqPrPZXYsyUpT0PTNgcwRrRZ/eD7FkPJowKOJHONeCMXoA=@vger.kernel.org
X-Gm-Message-State: AFuF++lZnmzsTFMNbToJE1XUJs1oMAcbu3PFgwPmk6NqOvPqUBnBwGqv
	r0ejEeo5mo0pwY/UGiVEuHz02n421bId/JtqBWxKxCMEcpusUMUiqqjoVdsg0j8QnTf7nUzVBwh
	HwgJznFWTEy+0IhtZZ9RzVwDNlZ++USQ=
X-Received: by 2002:a05:690c:2503:b0:847:d0cd:11eb with SMTP id
 00721157ae682-849f2a38e40mr19670167b3.9.1787304099576; Fri, 21 Aug 2026
 02:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6fojkds.fsf@gitster.g> <336EEC18-98D3-4068-8C5C-476749959814@gmail.com>
 <an1dekUM_fsM_l8d-delilahwu@linux.microsoft.com>
In-Reply-To: <an1dekUM_fsM_l8d-delilahwu@linux.microsoft.com>
From: Nils Fahldieck <nils@fahldieck.de>
Date: Fri, 21 Aug 2026 11:21:02 +0200
X-Gmail-Original-Message-ID: <CAAdFe9z92-h8eQmwxzZ=1cCB_8ptTHKnL1QMWAO=VEJVHe07OQ@mail.gmail.com>
X-Gm-Features: AcwNN1VfF1q-G-1L5BRDw2nnDpMJK2n9LooWfq5ffQiYqFDi7BdQ5Z7G7_k5rso
Message-ID: <CAAdFe9z92-h8eQmwxzZ=1cCB_8ptTHKnL1QMWAO=VEJVHe07OQ@mail.gmail.com>
Subject: Re: [BUG] git config --global: doc and behaviour disagree when
 ~/.gitconfig and XDG config file coexist
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Nils Fahldieck <nils@fahldieck.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Con-Id: 301193
X-Con-U: 0-nils

Hi Delilah, thank you for chiming into this thread. I am very excited
to be reading about your progress, patches and everything you've
contributed so far.

> Since then, I've addressed most of the review feedback. I have a draft
> v2 series [4] almost ready for reroll.

When you have the v2 of your patch ready, please let me know and I am
happy to provide any feedback. I really like to see this change
happening.

Am Do., 13. Aug. 2026 um 08:07 Uhr schrieb Delilah Ashley Wu
<delilahwu@linux.microsoft.com>:
>
> On Fri, Jul 31, 2026 at 09:14:07AM +1000, Ben Knoble wrote:
> >> Le 31 juil. 2026 =C3=A0 05:35, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
> >> =EF=BB=BFNils Fahldieck <nils@fahldieck.de> writes:
> >>> 2. The reading claim is outright wrong.
> >>>
> >>>   The docs say --global reads from BOTH files.  The code reads from
> >>>   ONE.  git_global_config() selects a winner and frees the other
> >>>   path.  There is no code path under --global that reads both files.
> >>
> >> The documentation needs to be corrected, I think.
> >
> > Agreed based on recent thread <20260720113402.0dc16abe@frustcomp.hnjs.h=
ome.arpa>
> > (subject =C2=AB git config: unintuitive behavior with - -global and - -=
no-includes =C2=BB
>
> A previous thread [1] said this behavior could be a bug. So, last year,
> I submitted a patch series [2] to align behavior with documentation,
> changing `git config` to read from both files. We gave time for the
> community to comment on whether we should change the behavior or the
> documentation, but there weren't any strong opinions [3]. The only
> responses were a correction to my cover letter and a technical review of
> my patches.
>
> Since then, I've addressed most of the review feedback. I have a draft
> v2 series [4] almost ready for reroll. I only work on it during "side
> project time" [5] at my workplace, but I'll try to have v2 ready soon
> for further discussion/review.
>
> [1] https://lore.kernel.org/git/xmqqmt5lezi3.fsf@gitster.g/
> [2] https://lore.kernel.org/git/pull.1938.git.1760058849.gitgitgadget@gma=
il.com/
> [3] https://lore.kernel.org/git/xmqqtsysfakt.fsf@gitster.g/
> [4] https://github.com/gitgitgadget/git/pull/2196
> [5] https://en.wikipedia.org/wiki/Side_project_time
