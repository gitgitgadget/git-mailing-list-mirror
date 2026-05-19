Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F53E0C6F
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179005; cv=pass; b=QaENvNUEHBHxHCcqdmh3DSjbawKnZxjqgn8dbJxOGI6CJGDBWKoeC0KAbHzty7Kbblm7dzi2sw9d4d9jiuhx9JiZWRrTfWoQl1j48HCiEIyHchxABNuKT1hIqEoWOD5Ed1jwEFjeR3qHbb8aTfXYYvM6IQHAKXgDT3dlNa8iqXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179005; c=relaxed/simple;
	bh=tv8rid10cZBfbHoCmqZCdRtwYs4SsWcAfoHlR9BxWhU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzqD1WKyb4jZ70IWx3W3O7BebQ1//nzS0JkrCjHjvdpR781cjRtsE1eu9MDVQ5EYUyUcxz9lEw0uk5wGL+ed4TRFK20Ie5vjNBfzsX6P+cc/WDoxZlsV/3jnn3k6bO47g9ZA+cpd9R3johVTNzvqA7C6u0BhoFF37sksAc33mP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hohd3SpD; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hohd3SpD"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95fb6411e01so1347975241.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 01:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179002; cv=none;
        d=google.com; s=arc-20240605;
        b=MM36QurBrin9KxiAB6BcIwJCLHrD1mSDH6/SqaeBNJ6eOX3V8X9FJKE7YqT8Fst1Dg
         +1eKInDYMj31yJB3+J14ykzfNSjH37CEm0COvXxfjOKjyIyqF6Jj8W1O+lSzyJ1Ncycu
         n99f87wK/+OxoZi82cDY8voBS4FQBuz6WzIollGgqFbbZ5+TKN8zSUQ/JIAFtj8XlAVS
         G4gloOfwF2bg8xKHiFvFrtGb5zOMSumP0PzuuwCP9sRWpUKf+z1jsrkg64mDcB9lqt7P
         rV/envY5FJw/bppqNxkX9WW1l0ilp7WCEMkr8rWy9XWdQw6Vw6eR8Hbfsmg3CErXY/ln
         RpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NmOq39Jn3JBF3XBkDhRnQgnWT8Jjsg+lFj77fZ3KVaU=;
        fh=XY/ivCsiG7fYtj5c5g9mOwB68YAcStHw5+asc/gDKPA=;
        b=f0h4oE//67Nt+uFz6c/pVnC7Q8+96MgbRztHkazSTj3iyVxTrHUXCrTJzrlyQ+AfOw
         fekI0sxGBrvSGnMMIwD/trJxL+zng3iCXop9CpSV8RYeUM6GEh6RQD5LVp2hUHxuSS01
         Uncds9O+2aHkK458KC05lACxzdYzpMTMt0E/PWriOOqacIp19lr5nhV6SbxHBSXXGwyA
         jvmebFi8BjPhKCc0kvdRyyCKA+SW7//lmSfgU4Evgf9xvry+yyY377WpXkoeELE73o9U
         z43w28pe+RNCEOjZdI6EzQ0BbOG1ZFxRZD49KlFod+ALvfTRyvYyyQx67mlMPqb1TLpC
         wbBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779179002; x=1779783802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmOq39Jn3JBF3XBkDhRnQgnWT8Jjsg+lFj77fZ3KVaU=;
        b=Hohd3SpDG6s5ZpygZcsxA52ttk2NIlgBU81TOVNHGRxO3HC7he2iCKBjPVFoZQym8U
         6LFZWyxpKcEyEy4yIHNTmdBDj8ypPdwF+t38CMXnxNqUgNEBamMZ6s6bu8elUcC8aqBF
         fqBinT+Qz+B7eIA973SGO8wBxetCEAqtgwOWQIWExV01UC25irsfETd1QEWh3Ff6DHJx
         3JOnl4g1UrjEYABn4Pj0gqF81zmDnAudBLZp9gRNA/5NnGs4yeC1aMZfFPv9BtPlMUkr
         9RFOW7dVCENW0hfX5Vb1rmvPCNsoa0ReAOcldMu0IxhHxoQN9rDstVET92acUxrP5Ozk
         Dn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179002; x=1779783802;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmOq39Jn3JBF3XBkDhRnQgnWT8Jjsg+lFj77fZ3KVaU=;
        b=jYnUs9f2yc/TkkWK13XJqYLi9WgU/d1jaIxI1PuuuzYPiGTC6LfxzA9Xyu0AG2921K
         ktHBgshPdtQzt2GBeKODj15x+2VNnLdBOPbZr2WjO7FJOA8xRdsStzhsFzWAadVd/3o+
         pl7+KdfC5HCjhxf8TWEA9Esv0U3f555Ht/hc/zPZZRsnwSj3bzD5A/njNGdFbK3Vs5NC
         8vM9FsMkmt2Iun/uV+YLR1Dt+5uIe46w0iIyFmM19Wn5avnXWJkIVUX4u5r3mBDZ0k8o
         B1/fN7OtWGVVBzhfwL78U5oioLYs33BHjGt6NRTt2wvMHwTEVaTXHfGeg6jUrUieXO8B
         H22w==
X-Forwarded-Encrypted: i=1; AFNElJ9LYs+rugUyWl4aPnJ3CRlaXoNfiYOBxMXt9bekhgtMTGkQbojkbjgk2hhzmKfX9sTLGKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRHzZiuOrpdIQrfHv+k4jftClbckJAyCWw2r1ARXOYmjnVweY
	TBTa6Bvphpia6XsC4U3E9HxltrO4LtaFttetq/Ak0EehqlRuUwZ4Na4qDUuo1PYQj/MC34/2cgz
	tlTYCf66QteqWMP2uXrjkN3qObS4ED1APlA==
X-Gm-Gg: Acq92OFZ1qyxiiUd5KBSN5uD81gscXV6nAzbls5OJjrKZOQUMrHSjItIX7UrPmi5/Px
	zjRE3m1go3q5a8A0iB107seQSbP2xsC6l+LUq+6jyjm9rppMMKwSP85MkO0xJJJpTuDAXflVNLb
	/wX3NuYXK2MuLUOiVaz6FNnPPmbLuRzRQq4xBbsf42OZHTZLq9YlOj5Uv6GQr/FvA83jAmGhMPX
	0EhPDf9lHbB9RFqPKLi/g3CFkPlGHb74MYfjjMlVCZHXOZIrP/fEXtMY7YKm0S0jMQcnK5OfBt8
	QOTXqjk+2C30AenKGgGZCWT6AL+Wo0yzmmgCEUh4yQSIt3XHyhX2V/SKe85MIZHaTLEoZ/I8khL
	FDlLxwA==
X-Received: by 2002:a05:6102:946:b0:631:ab8b:c348 with SMTP id
 ada2fe7eead31-63a3cf12325mr9986171137.8.1779179002527; Tue, 19 May 2026
 01:23:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 01:23:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 01:23:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-2-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im> <20260518-pks-setup-wo-the-repository-v2-2-6933c0f1d568@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 01:23:21 -0700
X-Gm-Features: AVHnY4KJgFrdNZhTM_rQO3p2ozBuISkCal4uaXuUo-dlS81em4eZgO9J9JiiKzw
Message-ID: <CAOLa=ZT2Qo+oJ1rx2iM3QRcXMGaucFRJdxBAgxBdz3ZtgSb=Qg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] setup: stop using `the_repository` in `is_inside_worktree()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
Content-Type: multipart/mixed; boundary="00000000000070220706522764bf"

--00000000000070220706522764bf
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `is_inside_worktree()` verifies whether or not the current

Nit: Here and the subject s/is_inside_worktree/is_inside_work_tree/

Honestly, I would prefer `worktree` as that's what we've used through
out the code base, but that is probably out of scope here.

> working directory is located inside the worktree of `the_repository`.
> This is done by taking the worktree path and verifying that it's a
> prefix of the current working directory.
>
> This information is cached so that we don't have to re-do this change
> multiple times. Furthermore, we proactively set the value in multiple
> locations so that we don't even have to perform the check when we have
> discovered the repository.
>
> While we could simply move the caching variable into the repository, the
> current layout doesn't really feel sensible in the first place:
>
>   - It can easily lead to false positives or negatives if at any point
>     in time we may switch the current working directory.
>
>   - We don't call the function in a hot loop, and neither is it overly
>     expensive to compute.
>
> Drop the caching infrastructure and instead compute the property ad-hoc
> via an injected repository.

So the caching mechanism is simply a global variable pre-set to -1.
Okay, so that's a good improvement.

>
> Note that there is one small gotcha: we sometimes may end up with
> relative directory paths, and if so `is_inside_dir()` might fail. This
> wasn't an issue before because of how we proactively set the cached
> value during repository discovery. Now that we stop doing that it
> becomes a problem though, but it is worked around by resolving the
> repository directory via `realpath()`.
>

Curious if you discovered this via a test. But running the tests
without `realpath()` didn't trigger any failures. Is this something we
can add a test for?

[snip]

--00000000000070220706522764bf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7b2b4997381c613a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vTUhmY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1VmQy85WTdPRTgwdjdoaXhGcDBNaW1HUlR5aldpVgplRXgyWnkvQ1Jm
djJYZ25vcVZpcmZlNlhKVDhkdXpFdW1FQXh6ZDE2b1dldFdvM21BRXFsOE10dmZlZmgranhsCnBm
aldRa3dES1NCYm5HMm8zR25VUUpQRWx5VS9YZlZYOUtmaTVibWRuN2F6VzhlQkFRRGdvV0tJRGVi
VlMwZ0QKOUUxYUhoMmZlSXJobHUxaURlRGFMeTZxWGx5a3N4elY1Vk5rSHVPenU3UFlqYVZZdGl0
UlVJa0hXVVFBaVB0cQozZTJOaFdxOTdQSUhEZnNlSDNUUkZPRGI0dmMwL0hrdWxUOGJGS3ovaWVN
L1FVSjFCUWFFRFpKbVFNNlpjVEFyCklldEEzY0xDQ3hmNGtkQWRBNTI5M2thOS9RRTVnNnFZQkZT
djBjZ0NUU1BoTkJBTjRyNVcrODVIU3hLTXFCZnkKck1LZTRobEZNaUtkQ0trVTBxUms0YVNpVzk5
U1RiTDhxZTc5cXAyZlNEcXFtc0wzNXB1QWFtd0lZYWNjMWNVRQo2NEp4cHFLUHlaMDNvbTRwSmpR
UWx6MlhDaU9JWjYwdGYra1JGZkt4cTZCUUlFbWdER0pidlIvQVZQc3NSaCtNCmF0bHBFcWIwaGhT
UG5maVFSTEQ2WkhLVE1pbG5qK2RWc3lJelp6cz0KPXczdWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000070220706522764bf--
