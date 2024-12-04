Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC573136338
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300177; cv=none; b=FSFpapCkgIy9v1L+GvLn61S7XziBRFDZwW9IgLegawf7V95I49FcIKK4be+qHUv7Rz5z2Wyjc7QO7Dk6lmvWj3u+nCO0AvR3qRtndplm4yCPe1c1wwLFMH19Ncz+tn35u2lBebZeIKrvy9sijfOjorRaOj77DTrd4BGPaEC/0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300177; c=relaxed/simple;
	bh=letcXqb/ZcHRbBKyze1jYZk71+6AIx23XX5XFg4tfI8=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=a3P4zdVTfuhcHUabJqXWo48snZAQvziG7Q7ONoT3C87WjpnlSDvuRZF2GlzHqv1RPTRT6fidsT5IBf4rQxNeJBmJ8a1xjiotRCheCxdXFTwR+qIEZnyH1YLQLQGtHwG3xu6XJ/SKN7coq30fN7YQHuv6T2LbrkcL4y+7Itmqb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=V4IGPu0R; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="V4IGPu0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=h66RBfEfCQiBQ7XBz3jMqPeXx0c24+Oy1ZPmD7Ai85c=;
 b=V4IGPu0RFA7o5RA5r3V1aefn1wr5CvPksQNtNfOdjTKuYjyB/huOcIkIswQC1UNVkvSKAA5Y0yFG
   kbqiXSqCI3ZlWA6TtETShBT06j9mruCy5leX0Wb4NttGcwKgv5MegXMyFsOlKADM1sYUV9x3IxTy
   maZq191vw+bLbkscguy4kDcRXJ1f/5OQOCUurbk5U5LNzy/epkb/RaPA6Qm3/zAnBY9MsT2JXnoK
   2ZGHuFNAT5XfeDcV/DPM9UWjOsNQa3A9DgX8aPI0Us0zXq8hOLa1+3RGLdgV1T7wz96fINNn6xK3
   CHQQ8MfyszeI13sr2oXNPYa5MFcBVDJM7pnUYA==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNY00IE3MYV3L70@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 04 Dec 2024 08:16:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 04 Dec 2024 09:15:27 +0100
Message-id: <D62RM601U1FN.12YBAISXW0ORI@ferdinandy.com>
Subject: Re: [RFC PATCH v1 1/2] fetch set_head: add warn-if-not-$branch option
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <xmqqiks7oprx.fsf@gitster.g>
 <20241203215713.135068-1-bence@ferdinandy.com>
 <20241203215713.135068-2-bence@ferdinandy.com> <xmqqh67k5gv8.fsf@gitster.g>
In-reply-to: <xmqqh67k5gv8.fsf@gitster.g>
Reporting-Meta:
 AAHS+YWIshjBAsVdOJ3hmVq/RKm/T1E1W5UM0c0XTQpGI33mRFeDfeDOq96ykXZa
 KfJRzZQFMHF0D5qgJfmrUdCjY6Y5Y9nzYL2poWko0YCUE8eVlnHeo1odkJv/ARrv
 VgEfZY8vgBhKrYKIwYC4cnBXFzGPx+OQIMSRiudVNdDTtkPMFWq0NzYzv2ag/2DP
 PsevZTY+k/1g39MEwobLguxxLVVArpbVrf7kS76rdFFs6zp7XJdkG/7e+GByK1kZ
 bzKl7cuhGnfRxFJQ5D1AlxlspjHBbDMsIDtIFecjD93bWoTQBiwrIpBuNK1HJ/hL
 OsYZ9WaAYYWoI0C9WhZ23mPudjEM8CpdO88GWm5w42/JZR67f2rR1jIny35fKSX5
 lLMNYGLV7abz4vy+/M0Cgh1jurhfn0+7BBsVO2ufdnNyRhLHwokiYhszasHj4LZv
 ChUdhR5BapWOLzzbE3Rv0tKuG8hqx1u558pFnormvyDSaj3wnscgLrc5


On Wed Dec 04, 2024 at 03:20, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> +static void set_head_advice_msg(const char *remote, const char *head_na=
me) {
>> +
>> +	printf("Run 'git remote set-head %s %s' to follow the change, or\n"
>> +		"'git config set remote.%s.warn-if-not-%s' to disable this warning\n"
>> +		"until the remote changes HEAD again.\n",
>> +		remote, head_name, remote, head_name);
>> +
>> +}
>
> Style. "{" that encloses the function body sits on a line of its
> own.
>
> Perhaps use the advise_if_enabled(), so that those who already
> learned how to deal with the situation can squelch the "how to fix"
> message.
>
>> -static int set_head(const struct ref *remote_refs, int follow_remote_he=
ad)
>> +static int set_head(const struct ref *remote_refs, int follow_remote_he=
ad,
>> +		const char *no_warn_branch)
>>  {
>>  	int result =3D 0, create_only, is_bare, was_detached;
>>  	struct strbuf b_head =3D STRBUF_INIT, b_remote_head =3D STRBUF_INIT,
>> @@ -1660,7 +1668,10 @@ static int set_head(const struct ref *remote_refs=
, int follow_remote_head)
>>  		result =3D 1;
>>  		goto cleanup;
>>  	}
>> -	if (follow_remote_head =3D=3D FOLLOW_REMOTE_WARN && verbosity >=3D 0)
>> +	if ((follow_remote_head =3D=3D FOLLOW_REMOTE_WARN ||
>> +		(follow_remote_head =3D=3D FOLLOW_REMOTE_WARN_IF_NOT_BRANCH &&
>> +		strcmp(no_warn_branch, head_name))
>> +		) && verbosity >=3D 0)
>
> Reorder conditions combined with &&- to have more expensive ones
> later.
>
> 	if (verbosity >=3D 0 &&
>             (follow_remote_head =3D=3D FOLLOW_REMOTE_WARN ||
> 	    (follow_remote_head =3D=3D FOLLOW_REMOTE_WARN_IF_NOT_BRANCH &&
> 	     strcmp(no_warn_branch, head_name)))
>
> As human readers, we may know that no_warn_branch is always valid
> when (follow_remote_head =3D=3D FOLLOW_REMOTE_WARN_IF_NOT_BRANCH), but
> semi clever compilers may not realize it and give a false warning
> about using no_warn_branch potentially uninitialized.
>
> We could do without adding FOLLOW_REMOTE_WARN_IF_NOT_BRANCH and reuse
> FOLLOW_REMOTE_WARN, like so:
>
> 	if (verbosity >=3D 0 &&
>             follow_remote_head =3D=3D FOLLOW_REMOTE_WARN &&
> 	    (!no_warn_branch || strcmp(no_warn_branch, head_name)))
>
> That is, "if set to remote-warn, always warn, or no_warn_branch is
> not NULL, only warn if the current head is different from it".

Ah, nice, this has the added benefit of a bad configuration where
"warn-if-not-" doesn't actually specify a branch to fall back to just "warn=
".

>
>> diff --git a/remote.c b/remote.c
>> index 0b18840d43..f0e1b1b76a 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -515,6 +515,7 @@ static int handle_config(const char *key, const char=
 *value,
>>  		return parse_transport_option(key, value,
>>  					      &remote->server_options);
>>  	} else if (!strcmp(subkey, "followremotehead")) {
>> +		const char *no_warn_branch;
>>  		if (!strcmp(value, "never"))
>>  			remote->follow_remote_head =3D FOLLOW_REMOTE_NEVER;
>>  		else if (!strcmp(value, "create"))
>> @@ -523,6 +524,10 @@ static int handle_config(const char *key, const cha=
r *value,
>>  			remote->follow_remote_head =3D FOLLOW_REMOTE_WARN;
>>  		else if (!strcmp(value, "always"))
>>  			remote->follow_remote_head =3D FOLLOW_REMOTE_ALWAYS;
>> +		else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
>> +			remote->follow_remote_head =3D FOLLOW_REMOTE_WARN_IF_NOT_BRANCH;
>> +			remote->no_warn_branch =3D no_warn_branch;
>> +		}
>
> If we were to do without FOLLOW_REMOTE_WARN_IF_NOT_BRANCH, then the
> above becomes
>
> 			remote->follow_remote_head =3D FOLLOW_REMOTE_WARN;
> 			remote->no_warn_branch =3D NULL;
> 		} else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
> 			remote->follow_remote_head =3D FOLLOW_REMOTE_WARN;
> 			remote->no_warn_branch =3D no_warn_branch;
> 		} else if (!strcmp(value, "always")) {
> 			remote->follow_remote_head =3D FOLLOW_REMOTE_ALWAYS;
> 		} else {
> 			warn(_("unrecognized followRemoteHEAD value '%s' ignored"),
> 			     value);
> 		}
>
> We'd want the new choice documented before we graduate this topic
> out of the RFC status.
>
> Thanks.




--=20
bence.ferdinandy.com

