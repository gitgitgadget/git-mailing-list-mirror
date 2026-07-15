Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9E439911
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141568; cv=none; b=VhfnyVzMkVhKCAZ9HC4OsMghoYZWBm7v140W2bd+brncrMaOD7p1z7LszqQlGB8F3+dN3yticdeM8RegGUD8zT3GwT+l0Al+2S86LxiNsTfyz/KXUbXhBSphprNxLl/DgL1XcrmsAfzO0tsgLA/G4TNUnRp1yW9JHHkgelEKQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141568; c=relaxed/simple;
	bh=4z9tTqfs98Mhx4lftFZvNk2HdXBvPDSuDRBsrZwW9W8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TwbclbuBqK+j6Vt27tFafBRW537nGWR3b++ttaAGgSQ7B7oe/44ht0z9HV+kf+kqGu4owZLDfPA4Ig0fL3L1QVbCrikrYcMjLvZCd+l0yUwXC1/43UlymRqg4bmTQPhF3ljPjMsF3DgRIwZQWjJdGQ4Rxt9X8FD80QoO9sHr4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCjq0OWj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCjq0OWj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso23776815e9.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141563; x=1784746363; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vZGWAusLCTeSmWa7gU5SNseS82IIoXSybNaU+pMMWY4=;
        b=oCjq0OWjiHx0P0rrGGQW89uTwMIn2vNUEi0UFWt3nGA2QIvh4T8tJz1vCH184voHH8
         ReGI0JdiNhGXOFPo1Tn98WY8VuMMLVojUkJz5Yax0gZGt7IkDDCebH7N93tu/elGyinR
         jGcuIgaEOzUnRIXjsfKhfYwkrIuwCJZO0vs34d1pdCIBWR9RGhUl+996bSp5yS1JZyRz
         hteT90dtx5Dw+q38hvL2bVT/9oqdKi9J/6xVhg37gv06Q8m1dFYkdZ50HHIod7hjkjED
         eIGPPk0LU9VT/KFSDRko2TMvzkvHdxJUp69PXHHZDRgnAV3D2YOKuXcje/PU+55Tjelt
         nBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141563; x=1784746363;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZGWAusLCTeSmWa7gU5SNseS82IIoXSybNaU+pMMWY4=;
        b=Fb/9f8V5nkhWER4GDpRPmnhyqXNvmjGUtHXeZwSEHYSt1GHo3HG6imZWFcA8fDjCU0
         L/70nVdJIZ4AeFdK5ax6lxpSw7ivqna5BEM3vdvBSdn/qWw0QvbiR+LV5oKg2gYcYKdb
         BuyqSZvEv8mhtiGUbCzUN2Rt/bzd2nPHxeATbVbogndRI06Oon7rEBP0ZYNQA32gxsKy
         kxYSFltI8uFOE+sIU9DbyC1j1HeL9mtmePLOl8Ne9bKmLrAp4RynKjbtdZqMANBk1Qs0
         gHgNjcf6rxLVbhtXADkLzoZ3Oq/s/e0EckTkaXchZoQWT9KKwhYhHEKjRohHKcTRkP38
         VNOQ==
X-Gm-Message-State: AOJu0YzjztliVq+aHwV/MMPJaVbcvMp4q8imZHvnMiL1LubDiaVYkPRY
	+9O+q4zaNCOb4CqlbJ2jjnkAKeYinGh7kYbXjzw0naEoHYKpjj4vsJzU
X-Gm-Gg: AfdE7cn5JhX68jLQg4tNeQldaxuROdGFj7CPoQj8A9sNM4YGmcsqOZYCt43Yk20vX6M
	NCMMerp5u0UX1YNax/VZa7bpk9K5daPEcpj9F81cWaE7ugcVgmgux+Jrt4/u4hL5hGwteFZOHAW
	3T30bUZJOTSqVJXJVV+bbrflkhvchlylzCiNzz8WLCXolrmk3Ru7UEPWEk190yKUpGq8nasPAIo
	T0KyQm9fRNnosJj4G4YdEu1Wz3h7abvTEwgZUsXFZqI0mvmpC1Mo/DN/dl9dzKnLPosbuemwdMV
	Tx0tnKhR4g2FU4dclz5Pr0RHxYZ8fj8gtRWuFtftdkU8cdKMWaGTpSQHGvc4hSJv/QdjjLaDJOz
	50caJBoQ0WorX+jDqai3LJGq3L3Jqpj6oCXpe6iH/BDT+vvZHmZYgSwg7iqsaEdeSIzzacX7aNV
	phwv6VzzhCGDqBE2sdaHK2/YEHi+LYjyfaxmrwEO+PIEo0LwfWdN9jnW1STb4Zp0hfYLtjJyuqi
	hhY9cK0oWOkGSXe0eTL1Etpgyg8019tzBeM9LzUU4/ZhYT+MjK8P7GATMxGkratFa+iVkCxzS2m
	ekWVL+CJxmu66S1XIR38sdiABZ/cgL/qkmx15jO9Xvja7vbMzeFsrrnu3YWSovb8mqMzFA==
X-Received: by 2002:a05:600c:2b06:b0:492:45a0:dcef with SMTP id 5b1f17b1804b1-495158c6a10mr74017355e9.5.1784141562480;
        Wed, 15 Jul 2026 11:52:42 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c1f84sm18887423f8f.29.2026.07.15.11.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 11:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 20:52:40 +0200
Message-Id: <DJZDEE0G6ZRS.2RT8JTQQ6CUXB@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <chriscool@tuxfamily.org>, <eric.peijian@gmail.com>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>
Subject: Re: [PATCH GSoC v18 13/13] cat-file: make remote-object-info
 allow-list dynamic
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
 <xmqqcxwonnkx.fsf@gitster.g>
In-Reply-To: <xmqqcxwonnkx.fsf@gitster.g>

On Wed Jul 15, 2026 at 7:56 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> The static allow-list in expand_atom() is hardcoded to only allow
>> "objectname" and "objectsize" for remote queries. This works because
>> up to this point all servers will either support object-info with name
>> and size or they do not support them at all, but we cannot expect that
>> in a future different servers with different git versions to have the
>> same object-info capabilities. Therefore, the allow_list needs to be
>> dynamic depending on what the server advertises.
>>
>> The client will now:
>>
>> 1. Request the protocol option that the placeholder refers to (i.e.
>>    "size" when "%(objectsize)").
>
> "when" -> "for"?

Will change.

>
>>
>> 2. Filters the request in fetch_object_info() dropping any option that
>>    the server does not advertise.
>>
>> 3. After the fetching, the options that haven't been dropped are the one=
s
>>    fetched and supported by the server, these supported options are
>>    mapped and remote_allowed_atoms is populated with the placeholders.
>>
>> 4. expand_atom() checks remote_allowed_atoms with the same behaviour as
>>    the static allow_list had.
>
> I am not sure I follow the above entirely.  Could you add a
> concrete example to the commit message?
>
> For instance, if the client wants "%(objectsize) %(objectcolor)" and
> the server only supports 'size' but not 'color', the filtering in
> step (2) prevents the client from asking about the color, requesting
> only the size instead.  When the server says the size is 42, step (3)
> uses that to substitute '%(objectsize)'.  Would the end result then
> be "42 %(objectcolor)"?

You've gotten everything right until the last step, because we have only
size from the server there is no data to match %(objectcolor) and the
end result is an empty string for %(objeccolor):

"42 "

Note that %(objectcolor) doesn't exists and it would have die(), the
empty string is only for known but unsupported placeholders.

This is what for-each-ref does for known but unaplicable placeholders (atom=
s).

I'll add an example to the commmit log so it is clearer.

>
>> -static const char *remote_object_info_atoms[] =3D {
>> -	"objectname",
>> -	"objectsize",
>> +	struct string_list remote_allowed_atoms;
>>  };
>> +#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, .type =3D OBJ_BAD, \
>> +			    .remote_allowed_atoms =3D STRING_LIST_INIT_NODUP }
>
> Hmph, is this list expected to change over time?  One-line-per-item
> format would be more suited for updates if it is the case.

Will format like so.

>
>> @@ -683,12 +675,12 @@ static int get_remote_info(struct batch_options *o=
pt,
>>  			   int argc,
>>  			   const char **argv,
>>  			   struct object_info **remote_object_info,
>> -			   struct oid_array *object_info_oids)
>> +			   struct oid_array *object_info_oids,
>> +			   struct string_list *object_info_options)
>>  {
>>  	int retval =3D 0;
>>  	struct remote *remote =3D NULL;
>>  	struct object_id oid;
>> -	struct string_list object_info_options =3D STRING_LIST_INIT_NODUP;
>>  	struct transport *gtransport;
>>
>>  	/*
>> @@ -736,15 +728,12 @@ static int get_remote_info(struct batch_options *o=
pt,
>>  	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
>>  	gtransport->smart_options->object_info_oids =3D object_info_oids;
>>
>> -	string_list_append(&object_info_options, "size");
>> -
>> -	if (object_info_options.nr > 0) {
>> -		gtransport->smart_options->object_info_options =3D &object_info_optio=
ns;
>> +	if (object_info_options->nr > 0) {
>> +		gtransport->smart_options->object_info_options =3D object_info_option=
s;
>>  		gtransport->smart_options->object_info_data =3D *remote_object_info;
>>  		retval =3D transport_fetch_object_info(gtransport);
>>  	}
>
> This is not a new issue, but if the caller does not ask for
> anything in object_info_options, no call to
> transport_fetch_object_info() is made here.  This is so even
> though we went through quite a lot of work, including the
> connection establishment and teardown below.
>
> By failing to contact the remote side, we wouldn't even know if
> the objects being queried actually exist there, which is
> probably even worse.

[Answered below]

>
>>  static void parse_cmd_remote_object_info(struct batch_options *opt,
>>  					 const char *line, struct strbuf *output,
>>  					 struct expand_data *data)
>> @@ -839,6 +843,7 @@ static void parse_cmd_remote_object_info(struct batc=
h_options *opt,
>>  	char *line_to_split;
>>  	struct object_info *remote_object_info =3D NULL;
>>  	struct oid_array object_info_oids =3D OID_ARRAY_INIT;
>> +	struct string_list object_info_options =3D STRING_LIST_INIT_NODUP;
>>
>>  	if (strlen(line) >=3D MAX_REMOTE_OBJ_INFO_LINE)
>>  		die(_("remote-object-info command too long"));
>> @@ -851,32 +856,57 @@ static void parse_cmd_remote_object_info(struct ba=
tch_options *opt,
>>  		die(_("remote-object-info supports at most %d objects"),
>>  		    MAX_ALLOWED_OBJ_LIMIT);
>>
>> +	if (data->info.sizep)
>> +		string_list_append(&object_info_options, "size");
>> +	if (data->info.typep)
>> +		string_list_append(&object_info_options, "type");
>
> And if the request is only for "%(objectname)", an empty
> object_info_options is given to get_remote_info().

Right now 'name' is not part of the protocol as 'type' or 'size' are,
'objectname' is always allowed but only shown if it's present on the
format.
If the format is only "%(objectname)" then there's nothing to ask the
server for.

The current code avoids making the request if there's only objectname or
nothing supported, but still goes through the connection work. I will
add an early return to just output the oid back without any connection.

Returning the oid is what the client expects for which we don't need a
connection, but this means that we skip the existence check that
we would get if we asked for size.

The server is not ready to support a bare oid for existence check, it
could be done but that work belongs to a future series.

>
>>  	if (get_remote_info(opt, count, argv, &remote_object_info,
>> -			    &object_info_oids))
>> +			    &object_info_oids, &object_info_options))
>>  		goto cleanup;

Regards,
Pablo
