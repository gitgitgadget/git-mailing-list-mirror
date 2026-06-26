Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1203FDBEA
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492900; cv=pass; b=aOX8BMDJbeec/st8CbT8439I0nPU3ySRmLEIvdM2Lj3ApHcS1zRkG/TkSzP9kC4MuL52B5DW92+eSStAaSJtPFArMXFxnp+Xz5i3lQxwH6Auv3+4Uevlz+R/N0ns7E9ses9thxdBrECzk9Gue2d+279Msn9MbiWC8JC1aBSbj6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492900; c=relaxed/simple;
	bh=QfhYn7e8L+GpJK4rmmbadZnM6CJcn5xVR5Z3wUd66YM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMeFEevA5/dgd3SD+4BCqzJ5hGAiUFOiAeDvJlFl0dbtSTjqojJLm+FTYcgJNF4u71DOmUq//amyHbhl2hlEpea1ZYJklS9hjxD0owWX6BZTVbSQayFaG8WPhkYjlVDmfTq4aHz60C2UJLl09/g7Kdtmqp1RKuknUT+NkFL4+8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogqxYAxD; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogqxYAxD"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7276a7aefefso451235137.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 09:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782492896; cv=none;
        d=google.com; s=arc-20260327;
        b=PBuLzCT/EeR8UZmHoELA41oKvYGnneh0eqcdcxYRQxT20kTK5+vFpwwvouEitcBj7P
         cVNprpzF8dZjpEKOCzsAiCk4pePr5wWej9xmMI4WfOkAWIZhR8ns8HjRPwgiqgqs08hZ
         TjDROKaba+ghhh+oYIFaACWdKlq9woBLGI38zUASg766nVPfj2Khfn5cn8nrp7PznOei
         Jl7bMMAqAxGeiBX1bxKGyL5GaHd6P+V3TNB7V0QGjl0FsppoGBEEWSh2ey1dj2qYFjbM
         wGuQrYajByYbf+NA7fpot9IhAPX9OtI/9RiUx3TntvHol7pfdTmYu+yoBHgohydAMmwk
         9UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=oKQ5lDDJvBB2r6ziyLrWtBWZFJXfbBGxJ/xaM+xcCRM=;
        fh=G9DjJfeljTVhMqynCUoITkM7Ps99F34iQWIBAwR2kTw=;
        b=qEL+iYPFbEOHjhw25umy27OJyhQjEtl7WvliACKT/f6wZH2W6XXHnt8G/Vaw368zLs
         HVn73aQ+Ws3CJbz/zkqRPOI/Uc0982kR70jaxuSBpluqZYeLpuhuPrK3PTbW9h7wQFVY
         lZRmB3DzE+Buv8h3vrFXEGawwyFd4QCd2eGyP/r4m/wtcGWZ6aVlfMgDXjkps1t/D50b
         NoLM1HklEg7fliC9ey+f/HvceL5uW8jIURrpu6QWPiVbwUg3/QL/LfxJ7GbG77GwPTVA
         hQrNuArK8wnXkwLzGx+WoCwqHBTPOe60HT6vTiw6FdMxUaL+x5962SE7g/+107s7oT7P
         TfIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782492896; x=1783097696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKQ5lDDJvBB2r6ziyLrWtBWZFJXfbBGxJ/xaM+xcCRM=;
        b=ogqxYAxDzQ7U2ugwYd+WatPS6wN95Uz+3YOh1UmJYcxNcW48qywZHZkMTA+iJXSaCt
         H+y3KdxzcPfOp5L5fpkwdySR3Rtp1fodxLccFzj6Vxf7ZAgS1Ut7yzS3x+24/x7dbci9
         GaHTP8s7IDYIjrZEIUrsa9QmgZaEHZkfnf+553yMMkfeV+J34O3bmyNaK6130fL4w06K
         F/EB9jLRaTyo9IaMlGdvqxN79tIr5Q0Yfg1K+gk3UjKR3GPNFAE2Pq4cYg4R3vVnor6q
         LJii0IJCb7iDLzBfhjuSD+UTwTG2hoCgXtKBgh469kMKonwbqsTwaOO/eLsSJyUVsTzi
         ttVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492896; x=1783097696;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKQ5lDDJvBB2r6ziyLrWtBWZFJXfbBGxJ/xaM+xcCRM=;
        b=KEWvktJDr5u1wzn6MpZBc7kQP9u86nRSS6JpL6aLbuiTrL9Al1e0yWFwcm0YSEIVcx
         uVG3yTOv640kuwp0PZTx+ywjV2Cmx2xbsQ4QfrLTwdHO6qc5WvQ8rlAJ56+RyeQgGSNd
         jwOvzy2pRuZOeb3+pZXKa6RYgRsvlrAwv9QdSGRNa8mSS3zCooIMVwTfN20NB4UDc8Bg
         jOdjon7fDXyid6gA+mVt7qu2H0pYfYb73OU17YYqAPZxZf0PoW9XelebxR1GCBBiJia/
         +IIRrLY6tweCWLEWQ7SRfEWQS7Dv4+GZBQJhigdUJaS97InRAxeSrcfF85qwUY7CRoM1
         RaNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrq6spcCZB+BnN8vA+vHaVGXYpqRGbWMafvY+86iBEOjNykYFzbOCgMrEEPlqMiS5EJu1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncxMe6FqbuLFFqqB0ex/8ZiK+h+jXDWVmhZE3fMBtlDIZV3cV
	CPa2gtjkNySveTUpvrMTdXur1BQoMPQkoFTDyfCfbJIQ4zhIlTqa3mKIvqdZBzhtGndEx3K221C
	nSsT6YA+ciTybhiZpLYw2iISIgi2p5lQ=
X-Gm-Gg: AfdE7ckg3Epd1aLsWrK3bE9xDEPlZXW7+ogDJanwMxYwWkPzvU/Ipalpb2qvuGz6lBH
	48t8LJOKTaTKhNlq6OrjOad975e3RhcmHP45CNh9giM97BD9Z7NkhxeXiaRPbj8Y+NtIAkGCjRx
	adzdmtPlzd4rAiIRiA1CDv5Lqbe5ovYE0KaPHeGZUco29cm1O5iHsyWF6WP8rSptUO6Xxro7Vup
	wsxI5PVxpvG1DEL3ujsjYVJ+bd8PNMVjm5f5mUjwoTgPhGSmxNYFlKl4waepE0HdGfd59DCC6DU
	MjskhQMiXXJfv9/bRJ4kuB4DfJ55MXGcZk10sszWs/HY8RhxSnRBgWDQYxXrD/vbRdYRRJkY7Q=
	=
X-Received: by 2002:a05:6102:1623:b0:729:e047:6155 with SMTP id
 ada2fe7eead31-73434245bc3mr3479654137.10.1782492896350; Fri, 26 Jun 2026
 09:54:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 12:54:55 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 12:54:55 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-5-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-5-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 12:54:55 -0400
X-Gm-Features: AVVi8CdXTAuzc9pxwpIWRIRH5AicZoeyLV3KM5ddr26X2q42K_3-HWAEs6uWO_0
Message-ID: <CAOLa=ZScS3Gmm5BAgJF69phpaDXGnP_j9jx+bMhn_tfF65RXEg@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 05/13] fetch-pack: prepare function to be moved
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="000000000000e6f3ae06552af717"

--000000000000e6f3ae06552af717
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

The subject doesn't really give much insight into what the patch does.
Perhaps something like:

    fetch-pack: use repo config in `write_fetch_command_and_capabilities()`
    fetch-pack: drop static variable use in
`write_fetch_command_and_capabilities()`

> `write_fetch_command_and_capabilities()` will be refactored and moved in
> subsequent commits where it will become a more general-purpose function,
> making it more accessible to additional commands in the future.
>
> To move `write_fetch_command_and_capabilities()` to `connect.c`, we
> previously need to adjust how `advertise_sid` is managed. Currently in

I don't think 'previously' makes sense here.

> `fetch_pack.c`, `advertise_sid` is a static variable, modified using
> `repo_config_get_bool()`.
>

Perhaps:

    To move `write_fetch_command_and_capabilities()` to `connect.c`,
    drop the usage of file static variable `advertise_sid` within the
    function. Currently, `advertise_sid` is modified...

>
> Initialize `advertise_sid` at the begining by directly using
> `repo_config_get_bool()`. This change is safe because:
>
> In the original `fetch-pack.c` code, there are only two places that write
> `advertise_sid`:
>

This needs to be modified no? This is from the prev patch, where we
moved and refactored in the same patch, this no longer is the case.

> 1. In function `do_fetch_pack()`:
>         if (!server_supports("session_id"))
>                advertise_sid = 0;
> 2. In function `fetch_pack_config()`:
>         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
>
> About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
> assignment can be ignored, as `write_fetch_command_and_capabilities()`
> is only used in v2.
>
> About 2, `repo_config_get_bool()` is from `config.h` and it's an
> out-of-box dependency of `connect.c`, so we can reuse it directly.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-pack.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f13951d154..ad07603755 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1380,6 +1380,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  						 const struct string_list *server_options)
>  {
>  	const char *hash_name;
> +	int advertise_sid;
> +
> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
>
>  	ensure_server_supports_v2("fetch");
>  	packet_buf_write(req_buf, "command=fetch");
> @@ -1395,7 +1398,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  	}
>
>  	if (server_feature_v2("object-format", &hash_name)) {
> -		int hash_algo = hash_algo_by_name(hash_name);
> +		const unsigned int hash_algo = hash_algo_by_name(hash_name);
>

Agreed with Chandra, this needs to be assessed.

>  		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>  			die(_("mismatched algorithms: client %s; server %s"),
>  			    the_hash_algo->name, hash_name);
>
> --
> 2.54.0

--000000000000e6f3ae06552af717
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c9bf294cd74369d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vK3J0MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0k0REFDaVMxR2tNbDZQU296Q0xZTnJsRHh1emRxaAp0OFZpbndBM1VM
a0tidXpLRnJRQnd6cVp5MmRXNERaa0tqOWlxMUZobS9QNXNFQStSVmZ6MlBvcS9GMWNrbURHCkk3
N2k3QUN2U25nY2FJeEZBVHJJSGluMy9vVWg1elRlczhjTGFFZHRyd004dThmYnlzb1VIdG0xanpv
TjNIVkQKQU9zUi8vWXBJZVQxRnA5Ymh3Z1BhalJTTkNYUWtnWnBpN3Y5QlNjKzRxYWpoU0NHZTQw
Njl0bzM1YlBua1J5QQpHS0dFckhhcExyeWFYUHA3eDZvUFZ3VWJqZTFKeVY2aEhkZ0dnMDYxWHBR
K2tKaVVlQ2Z3TExCVUhwRWMvanVnCjZCeFVFSTQ4aGdWWG1VOEZvdFBMaW5YVFIzaldickgwTmdP
OW1Rc1QvY2pRYTcrN1QwSGVNZTlobW1uakZndUgKeGNjazI1VVdkZFpBNzRnTG9obW96QTIzMHIy
dUI0dk1EK0d4cGRidFFFblFkK3BLcllua2pUd3BnQWJyTm9ZdQo1dFJZMnNvRGl0Ni9JUnJkUlFJ
MGMzQmp6ZDlmdkVFVVJsb1J0LzFYc3NwZzlSQ2dtbU94ZDR4T1dqMmxsVjBNCjlta2lYVkZ0VDds
aytZUDkwRkhCTVlGeTZSQ2VTcmlrQU9GRXBEZz0KPUs3cjUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e6f3ae06552af717--
