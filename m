Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6704085A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399988; cv=none; b=dUKZ4Yve5e7kvfO62CIhBMdSnaMrSClVk0OkOBhTWnyAcQ6r8MdRiiEkTyDl6xDi3ae2KeDJXtcTzVAqcfx2poj1CGzCUgGt/0yBeoslVK9C6qnG2/FYfZgQcLi26XC72lJk6ijstqHhytnk3XR6Wyi51viARe56ep3Hw3kOk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399988; c=relaxed/simple;
	bh=zhCI9vlL9ZLehUkphXki/2I0RW4SPcfbzTiSgCNDwdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HRgRkHn7SNaHrWJrwUTKsZI5AVjPTTWf77PhMaEAeUEZ4R6zaubRmZg51Bsi8SAPp+TRIFzoJvgkIdjRTic0d0Xb7Qte8ejTjMsqIFabROCPTkEZUzAE5FIXYuEztKP2zOoY/Q0mDC8larExH+mjx/FVpQgatlaRuM0AKm1El1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=jIqlgXvm; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="jIqlgXvm"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PKr0LK027655
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 21:53:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711399981; bh=zhCI9vlL9ZLehUkphXki/2I0RW4SPcfbzTiSgCNDwdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jIqlgXvmDczK2OBihTwOk6rl20izgTh7WB36l0XLG42IQ2BppbBvsWxaPsE/T60Rj
	 NthJ6TQ3h0yI/S/nGuEcs/eZOKy6YbpYDOTy/NstIdyr0axsix2vstGR69Z0FZybpw
	 yq11oMP+HN7DsKdzNeqMkjE3BMCdpu2LeCX2hoTE=
From: Dirk Gouders <dirk@gouders.net>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v3 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
In-Reply-To: <CAO_smVgb4uWZQGv9bKUEL1AGC2DXBb8xL6KeYOkvHgMCXSAhow@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 25 Mar 2024 10:05:55 -0700")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net>
	<CAO_smVgb4uWZQGv9bKUEL1AGC2DXBb8xL6KeYOkvHgMCXSAhow@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 25 Mar 2024 21:07:55 +0100
Message-ID: <ghle66krc4.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Mon, Mar 25, 2024 at 6:19=E2=80=AFAM Dirk Gouders <dirk@gouders.net> w=
rote:
>>
>> The 3rd iteration for this series.
>>
>> I tried to credit Kyle's suggestions for 4 and 5 with Helped-by tags and
>> hope it was adequate to do so.  Actually, at least #4 was a lot more
>> than a Helped-by, I would say...
>> ---
>> Changes in v3:
>> * Reword the description in [4/5]
>> * Add a missing slash in [5/5]
>>
>> Changes in v2:
>> * Added Emily to Cc in the hope for a review
>> * Remove superfluous tags from [1/5] and [3/5]
>> * Replace bashism `|&` by `2>&1 |` in [5/5]
>> ---
>> Dirk Gouders (5):
>>   MyFirstObjectWalk: use additional arg in config_fn_t
>>   MyFirstObjectWalk: fix misspelled "builtins/"
>>   MyFirstObjectWalk: fix filtered object walk
>>   MyFirstObjectWalk: fix description for counting omitted objects
>>   MyFirstObjectWalk: add stderr to pipe processing
>>
>>  Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> Range-diff against v2:
>> -:  ---------- > 1:  0eeb4b78ac MyFirstObjectWalk: use additional arg in=
 config_fn_t
>> -:  ---------- > 2:  3122ae2472 MyFirstObjectWalk: fix misspelled "built=
ins/"
>> -:  ---------- > 3:  f21348ab80 MyFirstObjectWalk: fix filtered object w=
alk
>
> Looks good, thanks again!

Thank you for looking at it.

Dirk
