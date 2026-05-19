Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05C408000
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204318; cv=pass; b=QVJu9W/iZ17BV8GOnwX05j/TOUFnT9FOLr6zvsOfgvV3pnsOKFRwMHIWnUEZh5vfcgqtu0wYN7yIbjP5ruNEeFwqlgRAXAUFvQXTBZaDzIy8FTATim3LoULWtSSRPswDwWZi4mBF5xnL9uq/wD9rHEoPNZ2yoioyFig8JFWnVy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204318; c=relaxed/simple;
	bh=4dNk4yarxMApgutdNwEyXP7XixqlHIkZk1LlTcm+hD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNKX2tnuO5GTYzXXKWRmCS1AdBvpdeidkTwdejVIq6fhtRP3GtmyQ1Br8rDqn5jnJm4iHIk2KPRKTExqzgRrwm2IJjdT5if6ICSjsSQVKaFCahoJHNFHWvQJNab98A0DUDS04DUgIRi/hL2B+mxwIdgq2soGYP8d9cie0R08llM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkF0SlIa; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkF0SlIa"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c1a170a50so4556115c88.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204316; cv=none;
        d=google.com; s=arc-20240605;
        b=YGq+ROUcd0l+qoWxn+YnFtVjsaHDniAFF6xfhl0FIhP5S0uyaSLAcYAIrXt1NLFmZ5
         XsTWxoi1VOfJ2H8jUlyFNuwlbhLEfcYQbP2ML8bqfpIMBxL3DAW6+xjkBmgHWtj9hqup
         mxxqhHdsO4x5rpOs2XRviYL583OGbuKrj5VIzW73cQ/8Kiwn0pnqWIi58HePDeSOqj+q
         yu+98VhxL5vo3iYLakSfFVMdv7ckbKKT1QAZ/2R7jpyJYVVASABI2vKZgDKN6THhoZne
         IKTc7rWgIsHSpM7SE1BgU9V9sL33cgyKRe3VIANXJ4PqYD8SgIlscLv3YZxMbqmSYBPh
         uUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAc2NJZCTBngHundiWRyGL7TQiqwNCZx+ZwV5TH/iYU=;
        fh=rnkYOd0g6i/l7E/y+/vhBWHmQUXTX4flLDwaef/8U0U=;
        b=FJGY+BvwVc+OzOajLhDFTiXscGNzBjhSW+hEetBkVFXeALhx7caRGh+QYgiZkGFfAS
         mmzBwIXcgbYQbwDmkYbaVRlvxpjwzIVo5trkskORsY6+7EAiHWHoERh7mDWHdgUzETgH
         7a6gumK+90cqf2/Hfsj7e0JFwWy0xIHncgu+CZuQeZligoi7k2m0lVH45el/AnnVkZMG
         fAv6IPObhX2yphr+JbOZtLuDhaWPj2/DF76+3moIcWAnByVJuryK4PZW2dehhLwa1Hr7
         OUSvbC/EHu4IPBEmcvO29+8zfqz2w5UkEk30X1OA3s005+MIr6SaO6TmUFryUEZNbvwg
         I2Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779204316; x=1779809116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAc2NJZCTBngHundiWRyGL7TQiqwNCZx+ZwV5TH/iYU=;
        b=GkF0SlIau+tJPNOY1gB3PkserVYBvTFDjlAZqmLJ/Y7ChuOEPreWob0F6Lgu/pSUmy
         yYRf4YbQtcdi26u1G0lrmrjOEmVvhoQxSfc5qiAHTbLf5+qTSyHYMZLFQ5QwTVQL7fFJ
         rsabD6NvpwlxPYZyCffCIGd4j/vAEJzkBSBDJI5/ewk9mrvsjvPXUJj6czdms/IRRZSA
         baBHkP0Fy9WsWuTC+Yvg0Pd5ysayN36AWmApGQ3stAadr9Vlin4ehGd72YCryMbQdHqZ
         H4/L3k4Zm2LIP3KRQT4nXWQs8qt0OAfgF5BKi4M9zTNuRV5XbAXYIQp6DGvoGcUvpqqB
         rppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204316; x=1779809116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAc2NJZCTBngHundiWRyGL7TQiqwNCZx+ZwV5TH/iYU=;
        b=NFl0wps0W/kfoDV9eT/eTKQt/wpHCPWf1o/i22dC8ZPSbJxYXHLwXwYQiF4SJs5etD
         mm0Yszv9wMlEq3APFobWYNxSNrfKBrJyQt8faSOrHvM7mH8QIGE5/VlKccjx0VGUNBSf
         6YkbCafv93CPIS7wjHaKPA65BkhVBURfqDPvzwzBeHsIUEcXDfkstHd47R0zKklwPTxn
         8F88VD3SJUaP/YSDw9S4BVPwmuz10kzFri8dEQ5LbkvMsbi536ctQmxqYnDGev1TQsmW
         XNpqMSiXAZmIKRJjgkE2jJkQJ2ic1Kz/rRVWVX///V4iGxlGC/U0be5hfltYqRrDB2kC
         TCZg==
X-Gm-Message-State: AOJu0Yxt5i5fqMe8QjjoBgImePUk6TqWelUuq4tlwWX4ksAQjYummm0w
	uv+3KSrmyEx3Qh9nXJhOAOmN2iIfBrN2c6eTF0MeEyJG/ToTWjMIuILW4ioWzOu20pRutETioqY
	hPd8DEuY2XIi9SH+6bc9Ew4UkgZTOaQ8=
X-Gm-Gg: Acq92OFPHI8iiWQq/xyCL6VlKW9M4i+C115VZVvTBedFpt9Bj3BLhcnHl+IsUGeNNyN
	0RSV+PyDSlLbqCGp20xgRoZGMBDv34vF1dSdnQTaB/u77h4UnE2PbFsEyduRbo8xRbXcqTb9bHt
	dS+7UGe6fZhyhRcineW1U9T2neGLlv92JxbcmWj+hqoO7T4iaNvvqCOmyYxyfK0QcZ1baogq0qq
	XKnU6iXErwFLPSf3bbpbZCbehrbE5rC4QkL9TvJKyxAaZoRGKrRdbq+m/F+bsKTx2Ge6K62CbGO
	tw2m/VbCOgNkqEWZILsSVZe3Q9mAv/3oCwnlM5BZpAGRhMChn8NdDjMbt3g1oLYCQ94+
X-Received: by 2002:a05:7022:f9a:b0:132:5d31:dcb4 with SMTP id
 a92af1059eb24-1350483cd3bmr8216572c88.23.1779204315830; Tue, 19 May 2026
 08:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com> <20260427124108.3524129-7-christian.couder@gmail.com>
 <87qzninlb4.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
In-Reply-To: <87qzninlb4.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 19 May 2026 17:25:03 +0200
X-Gm-Features: AVHnY4L2AIIACuDLzRB2Rcaa-XdnF6rf-y4BoDo5mkdGm_gszRDVrmJm0RkoJi0
Message-ID: <CAP8UFD1VxxRzTG9ea8H7U032Ef76RFg_KgvO-w8zw5mUEdZSaA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] promisor-remote: trust known remotes matching acceptFromServerUrl
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 3:11=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +static bool match_one_url(const struct url_info *pi, const struct url_=
info *ui)
> > +{
> > +     const char *pat =3D pi->url;
> > +     const char *url =3D ui->url;
> > +     char *p_str, *u_str;
> > +     bool res;
> > +
> > +     /*
> > +      * Schemes must match exactly. They are case-folded by
> > +      * url_normalize(), so strncmp() suffices.
> > +      */
> > +     if (pi->scheme_len !=3D ui->scheme_len || strncmp(pat, url, pi->s=
cheme_len))
> > +             return false;
> > +
> > +     /*
> > +      * Ports must match exactly. url_normalize() strips default
> > +      * ports (like 443 for https), so length and content
> > +      * comparisons are sufficient.
> > +      */
> > +     if (pi->port_len !=3D ui->port_len ||
> > +         strncmp(pat + pi->port_off, url + ui->port_off, pi->port_len)=
)
> > +             return false;
> > +
> > +     /*
> > +      * Match host and path separately to prevent a '*' in the host
> > +      * portion of the pattern from matching across the '/'
> > +      * boundary into the path. Use WM_PATHNAME for the host so '*'
> > +      * cannot cross '/' there, and 0 for the path so '*' can still
> > +      * match multi-level paths.
> > +      */
> > +
> > +     p_str =3D xstrndup(pat + pi->host_off, pi->host_len);
> > +     u_str =3D xstrndup(url + ui->host_off, ui->host_len);
> > +     res =3D !wildmatch(p_str, u_str, WM_PATHNAME);
> > +     free(p_str);
> > +     free(u_str);
> > +
> > +     if (!res)
>
> I feel it's a bit confusing your negating the result from wildmatch()
> to negate it here again? Maybe keep using the int return value, or
> rename the variable to 'matches' ?

I have simplified this in the v3.

Thanks.
