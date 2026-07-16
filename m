Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65AEAC7
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213554; cv=none; b=Qmc0RAYy4hPOdtYvWsfu64JBOLu05rrbiJd+Em82Bzz17uyGHr+ybyUmiq1/6eHAizYgNKEIoyCecmQgbLDQRCWjkyalrYwvaYqKyNzxqADUHqkNxiJJc6NkB0YC8fwx8T9GXugHcW2qeuNWBswfPwqG9PQ70vDRamICPA7fJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213554; c=relaxed/simple;
	bh=TexfXZcyfEQipwiCrHw8UTM2Bx/UPTTOY4QsGH4d/pg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YmEPt462vMaXPCDsbik2DDdDJ/ZnogITvhHjNJryYSe4/qD//KxJaRYTw+vsoXp1HdWUR5vEFijDvr4UijbKcJjEyvWyBcs42wbFx1gTSIed39oAQNjYG6Mo9Bd94uAwyznrP2mGUvM0s0+3frL5C5IvUK2ij5PdW2RZMuX0uG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhP09ahl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhP09ahl"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15c42a45adso61360266b.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784213551; x=1784818351; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ikERiIyYrUt7EPi2x9m5hAHzc+arFCUdIZqKtdQ664w=;
        b=nhP09ahlxf8KOH8x7l+8ExsXhrdYyoanyXD+evB6exFGw+Tl+qQPp27iUEj46KS0l9
         6+zji2lN2Y9r3wufzgBY1L1ACxeJlgENruTsjQm3yNgZ8ABpkJQMWTyh3MsTal8Gg37S
         MsyZAAfZbl2L8YNo9Rxf2Cr5U13dMyJ4Jdug7g9EkY3JS3HPLjRt0bdygCReFVrt6rQC
         LFajstZOpsJceOaQh3UjGI6iy7UnWMNBxd9sPBnag3VTC6n0Y3lNjkJMz2Jth5cqCDtH
         jUuZk7a1DoOik5rSxbiemxvuWvIT28dM+42YYh70kGj6fN0ZQpdpKg8h5IPhCIoYa9VE
         9KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213551; x=1784818351;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikERiIyYrUt7EPi2x9m5hAHzc+arFCUdIZqKtdQ664w=;
        b=gbV6kAx+T06YkndFE1FLxmWqAUMPmClEdimoBiN/58MvRvsntfXFznM7LsbaCc+oOe
         UjKJTHgYSRvZvABhuOlDNI+ApcqsADZncmGtqeH75KXs8tARcXAOledO9bbBahIiB1eX
         HnDFoyZnE+cp/w9J9u95Rvu6WxitH7RLfpYasRxV2RXTJt0/FObHQ9sM85PoSopm/cWU
         x1pIff7AzlklcFYi+aP9g1y4boFO9xnBE3e7b6eYQvCEEoIgrihNlUxJlXHsQJIa4oi1
         aITE8XEcVbTw06T9rI68837jHJ3AT/w021gqejKjET4hM5Mnw3DBcPHzvhgDFzBooirk
         C3Cg==
X-Forwarded-Encrypted: i=1; AHgh+RogejjXGK0eTo2Iaz/rBuSz2SsAkkhMeQuwLh73hxKe8BznzwGtSDOj8KpyPdnQfADwHpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywse9xR4oWaIP0jWJO4NX7HCyD3OzRYDxoFkLg5/Pqx/v4S5Q1W
	P2jMp1yebebSE4h+EdX437Eeuf5flaP503Kv3hbQZNJuqBHeLObxPTFp
X-Gm-Gg: AfdE7cnyKWgq+pT9srqWTJvPcFLnKNbD0aLSi2Buj/LmWxr35Y9J/JxBbmdahfWwVsA
	LPy7LiiiCmAO8VL7+Z3cfeOicizxWuU0oQulvSpmx3SB+y2HGEXG0pjMmKAge/T5v+2VgqD2OvQ
	6iZfIBNtRKii6rlkD6weK3b4/hPuSwaECrAxfxRrcFWtNPs2cb5wbn6gFfHqMbQlf9c549gMl/e
	6wDlsN0BpW4svAyWnR3x3Gagzxdcq35Thdb2pJLUro7zM7IEHWTVAZHEzkPtF6LpAPrUBzVyDhi
	RJaYDTtJiZvcV/Y0oLzEfelU4ib0XKZ9mILCjiH0jyARQdNxRxfcegsP4EDsNP2ITMyMLuY2LQq
	E7l8npGpR1uhkprh6+EX536FV21lh+i1vvM9MefE3rhI4Klr1PkCd5FScNFEz6aN8Jv/qCcTy9l
	/laxfwOOLSvtdzsuOjAn1v8M6fdo1YUjhFF57wks501O0BvL8R2816Cr4020XsC6WqfLStY0mlo
	7RZIsx9r0BB9E6GmF+B3l5JEkNJg2DQm9cynANqQ2mxUEnpqqa1Pq3fLaSKdOYROX9dDyituKlh
	R8fwhv4mmN9cEJGYLemvIyce4GZg0zjGqp+Gb5b00C6E2shlDVFXxgc9oV0=
X-Received: by 2002:a17:907:c21:b0:beb:d461:7b09 with SMTP id a640c23a62f3a-c16920c8c00mr149409266b.11.1784213550736;
        Thu, 16 Jul 2026 07:52:30 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16874a3f86sm226315066b.59.2026.07.16.07.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 07:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 16:52:28 +0200
Message-Id: <DK02X0ULSX7S.24CCVGDZC6W9Y@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <gitster@pobox.com>, <jltobler@gmail.com>,
 <peff@peff.net>, <toon@iotcl.com>, "Jonathan Tan"
 <jonathantanmy@google.com>, "Calvin Wan" <calvinwan@google.com>
Subject: Re: [PATCH GSoC v18 05/13] fetch-pack: drop static advertise_sid
 variable
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260715-ps-eric-work-rebase-v18-5-34d7adb051bb@gmail.com>
 <CAOLa=ZSy1Z-R38cqFiz-Ejj9CNJkp4x_6rFk_wdfhyBytYH9fw@mail.gmail.com>
In-Reply-To: <CAOLa=ZSy1Z-R38cqFiz-Ejj9CNJkp4x_6rFk_wdfhyBytYH9fw@mail.gmail.com>

On Wed Jul 15, 2026 at 11:48 PM CEST, Karthik Nayak wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> write_fetch_command_and_capabilities() is moved to 'connect.c' in a
>> subsequent commit. To prepare for that, drop the static variable usage
>> of advertise_sid. Currently advertise_sid is used in two places:
>>
>> 1. In function do_fetch_pack():
>>         if (!server_supports("session-id"))
>>                advertise_sid =3D 0;
>>
>> 2. In function fetch_pack_config():
>>         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
>>
>
> Nit: But #2 isn't a usecase, it's where it is set no? Looking at the
> usecase, it seems like we have two:
>
>   #1 like you stated
>   #2 within `write_fetch_command_and_capabilities()`. But the flow is
>     that, the variable is set in `fetch_pack_config()`, right?

Completly true, fetch_pack_config() is where it's set, but not where
it's used.

I'll fix #2 to be where it is used.

Thanks.

>
>> About 1, it is only relevant for v0/v1 protocol, move it into
>> find_common().
>>
>> About 2, call repo_config_get_bool() inside of
>> write_fetch_command_and_capabilities() and find_common() replacing the
>> static variable.
>>
>> Because repo_config_get_bool() leaves advertise_sid as is if it is not
>> set, initialize it to 0 matching its default.
>>
>> Helped-by: Jonathan Tan <jonathantanmy@google.com>
>> Helped-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Calvin Wan <calvinwan@google.com>
>> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  fetch-pack.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index eea72b2500..8e04db8640 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -49,7 +49,6 @@ static int fetch_fsck_objects =3D -1;
>>  static int transfer_fsck_objects =3D -1;
>>  static int agent_supported;
>>  static int server_supports_filtering;
>> -static int advertise_sid;
>>  static struct shallow_lock shallow_lock;
>>  static const char *alternate_shallow_file;
>>  static struct strbuf fsck_msg_types =3D STRBUF_INIT;
>> @@ -363,6 +362,9 @@ static int find_common(struct fetch_negotiator *nego=
tiator,
>>  	size_t state_len =3D 0;
>>  	struct packet_reader reader;
>>  	struct oidset negotiation_include_oids =3D OIDSET_INIT;
>> +	int advertise_sid =3D 0;
>> +
>> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &adverti=
se_sid);
>>
>>  	if (args->stateless_rpc && multi_ack =3D=3D 1)
>>  		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack=
_detailed");
>> @@ -414,7 +416,7 @@ static int find_common(struct fetch_negotiator *nego=
tiator,
>>  			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
>>  			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
>>  							    git_user_agent_sanitized());
>> -			if (advertise_sid)
>> +			if (advertise_sid && server_supports("session-id"))
>>  				strbuf_addf(&c, " session-id=3D%s", trace2_session_id());
>>  			if (args->filter_options.choice)
>>  				strbuf_addstr(&c, " filter");
>> @@ -1160,9 +1162,6 @@ static struct ref *do_fetch_pack(struct fetch_pack=
_args *args,
>>  				      (int)agent_len, agent_feature);
>>  	}
>>
>> -	if (!server_supports("session-id"))
>> -		advertise_sid =3D 0;
>> -
>
> So earlier we'd set the `advertise_sid` to 0 if the server didn't support
> 'session-id'. But we could directly check where it is needed, which is
> `find_common()`. Is `find_common()` only called in v0/v1 as stated in
> the commit message?

Yes, find_common() is only called from do_fetch_pack() which is the v0/v1
path, if we take a look at fetch_pack():

	if (version =3D=3D protocol_v2) {
		[snip]
		ref_cpy =3D do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
					   &shallows_scratch, &si,
					   pack_lockfiles);
	} else {
		[snip]
		ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
					&si, pack_lockfiles);
	}

>
>>  	if (server_supports("shallow"))
>>  		print_verbose(args, _("Server supports %s"), "shallow");
>>  	else if (args->depth > 0 || is_repository_shallow(r))
>> @@ -1380,6 +1379,9 @@ static void write_fetch_command_and_capabilities(s=
truct strbuf *req_buf,
>>  						 const struct string_list *server_options)
>>  {
>>  	const char *hash_name;
>> +	int advertise_sid =3D 0;
>> +
>> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &adverti=
se_sid);
>>
>>  	ensure_server_supports_v2("fetch");
>>  	packet_buf_write(req_buf, "command=3Dfetch");
>> @@ -1998,7 +2000,6 @@ static void fetch_pack_config(void)
>>  	repo_config_get_bool(the_repository, "repack.usedeltabaseoffset", &pre=
fer_ofs_delta);
>>  	repo_config_get_bool(the_repository, "fetch.fsckobjects", &fetch_fsck_=
objects);
>>  	repo_config_get_bool(the_repository, "transfer.fsckobjects", &transfer=
_fsck_objects);
>> -	repo_config_get_bool(the_repository, "transfer.advertisesid", &adverti=
se_sid);
>>  	if (!uri_protocols.nr) {
>>  		char *str;
>>
>>
>> --
>> 2.54.0

Thanks for the feedback, will make it clear next reroll,
Pablo
