Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019C3E5599
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272716; cv=none; b=GQ2hsg4N5oSUD8Ef8MYLK/DFPTuSUBuao4tQb0Bg10XyhaMxx5Pp55IpLa92zAUBtNUHyQcgOd1QqaVUKxTixk1HssY6sgP15tcPvuRdr7aUsQUedCyPY8ZZBcznhZ1U/z3VC0Pky0jSV8OjDjLZ6TvpKFOK87laDOdSvtq6lAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272716; c=relaxed/simple;
	bh=qAAk576ZikLV7Lb/kDIsKecVFudt77zXPwbXGTdKZNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHBv6TjVN49igwbf9bPrqn+gmkMzYuYbJhdZGmJmCqX6U2dQBRnQT2JY7CYTUaLx+mNYgrfQX626nvoM+XpyQFvwCBD2lPm2Rh6HTx8Gpx/UIUvFynGp3Kq3POSGcLQ0IDQHrGVWSug+I/9+EnylmdzPsgVNC5p5QxbF4jRqeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=P2C+o8mZ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=T5woVbXO; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="P2C+o8mZ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="T5woVbXO"
DKIM-Signature: a=rsa-sha256; b=P2C+o8mZsjDNjVhGgEBysJydLFZmu6wJGyigGIS+K8BY0IREAID6TC8r6MwQR/yJnlTEpf6QzhUzAhb7wGB2F6Wm0IwPF4MoGJZPq+2cZQthzlptRF4LsNT+q77TPWCo1TQKx+02o1JXmWK9m6cWyu+VNGYi9Nyh3/dMmqHxbL59AkSYiHYLzl4zJl1UIS42tO4Ql29IkpuBrNSxLoPcWU+kVUhIa3DuJkFfJg+2BLM2mTkne/0g+aKKyakN3hxTcOmT0V5HEaEawUa7QFip4z4uhSuMIpr9I2uDW62mnIVw8fahm00QtLh2hmSK/jFn15kHONLkGJqmeo3BtJukiQ==; s=purelymail1; d=malon.dev; v=1; bh=qAAk576ZikLV7Lb/kDIsKecVFudt77zXPwbXGTdKZNc=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=T5woVbXOaqcXeI3IqH5sKm54w2+K7QPzYV5/r8tAO/qS/VU86GxuhnvB67mff2VS/clVcnLR2A6ES06Ja+qr/EZg8KJgYYNGU5ijL6AGhCFAPDf1WN+8pjDqIOGZkzdmBwR8VnJkPXsAgtpK31y5lbLe6kM9wal+swK4BexLzxj3dYCl7E1eJ81ZnCWQxYqDmqlmGivT5hrHHEkG16+j0jFTgWh75QoAQfyHyS2CXuyCwy1vbYj9Z0GU/JepbEBw6ZUNxyJ34Du2ZUBZNeycYp/FmSAWGfEB9jRxlG0EgEh/aygGj93EpAP0Ry3AwRZJ423JSZ2aqw9ChIP4DwDg9Q==; s=purelymail1; d=purelymail.com; v=1; bh=qAAk576ZikLV7Lb/kDIsKecVFudt77zXPwbXGTdKZNc=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1854087482;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Apr 2026 17:05:03 +0000 (UTC)
Message-ID: <21c10a52-82f4-4aa0-9027-21bb660b54cc@malon.dev>
Date: Thu, 16 Apr 2026 01:04:58 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] backfill: add --[no-]progress option
To: Trieu Huynh <vikingtc4@gmail.com>, stolee@gmail.com, gitster@pobox.com
Cc: git@vger.kernel.org
References: <20260412193659.26288-1-viking4@gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260412193659.26288-1-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/13/26 03:36, Trieu Huynh wrote:
> @@ -133,6 +133,30 @@ test_expect_success 'do partial clone 2, backfill mi=
n batch size' '
>   =09test_line_count =3D 0 revs2
>   '
>  =20
> +test_expect_success TTY 'backfill shows progress on tty by default' '
> +=09git clone --no-checkout --filter=3Dblob:none \=20
> +=09=09--single-branch --branch=3Dmain \

[1]

> +=09=09"file://$(pwd)/srv.bare" clone-tty &&
> +=09test_terminal env GIT_PROGRESS_DELAY=3D0 git -C clone-tty backfill 2>=
err &&
> +=09test_grep "Downloading missing blobs" err
> +'
> +
> +test_expect_success 'backfill --progress shows progress' '
> +=09git clone --no-checkout --filter=3Dblob:none \
> +=09=09--single-branch --branch=3Dmain \

[1]

> +=09=09"file://$(pwd)/srv.bare" clone-progress &&
> +=09git -C clone-progress backfill --progress 2>err &&
> +=09test_grep "Downloading missing blobs" err
> +'
> +
> +test_expect_success 'backfill --no-progress suppresses progress' '
> +=09git clone --no-checkout --filter=3Dblob:none \
> +=09=09--single-branch --branch=3Dmain \

[1]

> +=09=09"file://$(pwd)/srv.bare" clone-no-progress &&
> +=09git -C clone-no-progress backfill --no-progress 2>err &&
> +=09test_grep ! "Downloading missing blobs" err

[2]

> +'
> +
>   test_expect_success 'backfill --sparse without sparse-checkout fails' '
>   =09git init not-sparse &&
>   =09test_must_fail git -C not-sparse backfill --sparse 2>err &&

[1] I reckon you can reuse the git-cloned repository; there=E2=80=99s no ne=
ed to=20
clone in every test. It's up to you ;-)

[2] You mentioned that you want test script to verify that=20
'--no-progress suppresses output', but are you referring to the output=20
brought by the '--progress' parameter itself, or *all* output?

I believe the second scenario is a bit more meaningful. If that is the=20
case, then the matching condition 'Downloading missing blobs' is clearly=20
a necessary but insufficient condition. The output from the internal=20
call to 'git fetch' within 'git backfill' will not be matched, which=20
results in a false negative.

Regards, Yuchen


