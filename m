Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9537168
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768030; cv=none; b=a8mG9mr2jD0+9mj/0Fw9+nwtUeNLzVsPd/T4Klvi37gYkXlhcrF0iiUh9mVCKVb2A+OyKHoAitpSV+zTUaSxQw1QQjwlqQYj5x3S1jpZTqkVAkCOY9PdmcV2AU4tAI5CI2jj3p4XbN1Nl4z5R80Q3J70zWYEEsLM5xJEqx+Wrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768030; c=relaxed/simple;
	bh=Vzr3MMUDigeA5JXV8yCs9NthR4lL7eQ54nD2Tur6gjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AtDuS1BGdRoOoQtk6naMA6Z95RXRoNy7FYYa2C4EP66wvVxPhp7nH00nIvY8QlDBAacRygqCv/GhvLPtb81+8St4AFTDv4uN5PQ+uTTvd3KvrXBDFf+dSdpcp5p7Lt5PZ4ukkCS++GpiWuKEgvS2i6n1NV2wUFP5sYxOofzykn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=AJl4C472; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="AJl4C472"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1712768023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8qFcstQsWW8pmaoxaVnBhSbtDKBfjp/Usmu68dIZgc=;
	b=AJl4C472aa4VceixXb0Y257a1VyDtYI9DDELbkpxyU0oBLOzAaXS+z+2YiGBZg3Ti0sIKk
	gOzrHFUlVr7hD0TQqX9brB7DEMto1jOB/F9VWvYTJwJo+GijhJYBv29DgaELIw6E+uofcw
	ZZE9KRwxFqCqyqHOwVq6b5lTMuQy9Rk=
From: Toon claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, Josh Steadmon
 <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/12] ci: allow skipping sudo on dockerized jobs
In-Reply-To: <16603d40fdf96948580c04a7c2b791a97ec64fe7.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <16603d40fdf96948580c04a7c2b791a97ec64fe7.1712555682.git.ps@pks.im>
Date: Wed, 10 Apr 2024 18:53:19 +0200
Message-ID: <874jc9kvls.fsf@to1.studio>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


> [PATCH v2 03/12] ci: allow skipping sudo on dockerized jobs

I think this title is somewhat misleading. While it's true, I don't
think it's limited to dockerized jobs. Something more along the lines of
"allow running install-dependencies.sh as root" would make more sense to
me.

That's the only tiny remark I have on this patch series.

-- 
Toon
