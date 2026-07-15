Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119933CE80
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152127; cv=pass; b=tkGclBCsF8t9zwdUWH79yZB5tOlPMXs9OKRAbYcQGEDg7ohN8H0FRFlcpSL/osh9LLadfP3vLrTDMjRaIJUsd6POBTu6rWdhh1dF/mdzxH5/DOIojJK+PJQMaJJ6QJHp/7pAmJdjZrLR6fGPJ278S7Bck5UDP5m8kh14dGkmJ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152127; c=relaxed/simple;
	bh=SRO/lnLU8iKrHfLEK7sGJEIz1FSJJJv7GzTboQCytJo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxhjQTN053NpYHBpOGm2O3M3DNsiEkzT4wte070QnVx36j9yfL6k3sMsxQKw5tPLpUyCPeBO771OVCbZC/U+I6GDNGfzKaErWKlNMW+prnxxz9lXvCq3JKpmUWbFEsCWq/Z3FCywl2trN7ZrJqSt/3vlOiXTIc67PwK25NyV3Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7mRIUpq; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7mRIUpq"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9696319e14dso2340622241.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784152123; cv=none;
        d=google.com; s=arc-20260327;
        b=n6bBBBEhP4wQ3ufWfDzvuE9mKkCkwEziJFl1DSENPe4qU6tFEOPu/4fI+CksNyzF/y
         gH6/Qa1TAdYxlM0PppHijNY7QV8NUffdJnUpmKc3C7Zp+cCLwaGr44KVCsALf4xioTtt
         k57FBHCHN/dY6feu/EZm/RaTynqr1T5YBN32BGlGCWPFqzL4xODpQn3etOoBeTBtkTUH
         pGV1Qpc+KT1iK2DmieOl6avNLZ9RQfsYRGnVnGwhea+6uEddljQv7i/umdBGUAYaAiBN
         f6BSC0zmWUeyn4DkcBjPgWps23/b4rbcwjmx5b/wo5m3bCYx2d28g8FPhDn+gW4lSxk2
         kJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=VmYfSLs2jnrrbaU5ft3pMhJA/NJfDyqO7v35fEG9pLQ=;
        fh=J3KKJi2VWy7vHpl4osSlR0h9kOFHSk+7Fif24PUGDO8=;
        b=mVi2YGE9LDCIXsL/i/PMVw/jYja3HzWJCNplt/CYWnuVwDUdlILr6PS3roIsLqTxW0
         dnvM341UorK4WfIDOMyMnn2zeY1M43GDdlMIFuc8xyfZF+C0F0eoTtJBfh7KwV85iNbm
         gBxcdDUXt1rqMQsM8UYLwK9ApwN6W5zFxU/0zhBxxigxAayfomXTnJWCqVtRI/n7e0Y+
         WsjlqBf3ACr2/djkZH9lLS+k4uABjOSbLDc5cy09w60pqcFdDNQHdgTS+3UJMzn+dSCB
         J332uobf63idMWRpIUrkOGaXn7FHIP5kibtxoBxzuMYyGWQb8XFRjHZw6YX11mwQa0DN
         wXpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152123; x=1784756923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VmYfSLs2jnrrbaU5ft3pMhJA/NJfDyqO7v35fEG9pLQ=;
        b=F7mRIUpq72jdxVLxsT1M4uD7avZCvoEBYrTTXGO1jzLPGArOQabx8OvFPgFUlP4MR9
         IDaNrs2aBH1pOSxMn4gn5A46wS8hYG9YPd6kgXIgQPhzwebMsgfwXxxCueLE8O89aIAr
         cDwBoACN7Btgg3x4ObmC3hxH4Dt8YzkYwy8KoRskg3E1kXSjEGyOQEXwgxxQO5BBPdHt
         Cn/cxxPauYMIVPJN3dTVYXNh0fOfJnbZCrfjjjrq++TBt4ugYTgsJy/Fl/q1NOYKHtr0
         2Q0Wl/NaTZwpLaPW8Y2rsneedkFnB8Q1Dt+OPS1KrbUjT0SHOIYjIQ4V5aqx1rBVh1Tm
         wcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152123; x=1784756923;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VmYfSLs2jnrrbaU5ft3pMhJA/NJfDyqO7v35fEG9pLQ=;
        b=XYyImk9/lq9Ntz6K+6OYsCX37LY6eloYBjHpFW3rUqEfLTGC5X1xYHJEtHvBEyWio/
         CL4C1L+A494ohaSTs0asoscJP6Zv227oP+Q5oBi13An0vwwTMkXZQzn0gVlvAYiX5p0b
         DWnUMb4qmS2gJfustzwjVpjWVxhAuKBQxyYEMul4OHCg51P6vY1iYUZrgX5QczuCiH8X
         HJgRccvw6y+56QlxEn9xtE8GtVhnagLYPGwLMShQr71DzcTsDhPKltPNeCWudY37quUZ
         S3RprWvGOvdGXqvIX2yYkkJN6A2lf+UbZWvGyX1EdUymGF/ScznPJ9B4Fvo9sQVDmXis
         I93Q==
X-Forwarded-Encrypted: i=1; AHgh+RpVkNPOHAtgQQgbU0GNfx5RmA4i4/AfO1Cj0zOI8tvSFj3JgzIWE9yEhv4G6vcBELCh7YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzqEvRH9H/brQWlCu/L4LiJEmmCsFjzdpjg6lCs4kD+wNnTcJ
	4y216p3OUNbI8gsxWjPjcj1/W/+1oVgDDzmcvMbq8aRttBcBCKiAYKAYMl+TCLkWLG7T6tc7sZc
	TTszcUGqZkiDsuH96BGsJ9Xys2BqDuIU=
X-Gm-Gg: AfdE7clJnLRnZLsK6Z+arYo2mYJOXpIw/K60rjQok1MDBiYLSQXkM3jd7BRJEnc+gQq
	r8W3LJkv94pVFXjC2CfygLTGL3YdGAbKz8HXmyd8bKXULK0DM2q9GQ3WjHl/gKn+Zp/MTv2tHgv
	MxGyAIVrvNdCeVaVRo6rGW5atyA5NFbjiBYVDiNEHGyoTzqkHaj1ErLctuu4V+YHnTmZIcYjvP3
	rLzzY5C5vscIEEkGrBC/x7lewLdsFmcZsTRmacEX5rqKvW8IQjKCuPfmzhX/ZrSv2UYkeflPWhF
	PNBKZxukffDq6aqmQ9k=
X-Received: by 2002:a05:6102:2ad6:b0:73a:9949:df89 with SMTP id
 ada2fe7eead31-7457e9b8e51mr5223092137.24.1784152123447; Wed, 15 Jul 2026
 14:48:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 17:48:42 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 17:48:42 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260715-ps-eric-work-rebase-v18-5-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com> <20260715-ps-eric-work-rebase-v18-5-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jul 2026 17:48:42 -0400
X-Gm-Features: AUfX_mzrt5vR29fB3Rp8zwGzlZewSPCDFyhp102DnkylwsiJ8LKBHvfZLq_V0_U
Message-ID: <CAOLa=ZSy1Z-R38cqFiz-Ejj9CNJkp4x_6rFk_wdfhyBytYH9fw@mail.gmail.com>
Subject: Re: [PATCH GSoC v18 05/13] fetch-pack: drop static advertise_sid variable
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="0000000000008b40f90656ad4921"

--0000000000008b40f90656ad4921
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> write_fetch_command_and_capabilities() is moved to 'connect.c' in a
> subsequent commit. To prepare for that, drop the static variable usage
> of advertise_sid. Currently advertise_sid is used in two places:
>
> 1. In function do_fetch_pack():
>         if (!server_supports("session-id"))
>                advertise_sid = 0;
>
> 2. In function fetch_pack_config():
>         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
>

Nit: But #2 isn't a usecase, it's where it is set no? Looking at the
usecase, it seems like we have two:

  #1 like you stated
  #2 within `write_fetch_command_and_capabilities()`. But the flow is
    that, the variable is set in `fetch_pack_config()`, right?

> About 1, it is only relevant for v0/v1 protocol, move it into
> find_common().
>
> About 2, call repo_config_get_bool() inside of
> write_fetch_command_and_capabilities() and find_common() replacing the
> static variable.
>
> Because repo_config_get_bool() leaves advertise_sid as is if it is not
> set, initialize it to 0 matching its default.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-pack.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index eea72b2500..8e04db8640 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -49,7 +49,6 @@ static int fetch_fsck_objects = -1;
>  static int transfer_fsck_objects = -1;
>  static int agent_supported;
>  static int server_supports_filtering;
> -static int advertise_sid;
>  static struct shallow_lock shallow_lock;
>  static const char *alternate_shallow_file;
>  static struct strbuf fsck_msg_types = STRBUF_INIT;
> @@ -363,6 +362,9 @@ static int find_common(struct fetch_negotiator *negotiator,
>  	size_t state_len = 0;
>  	struct packet_reader reader;
>  	struct oidset negotiation_include_oids = OIDSET_INIT;
> +	int advertise_sid = 0;
> +
> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
>
>  	if (args->stateless_rpc && multi_ack == 1)
>  		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
> @@ -414,7 +416,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
>  			if (agent_supported)    strbuf_addf(&c, " agent=%s",
>  							    git_user_agent_sanitized());
> -			if (advertise_sid)
> +			if (advertise_sid && server_supports("session-id"))
>  				strbuf_addf(&c, " session-id=%s", trace2_session_id());
>  			if (args->filter_options.choice)
>  				strbuf_addstr(&c, " filter");
> @@ -1160,9 +1162,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  				      (int)agent_len, agent_feature);
>  	}
>
> -	if (!server_supports("session-id"))
> -		advertise_sid = 0;
> -

So earlier we'd set the `advertise_sid` to 0 if the server didn't support
'session-id'. But we could directly check where it is needed, which is
`find_common()`. Is `find_common()` only called in v0/v1 as stated in
the commit message?

>  	if (server_supports("shallow"))
>  		print_verbose(args, _("Server supports %s"), "shallow");
>  	else if (args->depth > 0 || is_repository_shallow(r))
> @@ -1380,6 +1379,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  						 const struct string_list *server_options)
>  {
>  	const char *hash_name;
> +	int advertise_sid = 0;
> +
> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
>
>  	ensure_server_supports_v2("fetch");
>  	packet_buf_write(req_buf, "command=fetch");
> @@ -1998,7 +2000,6 @@ static void fetch_pack_config(void)
>  	repo_config_get_bool(the_repository, "repack.usedeltabaseoffset", &prefer_ofs_delta);
>  	repo_config_get_bool(the_repository, "fetch.fsckobjects", &fetch_fsck_objects);
>  	repo_config_get_bool(the_repository, "transfer.fsckobjects", &transfer_fsck_objects);
> -	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
>  	if (!uri_protocols.nr) {
>  		char *str;
>
>
> --
> 2.54.0

--0000000000008b40f90656ad4921
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4507baa296ba6853_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wWUFEWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmJyQy93UGxKZmpXWEsySFBVZFhHazVnVkN0UDRKNwpDZGxqTXo2Z1Uy
aERNanIya2ZmY1l3YW40YVhxSVp4QWo3SDZ1c1BFbUkwaUZvelE5b1RPOE96SGZJcHYzeklYClRk
c1FxQ01sejViK2UyWThIZXdPWTRvcUcrS1hwQkllY2hPbGVtZ0lLaUpWWmN4b1BUdGJsWkIxNEhL
Ukg3SUsKQjdFY3RUZSs1SEd0bHJPNHZVd1pBWFlFS3hrOG83YWRrYmNoZVNzMVNDY0ZrQVFxckgz
SGQ0elo1bWlqTUszLwpCUVN4NmRrSlBHUE8wak1JVC9DYzlkOUp4a1VOK3J4d3BCQ2RuMUZLVUUw
MlJaWlRDY3hpOWRIVm5aL0lveThaClRHV1lzRnRuNlpxK3VJa0xGVk1hMmlBZ2I2NHp6Qmlzb3hO
a2hYbEl0Z3FtUVFyKzFYa1FpM3R1L0RlcVpxbnIKdkhGdTJKcGxIRFFVaXR5ZUNxMmg2SEhDZXpD
OXdPbmY1ZnZjVkhDM2xSYTRlbnJOWlM3a3V6R21jQUxrMzhsMApKck5hclRiOGszRmsrWXc4dHJw
ZVJRZlBuNHRaclJyT2I3OHpsVjZSWXNhSHJ5a2I2cmNGYWFkKzdsS3BUbUIzCmhHd1BVYXByeGlh
aGN6ZVZoK0VYcUxtWlJXdjhJZW9welZvNlMrcz0KPVl5UzEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008b40f90656ad4921--
