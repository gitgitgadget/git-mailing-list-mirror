Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2A173323
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895333; cv=none; b=jwaB0QwlFgBJy0KNf083RCOE2mdxF+MqCwQq2bst8YvVVBL43vaoeTcvFbr1jNr7QINmWvV1NnLK6PXUcEX8Q862ux80trOZGVOVleqnr1czjvbt2WigOCm51HXVo8+vG3NHVXonuR7UaPdwEvilBN3cLZVBvdzUjPkJSXQPLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895333; c=relaxed/simple;
	bh=gQC35zQo5PCz+9BGX4D+ptDN50+VFto5TzT+YxNJSoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCBL13Vfah9CDTNa3LSgAbe6lJbofnP6TsT2mrfeq8dJbT1NadzDadJZjTuxxjmgPgZuJYXItv5bQxFXYuZJLIEuYqbK7JBHHNsCMubGSyVJ3OZHQ1gVBR9JyOuocW09xHgwB9DPGNBEjsyd4g8KXglxmQmTYYHK1j759T2OV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com; spf=pass smtp.mailfrom=koordinates.com; dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b=DDY4hx8B; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koordinates.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="DDY4hx8B"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so20309966b.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1721895330; x=1722500130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qbrvMVPkqxBFrTSRXYJh1qQ/fiktW9SY6AGpd5PY5hM=;
        b=DDY4hx8B+gwJ8+S5pBlGJ7rJatuNwo0fgeM5nfYiHKYcsq/6DZYM5pPVYMZvr4vrqL
         j/pYqaMeTG5oaXXGln1cBCw4tZ5Fp8Ztut5Kp9HKy/KY5uci3C1eKJhaGb9OgUJv9LMX
         PFF4+MMnc8Z9hyvUCWp2Nfe1z07FTbeATJ6ECQae/Cb4MjQQZpIKvVX4daTSFxATA7a+
         itdG4otjFiuPZ3OJNTfeHlosng2Y8MDgJkTUb71aHsjPOXx21CneNkOr5C1nrSt9wzCb
         SDTcrXw7KNw+REcbKhKgiAHI/R+TXfSRTCn61FEY9AyUtdkOPlvg8wvzdPo9tiNRK20b
         JiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721895330; x=1722500130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbrvMVPkqxBFrTSRXYJh1qQ/fiktW9SY6AGpd5PY5hM=;
        b=A+jmwGcVyX1j45GsQg/WmWmHTYPg3Q5ek09LnSNwFmHzH2Vi7fZ9kq+InWj2r7OPXr
         F+9uHV4crKzfIwdjiVB1V9bB5wQkvADe89SkKJYGCIADly/fkvHyya6p6WKlxPYtcqYe
         zB6VmrowG8lGxAD36GHD5rYqwqTmao2e75rfgjuTu2cQJc3nLI1aGt+yzjsGm9KB/+0C
         +JkJXQRpZ5ErgJZ0KkmIHzmdcxJHoypqLmfJs7sXESfpqIA4eWJEmxfU0IYZ5OyWv0wW
         CvRJSEbUBupbqS4PQuKluh0IL+EFzZ3LvkFS6epSGQj6oFKP2//Vfl9jvKeBeH9+XTJ+
         Fidw==
X-Gm-Message-State: AOJu0Yy4e3kcsIeHb1HFLgLxjpSAEfxtciAsN2x0z3S3BgsvlkUtFqJs
	DgEPEZXs5nGFLSf4XPm+JGyKjfrgHRWWnOueKXRVoKth6Nv0uxUvJUDkG3xBc2yps2zIZB4VAR7
	Jx++MmZvY/0KBLk9qavDO94YM6cfQRma6+IHgGGY4jzJXWu5Q5MQ=
X-Google-Smtp-Source: AGHT+IHrDsW3BiIqnMJulxltj8tE16ta7TVSb2JxkAMYj2MKjStu+wASQanlskPA80vrus9/STaPxsizptYyV2ec2og=
X-Received: by 2002:a17:907:9404:b0:a7a:a7b8:adb1 with SMTP id
 a640c23a62f3a-a7acb554556mr79181266b.36.1721895330209; Thu, 25 Jul 2024
 01:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFLLRpJgpjJpNRC_UpZmUXF2626e0BiH8CkOkoMrX3zcrOp7YA@mail.gmail.com>
 <xmqq1q3iyceq.fsf@gitster.g>
In-Reply-To: <xmqq1q3iyceq.fsf@gitster.g>
From: Robert Coup <robert.coup@koordinates.com>
Date: Thu, 25 Jul 2024 09:15:14 +0100
Message-ID: <CAFLLRpKqU7nBGsPsf=kdA9Z4F6QaZ91hsRvArRy0GaCfxUgsTg@mail.gmail.com>
Subject: Re: bug/defaults: COMMIT_EDITMSG not reused after a failed commit
To: Junio C Hamano <gitster@pobox.com>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On Wed, 24 Jul 2024 at 17:37, Junio C Hamano <gitster@pobox.com> wrote:
>
> Unconditionally doing this change would be disruptive to workflows
> of existing users.  To them, Git left COMMIT_EDITMSG available even
> after the commit to them almost forever, but suddenly it stops doing
> so.

A general question: how far down the "I can imagine a hypothetical
workflow" route do we need to go? Moreso when the behaviour is
documented as doing something different, and it's noted in the list
archive as a bug? I appreciate there's a lot of users out there who do
a lot of weird and wonderful things. Could it suffice for the
hypothetical user to have an opt-in way to get to the old behaviour?

Some experimenting reveals a simple `git commit -F
.git/COMMIT_EDITMSG` doesn't work, since the comments get committed;
and using `git commit --template .git/COMMIT_EDITMSG` repeats the
#boilerplate, and results in an "Aborting commit; you did not edit the
message." error, even when you do. `git commit --edit -F
.git/COMMIT_EDITMSG --cleanup=strip` works, except it also repeats the
#boilerplate again, and it's getting unwieldy. I'll explore Jeff's
patch too.

Thanks,

Rob :)
