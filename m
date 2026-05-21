Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE76379C4E
	for <git@vger.kernel.org>; Thu, 21 May 2026 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381465; cv=none; b=ng5HH2lTRfcl+dIUZUKzGz7cg61HZ08ikzwkUHgZJi9OKUc65GENYC9V1VK0EB0IC7upUm+Qk8UfEyKDjT5c5nP8D5nDdaMovIEnyJ4sagOn1HygvoxHdaDA+eLB6yRjYOlloKcy5qq217QLBzsrRAsUMdtSrl7APUQ7VVnH94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381465; c=relaxed/simple;
	bh=inKHx/J1+/S3Hh9kmCzeLj6ppIiXj+gcaSXk/XZBXpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iitH4yeAAVGL7awfWBmwtW4iZ8DrVZrcmpYPZwmJvYwHQoV8FKVizzp0zbG8oqmtgG0scFABOLhsec/cqCoC2ekatBEC+pkUCoyekKxvTLJkCo5dkA3FQQe4XTaFzuUPFo2u0ml0ZYmoYpzydRTdvjwyxwgLmpjeShwGtCaLhVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ZG4aG1iv; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hSwooukM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ZG4aG1iv";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hSwooukM"
DKIM-Signature: a=rsa-sha256; b=ZG4aG1ivnEG7RnIcARS6miyn/gXZ/d0mHOleA3ZPPlBZsJcHn3PpcxLxTe31SzTDVfmmzA8t+Su1HqVDuol5NGAkM+heUbOphzMpOP0REN2kuvn2RLucAFE7l72iEW3qLs4NEbfQy6N6XfLCHiKXqpVn7IH6+OlgSUQdshZ19swaQj4oTYandm4p3DIWbCIQw6EKOWQ3Czh+757DtRBKezIVORA9lFJfmvdpWJITyZxnjQQS364yM+pvMz6mVTHQaaMUsx29WJDZ1N1NrT9HT80HJBqqIQ/muZXYoksi4i6zORzuRkJpEJkOtbYuamQfcGY1Bfh1R6NvOkNt/+VKZQ==; s=purelymail3; d=malon.dev; v=1; bh=inKHx/J1+/S3Hh9kmCzeLj6ppIiXj+gcaSXk/XZBXpk=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=hSwooukMToqjgXFD0ff+ht13rfW2HPu77fD1xkipWkFOcJJSpkvqzwX+uhH6YC/yG5hIyabpXz/E3cfvsyoH5/vSe8TVrMUHUHtZTGSga3V7+d92XwLawzWIdEJVqM2+Dga+AG1gRAmahkthPiuLUaPK+TPoPhhnB/DwA3w9oQmVLuJ0XwGdOxboui7j6n0yJZwUD/JOJU29odLK8qImNLPGjr/Vw77FwoWiItBq37eFda4p7FvuS7nN93kXIOx7r0OGVd5WlI0AxqmyvWM2gHRsnDCjbRw7AwFEy2YyejW4k5iYFPq7xgT4tKii9gxKz0VlUeFdTRUX7PC7AiM5Bw==; s=purelymail3; d=purelymail.com; v=1; bh=inKHx/J1+/S3Hh9kmCzeLj6ppIiXj+gcaSXk/XZBXpk=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1535445548;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 21 May 2026 16:37:34 +0000 (UTC)
Message-ID: <08efcc49-0db8-49f6-8971-633aa55eb66c@malon.dev>
Date: Fri, 22 May 2026 00:37:29 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] environment: move "trust_ctime" into `struct
 repo_config_values`
Content-Language: en-US
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423165432.143598-1-belkid98@gmail.com>
 <20260423165432.143598-2-belkid98@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260423165432.143598-2-belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Bello!

On 4/24/26 00:54, Olamide Caleb Bello wrote:

The code itself looks great to me, but I have some reservations about=20
the description here (in terms of why trust_ctime is eagerly parsed):

 > `core.trustctime` is parsed eagerly
 > because it is used in low=E2=80=91level stat=E2=80=91matching functions
 > (`match_stat_data()`), where a lazy parse could cause unexpected
 > fatal errors and complicate libification efforts.

It's true that if we use repo_config_get_bool() to parse trust_ctime,=20
following the call stack downwards, there is a die() call. The terminate=20
condition is that the configuration does not exist or contains invalid=20
characters.

But I think there is another factor: match_stat_data() is called on a=20
hot path. The following code is implemented in read-cache.c,=20
refresh_index() function:

=09for (i =3D 0; i < istate->cache_nr; i++) {
=09=09...
=09=09new_entry =3D refresh_cache_ent(istate, ce, options,
=09=09=09=09=09      &cache_errno, &changed,
=09=09=09=09=09      &t2_did_lstat, &t2_did_scan);
=09=09t2_sum_lstat +=3D t2_did_lstat;
=09=09t2_sum_scan +=3D t2_did_scan;
=09=09if (new_entry =3D=3D ce)
=09=09...

The call chain: refresh_index() -> refresh_cache_ent() ->=20
ie_match_stat() -> ce_match_stat_basic() -> *match_stat_data()*

Therefore, if the variable is lazily parsed, this means there will be a=20
performance regression whenever the index status needs to be checked,=20
e.g. 'git status'.

So, I guess it would be better to extend a bit:

'...where a lazy parse could cause unexpected fatal, and result in a=20
performance regression...'

Thanks, yuchen
