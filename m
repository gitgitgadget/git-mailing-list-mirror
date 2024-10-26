Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD19189F59
	for <git@vger.kernel.org>; Sat, 26 Oct 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729982119; cv=none; b=JV/G/TnlRFykRqAH9SHFfq+cDgkcuaiypxyaJvswvWt4IE6z3/FvQOf+yCaazkBWTqq8FJQ4SzB0OK9TaNsTOUpdP5OKj7GtCcqUIq0Yy5QNZIpFb+OHbsprYghWN69XU6fRSySxPIi8yfcxVQqJF4aPddGVppWsdej41wbpkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729982119; c=relaxed/simple;
	bh=m26x9pyAEZkpgMGAWnr57Jx+gRlpV5rxY1hEmSSqYTA=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=p4R5cclGfFmsguxQswyEnwj0XI+j1daiVfa1v3tvs5GTSklCArTwxQh9lUk6Ehu/iI/hKIcTSsYIltNl06/SQCm/OXCKnphOvglCriaKUMiungeLqBA0lJu75JMUGTRf1QCd1GIHd3af9mD/5ISayLISC8Q2Gcdrzm/kaNOASR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=GoEwN453; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="GoEwN453"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=RjH4SfhYq//DIQt6WR/iaRacHuiOOMvH9wD0OVPYWtQ=;
 b=GoEwN453rYvuXdjMl1fLK8pcv8Vhm/bJjbidE0zCaUP2gOGYMX2IUN+OrCfb2NqyUyy9fwmz4ib4
   QrF6bqBtb5hSwZb2Cjagy2gd+IGbPWvzz9P6bnRmH17tPebvv5JLMyDFDjBot5lUXQFygwQbPIWZ
   ej8NO5JlqhNW43PkBlJxLCTU4EIiJhRKokrEBKKYS0XC7lHTod2YFmQUwBfLq2yoZ2CVMkFiOZgM
   Kbp6ZJue2L0vGYr0FVLzt1pYmEkr/JADwagxuWzYWMrmd+NSD3v2KmgaDWxwzlLZa49FtSS0bXiT
   9zOI/am0wXx0wpBANfq20wCU+RttTK4+ZlbEyw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLZ0029LIQKT930@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 26 Oct 2024 22:35:08 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 27 Oct 2024 00:34:03 +0200
Message-id: <D563GBE4H09H.2JENKJVUOLMD6@ferdinandy.com>
Subject: Re: [RFC PATCH] notes: add prepend command
Cc: <git@vger.kernel.org>, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Teng Long" <dyroneteng@gmail.com>
To: =?utf-8?q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?=
 <congdanhqx@gmail.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023201430.986389-1-bence@ferdinandy.com>
 <ZxotMcKv5rEIMZ8q@danh.dev>
In-reply-to: <ZxotMcKv5rEIMZ8q@danh.dev>
Reporting-Meta:
 AAGCq1oUexhRMD2PC+XQhuEnSyVdA6mC3DjOtCapUdN/5MEY3+wChKwR5vvUVAEC
 7+4fcbrLqwEAO65NFkJRoBhdMCvbLNsaU0QTZw1Qt6Fp+CKdSeRT6gNTlhWH/JHr
 PwhSZhvFQXrNCdH/zC3WREy+MteeniWpn47HgUpqgZWi7T0ThUBxHcVn4TUhDVCg
 1V8W85APkfYOR72ZNvoVujNZ8rFTsgWdbc4SMrg9SOYF/xKpsTydMPV4SI7giDpv
 esRdgunVE0xOH57RjvxqVn6Xz4jx1Oyximb0zHWGe+cvaPzA8RDRPL6Lx4JUgmo/
 eTXqj09LriK9Zy3osXJT45Wo6sT6lSLMjfDmGIXXJRciOUrU2ds1no6ACc+YGfh6
 tRHxN2eFm0wr57ut1fedUsqN+xNDRcW/lP5/QsRW9GbWH+BCrxxpnlwUAEfZSbJm
 DdKZEZAqCOzuamOR4z6EbwZtEVhetc+FzJsFQopJmiWylGc7nlMS8R7G


On Thu Oct 24, 2024 at 13:19, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
> On 2024-10-23 22:14:24+0200, Bence Ferdinandy <bence@ferdinandy.com> wrot=
e:
>> -static int append_edit(int argc, const char **argv, const char *prefix)
>> +
>> +static int append_prepend_edit(int argc, const char **argv, const char =
*prefix, int prepend)
>>  {
>>  	int allow_empty =3D 0;
>>  	const char *object_ref;
>> @@ -716,11 +718,18 @@ static int append_edit(int argc, const char **argv=
, const char *prefix)
>> =20
>>  		if (!prev_buf)
>>  			die(_("unable to read %s"), oid_to_hex(note));
>> -		if (size)
>> -			strbuf_add(&buf, prev_buf, size);
>> -		if (d.buf.len && size)
>> -			append_separator(&buf);
>> -		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
>> +		if (prepend) {
>> +			if (d.buf.len && size)
>> +				append_separator(&buf);
>> +			if (size)
>> +				strbuf_add(&buf, prev_buf, size);
>> +		} else {
>> +			if (size)
>> +				strbuf_add(&buf, prev_buf, size);
>> +			if (d.buf.len && size)
>> +				append_separator(&buf);
>> +		}
>> +		strbuf_insert(&d.buf, prepend ? d.buf.len : 0, buf.buf, buf.len);
>> =20
>>  		free(prev_buf);
>>  		strbuf_release(&buf);
>
> Without prejudice about whether we should take this command.
> (I think we shouldn't, just like we shouldn't top-posting).

Again, I do not feel very strongly, about this patch, since it's not that h=
ard
to do with a script, but I don't think the analogy with top-posting is
appropriate. It's usually not a discussion going on in the comments, and
prepending might happen for any reason. The ordering of content in a note m=
ay
not even be temporal in nature (although to be fair, I have personally neve=
r
used it for anything else than versioning patches).

The specific use-case came up in patch versioning (pointed out by Kristoffe=
r),
where in a longer series with many iterations, seeing the "v1024: no change=
" at
the top would save reviewers from having to scroll an indefinite amount in =
the
particular patch just to find that they actually don't need to look at that
one, since it hasn't changed since the previous iteration they saw. In this
sense having the newest at the top rather than the bottom would be more
natural. I'd think probably even new reviewers jumping in during the middle
might not be very interested in the beginning.

>
> I think this diff should be written like this for easier reasoning:
>
> ----- 8< -----------------
> @@ -711,19 +713,27 @@ static int append_edit(int argc, const char **argv,=
 const char *prefix)
>  		/* Append buf to previous note contents */
>  		unsigned long size;
>  		enum object_type type;
> -		struct strbuf buf =3D STRBUF_INIT;
>  		char *prev_buf =3D repo_read_object_file(the_repository, note, &type, =
&size);
> =20
>  		if (!prev_buf)
>  			die(_("unable to read %s"), oid_to_hex(note));
> -		if (size)
> +		if (!size) {
> +			// no existing notes, use whatever we have here
> +		} else if (prepend) {
> +			if (d.buf.len)
> +				append_separator(&d.buf);
> +			strbuf_add(&d.buf, prev_buf, size);
> +		} else {
> +			struct strbuf buf =3D STRBUF_INIT;
>  			strbuf_add(&buf, prev_buf, size);
> -		if (d.buf.len && size)
> -			append_separator(&buf);
> -		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
> +			if (d.buf.len)
> +				append_separator(&buf);
> +			strbuf_addbuf(&buf, &d.buf);
> +			strbuf_swap(&buf, &d.buf);
> +			strbuf_release(&buf);
> +		}
> =20
>  		free(prev_buf);
> -		strbuf_release(&buf);
>  	}
> =20
>  	if (d.buf.len || allow_empty) {
> -------------- 8< --------------------
>
> Even if we don't take this subcommand, I think we should re-write the
> append part, so:
> - we can see the append logic better,
> - we can avoid the `strbuf_insert` which will require memmove/memcpy.

Thanks, I do find this a bit more easier to read indeed.

>
> Well, the second point is micro-optimisation, so take it with a grain
> of salt.
>
>
> Also tests.
> -------------- 8< -----------------------
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 99137fb235731..5a7ad40fde6a8 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -558,6 +558,20 @@ test_expect_success 'listing non-existing notes fail=
s' '
>  	test_must_be_empty actual
>  '
> =20
> +test_expect_success 'append: specify a separator with an empty arg' '
> +	test_when_finished git notes remove HEAD &&
> +	cat >expect <<-\EOF &&
> +	notes-2
> +
> +	notes-1
> +	EOF
> +
> +	git notes add -m "notes-1" &&
> +	git notes prepend --separator=3D"" -m "notes-2" &&
> +	git notes show >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'append: specify a separator with an empty arg' '
>  	test_when_finished git notes remove HEAD &&
>  	cat >expect <<-\EOF &&
> ----------- >8 --------------

Thanks! I didn't look at tests (and documentation) before it was clear if t=
he
idea got a green light or not, but I guess if it does, this would cover tes=
ts.

Best,
Bence

--=20
bence.ferdinandy.com

