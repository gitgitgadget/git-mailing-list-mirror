Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352533995
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400887; cv=none; b=Mii5HThzE50cuO/O/XN60oLubrRGc1R+F8ozomM0S1i+CvyTwszwUrRy7vP554xjNe6sz2oLVhs5PnifF88jPKdASzuzO6CTCh/Mg/12vjmR0A1ziAUjjqu2MqxY+GYRGNMpRh0gkR1jZHeWN9OR2VUjErTURHgsew0Gq86puUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400887; c=relaxed/simple;
	bh=/08ei2RaU0kqRUruLAODTSZZUOsNqfzfg4ZL0VdaYO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MI5RIzna6lauwnxn+vd5RB5XYgBO5lsmg/Q8NtY4oM3j7BOkv7drcj+1mPrDlyk4Wb9BWUkPQW10osgWQz3kX5IsCXiqfV8+Nj+JDBq0i42LH4xbeM++RacyC/3emBLc3IjfmBrFlnkoteemfGCyoLa1mEpFX++Mvs3sEkElBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=hJSvJIOr; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="hJSvJIOr"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PL7v8q030041
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 22:07:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711400878; bh=/08ei2RaU0kqRUruLAODTSZZUOsNqfzfg4ZL0VdaYO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hJSvJIOrDpTWPZfRB25NxK0rX1A3pDI1YVojdA1caaNbQ3sdecYIkcvGbuVqpLE/N
	 A9Odiy8ldc6V9oYuGn3F9LgJz55w5xzcYCN04eytmhcwrPpYWAEjO32CljUpnpafEy
	 obwx7Wu8brm3UpzeWC5Wuk3dgWikorO9aVNs/Buo=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
In-Reply-To: <xmqqsf0ekxpu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	25 Mar 2024 10:50:05 -0700")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net> <xmqqsf0ekxpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 25 Mar 2024 21:22:53 +0100
Message-ID: <ghh6gukqn6.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> The 3rd iteration for this series.
>>
>> I tried to credit Kyle's suggestions for 4 and 5 with Helped-by tags and
>> hope it was adequate to do so.  Actually, at least #4 was a lot more
>> than a Helped-by, I would say...
>
> It seemed adequate, at least to me, but I'll leave the final say up
> to Kyle.
>
> I left a few comments but overall the series is looking much nicer.
> Thanks for working on it (and thanks for reviewing and helping,
> Kyle).
>
> This is an unrelated tangent, but I wonder if we can come up with a
> way to find breakages coming from API updates to these "tutorial"
> documents.  The original "user-manual" also shares the same issue,
> and the issue may be deeper there as it also needs to catch up with
> end-user facing UI updates.  In any case, we somehow ended up with
> two more "tutorial"-ish documents (MyFirstContribution.txt is the
> other one) that somebody needs to keep an eye on.

My plan was to also work through MyFirstContribution.txt and test
everything which at least should disclose currently existing issues.

But, besides those tutorial documents, many manual pages also contain
examples and I wonder how these are maintained.

Dirk
