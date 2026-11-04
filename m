Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816751;
	b=qRSvG0sWDeDx4JPHOetA9/y7EcxWzBMhb6o6yZac7LTP0jj+924sqNUVIjIEPiim+gP7
	 GEKWPAjXRTPRn4l3QrznVxX3/33s/WVtxqaA/CEDSaZCQExzjKN+ociL51vf3NB4dZZF4
	 QQyUFdL/MoaFPs6sRsbFVdPgVlgS7kB810Nh6bWSC4FlNuyCF5FNz+zmaQ+8ZDE3fHRsn
	 dHhEU/gE/GX0vOVQit7BR50uvI6MNNQFARDxAWJXR6d0GBOAzalpv761VqpECCFRRUQuO
	 ON2pHRLtLZe/lbZg/EP7rirae3g/C7zVLbjUj5ikkhcDSqbZfx+7otuldgINHeEWUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=CeO9ElOK0s7V++pzdz8u0ZkEPA4hjMfja87PPbOr8c4=;
	b=aWVUaFggB5lk2hsMV7JXkFZFca45Z1G3yfM+eyUqTj48GS+cg4p5pahePBZuTsTshkN5
	 K0bfK4J6XkFgAfkUw9M2UXvWBO6i/LgOIrN10okZGwJ7Y2DgNPBI+Hziup9iteUmu9GMm
	 pIwzjIjpAxy40N747Ft6vYeE8Z2XPX7HvRDbbUuvEe7ZeDkroDktBD5F3rqd6ijWDZfPF
	 UuAGzcZGxlNVq/sXabgNddT7sfRqeH2Cr1uKs9Y/EDQDRfPvaRorAiThkNLMiCdO/kkL1
	 /y3SIJsy5LK9VKxzB4g2RYIDWxk90rD4N0u+fNJLi384eYzv7dNKvbHu4dsShqCCKNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRKqrD7R;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC510606A334
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC510606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRKqrD7R
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36dbde64409so416870eec.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816750; x=1794421550; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CeO9ElOK0s7V++pzdz8u0ZkEPA4hjMfja87PPbOr8c4=;
        b=xRKqrD7RSiO6/aK/SuWnbYK8F2DvJWS3e5NX9bz0moH/1jSSz0e/12Y9uWpljMqz43
         PiVAErmv1mtP/aC85yx83jn34Nmz+TShpYDqtI4vaEx0vq4fKMq5VDS09rRDSK3AqFzq
         yiIK2/DEUZmws9eCa8Z9zCRl3QnDU38cak0hHqi+2jCF6n9DZ/BqI4N4UiYXTy9UHDsi
         iLCQlhVGq45mo5s3/WimqIjvTaSX4YdW26+4DQ+n5TcrnoKW6n47ourPkpbqFeBIgPGv
         6hFFPqwKbu1+itYrHSc8Gj/Rl6DSBvIwqJ7wJgs8fVMWxPcGIG9X7yRunl1J7S6N3JsG
         pF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816750; x=1794421550;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeO9ElOK0s7V++pzdz8u0ZkEPA4hjMfja87PPbOr8c4=;
        b=orIMzBwyvZaMJw2yDufqz4WKfdFKf1ODaoMwYD0c/cmWnkcCNOyZYHvOLath3hW5lm
         giLxJXcbslD2WyRNpItV8pQV6xa9cRxh/PJI4mS9avHomql7Q5FmDhxltKFYNnKxaQp7
         Oqt1pvWMs0v4+pLCFv+kCWgN2HU3ugmSumZ2KjgkLnkOV4aTR6kz8Aitz1/2wNLz5NsL
         O/MXv2lJFqo8FMQ8w+UBbN3/rpT8gqnkrWnDnGuZmDfUyYCZZRQSHNmdPeUkWjR7fFAM
         RYfCqbHLnnuQ0aVUHYMrBsTaw5DnJ2ry1EU79bjZwUMq/sF4xQf5UwREr06MeCS1/ywc
         1tFg==
X-Gm-Message-State: APuU4Z+Z+OV2cWMKcdIuvLmr4R1swIBqICnH6gPX3khYpUYhBgYzsATS
	eWI2dsrktKHIags0Xk2+bS7O/4xhhRV4O0YuAlPL1THyy86g0/7kKvqhPZd0QrRS
X-Gm-Gg: AYBFou3kn9YagVeVjq4GkSC8+uMPaawaNtLYNbBeUIq0/nw6m871g0FLgSYx9HO+w4e
	I+NBYnby/eqyigys0mWg3JIw2CAgPKPSD7h1NZJh7GIRvjidF5EWNxe8uT5USHYG99ZN2lHSX+D
	W0mN/+QGSY/ScL4VPgqbYC/nSI5fE+9dxGv2lZL1UxJt05aIa+/qJ3ZNRkvMfWaz8D0XVWnFvnR
	H9eOrv4snPAH+ZmAJxFd9qc4ABovrTzfDZMsOeypUal7SBfT33f71tRsLG0YeQ071vLAy6W5j2i
	PHru8sO1WuADbYAc94vpdL+RVcvA7W6IwIDyOoIHrQC5URWMlfeG55Nx1woK9o12UzBRXOM1mrq
	etRlLhr1md1M1g5hMc2rjnqMjVk/rpflR5TVHZAR18O52cCFY5SYVdy0dv2DypW+7OjLaJ6foyQ
	8fOlG30AV4qUTghORJDUyJRuNPZpeS+7wgWi1D5DaI60VkjKno6fnwbq5UEF+Db+paLDtOv1uRz
	Ci34IjqBbKg/1lEgJIMp/euxrP+/n+I99TjZNoIPiHS8WiY9dFlI3KSh7ALotIhhu03VnqzzPPD
	kM9uV2WRV5YO7Pirn7j7kFXScMuLhIsn
X-Received: by 2002:a05:693c:42d3:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-36a4236a650mr25225612eec.8.1793816749472;
        Wed, 04 Nov 2026 10:25:49 -0800 (PST)
Received: from localhost ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm8489901eec.15.2026.11.04.10.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:25:48 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 10:25:46 -0800
Message-Id: <DMMMYT4Q87N3.W2MQQMHI76I6@gmail.com>
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>, "Jeff King"
 <peff@peff.net>, "M Hickford" <mirth.hickford@gmail.com>, "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>, "Jeff Hostetler"
 <jeffhostetler@github.com>
Subject: Re: [PATCH 1/2] credential-cache--daemon: allow a concurrently
 created socket dir
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
 <20261101-fz-credential-cache-race-v1-1-28f0bac51e11@gmail.com>
 <aumUxF1uVtVC4qYj@pks.im>
In-Reply-To: <aumUxF1uVtVC4qYj@pks.im>

On Tue Nov 3, 2026 at 12:01 AM PST, Patrick Steinhardt wrote:
> On Sun, Nov 01, 2026 at 03:29:25PM -0800, Farid Zakaria wrote:
>> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cac=
he--daemon.c
>> index 65cc619bec..0dfa11e2ec 100644
>> --- a/builtin/credential-cache--daemon.c
>> +++ b/builtin/credential-cache--daemon.c
>> @@ -273,8 +273,18 @@ static void init_socket_directory(const char *path)
>>  		 */
>>  		if (safe_create_leading_directories_const(the_repository, dir) < 0)
>>  			die_errno("unable to create directories for '%s'", dir);
>
> It's quite curious that we use `safe_create_leading_directories()` here.
> As documented in "path.h", the `safe_...()` functions should only ever
> be used for creating directories in the ".git" directory itself. In
> particular, applying "core.sharedRepostiory" to the leading directories
> of our credential daemon is never going to result in anything good at
> all.
>
> So we should call `safe_create_leadingdirectories_no_share_const()`
> instead, which does not apply "core.sharedRepository". I know that's not
> introduced by your patch, but would you mind maybe fixing that in a
> preparatory commit?
>

Sure, I'll add that as the first patch in v2.

>> -		if (mkdir(dir, 0700) < 0)
>> -			die_errno("unable to mkdir '%s'", dir);
>> +		if (mkdir(dir, 0700) < 0) {
>> +			if (errno !=3D EEXIST)
>> +				die_errno("unable to mkdir '%s'", dir);
>
> Makes sense.
>
>> +			/*
>> +			 * Another daemon created it first; check it like one
>> +			 * that already existed.
>> +			 */
>> +			if (stat(dir, &st))
>> +				die_errno("unable to stat '%s'", dir);
>> +			if (st.st_mode & 077)
>> +				die(_(permissions_advice), dir);
>> +		}
>
> A bit of a shame that we duplicate this logic, but I don't see an
> obvious way for how to avoid that.
>
> Patrick


