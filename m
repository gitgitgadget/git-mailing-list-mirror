Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82D3AB262
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503779; cv=none; b=tJW7gSwcvFEqzdu1HAUnGyITAPCAldU1uCg2M+bjAAmEdu9J+GQHvud8k/aitDJINv3HDs3AjHEEN2qnCnczszghbTCfZnPC6KoMgsUSf2YU0qiDBeRuR0YdkPxTygPmdwTz+AqTGWa2NFoDT4MtOAqwKNMSJIobzL7O2w4rcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503779; c=relaxed/simple;
	bh=IBU0eADTPz8prQMH/nj4rEJkWFSTqevJi+HmJRC0uBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SirX+yL366d/pGtlHb6Y1NjktsDhshvPxcyDEaryX41RkY574MkrclE+HZPVIaP4MWywJSZtN+CaBEwq+3vfivjXXLYaZGQdU9VoebRDzzEBFc6uI3rUYb+A5BIJvSQ5ROXXsk0I2qr5p3PzwKerofhkS1mz+1ezUgfqo1jmrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WLAlZKH7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WLAlZKH7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783503775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd2u1ymjeqKtXqt57UHGoRLHN3O6opzUQRslgnwxsbU=;
	b=WLAlZKH7PX+9rdfkpwoDw/AYJAXST+N+SV28bN+C2qapQM01Jvo/DdSzQ1EZdGmaf8rhm0
	a9r9bgSrIP2TI7bb/37R6NZeOBgjWdxSZ9WRVYI5He8MnyvQJfCGFavetW1ftGC3tkPuJQ
	WnuOXlpuLRP0GIhQkUACji+/aj6ndDY=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] setup: split up repository discovery and setup
In-Reply-To: <xmqqldbm4r86.fsf@gitster.g>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
 <ak0U46-J4qmwL2FD@denethor> <xmqqldbm4r86.fsf@gitster.g>
Date: Wed, 08 Jul 2026 11:42:36 +0200
Message-ID: <87h5m9om0j.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>> The changes in this version look good to me. Thanks.
>
> Thanks, both.  These indeed look good.

It's nice to see the discovery being kept in this new struct that holds
accurate information. There is quite some code shuffled around through
this series, but the changes look sensible. So as far as I am concerned,
I agree this series looks good.


Cheers,
Toon
