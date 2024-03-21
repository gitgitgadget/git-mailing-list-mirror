Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3C6FBF
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996648; cv=none; b=H5R11mCMgCAQ3320K4vlpYyabtk3FkPJr5g2dnFpYpcTyPzd80dco5XJ9aM0MOL4MOVGeqOjazkDLwakP3BBG1y3FFB4FuIGizHmKLPfK6uZ/v2xSrvsAteJCOhgiW9BXn/oUUi38vf4X4wglxUIH5erFJQcX/cVP8xoW0H/KPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996648; c=relaxed/simple;
	bh=ZYjHYi3qp7CFK3FypNN5Aqtbm+HJKQsn2wGcJrE/6zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LytvqQ8ERIVdOzmg028mcGILwcHZEKJe3L78W94di4ouaBWUlT00nIxF0BA8B19V3ryvSOH01BUiMxkWvT+2ELIZr58EVv2C+C7+9jLDnsrx85W8Cdj85iVTQ+iX53QfQgg4YvUvyX1c1vyq8ZMKegr7QtYb/BEpDXDh6YZ7hwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-695df25699fso5667426d6.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710996645; x=1711601445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hbOvCNocqAqK7bs/UydGSUw/DhM1cyE80h1mRUzLro=;
        b=UetvjLeywwMHLB374eq7qlxEFLjl+pwmljjCtCIfIJqeTLEUEfHVzjsU0STUVc4sCy
         ttorAry/fcSH3VzaxI1ywDuYtJpNAS6EcV7Q+YvyHcXWSOLwp4ZjvvX+uYlRXcEamrpH
         n2/hzyu7XmRUpPGAKQbHOJ5vTKM6VEq2UsqcqBTYWrUy0+hMZfLqiTXovga4xrmxB7e+
         sN5X/24C00+96xtwgGV7tBhG/xsbfhV60xE4m1g1JvQNmxn6BCbFydpts3dmLS7lDIAT
         ClCu0Xm1xKvAVLI8gYQKkDk/yAOzJ+HiA6MTSGEkEDg17AVg61Jbd3NhaIiUWOtJdV/A
         NGKA==
X-Gm-Message-State: AOJu0YwTZ/IFm4NdFmuX84MilFWN97OjPgHt0QZs9nS4q5ONSYLoz3lW
	huCwgo4orjKs9puEb6hwD/GNxCcGgEWl50diOfABzuWRoHeqXSS7IpFT+mozTqSS1F3JYez2GXu
	vUGI+/SnjkHI7fSOywydxabPf3X2LOFJM
X-Google-Smtp-Source: AGHT+IENwC9Mb8MvEDqYzgIl2j1dTKEZVPBfFRp9IV3Zin7aVfiMZ6glThG2AaDS/FPuvNeeXlxdloecBYtDljw32Nw=
X-Received: by 2002:a05:6214:110c:b0:696:4621:9da6 with SMTP id
 e12-20020a056214110c00b0069646219da6mr3590027qvs.3.1710996645311; Wed, 20 Mar
 2024 21:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710994548.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710994548.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 21 Mar 2024 00:50:34 -0400
Message-ID: <CAPig+cRCCqRHYOpMxdL4MWaSF5S0Qb7fcJ5HqkT0j_MU1dRvfQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Fix a bug in configuration parsing, and improve
 tests and documentation
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:17=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
> In v2, this series had five patches in total, out of which the third patc=
h
> (i.e. patch 3/5) was dropped in v3. [4]  Other changes in each version ar=
e
> described in each patch.

In addition to a written description of the changes since the previous
version, reviewers also greatly appreciate seeing a range-diff which
you can generate automatically in the cover-letter via:

   git format-patch --cover-letter --range-diff=3D<...> ...

or less frequently, an interdiff via:

    git format-patch --cover-letter --interdiff=3D<...> ...

Both options (--range-diff & --interdiff) also work for single-patch
series which lack a cover-letter.
