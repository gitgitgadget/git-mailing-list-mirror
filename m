Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B110501F3F
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547697; cv=pass; b=L/UpuwN0TPCj6zvYJVM4fSFSsDObkwvauceQimTpr/1yhXoP/9AG3+MFAaEKeWrglM7upPPPUKfCd6yw+SBqsZemLoRq9LRz6YAbZr4GfP0m96R6KXYCiLUrHO5RWzqrSVkMggjj9yHMbdKw6iph604Aw3Ha0MB8NGLj1N4hhTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547697; c=relaxed/simple;
	bh=lHj7WLSd8lklFPwwu/afG/QtNqpbcWDaEDJgoRy3PJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZegor1K2b35d2kP1wCSpCzlU8X2yRwuhQzhR0KdvThRu2m9Lt+OYnz2CXYiaGp+MhKqVyhn08dLXYKqy12yNd9FJrxIB5Ra1kYJgpjebPK1aH1S7cJQsb+iDgwFFblVIRJS3Md0ZX5vkkDrL1+TZUmENT+iYH39U2ilF5ixZcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso18332595e9.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 11:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788547693; cv=none;
        d=google.com; s=arc-20260327;
        b=E+UAT5E1pilLutlpz1t56B2CBr3iP3HrDpAlHXZYQf6HVi9HHsuH6aiWCBWFesuHf6
         J+8nNPVL1AFkCN0LklXUUkN7cHwe7SqZSoDHLFbqZUlEV7hx2mxTnglB9jwoAPzOQOzq
         IaIXmZxnLmv0oOdyF4VD75U006pSFGWzbb81yWHMcgzBViuJx8p6SUppK8Tbprl3aQRD
         igZSqSOQ/X1j3jMF7vz1apMc14OisvZ6K2WC3JdwR6xvlis5/Fe+zS+mhygx5MIr24nF
         4uZgI57AEAwVIjHeotJ1YKlV1KtjYySR8PA8GV4EWxMzOIyPhQBuIYtDOcIuzZT6LHZb
         7Wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=7AhIrYcp2uA06Iixxth3SFZz9Aa1fC0nFH3vGZu+ybw=;
        fh=anyqXcJa+fgiqxjkSnttRt7wAhh2FcfGkcVESvoAkwk=;
        b=QjdatIvAoG23Vb4gKnDBvwKywcHjEwRRRnJtn1d/xsMrWv2TWNdwiS4Wja917oys6d
         mggrjnXHC9z7UV6zeno4S3lMz2upuK9jPHMmLqYfSPmZW0YZFWMoFyneGDqALDjtyGCM
         Q+GK9kBol5oji6pefjrYZnGyj+yVaFicpUnYWPotaieIBQ/kwKjg6aanZwte+d9H5WRb
         QgmVjagpY5+RAuv2bLJDrCGkl7owx3+iBujZsQDK5vGgE3J1ZCFutxRZTOL645UyiwVz
         A+UEf8Rt9/bAf5wZPngwU1fPdW+szB9QZt+rL+05lu1cAqprUulK54Q684n14ZGx3np/
         7pDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788547693; x=1789152493;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7AhIrYcp2uA06Iixxth3SFZz9Aa1fC0nFH3vGZu+ybw=;
        b=X7Em6rvWyTJbMtv0xs+rd9ywTNP6/tPTfPucOqVUOwnO4ATRiV3iOof7/En2hjGVmc
         A0SUuEyEnSKSuDq0VbUTSBmMeAl9EY+ET/T+cyIO4yQ3rbEgs+6T5Q3xUgbS0C2KQP3s
         AgdowmXo5rmUF/o9KLxiVZgLxsNMh6GvcRup36HUKr2qCopAj2Odrw1xBlUbsgn9cFdR
         rIUt1qI0FDGFv+k/3bD/EHL50yKCYBL99FDv016PlVqBkk9DzYmRMFT9QxsSvI5yyrPr
         gjSLia/NycLohSgrENesHgHCrEOpstoEUS9eI/LI4vxE26XZhZG1MUwMqJXk5qoJ5iEh
         gSJw==
X-Gm-Message-State: AFuF++mIri7WMrOJZAkkRrdvsmtf1AfdYUg8ex/sg/mLCZoyKCXEwUGa
	Aq/sfzgRHvgmQtgnvG8SarCvFjjpRpGARiP5nTrAjbqFDC0CgSp/7u62vCE0T8U/+9ANDs3vl2I
	BoBhOnhjft/95pa6lejdDqiGCFBkTsK4=
X-Gm-Gg: AYBFou2YscEE6NGumNoZRWQlIJeIGCZs9qgcMFnl4MGwncGDwB6iIFoyTvgXTlTAADE
	PvqL6wVpVuuhaN52cmC/iOueYe0rnGOsXzTk1PEZH7ztJ/AFAu7xKVzPeA/iAbB68YCKyOviJOC
	J9VY0P/r3VBdjfj4sYZIU2uS1/vhrQNL1EuHaPqJK6ijj8kJa5j/X8J6gBbbip2WeftMZOiFxhv
	sZUNQniKNfEn/UdTdiVoEFkqNG6gyHiOdzM+FEgJACH54gyr21ADDv+SntA2pSRxiLhyXjf8CFZ
	W5hVcPRurVSGpamjpB8MTlKTW9cCCsjwmUylNKXMXiNdzEjT/3cvAkKS7y3Sm3Azr0sHlCXia0G
	PVsP6edZ9k6z7lLJW8nQ/EQ0w72lqvuHQRb+swGzqgL2e7hA2TWbFSJAdorZph0Xix7I2YjIP9f
	1Keg+85Tuvc7A3UncFKKN+
X-Received: by 2002:a05:600c:3544:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49cf82bea0amr63272475e9.3.1788547693374; Fri, 04 Sep 2026
 11:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518112225.73172-2-erik@cervined.in> <cover.1779792311.git.erik@cervined.in>
 <b3fc743abf5d35fbb23c7483836de292ad5bffda.1779792311.git.erik@cervined.in> <xmqq1pbkefh0.fsf@gitster.g>
In-Reply-To: <xmqq1pbkefh0.fsf@gitster.g>
From: Erik Cervin Edin <erik@cervined.in>
Date: Fri, 4 Sep 2026 20:47:35 +0200
X-Gm-Features: AcwNN1V7r6KVWAoOM5EAUitIkvdQS9_W6af_qUBXX2ElczgYCo877G6EZbG-lJo
Message-ID: <CA+JQ7M__GOnM9LHt0txry-G2z2CKhdZr0b-rU=Yd_A0gCEwmaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] commit: allow -c/-C for all kinds of --fixup
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Aug 2026 at 23:31, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, but this topic has been hanging without getting any reviews
> on the list for quite a while.
>
> Any takers?

I'm a little unfamiliar with this part of the mailing list, but yes,
it's been a while. I've been assuming people are busy with other
things, which is ofc okay. If there's anything I can do on my side to
help make this easier I'm happy to. I may be slow to respond since I
check this thread less frequently these days.

FWIW I've been dogfooding these options to reword commit messages the
last few months and found it pretty useful so far.

> One small thing I noticed appears here:
>
> > @@ -1341,7 +1346,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
> >               die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> >       die_for_incompatible_opt3(!!use_message, "-C",
> >                                 !!edit_message, "-c",
> > -                               !!fixup_message, "--fixup");
> > +                               !!logfile, "-F");
> >       die_for_incompatible_opt4(have_option_m, "-m",
> >                                 !!edit_message, "-c",
> >                                 !!use_message, "-C",
>
> This blocks -C, -c, -F from being used together.  But the next
> opt4() covers these combinations already:
>
>         die_for_incompatible_opt4(have_option_m, "-m",
>                                   !!edit_message, "-c",
>                                   !!use_message, "-C",
>                                   !!logfile, "-F")

That looks like it's worth a second look. I'll be away for a few weeks
but I'll take a look at that when I get back.
