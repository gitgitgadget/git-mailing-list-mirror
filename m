Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019216D4F6
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184564; cv=none; b=DfcUoUKlzGMYQ+EPqG0u528XWVpnlKN9+JS+4Z5EAcBqWJAex1Jgz+PIC0CpPYGuTfyd6lxSQxEmdtX0u8O51SQ/kkA1DqtFjCzwRH/W36XQAwFcOEVai239zyQ16SmVvPnruR1u2n3FtSY9t6pmnvhZPoWXDGoqKmeeiPw5KQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184564; c=relaxed/simple;
	bh=NwA0yCZXgLBwLAl/QTMZb2e+QtfcrjUFQlMmuXO61SI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQUfwpfcql/SjZVNRfbDRI3mZaiqye3PwqXb8dHyHU6zpbbfG5mhzDStu4g7JGNR/vN/jRGVHmxbfGVjVmtfitScGM7eQPgDSdFa5kfUKPBqKZAZIxTwqEqz0Squr4rbNoGQOp92cUEVS3pz/r102XSGoRv1p0nAqZdBvufNll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTwCajiC; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTwCajiC"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c9f91242dso917172fac.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718184562; x=1718789362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nA8cClOzFFzbePwOqYu0YYzduggOySKKQ9QHurR9SBA=;
        b=JTwCajiCoLBuBqMCVOHbmiMVANpveJdr8DOpdpAh2v9ySqlCNRkPW0l7lTwIApS+w4
         52dIlWhuZsqVgLrDFie7I8j7AhWHvBZk33kKssRztIPXoF6FW20JvbWlMlLf3XA+3Ah+
         kqRSrjYfRbZuKQmYFUYs70S5HvZzsBzXgW3bSiLIFpKODDYPjF8eXELnP9Y/lJ6D06le
         AC+urkGUNEsOwCWHxcgVFTQkJyKUMTuc66abWuBn3gbqP9I6tE/dxjxDUsFWyyBaMedb
         7wvsI7VI54IVREJdvGX1B0kMBNrxXAYYvDoV97MVf9PA/uHyCwwQqS5ocWY8ChdV8Ybd
         685w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184562; x=1718789362;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nA8cClOzFFzbePwOqYu0YYzduggOySKKQ9QHurR9SBA=;
        b=aWRjZPPnNXhfTJeeDQn+0ihJ9JCzQJOo7fGQoGtOm38X5xjZtxhsMqssDIPQBqFik8
         8Z/Vz/oF/lqaUcZj4MvBscFG1Bj+9CcWBvpBykgeb6f+5CSuEYDcXfLLQfVXk3mCQFul
         qlyvFT0tsA1NuhWoXboULd2mRI44+JhjBbadcbqiA2GZIPMZPYIK6hK7DSWn4VBGQ5lh
         5TmtK54kXMb3ynSmR7TjRQ9pKelRV5xjwqo9R+tUewq/QJ7kQ3cAJlse5ElXT7oOKYN/
         FXH2wV9fQK8RbyKd/oe3AbUSTi+XrRy3pCxKfKvBKRZEXwvzipGzNXvsaH1v8bld28B0
         KxPw==
X-Forwarded-Encrypted: i=1; AJvYcCX4JjtPqCt+jOEjDcyTgtmdukhQ21EfoX5t6KyBbPDsKNQNXWP6d6dm+QexO7/6oDM9XXgPmofNNT4l5LEmFfTYLorQ
X-Gm-Message-State: AOJu0Yzcepwh+BkgUYXARKj2iTruf/vF3CRENziI5fpi6kwueZK691By
	ilGUHP+7U0j4wAM6tfXlcylDzJg0wXe3g2+9r74R7V8V5DaTiSUPQZTnmDCQwH2amJq48JjOv8g
	tyV2AA7AEymcx7PEMwktLq3tInq4=
X-Google-Smtp-Source: AGHT+IEZYrpC9Qv1vkVbyh8VJsL2f+79iSQIi0mbFFDAg+XFMcgBgbPgT54Rw3JICSCDngezWqXAi+ffV/59MbXi6WU=
X-Received: by 2002:a05:6871:5b26:b0:24f:d873:9f32 with SMTP id
 586e51a60fabf-25514c195ccmr1430722fac.26.1718184561822; Wed, 12 Jun 2024
 02:29:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jun 2024 09:29:21 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1718178996.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
 <cover.1718178996.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Jun 2024 09:29:21 +0000
Message-ID: <CAOLa=ZQBmp3Aj135HppKzkcVhpNC40JgtX6YN6Dam34cmeSg5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] config: fix segfault when parsing "core.abbrev"
 without repo
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000077660d061aae0444"

--00000000000077660d061aae0444
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that fixes a segfault when
> parsing "core.abbrev" without a repository.
>
> Changes compared to v1:
>
>   - Stop truncating the abbreviation length to the upper boundary
>     completely. It's unnecessary, complicates the code and makes us
>     dependent on `the_repository`.
>
>   - Adapt `parse_opt_abbrev_cb()` to also stop truncating such that the
>     behaviour of "core.abbrev" and `--abbrev` is the same.
>
>   - Extend test coverage a bit.
>
> Thanks!
>
> Patrick

The changes look good, I wasn't expecting a benchmark in the last commit
for such a small change, but that was nice to see. Thanks.

[snip]

--00000000000077660d061aae0444
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8b7f92f95f38be36_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1acGFtOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUxpREFDT1VhMTNYdXFCQ0xtZEFJQ01wdnBaTDR6SApCYUJYZm9Mam5B
TXJ6QzlPUEdqclJOaFliTVFSZ2cxeEpxaTlGWGNWZUdKK0NwWCsyU2YrYU1aUXpTRzUyTlhZCmtl
aGxOVDBBalZ0YVdxemxqUC9xRUROV293enNDRlJqaVNPd0VLczlYcWdIYzBqajhuSk9tWXZadVpz
c2lXQXIKalNOQ1VCdktaV29CQWRQcU9yN21zYXYvYzVTSlVmMHZKUVJCdXZOaU11djZsYy8wUlNr
bHp3eGl2d2x4bVhteQpCdS9NNmVQcXhoQktJVjdPZHJlOFQ3UFV0alljcTVxcWQ2ZExTanFoeldQ
Ulhxc3VITDN1WUVPZVRvbjY1dURlClRtZ3hNTi96bVRWV0hFUUYxQ3VvbzJjRUZJWEhxQUFCSzNL
UXdwcnY3S3U3N0JWbEE3anRxNEc2YjZHVFNqZUsKUFFNSHlBRS9Fc2xIeDlPWFljNWVVWmNNeUtB
MFFtOGZxTmlFR0wxSlo5Zys4ZUxQeGNJZlM1RUNBdkdnZWJpSgpFMjJJU0RqUWVqaDRBajMwTXlY
L1FRMnZYbHpFcGlhSlRKd1JveFJSK28yaVM5eDRsbUd4bG9FeCtPUHNTU01VCjRZODhLeU5kcGx5
Q2NnQzBUU09zT0VaU2ZOYTJJRmg1anFHSVYvbz0KPTBQcGgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000077660d061aae0444--
