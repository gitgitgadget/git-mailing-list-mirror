Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57A1FA272
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253101; cv=none; b=rVHJUtcG4a2omFhqNq040FZQeZVb0h6iDUL2AY42CpswKZcKWd4W8fnNbCWvTgfbg45C2+SKzFOlxsp0ou+uDf6wqLOciam3kgeNER/1Kdtl5hNjcPXg0B3NnyI0u++cVXXbEA0SOYVXShdXl548otoMRyUlSCVUXOQye5xyhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253101; c=relaxed/simple;
	bh=9nETNeWoF225rMSdioM4bz/aLKE3js2FoZCg+3fDEf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Drnnc6xztrBNv/R35qaN5vA+A9ZdAw0q8ik+7BSoIB/gKvsnxqRFN5CVunpKFQpjg8RG70kmZ+l4HU4VTNMR+xqWxWknvMgpWpr1hgj6b1jfCEfvGUm3qNjngpPPypirVJGg+Cm2LCsvlesJtfv2oM3plI2YRI2JnKc6ht06IzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AhG9kdAf; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AhG9kdAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773253091; x=1773857891; i=l.s.r@web.de;
	bh=CCDsqGik2IP2yeAFV1g7UeRDmo2rjfrSBfTUqS16Kb4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AhG9kdAfjjaisLAlayXJ7VNo5y0k64t+roakzvzD6EMIE+Vg19qu2kVooV32SnDj
	 E/SZrxunAj9DBLdqmhm5KPbp1BOqebYijBUZ/d2tp/ErbFD6kLZz9UdK8LK6PAHIT
	 AzLl4IxcVNzswMAWtFWVioEWvp1sUp1q2PohFvkXZhqObQyEcBujOwiZ6f7ztGUwc
	 gz3v9vGO58zE6uK9IIy5oagkEiJotaB3BeaUMRa98FjjaT2LvyDCWScasxrp9Jihk
	 /D1P2v+Y7SRukxiwJTINAX68g2W1caDKWtiuFsTZ91YV2qah+5zn4Xw1k99fNitL6
	 vjivLbVms5Bq4cVWbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1vvyHz04GW-000nyX; Wed, 11
 Mar 2026 19:18:11 +0100
Message-ID: <041604ef-0bdb-4c40-a9e1-60c38ae664cb@web.de>
Date: Wed, 11 Mar 2026 19:18:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wean start_command() off the_repository
To: =?UTF-8?Q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>,
 git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, ps@pks.im
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260311151923.4178655-1-bkkaracay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T/i7ZmN2cQuCUHvABPlQ16kUOUJ3ftu0Q/FopOOqE0nBwXtpKgR
 C9Iz0c5T6gzZ3GYb+jTyhg28P+aDOp7e52Ei8mf3+j36QeW0nX7aGjxU+MnT1miBuou7R7t
 YR2ZpDwo3xl2obz4hlof/tsbvs03GWMTR8/1hAp2LUZdiMFvKEFSitq/qt9Zu5D1hK71iUx
 V3tFpcsLoGsGsCX2aQv7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:svXl1nbw25U=;fJnA++GY8iSHLFrmFpCAykbXtH7
 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

On 3/11/26 4:19 PM, Burak Kaan Kara=C3=A7ay wrote:
>=20
> start_command() relies on the_repository due to the 'close_object_store'
> flag in 'struct child_process'. Introduce repo_start_command() to allow
> working with arbitrary repositories. Turn start_command() into a macro
> that wraps repo_start_command() and migrate the existing callers with a
> cocci script.

Good idea to expose this hidden dependency.  It's different from the
other repo_* functions, though, in that most callers can safely pass
NULL as repo because they don't set close_object_store.

Only gc, pull and auto-maintenance set close_object_store.  If we
changed them to set a pointer to the object store they want to have
closed instead of a binary flag then we could leave the other callers
unchanged.

Ren=C3=A9

