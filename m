Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D802D2385
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066900; cv=none; b=PxNVDa6Ppe+Rz2/nFfBgfCa+syFKB5rHvqidaECpXO7zmGK4S/D3NwK8f++7Vs/Hpbb3NlJz3F6HEPJKu7YBHgVz7tPHSaHv/lGvtijukwhoDRMx+oY2/l8A5jmodZyfSeNbKvCxYDKNpNfxxjnIyM9hO/XYUn5oTbgCMovFhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066900; c=relaxed/simple;
	bh=sPjkE715ld6BL7GhJdhxWQxqa32TFbMLWt1FrqKTaTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxgC1y3JXO3FdAfHembGxSjTLJxgEjZnUTGxZmNV9Nb1oz+TTTNcxNTmtCqh4Ve6iL8O57szRmLrqCGoVkccVeS2cLSQa/XOW5azMyZ8E1o8+BwI2vNHR2QN9MFxIxxMoDLHeBhMApKTGRqWBRGRJf1tcM6yxdOn/5xzhxvPWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7074a9e498bso2081676d6.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 23:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066897; x=1755671697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE+Zcz27Q07jUQPc90zYn8rVQThMX03FCs+F1bfSLwA=;
        b=RrhXZlSI/Jf3RsHxCKJDuAMHajO6yZ4Rm6LHK5wMyklge9h8vaVpX9ifkKw3QfuK7d
         7bS9OiaNF4PrwW7CuNRd2yaH6RdQ5uwY/Jr7Ua5R2eBnXTDs8piez4iJTP0JRNAXs9dG
         s2xuacp2f/mNZCKSTslZHLPdirBP7sRuyuSShzv1Qt77zvYkotP6dkKQm1zrv7RLCm2k
         1I3ZSNLM1vCzjtK2Zk1NMPwef0Zw+F7hEu2Zr4y70OS7urqDH1GBCTBbusPurpKvD8DH
         U3V1R2KQgYhhptGbP0IymV0DRBXnJ51EUtI00qsYOoKlJV2G5nZdjAdydNzIAvzNIHPM
         NGPA==
X-Gm-Message-State: AOJu0Yw3o7mdUUyevfCdhqrvqLGaMvy9ec97HkM3BEgU7ZNqzDEM4jz9
	suaw2QIvv2GYKzLKG1nOKtnjuOf/gT5k+HhY0G4rojQ85Jtg0xhkizvCfoYhk1HuQv7TaBYl8p6
	kSKPK9xeNO1cOovPeSqY+9cpochDmKN8=
X-Gm-Gg: ASbGncvGE2+hyjIclGIz7Wqa96bgEHu1tz9lJ9T5OekCLebV9lqd9nIGrJ9NQRVXbxY
	iR0xeJUoGoxOiFJY8tBx/yXHNMZIdf1hVQ1ozg1yBRTPMP4iqePWB3wUCoz/dOemHBYEHl/Yvb8
	d4SZj9hsxNFvIVxf1RSm/Q9wFAeEEy2VjpgQb9UTlBQBVEpTlrpuvwL+Xb56iqKYHjTKWpd37QJ
	EAsAK4JN6mzt8IaP/P/QM1SHZ/fqlkx1I0KvEfdJb98ZfNGfAM=
X-Google-Smtp-Source: AGHT+IE4x/vWpPSO1Mzj3tRuc7d5LYHHKlnLqreDQB6jC1+5Zgzjow6rzLXKHTYHWFpEx8FQsXqXERIUwac+mi7TjtY=
X-Received: by 2002:ad4:5d41:0:b0:707:4d59:cc85 with SMTP id
 6a1803df08f44-709e8992b45mr9638646d6.3.1755066897246; Tue, 12 Aug 2025
 23:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOZdJXWaC2U_YrwuDcA0x3iUeF_uJ658a93cTfdLftEXYRB52Q@mail.gmail.com>
In-Reply-To: <CAOZdJXWaC2U_YrwuDcA0x3iUeF_uJ658a93cTfdLftEXYRB52Q@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 13 Aug 2025 02:34:45 -0400
X-Gm-Features: Ac12FXwVqq4xafh3sESm-60auXKFbKzbJIDmYdMnOLZIVRWqRoUved30bTjdJgo
Message-ID: <CAPig+cTvCLU3u5y23HSrbxovs8cjcJdOUj0e1G9Rg4F1AP0jAg@mail.gmail.com>
Subject: Re: [BUG] suppress-cc does not support multiple keywords
To: Timur Tabi <timur@kernel.org>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:06=E2=80=AFPM Timur Tabi <timur@kernel.org> wrote=
:
> I hope this isn't just some user error on my part, but whenever I use
> the --suppress-cc option, and I specify more than one keyword (e.g.
> --suppress-cc=3Dauthor,self ), git complains that it doesn't recognize
> the keyword.  It seems that it treats all of the comma-separated
> keywords as one big keyword with commas in it.

It's probably a case of user error. As far as I can see, the
documentation[*] does not in any way suggest that --suppress-cc
accepts a comma-separated list of categories to suppress.

> I was able to work around the problem by specifying --suppress-cc
> multiple times, once for each keyword.

Indeed, consulting the source code, this behavior appears to be
intentional. If there is any "bug", it's that the documentation does
state that you can specify --suppress-cc multiple times (even though
you obviously can).

[*]: https://git-scm.com/docs/git-send-email#Documentation/git-send-email.t=
xt---suppress-cccategory
