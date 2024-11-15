Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135E16631C
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731713594; cv=none; b=qsxqYdFuq95MK1inOA1IcK36YYtMVSe6g3BpQHsMUf8kAwfC3zc5tTzUyeWSMy52OHtxVYsxB813P9TtxFSuE8rWR88OvICsCS30R0fIVqTI79ZbMc0nghWH71XZUWO3As9brUGV4a3Q3iQiLvRg+pROIrwFwDqKvnrdelsDpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731713594; c=relaxed/simple;
	bh=hyYzqmlDslCI6sS+GRohuM44c3cEEEsaC+XBQ/LwymM=;
	h=Date:From:To:Cc:Message-id:In-reply-to:References:Subject:
	 MIME-version:Content-type; b=tPxNmOTELEnQ0cCZSpCBzMJdwCngyUHJLUcD+cIngVRzn5Ti9dCCtlae+PLIeGI4ng4PzV6hUG4TxdoI9OO/WW7Qwgazw3bQLStEtCzzy4NVlbPjR2H5kfgZQOhOGy1Nx5kKOlUwHaN/Aj4Qj2lcVchW0Qv6ZPYBc0UNj89ADZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=PjnHdRHj; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="PjnHdRHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=hyYzqmlDslCI6sS+GRohuM44c3cEEEsaC+XBQ/LwymM=;
 b=PjnHdRHjymjj3s4SsPCQQw2lsMFWUJnbyYjWSXgqLt8xCziSyEhGdF0hiGupVGrqyKNbeEighrNA
   A1yEOXHQRHc1OGcuOeMgpbaky5UR1xo9atUjIgZQpykGO9OoY9EArEp2ylN31yhNS4YJ/wPQjUnK
   pZZfTkL99n/eD4bX4SbEY9oCxymWhrEADZ0bjS31RrcDu9lVz+CYnkj4gFTDEJDdcyF97C1EK/MG
   A72xlXzW8+LfwhtYuaZiMLrzLhSYnoUbVK/rXTXTUhqOyBmKPcDvTP2ZnpHGfhdFoFcpybA4XpHg
   9lq96dMi0dIE2PrypcHLt8cI8PjPum1SefL3KA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN0000GAMIRWK70@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 15 Nov 2024 23:28:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Date: Sat, 16 Nov 2024 00:27:44 +0100 (GMT+01:00)
From: Bence Ferdinandy <bence@ferdinandy.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,	karthik.188@gmail.com,
 Taylor Blau <me@ttaylorr.com>,	ferdinandy.bence@ttk.elte.hu
Message-id: <54677502-a08c-4920-9b08-13517c8f027a@ferdinandy.com>
In-reply-to: <D5N3N1RMMR9Q.28GSGYYBWZSOS@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-3-bence@ferdinandy.com> <xmqqr07d11wt.fsf@gitster.g>
 <D5N3N1RMMR9Q.28GSGYYBWZSOS@ferdinandy.com>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: quoted-printable
X-Correlation-ID: <54677502-a08c-4920-9b08-13517c8f027a@ferdinandy.com>
Reporting-Meta:
 AAFLrooIivhn4mS5hdUDcR0uEaS0PncLSm00cWoHIVZ2R8oRK46qRh2QmK9Mx5pg
 Y5brOwqXSdRo+KQx5OIk6D6ycNxWFkG9SrN/1tLi7go8glsXH5rG0X3ctiht2HgG
 2M2G7g1aQX2zqIPr6vTXzTBlJErbLQs8g90qPqi6zGon7jR/cgkuEHx1n6BbvUI7
 N1/CNarhbrOE/E6aMl1xqa7hHep8mU+EcFM3aa1xM/vEvpckMA27OeXT0htZJwy9
 pKF0GvYBrUYvnXVOzvANZeqnmh3UVKhQEwqSeHim5npGugMmyLg6ZdG1H3lI3NnB
 9pmfvoM5zFIOQW1PCTQtmuCVMFroyXSZdsfjJjjYtVdcbbirawnHynHmIJzzneoa
 W/t29rBeGiBs/blkjQlcJkgk8hn6jg6x5ZaXSn2Tkc8644+ut+sdLxcjGYB8ufVO
 mN+Aau0GN8ssUmPhglD1SmFhECON68dk76ASOZgfQBRKU7ZXnnRqdxI=

2024. nov. 15. 23:18:10 Bence Ferdinandy <bence@ferdinandy.com>:

>
> On Fri Nov 15, 2024 at 06:50, Junio C Hamano <gitster@pobox.com> wrote:
>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>
>>> int refs_update_symref(struct ref_store *refs, const char *ref,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const char *target, const char *logmsg)
>>> +{
>>> +=C2=A0=C2=A0 return refs_update_symref_extended(refs, ref, target, log=
msg,=20
>>> NULL);
>>> +}
>>
>> OK.=C2=A0 As the enhanced and renamed function is also external, we do
>> not have to worry about reordering the old one to come after the new
>> one.
>
> I guess this also decides that the name "_extended" is fine :)
>
>>
>>> +int refs_update_symref_extended(struct ref_store *refs, const char=20
>>> *ref,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const char *target, const char *logmsg,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct strbuf *referent)
>>> {
>>> =C2=A0=C2=A0=C2=A0 struct ref_transaction *transaction;
>>> =C2=A0=C2=A0=C2=A0 struct strbuf err =3D STRBUF_INIT;
>>> @@ -2122,13 +2129,20 @@ int refs_update_symref(struct ref_store=20
>>> *refs, const char *ref,
>>>
>>> =C2=A0=C2=A0=C2=A0 transaction =3D ref_store_transaction_begin(refs, &e=
rr);
>>> =C2=A0=C2=A0=C2=A0 if (!transaction ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_transaction_update(transactio=
n, ref, NULL, NULL,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_transaction_update(transactio=
n, ref, NULL, NULL,
>>
>> An unwanted patch noise?
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target, NULL, REF_NO_DEREF,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logmsg, &err) ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_transaction_commit(transactio=
n, &err)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_transaction_prepare(transacti=
on, &err)) {
>>
>> Likewise, but the noise distracts from the real change made on this
>> line, which is even worse.
>
> Mea culpa, I'll get this cleaned up.
>
>>
>> The real change here is to only call _prepare(), which also asks the
>> transaction hook if we are OK to proceed.=C2=A0 If we fail, we stop here
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error("%s", err.buf)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
>>
>> This is also a real change.=C2=A0 We could instead make the additional
>> code below into the else clause (see below).
>>
>>> =C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0 if (referent)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refs_read_symbolic_ref(refs, ref,=
 referent);
>>
>> And if we were asked to give the value of the symbolic ref, we make
>> this call.=C2=A0 What should this code do when reading fails (I know it
>> ignores, as written, but I am asking what it _should_ do)?
>
> I think this should do _nothing_ if it fails (although should it stay=20
> this way,
> I guess it should be marked with a comment that this is on purpose). My
> reasoning is that running `git fetch` will be running this part of the=20
> code,
> which means that should reading the symbolic ref fail for any reason, a=
=20
> `fetch`
> that previously ran without error would now fail. We now pass up an=20
> empty
> string as the previous which does mask that there was an error here.=20
> What
> I think we could maybe do is pass up a special string that means there=20
> was an
> error? Something that for sure cannot be a valid value for an existing
> reference? I'm not sure how much sense that makes.

Sorry, it's late. The above is slightly bollocks since fetch ignores any=20
set_head errors later :)
But the idea stands that if we can set the head, let's do it.
The previous head is not important enough to die on.

As mentioned on the other patch, we could try to read a non-symref=20
instead also, if symref fails.
>
>>
>>> +=C2=A0=C2=A0 if (ref_transaction_commit(transaction, &err))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error("%s", err.buf);
>>
>> And then we commit, or we fail to commit.
>>
>>> +cleanup:
>>
>> We could write the whole thing as a single "do these and leave as
>> soon as we see any failure" ||-cascade,
>>
>> =C2=A0=C2=A0=C2=A0 if (!(transaction =3D ref_store_transaction_begin(ref=
s, &err)) ||
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_transaction_update(transa=
ction, ref, NULL, NULL,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target, NULL, REF_NO_DEREF,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logmsg, &err) ||
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_transaction_prepare(trans=
action, &err)) ||
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (referent
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? refs_read_symbolic_ref(refs=
, ref, referent)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 0) ||
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_transaction_commit(transa=
ction, &err)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!err.len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... s=
tuff default error message to err ...;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error("%s", err.buf);
>> =C2=A0=C2=A0=C2=A0 }
>>
>> which may not necessarily easier to follow (and in fact it is rather
>> ugly), but at least, the resulting code does not have to special
>> case the "optionally peek into the symref" step.
>
> As I said above, I don't think we actually want to fail the update even=
=20
> if the
> symbolic ref reading fails, so I think the special casing should stay.=20
> I'll
> wait here to see more clearly on what to do here.
