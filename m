Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50101C3038
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012194; cv=none; b=QSxOL6jrYHpLc7cndUvAHPFxwRERgC8vOXbZgJ6unS0aVf6ofM9qN5Q73unBK6+rOzoJxO96+EamhqHt0MyZe3jG6uuZnDtUonBOlGDnuKEXFHXCSRgrHQD9xmV7fSd7NLgLIr0pMBIFSlVU9WbWIIRrGBD4Ky8V2vhW57ZbqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012194; c=relaxed/simple;
	bh=kk3PmGcPqxUT1PaqscEujIF3CatumsyWwo1grdBk+1o=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=qPsP3435eMLn8P67CLRufbUIF/R66Rl1eo/K2BiSMTBucxg9stGTPrHpSXTaHwm9Vtwnxkx6bfD2cvy1W4AZr4zjDm5keo7WhMSj14pA9+x6NSf0iP8dIGk7OZzIzhkZxWVKkfWQ+BDUkD2KrVXtxCtEKtBQwGGito5jC0eO6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=nJoZsg/7; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="nJoZsg/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=kkSEbDjKjBixlJ403ZjQXvO2l/sFbWtEx0EtR90EEBI=;
 b=nJoZsg/7iGnnr1Lpcmf0MQzDyV1LZzEI85JUTU32uYQCMxCtZ3rIAZM8JFFPlDhP4Y8MslUZCYyk
   0/xohACCl3fu/hH1volbJObLoWBPof61KyNdFoCEB11+FCU2bFr5rWPTu2cvdcYdjo5laE498JWG
   yBiOISLcHksgcumXckx3h2KMpmYk+mQY00NQOGKPjkXZ3WutRHx3121nw7DkaAQBVOYsUU2sxOKl
   KzYnY34sFo9HeIBA/gCpMYx+5tgAz/qrE8R7pLUw4EilccH5ix8cows+bifSSWzpNPoHgZpi9BJn
   kxEx1KYbFj7f9wKeAKABNX+F+FxAARahImdJIA==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN70032615R24C0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 19 Nov 2024 10:29:51 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 11:29:34 +0100
Message-id: <D5Q32ODJM8P5.6VQ08LDQHPXS@ferdinandy.com>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v13 5/9] remote set-head: better output for --auto
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-6-bence@ferdinandy.com> <xmqqldxgez4l.fsf@gitster.g>
In-reply-to: <xmqqldxgez4l.fsf@gitster.g>
Reporting-Meta:
 AAHIATIbPOwlSPb0c5ZOweDbho4xn0bKSaEvwKHbnE52BfMmbMDm7omK3A7m/rkl
 j8F2Fld+0BvYmV21qPHrkXVpIN+VaAE6vZkqNQgr5KQo7AbNa4cuy66qSMdbwBsh
 j7cazqJsfLXsiti9BZIKQkNL4PIUC1GsRWJna4YpVaWcII2SQXT3M0AItW2tDhi4
 Gx4dG2PQiMZtlONryg7ELIW2wK0qUIvzP0Nok9fHniRFt2lBhnv1xTq9r0gfGb6S
 oqdSywSpIsCfQ5N6a4xNJn7JWsDijCyVyFcqoXxiYqrbaXbiC71CMtmuLoPQFvaL
 gfQsiSmkFhzLjNUrVNCmNU8fSj9++tquK355jqEYvh1fDeP7ZIYxG00VW0Apn28c
 26ZO/DnuNyejJBQ9WINIYFfO+q63jRGtarjUCovsHUHBbaUVQ6mdxb9FqQTA0TW3
 DuHMKKXEfhDswbU1bpp+fKVWWU+tndkDsRqqU0HiECWa4vlW2G//O4aH


On Tue Nov 19, 2024 at 03:27, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> +static void report_set_head_auto(const char *remote, const char *head_n=
ame,
>> +			struct strbuf *b_local_head, int updateres) {
>
> "updateres" was too mysterious a name.  "res" stands for what,
> "resource"?
>
> Looking at the way the parameter is used by the code, it seems to
> indicate that the remote HEAD originally was in a detached state, so
> "was_detached" may be a better name, perhaps?

"res" wanted to be short for result, but "was_detached" is definitely more =
readable.

>
>> +	else if (!!updateres && b_local_head->len)
>> +		printf(_("'%s/HEAD' was detached at '%s' and now points to '%s'\n"),
>> +			remote, b_local_head->buf, head_name);
>
> There is no need for !!; any non-zero integer is true.  !! is useful
> only in a context that takes only 0 and 1 (like when you are making
> an assignment to a variable or a structure member that takes only 0
> or 1).
>
>>  static int set_head(int argc, const char **argv, const char *prefix)
>>  {
>> -	int i, opt_a =3D 0, opt_d =3D 0, result =3D 0;
>> -	struct strbuf b_head =3D STRBUF_INIT, b_remote_head =3D STRBUF_INIT;
>> +	int i, opt_a =3D 0, opt_d =3D 0, result =3D 0, updateres;
>> +	struct strbuf b_head =3D STRBUF_INIT, b_remote_head =3D STRBUF_INIT,
>> +		b_local_head =3D STRBUF_INIT;
>
>> @@ -1440,20 +1468,27 @@ static int set_head(int argc, const char **argv,=
 const char *prefix)
>>  	} else
>>  		usage_with_options(builtin_remote_sethead_usage, options);
>> =20
>> -	if (head_name) {
>> -		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name)=
;
>> -		/* make sure it's valid */
>> -		if (!refs_ref_exists(refs, b_remote_head.buf))
>> -			result |=3D error(_("Not a valid ref: %s"), b_remote_head.buf);
>> -		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "rem=
ote set-head"))
>> -			result |=3D error(_("Could not setup %s"), b_head.buf);
>> -		else if (opt_a)
>> -			printf("%s/HEAD set to %s\n", argv[0], head_name);
>> -		free(head_name);
>> +	if (!head_name)
>> +		goto cleanup;
>> +	strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
>> +	if (!refs_ref_exists(refs, b_remote_head.buf)) {
>> +		result |=3D error(_("Not a valid ref: %s"), b_remote_head.buf);
>> +		goto cleanup;
>> +	}
>
> OK, we refuse to allow a manual "remote set-head" to create a
> dangling symref, which is a faithful rewrite from the original.
>
>> +	updateres =3D refs_update_symref_extended(refs, b_head.buf, b_remote_h=
ead.buf,
>> +			"remote set-head", &b_local_head);
>
>> +	if (updateres =3D=3D -2) {
>
> Where does this -2 come from?  It is not the "you asked to read it
> as a symref but it wasn't a symref" thing, which was mapped to -1
> with [PATCH 3/9].

No, it is not, but it's also a mistake. It should be `updateres =3D=3D 1`.
refs_update_symref_extended outputs -1 for "not a symref" and 1 for any oth=
er
error currently. Before I touched the code it was 1 for any error, so I lef=
t
that as is. So we want to error out on set_head if we get a 1 and continue =
if
we get 0 or -1 (and handle the difference in the report_set_head_auto).

Thanks for noticing, I'll get that fixed in v14.



