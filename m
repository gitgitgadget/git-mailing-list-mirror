Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28C16DC28
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278242; cv=none; b=INCQK7Dhgx2o9DxJBTDbOt0SYL4dRZkr6VKz6HNs41fUDnvJaw/7n6K2CoIwNoOd4VcH4OVueYR1vL/UCUzlgXhrII9gHQijJ6E2egBuYQBVDLik09QeIIAQcdO/dUSMPnyd6m9PDcMBkn68Uek8SbbZb5CY2z6gpUuNCqkgn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278242; c=relaxed/simple;
	bh=Gr+vkfrVCVRmdU+mLtSK2Nx6OTFDZoT290rBbzzZg2w=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=oGCjV2cd+SyOfYyGTGAgdTt9XfV+W/Ve+NxC3FooDHIsGViQEZVfHTQevmdFXzdnw1lUswtT1u+R86xHntpXIi4JXnzA3lHP/4JNCaUYSoUyusIv1pMJ+KU7UJPQjIBVETzR50jZOKOLit+6ObXWFRgB65z43Ke8gDPKl/xEoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=KnusSl8v; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="KnusSl8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=8+sw0VTNDaeh5tBlum7J/H4rB12J+iTNARJU7UpeCXk=;
 b=KnusSl8vXdufGMoAlSHp6+ELR7inxKUPPAUqdxFm4hYxws3FHvmF10rHMl6nNOEUaojJ7pVzKyS1
   eLY+6PpViF7c2IPOB3lVpesBbM6LvoJFPS4oB+u7B6nrVP/VsD6a1mV/iGS70pYu+XIiAfJNwfeU
   fZ90Zo7SSsV/uR9VwlcBPRFFxIhHdqa/h6Z6QOss1FAWmaUdfZeHVs93Qem2iRV9+WDpwPw5S+7D
   twL4YJy69xhjTGlWy3CyzebKGaMUeeeucgIbY0D0VJFEvy2vrC8yAsj0tXUWwHk7/oR7LJikyh/F
   aSQh/Vd+Q/k1Z3cghX3QFrYB5mhUzCBr63Afhg==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00ITDQFYOC60@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:23:58 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 22 Nov 2024 13:23:30 +0100
Message-id: <D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com>
To: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
Cc: <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com>
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
 <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
 <CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
In-reply-to:
 <CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
Reporting-Meta:
 AAGN7aBan77MbfXOZPfdOp38TJZ+yLtwIVHmtjoIulUFo1vBC91WQx5I9iiB+PAd
 +OJ1GES+9OUEPUbnbVtyGQvFN/tQ1McXv6bpq9PdOO6RIoE+8U7hhjMw7X6gP45A
 ug+qkGywrRp38ymHVY4QJElDWRZAdqmCoTU7SMgiI/pMGS3NTf7wbfiYR8IErorj
 UHmmQEXF/qIQVBN2Qjeae6THcPK5ULIJpXLviAXfOKzyKyujWxgf0zngCNgPJUdT
 HY++qdJ+FW0wsSv4DFNezLrAPwV08c+LJXEVVDjRYfhIv9yT8mNdRO36IedoL+VA
 TtzM6GtSn7zJXmouXouYpvk/vn0dHeL60PvgwdN3hl95vT13pPXmCCbDOeUUyL8H
 e0tJoBOX0YCDnEa+NnV86fATznzgjBNmrqpa2+wNBkowFMirjCTw/iPGSuRYNHk+
 FwAKaVLVrydM270xQtmgw2XwPyXzuU0FY8v3/qE+/sgSknQZOZW767xq


On Fri Nov 22, 2024 at 12:30, karthik nayak <karthik.188@gmail.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> On Fri Nov 22, 2024 at 11:37, karthik nayak <karthik.188@gmail.com> wrot=
e:
>>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>>
>>> [snip]
>>>
>>>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>>>> index 38eb14d591..1809e3426a 100644
>>>> --- a/refs/reftable-backend.c
>>>> +++ b/refs/reftable-backend.c
>>>> @@ -830,10 +830,12 @@ static int reftable_be_read_symbolic_ref(struct =
ref_store *ref_store,
>>>>  		return ret;
>>>>
>>>>  	ret =3D reftable_stack_read_ref(stack, refname, &ref);
>>>> -	if (ret =3D=3D 0 && ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>>>> +        if (ret)
>>>> +                ret =3D -1;
>>>> +        else if (ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>>>>  		strbuf_addstr(referent, ref.value.symref);
>>>> -	else
>>>> -		ret =3D -1;
>>>> +        else
>>>> +                ret =3D NOT_A_SYMREF;
>>>>
>>>
>>> I was building my series on top of this, and noticed whitespace issues
>>> here. A simple way to check your series is to run:
>>>
>>>   $ git log --check --pretty=3Dformat:"---% h% s"
>>
>> I ran this on v15 and it didn't produce any output.
>
> Did you already post v15? I only see v14

Not yet, but I'll be sending it in a pinch.

>
>> I read what --check is in
>> the manpages, although the format is a bit cryptic for me. What does tha=
t do
>> exactly?
>>
>
> It ensures that commits don't have conflict markers and that there are
> no trailing whitespaces and spaces followed by tabs by default.
>
> Also this is included in the CI checks (see ci/check-whitespace.sh), so
> if you use either GitLab or GitHub you should see these shown as errors
> on the CI. You'll have to raise a MR/PR to trigger the CI I believe.

I've been running the CI by pushing to a fork since Taylor first caught an
error I didn't see locally and it never flagged. Now that you mention it, I=
'll
also add log --check to my CI-s.

>
> On a sidenote, do you think we should modify the manpage? I found it
> comprehensible, but would be nice to clarify anything cryptic.

No, --check was quite clear, the `--pretty=3Dformat:"---% h% s"` part was w=
hat
was cryptic.

>
>> Anyhow if there was no output for v15 I should be fine, right?
>>
>
> At the least you should see `git log`'s output, but if there are issues
> they should be shown inline. So when you say 'no output' do you mean you
> see absolutely no output?

Absolutely no output:
	https://asciinema.org/a/lsqp4e1bNst6cFWw9M2jX1IqC

But I figured out why: the whitespace and the tabs were not mixed on the li=
ne,
just across lines. As I read it, that is not an error to have tabs on one l=
ine
and spaces on the next.

Anyhow that should be now cleared up, thanks. Gotta say, I was expecting to
learn about internals doing this, but I also ended up picking up a couple o=
f
usage things as well, like --range-diff for format patch and such.

Thanks,
Bence
