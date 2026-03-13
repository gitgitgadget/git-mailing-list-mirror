Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3A3CBE6F
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422136; cv=none; b=MhACzRa2na39qF4th0W+NQubqmcEatNQYMxHnECEfZLnN5s6520U4k2X7ijvxOl8lKxmUIJHoXXWm6T6f/Cn6A3zz5PCSvIOgECzZ5+aAiYApo6Xpbv0oj3fPqvoSJ4pq0bblHLR5VE6H6tiO6uy18KBWAh8lXSqOJp5AbuKnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422136; c=relaxed/simple;
	bh=ON8pVreABRTVSFw2W2b0B4UmZdGoLmXsHZ28nV3T9MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/rKbvGf2TrYE1yNxAK7QtFf5ZKhZeYdtkvx1HE8fn0Vo/JhS6TGjNPKzSNmNbYELeP6AEQ0kFWHUw95jC3/mw0BbzqlFPyeMMudOvYb77hsB0lWHs7SpLfoJcJGjIJh9ptD+pYAHP9Mh5N9ZqfUq0H5STh57AC93jB09R1mUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=RpXGzRM0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RiVMrWv6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="RpXGzRM0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RiVMrWv6"
DKIM-Signature: a=rsa-sha256; b=RpXGzRM0gJGD5yaJ4RwarH+qElBgxdqeM91mxTtw9zNDUjuAynTJQDUfojX9Z82hLvCtZWekLWT+ChtdzPwYNWqQy61frDM6JMNPaop4JJXN8QwuTF81wQ6H+gLvmUcEWeOD8Sk5wXFafR9/tbdWTrgWc7eNQrjMLXD0koR6gj/SjOKUKNYZtqEji53MI7L4ntQ2j1u+WBp8vpAJGZ4icobw5q5kmjGZxXFk73NHhIbYzu4TpZYgSowJU3D82xTN6Q49sLUXSQvvEcAtvGFw0H/77kN/ne7m6IPl8pJqrZNb1RxsQli8+GqfupU9AZYT4EPpYCf2cIsfIn3/iC+aFQ==; s=purelymail2; d=malon.dev; v=1; bh=ON8pVreABRTVSFw2W2b0B4UmZdGoLmXsHZ28nV3T9MY=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=RiVMrWv63SNqlq+95QT785dnnnBBSldq/gw6BnRSUEL3AELrK7VCmUMnZKTynBDuLWI6gYECp96MDf9nmYw49p8tibtGYSITy6Qa6i1zinz5GpKdJ6hoS1iA+OFCKfD+IpsvNjLbbyMzjQMHGUV69GXa+x+iygARVdbSWUn6LEyLGs3f/g2t+S8SZ9do7vUv21TwAxl6zTEX/RmDSr0VkvB0hJDsQvBXEh/C2aezTJaIiaKFeZhXkgsO8+GncRDbVlm4lqbSX5GlLWp8E2o/ec4aGnqsr7oREJmVGl/9RC5DsOA+ud1pl4V1Gh0UAsd2LTMnOGdFVlUt3QzwzK6IJA==; s=purelymail2; d=purelymail.com; v=1; bh=ON8pVreABRTVSFw2W2b0B4UmZdGoLmXsHZ28nV3T9MY=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 7426568;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 13 Mar 2026 17:15:28 +0000 (UTC)
Message-ID: <4fb9c915-7246-4c55-b7c6-b4ef7ca91230@malon.dev>
Date: Sat, 14 Mar 2026 01:15:23 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 karthik.188@gmail.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
References: <20260311181704.958509-1-cat@malon.dev> <abJjYNq_sxeH8yLQ@pks.im>
 <af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev> <xmqqpl577m3y.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqpl577m3y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 3/14/26 00:03, Junio C Hamano wrote:

> There is one corner case; upon "git foo -h", your cmd_foo() will get
> repo=3D=3DNULL when the command is run outside a repository.  As long as
> your cmd_foo() asks parse_options() to react to "-h" (which gives
> the help message and then exits) before it uses repo assuming it
> cannot be NULL, you are safe.

I was completely blown away =CE=A3( =C2=B0 =E2=96=B3 =C2=B0)

Thanks for pointing that out. Otherwise, I wouldn=E2=80=99t have been able =
to=20
figure it out no matter how hard I try.

I just took a quick look at the code:

> =09const struct option option[] =3D {
> =09=09OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
> =09=09OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing objec=
ts"), 1),
> =09=09OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of mor=
e than one tree"), 1),
> =09=09OPT_END()
> =09};
>=20
> =09ac =3D parse_options(ac, av, prefix, option, mktree_usage, 0);
> =09getline_fn =3D nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
>=20
> =09while (!got_eof) {
> =09=09while (1) { ...

I think if there's a '-h' parameter, it gets intercepted in=20
parse_options() and the process exits before repo is called. So there=E2=80=
=99s=20
nothing to worry about, right?


By the way, I find it a bit confusing that the'`-h' parameter =E2=80=94 whi=
ch is=20
solely used for documentation query =E2=80=94 is parsed and intercepted wit=
hin a=20
function that handles actual business logic. Wouldn=E2=80=99t it be more=20
appropriate to intercept it at a higher level? Is this a technical debt?=20
I don=E2=80=99t intend to write a patch to fix this, but this parameter has=
 made=20
me realize that this odd way of coding (at least in my understanding) is=20
highly unpredictable for someone with limited experience like me. I=20
don't know if there are any troubleshooting methods other than asking=20
someone with experience.

Regards,

Yuchen
