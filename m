Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302508BE0
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075682; cv=none; b=G0JJaGlJxjyPJOqR8pKRERd3aGxuaicWhNpYt5oOMEG9HvxrLTu1ctKlgSg0riKL+RVJe1xUzsVvHkG/55NFvOdeEXZu8UMGNwLbivWUBrlxAtGTr4XMBUKNd/FOZtmfYAxZLt4QM4QPsELBQ6qR9uneHW/BgX8qnvaNItLeWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075682; c=relaxed/simple;
	bh=A5ngiTeWC15uwblfvk9rPZ1X1TzWK41j+xfpUF6zJVE=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=lET/B5ujzR3PmVdEEBk6K9Fm1SZd+MJr7uXz3rD5kw/mUKdbn2N+ETNRP0x7l6EcAPCJbUdkyW7Y3O00pEzux/IEwWw7lOzghVVbSqZV9dQ4/+f/fdmRyCYAH2E2fcTUuYlbg+mReAYmDSmdwGa7P1mRk+AyL0rI1Nar1W47M5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+p/A6vv; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+p/A6vv"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-368713f2f23so622115ab.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711075680; x=1711680480; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1lbEz7LzWhSfTeo7VG4R88W7sYNCT/uMyBYE0vbc3g=;
        b=c+p/A6vvK7UasotVKuPf7dgSXoATvSpZeFTTqO98qvQbevT2BxdXKsAh2hnlWIyH8n
         7vtoEWWPuKHum3h+oO8vtC8Gpz/eqsFOQPHlUR7lm97e2bYEK0YljaKE74mGV4NDXISb
         bpe3gbB2DQ9Hnoqanal4aplRwtDeOY4PoFRJQKIPN7HWeOdq1lsYjhbcoUE3qMQtYYzU
         ljz+EVtkwMxVnJ5jqbfxGqsDxL2xQqZKtMpa2WXOVtBI8nbtgorArWZTrqKSOjngApTZ
         XTA97Nx5XJA1M7knIbkE9TwyUn515dkGXPSYRjNUQj0oGlcw1WY0HIO3VZpjCYuOQrqC
         Oeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711075680; x=1711680480;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1lbEz7LzWhSfTeo7VG4R88W7sYNCT/uMyBYE0vbc3g=;
        b=W9B2sSTIYR5E8zoRXwDMfC0bADsP3RmA1myrBDlmTWHf5UrehXvqJtHN5GX3XCGvws
         59x6Z4cNMFOq1uVOaoCZoloDwguJl7xPg5FLoRNIMBjhUJgPMXPrtPn0EWQSVSaFlojT
         oLmordJsAkehgMqcPQJ9ZQ113lHZ3mlrDCySJNgcwVPITBtJ4Qa/6qRfIVvfCSreV/B9
         aI92JtSmG0/Oxa0GAPaYctnqol8fmBft9aYTdgNYxMp+WPokIBfPOF9iTmIqVVYuGC4z
         q08mmYO6isZprUSHCJ4qG1LtDP9sVNIp7U+UOgK9lAY5OUFvtzFmieHPolKEoOfPPfJX
         LFbQ==
X-Gm-Message-State: AOJu0YwsNuGs6I9zOysCTS5GVUWIq3RD9iR2KmBcvAoCjBwU3vpPVJpT
	C1mPbFBoEnkZnQ+cHz7XcBCIARU0sDxmCMEQI1QO1JebotsbZkXfpsJsSlk8
X-Google-Smtp-Source: AGHT+IGLhyZpJyL3mYI/j5om+WbDYhqKxb7rZkPl6Jg6MEUNFFCgx06UJQo1K/74GAZQ86iiBASxSg==
X-Received: by 2002:a92:d185:0:b0:365:d2be:3de6 with SMTP id z5-20020a92d185000000b00365d2be3de6mr1364465ilz.2.1711075680089;
        Thu, 21 Mar 2024 19:48:00 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id n13-20020a02a90d000000b0047710c4c115sm277387jam.161.2024.03.21.19.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 19:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqcyrn58mf.fsf@gitster.g>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>, 
	"=?utf-8?Q?Jean-No=C3=ABl_AVILA?=" <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
Message-ID: <17bef643ca4eabab.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 22 Mar 2024 02:47:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Thu, Mar 21, 2024 at 8:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> "Brian Lyles" <brianmlyles@gmail.com> writes:
>=20
>> Yes, I suspect you are right. I think the cover letter would be a good
>> start at the very least. Would you welcome a patch to
>> 'Documentation/SubmittingPatches' that adds a new expectation for this,
>> or do you think this would be best handled yourself? I am interested in
>> contributing but, as I'm sure you've noticed, I'm also quite new to the
>> project =3D)
>=20
> I'd prefer to start with a much less official "experimental" launch
> of such a new workflow, instead of adding an unproven idea as if it
> is a new hard requirement to the SubmittingPatches document.  If it
> works well, we can write it down later.
>=20
> But even a soft launch needs some way to advertise it to the target
> audience, and the SubmittingPatches document is the only sensible
> place to do so.  So, perhaps do something like this?  I dunno.

I would agree that it would be hard to advertise without some change
there. I think that documenting an optional opportunity for now before
considering if it should be a requirement later makes sense.

> ------- >8 ------------- >8 ------------- >8 -------
> Subject: SubmittingPatches: release-notes entry experiment
>=20
> It has been the maintainer's task to prepare the description of each
> topic listed in the "What's cooking" report.  The description is
> automatically picked up from the "What's cooking" report and used in
> the commit log message of the merge commit when the topic is merged
> into integration branches.  These commit log messges of the merge
> commits are then propagated to the release notes.
>=20
> The original author of a topic may be in the best position to write
> the initial description of a topic, but we so far lacked a formal
> channel for the author to tell what description to use.  The usual
> procedure has been to see the topic described in "What's cooking"
> report, and then either complain about inaccurate explanation and/or
> offer a rewrite.
>=20
> Let's try an experiment to optionally let the author propose the one
> paragraph description when the topic is submitted.  Pick the cover
> letter as the logical place to do so, and describe an experimental
> workflow in the SubmittingPatches document.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  [for what's cooking]
>  * An experimental procedure for a topic author to propose the topic
>    description to be used in "What's cooking" report and in the
>    release notes have been added to the SubmittingPatches document.
>=20
>  Documentation/SubmittingPatches | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPat=
ches
> index e734a3f0f1..05e15b9436 100644
> --- i/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -459,6 +459,17 @@ an explanation of changes between each iteration can =
be kept in
>  Git-notes and inserted automatically following the three-dash
>  line via `git format-patch --notes`.
> =20
> +[[a-paragraph-summary]]
> +
> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
> +paragraph summary that appears in the "What's cooking" report when it
> +is picked up to explain the topic.  If you choose to do so, please
> +write 2-5 lines of a paragraph that will fit well in our release notes
> +(see Documentation/RelNotes/* directory for examples), and put it in
> +the cover letter, clearly marked as such.  For a single-patch series,
> +use the space between the three-dash line and the diffstat, as
> +described earlier.

Would it be beneficial to request some specific heading, phrase, or
other structured text such that this summary is obvious, or even easily
extracted with some sort of script? Or is that perhaps overkill for now?
I could see relying on any sort of automatic extraction being unreliable
even with such a recommendation so perhaps it's not worth pursuing for
that reason, but I could imagine it may be useful to have a standardized
way to separate this release notes/what's cooking summary from the rest
of the cover letter (which also acts as a summary of the series).

But in general, I think this looks like a good proposal. Thanks!

> +
>  [[attachment]]
>  Do not attach the patch as a MIME attachment, compressed or not.
>  Do not let your e-mail client send quoted-printable.  Do not let

--=20
Thank you,
Brian Lyles
