Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CC3C7DE0
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020352; cv=pass; b=OBfqOPU1nXth7LlX0WykWtI1KfoIu4or74YQe+b741USbAtgxJ082HqtEGtSjGY2EquAMKZBY44DL+H/G0VWRuOa5PRhrkQqVnFI8TZfKXJody8qkKSpmIrVfgVExaAxz+6GxZlUIbgadjDkEDVqIQbY3Zg+OQmZA2U6V3K6IZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020352; c=relaxed/simple;
	bh=aXOexAvRP7o/Ef7YYUvCN4Nn8/pdvx+8sMfo3ljckNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzTNudHXoP3ofnHAgDVn4UrJr3365XBv6gIsXOH0V6yjcP5dD/d1KINE3sq0ZAgODUFdl3GEcYwli/riaVKKLoORZV4BtJBTjScrG3RzCYgAucTvIyM7sIbiG21NCluiRUxB92Bn0ech9qfXxmfwc7VN8WCf5mL+YKpzs9IzVI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1y9fRb5; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1y9fRb5"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a5ad7cc52so23029417b3.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 08:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774020350; cv=none;
        d=google.com; s=arc-20240605;
        b=PBYwL7PFcjG8G2vUk0hiNEGq65oQyYMS01txi9m68OLFjfJs+Fvc6zYrivOD4cnhc/
         IeBb4UYsiJJ0hnie37VV+xrzeQAL6uJDwxKE/zgRIEX8w3F/BlFHY7tehnvZy+D4od+M
         SiOoBoXTNgQlBCeVfOw4h2Qowr8GHzMESdGw2dXcuMQFXr7aHufX9qof7IJqJnEYsa/c
         iFwh1qHACYKXsakYlAeRF8feuuL2hfRDL9Hm1hP/uCA51I6bMBSEQgcwlDQMV5Q8Ieit
         r5JbY5+exN56Qa0zmq9NQMGyJ3OrZaZGIphxJ17Lv6XynvBoSQHf+cgVHFyUzk6J15MF
         myzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ybh8CPh2j+rIapSD35c9/kwj0MVVQ6TSHeQn57h1L5g=;
        fh=mJbBesx+oRc26OZKm2CZILTBbLe8BCinXbh84KNv+5A=;
        b=GQo39BJyhLzIgkoo21FufUW6V4wwf/Ty1228CCa+ZOmICbLFL4yJcn9peQ3tCBxup6
         UjZcjPswE5dsvpe2oLp1etc0X3Vg2ntks26sfutHe7uBBRQVPIT71JMsxuKR23iqIyWz
         ob1QVzlArw91zU6PsSBYVHinDHW9jC/LBdqD9AfGWtwvwsyE1jgZhP3FHwH5YCK2zbnF
         FsWkIg5XObZs05uc5dvDUwHjlrb6oq4VkL/Tr0vYN/WsZ6brVj+umFTEoiuluPzqHRtx
         uvOPjYtfnF3OdDVO1NK9IHlcPNJcfe6QuT5Q5E4qD/k1hWUS6aHcOeqVoJMXNSnE4+gQ
         7Vug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774020350; x=1774625150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybh8CPh2j+rIapSD35c9/kwj0MVVQ6TSHeQn57h1L5g=;
        b=G1y9fRb58bV3bnDVXCGPkttg8AFJjvUXpzjsa0SnQdZ8tmGUwPMG98Zh33LB2X/sOc
         Ybcfjg/N+Fd2cqSuUEGlJBcU6NeHb8C7QABJBLzSlwvXVhrtr+EgPt/8VwXziBMIVE4R
         ioLjFZkS5XwITidCtFr4KzsXSfyIv832xhg0B/YUJCaUlrOr4zfs9IUz7uRgqgTT8Z5y
         b3eN42GkNSO0SqGwEswGwuE2rMpARIEPTgLH49ZXjyBVjmbpSjcDDclbJ59lM4Fc8IWy
         5hXYdbCjaaOOctdVQtsU/M7/XYkfZEktk80PvQ/+fW20n/NhIK8R8jEDroZ/4qyrKC+0
         yPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774020350; x=1774625150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ybh8CPh2j+rIapSD35c9/kwj0MVVQ6TSHeQn57h1L5g=;
        b=Jv1jUwxLpJsZnTSN0yb6IfYTgRxalE1DIUIPo/U/UF5gXeXaGEb1ZjxzuLRv4cD/0g
         rMD+amVcq6q4VR+87c+EmC+/ooSPMDcsfqRK8mLA5VGk14lTy/5yLMA3F9WTz4nb9yVn
         qYZcFXe+TyINfMtskt7xeEHc11GoAL/P5bu+Dx4cuOMBYXnbVcN/prirnhJV+pq+aaNa
         ddMxHVxoD3hlyw4XJdh0L2NVJentFpKC9gcneFohPSCQrSzfcAakr2+zVCw0mEcMzpXN
         dOb6lNBWuYRhPNd7kghgQEDvG/0k1gr7OnHtAo/8dLS0OJCQV4tbqItUWPPOm21MxTWk
         4Nng==
X-Gm-Message-State: AOJu0Yw2qlk6br1RZRpjz4QPE12IJX8QTPguyXo3icshxtMsSwUO7J5h
	Gp7s2MUPXIFl6MscFu3oni1f+wDO8sz2FJzWST1XY5qrXhihjID3/vJZJ12vOnEyHJrRUc3ZWPC
	r+oF24ZzhTE/0kQ2ebqjUkzN6oRfrNiNawAuH
X-Gm-Gg: ATEYQzxtoBAyUmiYtupLZxYhuLmptcPdG+pNdZRfGRFaX0zc1oej/7lRl7YXlQXcAsv
	zOYcqKSqpTXglD+2Rz+2JFyJ1C4/nFcbtokgw9d/Sq9fdCfbGv1wFTPzvDmVUBD8I6uVfEzt4el
	yDrxphWeBhTxufIIljsWUv1GLwFNoPtKP52kr391zgX5/8Fzx1gvJ79Gc1vVDtExWWykVI+X47M
	huUo3xjoV8iGaogU+pyFpg0jOVRnDQAIn9x4+SEyLVkPrPkEGQ4kgpmIQVGDY3fpeKqd9K4n006
	fcEZmraEoE+AULUNmBSYNHmg0eO/3ZCGmdUCN7g1FuJ9MVNQ0Q3l/TWdUKRzC8bX2MnDSGqJ9Lu
	/PkXI3wsbI2t8nIGzWPM1i+URZvE=
X-Received: by 2002:a05:690c:1b:b0:798:715a:c9c1 with SMTP id
 00721157ae682-79a90ac2270mr35776157b3.10.1774020349979; Fri, 20 Mar 2026
 08:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_name-rev_--format.4ad@msgid.xyz> <V2_CV_name-rev_--format.51b@msgid.xyz>
 <V2_name-rev_--format.51d@msgid.xyz>
In-Reply-To: <V2_name-rev_--format.51d@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 20 Mar 2026 11:25:37 -0400
X-Gm-Features: AaiRm52hDc-NR7luoUtI0Sgw06YipR_D4q0wq1llGFV4Vg_NxtJub9X3y5oUoCc
Message-ID: <CALnO6CB5WOTp_e7Kv3CrEbQ+3XE-gDxNVHf7qATBEbyKWfxpLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] name-rev: learn --format=<pretty>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 9:13=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Teach git-name-rev(1) to format the given revisions instead of creating
> symbolic names.
[snip]
> ---
>
> Notes (series):
>     v2:
>     =E2=80=A2 Propely implement =E2=80=9C--format implies --name-only=E2=
=80=9D
>     =E2=80=A2 Don=E2=80=99t use a needless intermediary struct
>     =E2=80=A2 Add a new member to `name_rev_usage[]`
>     =E2=80=A2 FREE_AND_NULL notes string. There is no use-after-free but =
we have no
>       reason to leave a freed pointer just laying there
>     =E2=80=A2 Implement `--notes` for `%N` atom use (not just restrict to=
 the default
>       notes ref)
[snip]
> diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev=
.adoc
> index d4f1c4d5945..65348690c8c 100644
> --- a/Documentation/git-name-rev.adoc
> +++ b/Documentation/git-name-rev.adoc
> @@ -9,7 +9,7 @@ git-name-rev - Find symbolic names for given revs
>  SYNOPSIS
>  --------
>  [verse]
> -'git name-rev' [--tags] [--refs=3D<pattern>]
> +'git name-rev' [--tags] [--refs=3D<pattern>] [--format=3D<pretty>]
>                ( --all | --annotate-stdin | <commit-ish>... )
>
>  DESCRIPTION
> @@ -21,6 +21,14 @@ format parsable by 'git rev-parse'.
>  OPTIONS
>  -------
>
> +--format=3D<pretty>::
> +--no-format::
> +       Format revisions instead of outputting symbolic names. The
> +       default is `--no-format`.
> ++
> +Implies `--name-only`. The negation `--no-format` implies
> +`--no-name-only` (the default for the command).
> +
>  --tags::
>         Do not use branch names, but only tags to name the commits

IIUC that this patch also adds --notes, should it be documented here?
