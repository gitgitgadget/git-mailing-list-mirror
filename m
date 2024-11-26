Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F4946C
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654625; cv=none; b=UBzVZra7pELG/lOW9GlEY/Izc1Ib0r5x93oxqAW1sp7uAcpbhyX8tQ8qYnI9xZ3d9QKJzz2bNvZLhUJ74JCnics2LzBn0+gkRDRFVMGz1NwjMXDzbpftSwA2m8oThhFuH99g0nP3c3TcuCWuSWwYR+Ct5oW8vLjDCu82wv8BpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654625; c=relaxed/simple;
	bh=6HnKmLu+W+tczdJL+9G5+1i/gd6zzAw5iXlsUDisZuE=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=ezM9V6YiwG2zLCCd9FyCCdxoPLQ3TzxQ61St6V6fe2314FYVSPnZtltUDbpzlrGUZFLJFuwigIH+6BFONlhC3Q2ww0yNR6ulOiKdlEoYaL5Zcfivvy9CK/Ob7EUA3ByJ8hbqZA8RvcF8APWdIjuhW6UjdMATG0SGSUVudXkjsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=C7gJK7xc; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="C7gJK7xc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=3Oi+DbZQ1zGt0jb7Reu0F6DdvoFazTApYBaT3boSTOU=;
 b=C7gJK7xcQvkDyx8Q3mjzuWiriLsBZCR9O/tXQ7givBEBy9VisE/duBeRRgCHHf8bUROyMqh5/b3b
   gERgz0hy7uugSutdhsZi7ngWfldwvYjzIYE1qWPLm6Nr8xwmX0GfV5gqHwCmYOleinHuQHCrpQeD
   c0sDj11N6BePsTNF85RH7L51JJ3RrBl37uIqqpIzbY4BPpCB1VQla+eCDAJ+chr6zzbOB1BAhivK
   MupFbPs2rkVH3/vIx0jRbZA5aT0ddUibIIbxI6RQppb1FqqzlK2/PCVE73eDnUG8RWriHk0tW6FJ
   1BrpoDKE5kcCIcc4u3IOEyADf0W6+BAejuMKKQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNK000XUSV1I930@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 26 Nov 2024 20:57:01 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 26 Nov 2024 21:56:23 +0100
Message-id: <D5WESFCCZ463.3RFWANEKVGBOU@ferdinandy.com>
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>,
 "karthik nayak" <karthik.188@gmail.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com>
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
 <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
 <CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
 <D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com> <xmqqwmgs6mxk.fsf@gitster.g>
 <D5W75LQ6Z44H.3LKJ0OX40QKVQ@ferdinandy.com>
 <CAOLa=ZQ-ZeM4Lk0=ojx3f9RebRkVCX7w4KUKHphZoxUa5Cgfsg@mail.gmail.com>
 <xmqqh67twypb.fsf@gitster.g>
In-reply-to: <xmqqh67twypb.fsf@gitster.g>
Reporting-Meta:
 AAHhh4dA2aNZ8bE97xIG1tOe5sfDLE9VnaMMGLH64quINnxTCVZ/SwNu4pJUDm9d
 fVRQyo1ihCJ0UUisz9bYP4txtdB6rJYLAr1Lco09qCZ5fG4GLxS5DaHR0+wzhpci
 oljVtCpwXcH9qeynouGKVsFCRSlUii0x48lKP0BFttO6jPQR7x3VKpDb62+bE1Jv
 7Lpj0qzIV0JWAoNYEuyvX+VsPDXJ64lrAVoG8ldjkp2v6VeogR65Wvfthg4vtJOM
 ZSfLPNAn9lIC1PVkWeACSOXYUX9eUe8Pn/gq2yFys3aPbz0zQssC5YenkSAThBZ5
 Ob/8fjAYH8/jxs71eMtqqshA0so8EUNBX1dZH8SH5zGz1llDpg/JMjdAyPydUUTE
 PWiv0aR1Xu9q8/Wac0B15MIh6MHmpP8x4iGXajInOlZrrwEs4ys2AAFxETnBHd5A
 aVCMmCygdF0074v+YVn1z8iQu1GBLCBhcnMJTdeR1MKHaheZVR/sCfc=


On Tue Nov 26, 2024 at 21:02, Junio C Hamano <gitster@pobox.com> wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>> With v14, running `git log --check --pretty=3Dformat:"---% h% s" master.=
.`
>> gives me:
>> ...
>>   --- fed56bc6cc refs: standardize output of refs_read_symbolic_ref
>>   refs/reftable-backend.c:833: indent with spaces.
>>   +        if (ret)
>>   refs/reftable-backend.c:834: indent with spaces.
>>   +                ret =3D -1;
>> ...
>
> Thanks, the above matches what I saw in my message Bence responded
> to (to which you are responding).  I was unsure if/how the status of
> each "diff --check" is propagated up to the driving "git log", but
> the job is reading from the output of the command and not using the
> exit status of "git log --check", so even if "git log --check" did
> not signal a check failure with its status, it did not matter ;-) A
> quick local check says "git log --check" does exit with 2 if there
> is an offending commit in the range, so we should be OK.

Ok, so `git diff --check master` at least does produce the output for me, a=
nd
now that you mentioned the exit code, I checked that even though I get zero
output from git log --check, the exit code is indeed 2. So now I just don't=
 get
why I don't see any output ...

