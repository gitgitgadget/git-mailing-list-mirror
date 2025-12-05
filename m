Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154893557FC
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955559; cv=pass; b=kRvn/Jzk7NyeWyONXU+lvs7ApXwXu3PMw5szRIV016nDZ0RJBxM6dBG4pGmJ1MP0Q/YOnKD2v0QQox+gz34NbKW6cLxeMaTj/o+26HvqiHFNpdBa98tQ/81Sm58dBelqFWYRl48QNcuXiaLX+jVfzVSQP/h7imGY7Q2L64WGk7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955559; c=relaxed/simple;
	bh=3GRFSOeWgqx7IxtjBf5PVUgn3UbAETo89H4Tgj8ZFV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekVXEP2ZJuAwc6PjJ0bg/uL9GPbTNp9cMnv+uQ4WAVCNRhoJueea7zldYuBmeAwSZ2GHZDL3JchFQBupGPhk+r34c7KHmfSGpE/v6gzy9Kgj+KUj0MsEsvrBc9EHgmACQo2nMP8bLKyUU2Ij7w6Y4/HWN4mzMCatc0c/uHRJdIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=exEKpXYt; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="exEKpXYt"
ARC-Seal: i=1; a=rsa-sha256; t=1764955542; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EpdRm3FboqUqwPHI1XhMhU63vJS9FSwVxKTEplttfU/ghbAimI/RMmxxddnGGcuOzpni7DaCDO2+hVvlxQ6xR3o1QTT6nV+lP47AUJjUCqGOUUyD++P8fnbZlCv3VWF9eKpP13virsycNu5nBHiGuDskzftZ6X2pTCQQSCxsY9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764955542; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=viyHmhV6aW1Ymrpi7IhZTxRVtn1IFcgIaII7ZM5eqVA=; 
	b=Nj1QEuswi1mcpYKtRxw3+Y001TbFbuXycfZBM2wkpDa2pFbHSHMFNdkFcOS4jEpFflYOlv/x5GhPKqkZqFdWA0Trtw/gVcc6C8jwzNWWuyWTwdRLZtyANzCliMygeUVG5Bd4DMG7jXqp2fO8nGjriVvCEa01xnDJz3vxuQh2cwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764955542;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=viyHmhV6aW1Ymrpi7IhZTxRVtn1IFcgIaII7ZM5eqVA=;
	b=exEKpXYtcMZfh1syOQcmiF0EoTQYaO6zIl0W2VT1qzB+MZf5bVWU97gXdyWTplHy
	FAnrvyik1d8dLKpS9ek6fT18pb3kYs3dgZINnvt+pL1OzuFm50AUUKJTbTA8Y6rSgAa
	ryez021jA3sYPOK3dAehDeJLYdYS3/SOFqewcI7I=
Received: by mx.zohomail.com with SMTPS id 1764955541453947.6582468843446;
	Fri, 5 Dec 2025 09:25:41 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 2/7] builtin/credential-store: move
 is_rfc3986_unreserved to url.[ch]
In-Reply-To: <aTLNLnF_ZLpMnso-@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-3-adrian.ratiu@collabora.com>
 <aTLNLnF_ZLpMnso-@pks.im>
Date: Fri, 05 Dec 2025 19:25:37 +0200
Message-ID: <871pl8g7se.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Nov 19, 2025 at 11:10:25PM +0200, Adrian Ratiu wrote:
>> is_rfc3986_unreserved() was moved to credential-store.c and was made
>> static by f89854362c (credential-store: move related functions to
>> credential-store file, 2023-06-06) under a correct assumption, at the
>> time, that it was the only place using it.
>> 
>> However now we need it to apply URL-encoding to submodule names when
>> constructing gitdir paths, to avoid conflicts, so bring it back as a
>> public function exposed via url.h, instead of the old helper path
>> (strbuf), which has nothing to do with 3986 encoding/decoding anymore.
>> 
>> This function will be used by submodule.c in the next commit.
>
> Nit: this statement isn't true anymore :)
>

Indeed, thanks for catching these.

I will fix both nits in v6.

>> diff --git a/url.c b/url.c
>> index 282b12495a..0fb1859b28 100644
>> --- a/url.c
>> +++ b/url.c
>> @@ -3,6 +3,17 @@
>>  #include "strbuf.h"
>>  #include "url.h"
>>  
>> +/*
>> + * The set of unreserved characters as per STD66 (RFC3986) is
>> + * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
>> + * components without percent-encoding.
>> + */
>> +int is_rfc3986_unreserved(char ch)
>> +{
>> +	return isalnum(ch) ||
>> +		ch == '-' || ch == '_' || ch == '.' || ch == '~';
>> +}
>> +
>>  int is_urlschemechar(int first_flag, int ch)
>>  {
>>  	/*
>
> Nit: the function documentation should rather live in the header file.
>
> Patrick
