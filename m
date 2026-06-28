Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815B1E0E14
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782651526; cv=none; b=Yin671pWMCkrZw/dC0Tn94Y6vWXZLxPodWRvzDk4Om2nZbe6NtAa/UHxF226dixQjZ/AwYQnqejltBYenUP9Se3O9XF/0DAtESvrMfFgIV7aHl5sdtWEyD95kVavozbjXpgTY+Jc8ENO3uWzF1me6x3qzaRI29Y8YF+OrBmKNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782651526; c=relaxed/simple;
	bh=9H+jOfDnlCu3KTv5ZgFAArkv1aNdOqM7wCXLBiulXks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADSzxdCYGTC9NoPfk+6t/P8aEpc2OzvKp+X6jdcVM4MAZSID+1vl/slHM2BGwKzxV18S7O+H1dOqGGEXHX3F+Vpm12bqSKdmXWp4ewoFwOKA/+JAEtuVfISa5CIosonNfhXOWhR6j4gmya0h8DLng8qlauoqBkSDyokALX5X5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=tYy6BXUy; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FTpKkNKN; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="tYy6BXUy";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FTpKkNKN"
DKIM-Signature: a=rsa-sha256; b=tYy6BXUy3tvezaSsWntFsCxXJz/dXwPh4gxrUT7cVpz8YcAgRwXGdIvlrW1+Wi6U0lUkLVvebpYDbhAn5jB9iVp+5J6fnMAKOwhKLBoLooSfvaUY0iTyUojGDGpVQToDrh3LQ7mlfhK99hxnrSSJdU/Q5BbjgjTuS2EAvqM5LAdI8+dszjy8zBxtXWGceIilGgKsWa/n03BDWx7w9IhTk8axHosCuk3oce4LlXW3cxP2FBcdU33eTD466bsiRldw1zyaU981f20E5OkQPzLrP83+vo9wv3crwaz1y5hcDaHF1cjjBUlOcyrCuTQzPzuhwqiVMjwWzF00lKqTnjPY1Q==; s=purelymail2; d=malon.dev; v=1; bh=9H+jOfDnlCu3KTv5ZgFAArkv1aNdOqM7wCXLBiulXks=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=FTpKkNKNIwmBQk8XIwq8exoQ65iihrESbDaQCumI/hWh1BmQ0+ovsIraIVLs11FBqNLS3W4glZI6NbPuuQV5IcnXMulQmF5uIVJmTCj9bI2j/pFd3q9qkYs36/EfRFO72V9aDYHApit6ZHCIaM6dfOcHABKSJae7zzvEZ3a1s6W2EJYaGzO6ySaVxsAuc0broTCsHdc555Fkegtows+obQWoU7qJYx5NS4nKloKjMurGM5SoRNsUbQgnyVV5f1NdpARxwT1KDZVbjsUsc9E+mDUDKxJngqTysBFgzL4AYb0FpaeqNNH1ZKxT/NcxNinI8jV4e2B+41StdSme6BC/7Q==; s=purelymail2; d=purelymail.com; v=1; bh=9H+jOfDnlCu3KTv5ZgFAArkv1aNdOqM7wCXLBiulXks=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1522599134;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 28 Jun 2026 12:58:40 +0000 (UTC)
Message-ID: <18ad7c1c-5ddc-4f62-ba7c-5cda53f5a48d@malon.dev>
Date: Sun, 28 Jun 2026 20:58:35 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260627160813.1074201-1-cat@malon.dev>
 <20260627160813.1074201-2-cat@malon.dev>
 <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev> <xmqqv7b34snt.fsf@gitster.g>
 <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev> <xmqqbjcv2h3j.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqbjcv2h3j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 6/28/26 16:40, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
>=20
>>> Wouldn't we rather want to try to be more strict and say
>>>
>>> =09if (!repo || !repo->initialized)
>>> =09=09BUG("repo must be an initialied repository");
>>>
>>> here?  Aren't all the callers of this function supposed to be
>>> dealing with an already initialized repository?
>>
>> That makes sense, but from my point of view...
>>
>> 'repo_config_values()' already has a check for 'repo->initialized'. If
>> we're absolutely certain that the 'repo' is initialized, wouldn't it be
>> better to simply remove all the checks inside the getter and leave the
>> judgment to 'repo_config_values()'?
>=20
> Yes, that was what I was getting at ;-).

A lot of CI tests are failing, but that just goes to show that the=20
"bugs" are being properly identified, doesn=E2=80=99t it?

It means there are a lot of "invalid" calls in the tests (if the way we=20
define a 'valid' call, i.e. repo must be initialized, is correct)... It=20
seems that code like 'if (repo !=3D the_repository) return' or something=20
similar is inevitably going to end up somewhere, even though, as you=20
said, it=E2=80=99s "sweeping problems under the rug."

I=E2=80=99m not sure how to proceed from here either..

Regards, yuchen
