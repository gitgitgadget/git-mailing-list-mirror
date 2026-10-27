Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793100185;
	b=ZxwCt52uy548Wt/rvL1CERAc+G+Dr8w+dnzLyYWulIGq+eWSoNk4SzxwjfWmQlRo2SWU
	 xzoge7uXc7yYzsyJ2cC/fXTY702Vr0vx359tV5HfjjrNz7zEPYwL3R5+TCiuMeVfRCpYP
	 4GJ8XwkDx3abtOEGUCFRtY4mYrMDDrDJ0LFI34ZOmYRhHIefCBZAA8iMecEdlsQQYawzR
	 ERrfQiriK03I7nhoJDkXI9i+/V/xvK+lmeBsSJicy5mJgdQ/hfSSt1cuIBWcI02waFIxj
	 Aji1D+h5qqxJCb0zaj7kQkd/A5W3Yg2hoKiGV8ncUYs3AcquJsgnH0BLMxJhlOFDiFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ljph5d3KePALy+AQzkJZr3HSCfY/bhkUr/N2EDbBzO8=;
	b=2H0Pf1deVsUsH9E7Rqo0vMKpXZcKtXLSP1GflsbLcD6VI8DJNvdK2urSTxB1fvIxs01D
	 fHEYf3fkgNL0tTgq3JOy1y/PPKbMGNSsrklPJCo67yoPlA1ZseI2wwPsrLofkQ4eosbyB
	 wDNa9DPDiVvjSthDka/yQ3Ypa7DHJsEzZ8hc9oiwvgLNuKASfP0MZxfwC7FhHTwGSY9Yj
	 bRB1deciQjwpIQPTYwtHlCZfRXYLBE5MIRWwUMUda0ifEpnaBl3NoDg8NFafSjpYEIqsL
	 Lebikbyd9YefbEJLQ7FLL+1pRVcZylGfLUJjPiiw7TWK/90ZQq9FfY0+OJvRVeIiTDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="pfG/q8c4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC531606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC531606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pfG/q8c4
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so4812660c88.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793100184; cv=none;
        d=google.com; s=arc-20260327;
        b=MXnGalCrR1+l1Ufd8V/GzVU0vBuVnLrIPgOHs4ochreTDzr16tGp4PIKv4Mt1Dv720
         aI7A5X2V/dbCGJQb7mg9Vn+AN9P7xY5d4Q2VJPJYMpP+xCEuC7kJwDamQZhRDKaVZQIw
         BaV1jPyUd9v67V0WQeRV/kMGf6wpfOJrHHcu9qnARuJJICwgFrfWt6swvX+mzPluUJln
         Ug2XvWE2phpj7mdRKfDlaHK5cyOBGg8w6GBBTTrqb+pGOllZDa7c0+5LRPUrskagC3DV
         7P43DKtNPCnzjRuyVHvKNfQPihT9z0R3+GlNNG1JHNcS1PGN+TdmSASi1dAq+VDY1V9H
         FBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ljph5d3KePALy+AQzkJZr3HSCfY/bhkUr/N2EDbBzO8=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=bLfgCfGxcNvtXxnBcZ2O/Fb42psbk6G33bvVMeQokGHVSFuAH2cvw9AM+pTdT/lTo0
         W/WKk/gp1NpvtLiqHS0mtFL/TmYdOjQrGL94FntWGkdP9DXH45iCSnUWe1tDYRmX+bCp
         G4E24ZCyEs4dOZBJdzZeXp4fRBD2dvj6TEtbTIWW7Qv3m4OAvSGcpstlHH61dKzuMkHg
         YtL92fT2h35QolMvLO+F1nBvM4QAgcPxKdiDkInreygFzj9Uw94hOlNKwTQisunoMHA6
         MLGgWouZTxtwoePJuL3FSgwZt1WTt5bQ1vHSiuu5zymm/5EYgnqEldOIcYYj1KX0G4gn
         fqHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793100184; x=1793704984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ljph5d3KePALy+AQzkJZr3HSCfY/bhkUr/N2EDbBzO8=;
        b=pfG/q8c4ezoCM7Z30NRPCc3F+lg/IefwpDCzZLuRXEUpggVCEgC84V+mPSqse/QSzk
         w8lVIBzCJ1TCayBVWIBLdKIeW2tzyLbBK9hKOsB4lqyxH046RGPdxpOu1vxjSlNSWTBq
         bG2f3m6gt+FYH9tVxjgslO+T4vPcbB2HoZpr+NlpII0HehMPArqX6E2Y2DR+PllqtCNN
         UIqqmLYJlFsFVDHaUHtcLnFYQCupIuIdTXmUeFZeUh8rs6K61/nPvBnwAYr7JYkST8Yg
         oNp9UKSXGRizWQm5WiC9QvTdyErOHlBTe4z43LLJPnSL1O3RklTwQqGu1qHZCYVcCOyi
         jE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100184; x=1793704984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ljph5d3KePALy+AQzkJZr3HSCfY/bhkUr/N2EDbBzO8=;
        b=Rq3fyCy1mBAcxKOXKv6MYcZxZ/aAz5mNktLXtwqeq3Uwj36ZPQ2KJtOTiEklkwsNtN
         fztwykF7qjwjPSfb5hopZQ/pFo0zSDlbvKCjMNE9UQfSOYrW0sponoeEpYXc+beUvTSt
         FZSfYabApYJ+Y5vBPYdOh0p+gy2h+prD6ROAjhltlTmMs4y+RBXP9mdVEH/t6/YWd3Yh
         vb7/L/mmfMD5vGIxKB5Y3zdeARBNzhx+/1mJgZeFImHiUpayOuWTKcpISXBurarwgNeE
         28Sj2A7opXCExoHg8r//x8MQ40Hf+GGOqHy/QGWsvNfD0HBfSSdkoXRzwh18W2rh7lDn
         G3ug==
X-Gm-Message-State: AFq9FYJ9OFppnIxgmqexWAWXKjRABovg5ICXxAasVpZpSWy68OMkydtI
	k4jwo6ZHVRPV4I/hBZl9WxvTX0HcJ/Lq6z+wBMbXtCtbnB93LTxhFcnfD+p8wJ2pWbhCdKXhuE3
	eDZKZwcbLBU3ceXMxmC0S0E44d7dVxvI=
X-Gm-Gg: AYBFou0xn/RxgjEpOkQS2atfdwLEmsRVXs8+2BMyLcz+zt1BvKlq/4NHKx3+GsuccD4
	Wm3TYBVm+fr5+6wu1a51OuKrl8somWWA8AM7yidWBYvnPksCDGjRgnK9MOV546tuRkpkBeJxIgp
	Qg4ZewGWOWXbernTOHNhRZVNWgEuhmqneegfQiPJ+1GSDMSBbJJsCgxmtKJ/vqALnsXmjOvzxXP
	NkVrVRehjQVFz5diglQJzgTItFmqEj3GCtFbphNoKcE701Xzk9rrk8ItURCYHw+qWY8T6y4kRDz
	3ldcRvtoszxhXP5kqDcUd+P1XajfJyXUw/9hLH9v3jKyzh55PRCZjvr0e84G8W3FZb3XRU6ah2B
	qvXWfyY7XTsGpzhGBCktffIv2DLFKHouOJ8crQGQoEkwhkx5YMmtHLknAtUa2s9tVWTJQceeYfa
	uuSPZM/B/sh+GPWaZqKGoxQ6xR6hRJZzBlPjwDO0wGBNkzrYV8iS9ZCcfPRwhHzPl1nzI0xhiaN
	KC3xOWcqiTz7jgXKiB4s7xT
X-Received: by 2002:a05:7023:d04:b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-19936e34bacmr15182620c88.37.1793100183869; Tue, 27 Oct 2026
 04:23:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-6-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-6-30559d7ff43b@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Oct 2026 12:22:50 +0100
X-Gm-Features: AclHuK-B1k3pgdGe9369Zkn46EsKPwKYybP488eTCYSmVt7osod6yTo4fmw5ZSE
Message-ID: <CAP8UFD3XSQXFAiqGEp++=Y_OmEhogDo77t-XRFYAu_1yOQc+Gw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] odb/source-files: only reload alternates when the
 file has changed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> -static int read_alternates(const char *object_dir, struct strvec *out)
> +static void read_alternates(const char *object_dir, struct strvec *out,
> +                           struct stat_validity *validity)
>  {
>         struct strbuf buf =3D STRBUF_INIT;
>         char *path;
>
>         path =3D xstrfmt("%s/info/alternates", object_dir);
> -       if (strbuf_read_file(&buf, path, 1024) < 0) {
> -               warn_on_fopen_errors(path);
> -               free(path);
> -               return 0;
> +       if (!validity || !stat_validity_check(validity, path)) {
> +               bool successful =3D false;
> +               int fd;
> +
> +               fd =3D open(path, O_RDONLY);
> +               if (fd < 0) {
> +                       warn_on_fopen_errors(path);
> +               } else if (strbuf_read(&buf, fd, 1024) < 0) {

Here we start reading from the alternates file, but that file could
start to be written to...

> +                       warning_errno(_("unable to read alternates file '=
%s'"),
> +                                     path);
> +               } else {
> +                       parse_alternates(buf.buf, '\n', object_dir, out);

...suppose we parse the old content of the file (which calls
strbuf_realpath() for each entry and so does a few syscalls) while an
in-place rewrite of the file, like the:

  `echo "$PWD/alternate/.git/objects" >repo/.git/objects/info/alternates`

in the new t1006 test added by patch 3/6, happens...

> +                       successful =3D true;
> +               }
> +
> +               if (validity) {
> +                       if (successful)
> +                               stat_validity_update(validity, fd);

...then we would update the validity while the alternates file's
content has changed (and we only parsed its old content).

So, if the file content is not changed after that, we never parse the
content of the file from the in-place rewrite.

(If the rewrite is not an in-place one, but the file is for example
replaced through a lock file and rename, the race doesn't happen.)

It seems to me that if we want to avoid a race here, we should have
the `stat_validity_update(..., fd);` call before reading from fd like
in "refs/packed-backend.c" and "shallow.c".

> +                       else
> +                               stat_validity_clear(validity);
> +               }
> +
> +               if (fd >=3D 0)
> +                       close(fd);

It looks like v1 didn't have this issue, as it called
stat_validity_update() before reading. A concurrent rewrite then only
caused a spurious re-read on the next check. So I wonder if we could
keep that order, and just clear the validity when reading fails, which
would also address Junio's point:

               fd =3D open(path, O_RDONLY);
               if (fd < 0) {
                       warn_on_fopen_errors(path);
               } else {
                       if (validity)
                               stat_validity_update(validity, fd);
                       if (strbuf_read(&buf, fd, 1024) < 0) {
                               warning_errno(_("unable to read
alternates file '%s'"),
                                                       path);
                               if (validity)
                                       stat_validity_clear(validity);
                       } else {
                               parse_alternates(buf.buf, '\n', object_dir, =
out);
                       }
                       close(fd);
               }
