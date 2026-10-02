Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CD471415
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932740; cv=pass; b=r1iNhWJDc5mCjSaYANFGvJ9ofx9Qlrd4+eHYeQe9Mv172JMiBIBVH/MvRIvPyCJbUIq5UIsGVevgRFeN36iyo9Jwl2XFaaXt1xNC38jw3KgXEjT+CGNn4M066TVSYYJ8RELrLL8DEHDlbPNvp7bfQiYCxXss1eycXIc4plBQZh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932740; c=relaxed/simple;
	bh=Z8H8TeeflBYsnWOWE1mXO0WdPTQIM0yc2CvSbXJgKPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tmq/SsFPjDbdqECUtw0eDy2aAKYPdrRhochmACvINGvuknfUOuOT9DcO5Ba+52apRsRvsyVO211thI1bt8tUQutfg85t/ai4k1mLB1YAB2yLsAh8WetDT8ewX7keVcr637liATr+pfI4rPCvvHoV2ZJk4I7cbXhoVPazWmfbp00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSZsvMgC; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSZsvMgC"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so7066767c88.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 02:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790932738; cv=none;
        d=google.com; s=arc-20260327;
        b=Df/M0hX9tad0qADa69rnDP+tA7YEnLSfeAYQpkl5KtwsfubUwROEAtH8UUBwI4w9o1
         K7u9p7OANp4q0VhAbWVbpDIczGDfPvWaeTHN8GR4WIuqerlBjY18wOoxQEnvfC7k91wQ
         QBY+7At/pV1HIUhVz3xVQH8fqdFJlNnImpJbvltWxQTmuDnMaJA4COObZbww/IDG+XhO
         ovLBzLBLyf4AspXCO+Su3lJJIC+B+2JO6T5Hf6s0XNxzNQGx7fz9paNiVuvRxJFRdr6t
         J2mUS6QMog/OS7swbztKXhE3+hqXloIVW6APQh3vSKczKUKDP8oLEb+IoeiyEBLGrmqh
         x21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ve8scoE/H9l0rEsJBfoVnS6Q7fB7F+8GJKxqjX2slM=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=IcAx+1kbQSO4ajTW5M/zgZFaLWUDCHL0NTTSAY9AwIwnyz8dVBHoRmws2xoL5CdjXt
         5qygbUvCO1DyK1TdvjatKRKgyPgrYHu3GLwpxRd+G+GsyC6QB4yIntpHwxlms/xVtIbx
         AfgfRTgdn6e0RCFdD14TdxBjYRHcQZlJDTe9wFvPzceaI2zWvf4uRHBh1yM9xgid37w5
         IRFkYpxAxqptK149GXMH1i4ljidBP82S3URJxmZRsSoVNsvhlOqCiG3u/fpOmMPQid7i
         YY4qeqI/0PUmiM5Y/jTatBaXXT5cH4NOsufdqr3erroGiPvgpZg6Xl6dg7Eulh6lp8wD
         ktWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932738; x=1791537538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ve8scoE/H9l0rEsJBfoVnS6Q7fB7F+8GJKxqjX2slM=;
        b=FSZsvMgCQZS3smlf/dsLR1hTRMjUHQNYaXtvJYqOxHVQD6mKx+Db9J2WV1jecUkQBj
         JStrQteQX66MTgAeHLZC3ncESM4XzUcIkBjKlBc7OXeStqz6bTXGgEghIY+UKWyDIcPh
         pmFizNPNaf6QiBx6qlFCtGjMHzfNzjsGgHgn3F4AA3qCNQasFnFP503HuOf9h3BuU4Ot
         s4z0t4D+xjEzTk8ji4hAM52a1eScruESn4lOpI7+YBFwOQLgjEsZxSTqbwZSa5hdCNke
         AYwRcigBvF2g5B3rAd5YQwQ+JyNgZCsInj0KsTs7ABpoV9INia0HXEunhnl4WTcg07Kd
         5V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932738; x=1791537538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ve8scoE/H9l0rEsJBfoVnS6Q7fB7F+8GJKxqjX2slM=;
        b=kVfQTsjvvfuL/AKCN+pYscmDyhriOOWuC6sbbmXOn8htC41sVFUztWufDNstKvNc3Q
         qG32OFYCaB/6v8idIq65T6DL556dGTMk0VnbwfhsT354n3cHYemGxbcvxqO2hIC5ihZx
         yx5Bg1Xdg7gA1lbA5R/LCESBww/r79IM55u6mgpYNiy6jSeB5nQQpySWcJin513sYZvL
         suEzUq4E8u+buLlyDUqL+YyoixP5PjVR3+du4+wf92XMbzmL37nm29KI9ERNoBQxN+SD
         zjUoNDEb67svYtuxURLkzIiRzFN4Ym5g5C9ajjgA8MSAZnvvQdwEsl2WxXNDkPbWLE7Y
         F2Tw==
X-Gm-Message-State: AFuF++mPoirh5cI9OVDXFIlut2OUVou6aDsC4NYtzfe7tbZobC0rtZno
	ZjAPFnzOp9LROeOgNQQvc1kXYCi8y4mKgVDEBZWTYF9sr0lE1jzy+/FpFAiM6zfULO0W0LzVNT4
	lk6nNQLj9DieVj8+dNa+CiFBuMp4zFT4=
X-Gm-Gg: AYBFou2/c8/dGM9iuGsWKFSOmpte3xjDRdtzInaNvGKhO7eGrclYeY8PnkDk8cgLwr3
	56RgKvVvnQHjmx2M5F99IhGSuS8Wx1jmMxURugVIwMEyPLZitwOjiRISpQnZL9haOfI4hRs9DQV
	dq2leFUVTkPaROZd/hWdIbOo9FdGe+CoEGO/HntYQi82r6wl3F+RikswaGpQxwr3kCZX6PBYpv/
	C7ma+dyk7wlyeBUHEG5PtYUsvKilWmrU5x5/IEfrZkik7WHMoQ9XJvM2kV9SedYXUKbFBHrc9AU
	CQM6wTdlvtVRwav4getfwi+b7FQ/l5g7dfipOs667a34v2LEifc+fO0/zM1qja6guIihJFR8S9v
	Tu8St02XzgbNfAhGccIsVyBIf3S54Fjf7a592KQDTpGmbsDvHVb+yNNdyE4mh51lJJB0+foEv7j
	BuEHpfjuZ0mGqlnvy3/PpSWe+B6lBKjkM5QMuXxTg=
X-Received: by 2002:a05:7022:f90b:b0:149:c766:3629 with SMTP id
 a92af1059eb24-14f5c5e9661mr2617761c88.23.1790932737647; Fri, 02 Oct 2026
 02:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com> <20260928133846.2094261-6-christian.couder@gmail.com>
 <xmqqse2sgda6.fsf@gitster.g> <CAP8UFD2Ks9mJ+Gdw02VXjpKv16HTxXTtQ3_5_heP_1TOfsHb-A@mail.gmail.com>
In-Reply-To: <CAP8UFD2Ks9mJ+Gdw02VXjpKv16HTxXTtQ3_5_heP_1TOfsHb-A@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 Oct 2026 11:18:45 +0200
X-Gm-Features: AclHuK9QIG-X-Pwk2VrFxTTrn42-HU1fXAeEnQkRcLl73gg4QdvP1ggumBt1IBA
Message-ID: <CAP8UFD00nFxs_wXwdJQL2NxojUcnYozjf2pHm0=MZRAEm-nsrA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] builtin/upload-pack: don't disable lazy fetching
 on trusted repo
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 10:57=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Sep 29, 2026 at 7:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Christian Couder <christian.couder@gmail.com> writes:
>
> > > +uploadpack.lazyFetchTrusted::
> > > +     A multi-valued configuration variable, each of which contains t=
he
> > > +     absolute local path of a repository that `upload-pack` is allow=
ed to
> > > +     lazily fetch missing objects for.
> >
> > "each of which" lacks a plural noun to modify.  Perhaps
> >
> >         each value of which specifies the absolute local path of a
>
> Yeah, "each value of which specifies" is used in the v5 I just sent.
>
> >         repository from which upload-pack is allowed to lazily fetch
>
> "from which" would not be quite right, because the client would lazily
> fetch from the promisor remotes of this server repo (using the
> "promisor-remote" capability), not directly from this repo. So the
> rest of the sentence hasn't changed in v5.

Actually "from which" would not be quite right, but not for the reason
I just gave. Sorry. It is not about the client, nor about the
"promisor-remote" capability.

"uploadpack.lazyFetchTrusted" controls server-side lazy fetching. So
when a repo is listed in that config option, the server's
`upload-pack` (via `pack-objects`), while serving that repo, lazily
fetches missing objects _for_ that repo (not from it).

> >         missing objects.
