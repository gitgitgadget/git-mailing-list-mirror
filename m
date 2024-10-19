Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2D18872A
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729314573; cv=none; b=VuNIa8YXPsOSFRjADH13WVLKW/iYJ8HaxNQjGz8Ve1+j+ORRxZLDCKF/uwKEJLNyYWTE1C0E8ZtLVMXTVCe9vn9qOXpqcz9Bc+AP6lfRaOt+j00Vx+PCjOo+xzlvxbymYZtyvYCBKkqodQeCt1GUIrQ7F2iUm6YMxppI+EJX6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729314573; c=relaxed/simple;
	bh=2pzvSvX15GWW3Say1fi/jhKP+XGUztrEXy+BiO82oss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiYAaoL8zyFzBCUBdVbrYDdsKWiczuRzZ8mNrMXsKVMhTFDEfBommMy8+yzcjfRPUJzb/jKua2a0jgTtwOWgnmvY3RvqZWiB7dumiQJzuSqBHwcd6XibC9eonjlPd40jwtIXrEHacJf98hEJws8E4rH0qTfB9bn9zBcPnkwVEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbc46f8b3bso2717316d6.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 22:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729314570; x=1729919370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pzvSvX15GWW3Say1fi/jhKP+XGUztrEXy+BiO82oss=;
        b=ktAbYQpjUSEgGy/v1SJ2/89XPM1j1rh/zN5hk3yRe+IEhH+Hkr4aSm8oSuQIfGye+9
         AHsLfwwyihdy+4imYK590RE+tsp3+DaER6iVKyrS2K2JYkU11n+dTgu8yHnHk5cWuojF
         e96BbIRlML/wWHBd5Ukot5xXX1sbOlSYo3oMqjUUPIQxisj0B8dCwUYBbo3f1xHKqFTH
         d9PAjT/Z/qO4FKSXkPgm6xJR14kPWZt8Ng3pBDAiYFs02K85A8hegrGtd0oKqZQqLjqH
         z9CzT7AcRkMriLHn9x6e94Dx9D+vB2ozikHkS2TbYM5djn1xaIYjvxbJMyQED17Wk9ID
         bJ2w==
X-Gm-Message-State: AOJu0YyIJX7nGaQdPt3QxHAPyk3MHNKc9ZQgh5cx2l809dtXcIqaCqak
	757s9Jg3qZWQcxsdvuB8SSUsT5iO1e22NyETfirdGgMeI1Cv45ARA+rdX38dbVd2j3EZkVnrsbY
	IGoeKYbefnNWilAy88swNFmdGRBE=
X-Google-Smtp-Source: AGHT+IF61xxmdQjZaSP0nXvCUCRrAJLcxRBxbP4bMW+/VsTh0bjOEJZVn6aKMN2JssQ8F3LffxIUh3O5vyH10350A7k=
X-Received: by 2002:a05:6214:5293:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6cde14fa0femr29286676d6.1.1729314570466; Fri, 18 Oct 2024
 22:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im> <1c37d6d1f19322b22bb62216ff17a0c6b431678a.1729254070.git.ps@pks.im>
In-Reply-To: <1c37d6d1f19322b22bb62216ff17a0c6b431678a.1729254070.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 19 Oct 2024 01:09:19 -0400
Message-ID: <CAPig+cS+2U+zDcs6yWm08wQ+d1SanaRzwfj-JHap4zcEaJTaYw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/15] Makefile: simplify building of templates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 8:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> When we install Git we also install a set of default templates that both
> git-init(1) and git-clone(1) populate into our build directories. The
> way the pristine templates are layed out in our source directory is
> somewhat weird though: instead of reconstructing the actual directory
> hierarchy in "templates/", we represent directory separators with "--".

s/layed/laid/
