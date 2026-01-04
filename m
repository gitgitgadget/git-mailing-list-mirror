Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB061A9B24
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767521605; cv=none; b=qMebkIbrYrwj+n1Fj+RCuw3Au4Jc2+Tu3lHkFtntENKoX21+JlATiSYWomxGoExK+lRN55PNTXn/8iYsJcE+fRa+3KqLSRMUiBqttx0GWA9X19DIuTHRFaA8a9LDOk8nqoUt7x9Vn0W9knpXtfxM7sB6EZfNhOoQD0XcXKlMWTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767521605; c=relaxed/simple;
	bh=aGCHgg8AFkOGEpjpwKlLJ/KlY1xogPgyWkwvUcQXHsY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFlqI3QgkTDx5T/OzTj8nwOY8MMEqIEIa25CL0fjJcMTqMH0VFK4qAR0sGyu+a0cHe6tqoBxR2sYx73bnSSvq/Bl+6hR1bISDB0Vm85FP78p9BFSAaKK36ARPlpHqIxdkMO2HAthRy5qsJ56WajeFBXZr1yiqM/iFZN4nLXSzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Ju5yIuUW; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Ju5yIuUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767521594; x=1767780794;
	bh=kHIJYihwtc35SVCg51MmT6s0vVcCExlFxBJkoYAYyE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ju5yIuUWaAcPMlKdwNMkQqdeQ12swXaR9i12Y2fJuMQrxHNq/bmmWlLRo85VbaJCN
	 UzAL6uwQdN3dTHfRGYlFmPRnCNqkgGutonxxV2JTPdVdfenmtq6Kj2GR5/5pxrwHd4
	 a2Iw94dvQACthDU9wj6WLz+8CcapQ0Quud+nYzLWNHbO7iSv2yh1EmwVXFUjAO5duF
	 rhXqLnZawlDBZKD96yaDo3Tw04giUqHy5en3aEcrk2YJvUoPbanRfMOMdNLdOD9/vQ
	 gVZR2wEn92c8HG1VlYzfv0RNdJLKX5Nl19ZxkHk3Ptrm9TMLi7HRsGNIEKIR2fwNav
	 Z9+zqhtEJarXg==
Date: Sun, 04 Jan 2026 10:13:09 +0000
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "ps@pks.im" <ps@pks.im>
Subject: Re: [PATCH] reftable/iter: fix undefined behavior in indexed_table_ref_iter_next
Message-ID: <vKH4wrIZEyr9jZkXQad8wEowMcZq4fewU0z92Fdvv06lwH3e-pDFrvqjvehUFnmxO48-VGbwBP-ZzFubTlQEoIMeruyhqGBdRLmyU61nZ-k=@protonmail.com>
In-Reply-To: <CALE2CrQTvHeu21yLXtRg=A6ak9AB_vvwPirQNFDjZ2AmhoTzTQ@mail.gmail.com>
References: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com> <CALE2CrQTvHeu21yLXtRg=A6ak9AB_vvwPirQNFDjZ2AmhoTzTQ@mail.gmail.com>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: 84b84b3cc2515e96a790f83c091d3c35e009ac95
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is my first contribution attempt I am so happy I didn=E2=80=99t messed=
 it up
I found few more issues I will address them one by one
You made my day thank you


Sent from Proton Mail for iOS.

-------- Original Message --------
On Saturday, 01/03/26 at 09:35 Pushkar Singh <pushkarkumarsingh1970@gmail.c=
om> wrote:
Hi Tsahi,

Thanks for working on this.

The issue and fix make sense to me. Guarding access to the val2 members
behind a value_type check avoids the undefined behavior noted by the
existing comment, and explicitly handling REFTABLE_REF_VAL1 here matches
the pattern already used in filtering_ref_iterator_next().

I didn=E2=80=99t spot any issues with the control flow or logic in this cha=
nge.

Thanks for addressing this.

Pushkar

On Sat, Jan 3, 2026 at 12:47=E2=80=AFAM Tsahi Elkayam
<Tsahi.Elkayam@protonmail.com> wrote:
>
>
>
>   The indexed_table_ref_iter_next() function accesses ref->value.val2
>   without first checking the ref's value_type. This is undefined behavior
>   when the ref is not of type REFTABLE_REF_VAL2.
>
>   The correct pattern is already used in filtering_ref_iterator_next()
>   which checks value_type before accessing the appropriate union member.
>   Apply the same pattern here:
>
>    - Check for REFTABLE_REF_VAL2 before accessing val2 members
>    - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs
>
>   This was marked with a "/* BUG */" comment indicating the issue was
>   known but not yet fixed.
>
>   Signed-off-by: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
>   ---
>    reftable/iter.c | 13 ++++++++-----
>    1 file changed, 8 insertions(+), 5 deletions(-)
>
>   diff --git a/reftable/iter.c b/reftable/iter.c
>   index 2ecc52b336..2eee65bb1e 100644
>   --- a/reftable/iter.c
>   +++ b/reftable/iter.c
>   @@ -171,12 +171,15 @@ static int indexed_table_ref_iter_next(void *p, s=
truct reftable_record *rec)
>                         }
>                         continue;
>                 }
>   -             /* BUG */
>   -             if (!memcmp(it->oid.buf, ref->value.val2.target_value,
>   -                         it->oid.len) ||
>   -                 !memcmp(it->oid.buf, ref->value.val2.value, it->oid.l=
en)) {
>   +             if (ref->value_type =3D=3D REFTABLE_REF_VAL2 &&
>   +                 (!memcmp(it->oid.buf, ref->value.val2.target_value,
>   +                          it->oid.len) ||
>   +                  !memcmp(it->oid.buf, ref->value.val2.value, it->oid.=
len)))
>   +                     return 0;
>   +
>   +             if (ref->value_type =3D=3D REFTABLE_REF_VAL1 &&
>   +                 !memcmp(it->oid.buf, ref->value.val1, it->oid.len))
>                         return 0;
>   -             }
>         }
>    }
>
>   --
>   2.37.1 (Apple Git-137.1)
>

