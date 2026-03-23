Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB80283FEA
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278477; cv=pass; b=YrNY6/HoSxkqisRIhff2J+VSV31c4pCr8J7jXFmM43tkC8nsb0ZlJMDSgjAiB1tBlXlQtcwTVXQj9GFznT63tY8a0/Gf9gQunTZrcyDoD+EKN4hvvod8sBRbSXb7Vuweky3N4O+cG7rizk376jecUbJw2VgkZNe2Ayh0BuLeFY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278477; c=relaxed/simple;
	bh=KSlA0sLXZSaTGlT3wvrg+BSk/N/pXuDS88F62KFfe+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+F6jC1WP7D5hTtTQC+w08wIHcqBlt7L+57OW/8niG+PLGV01s0qYzCPj+cWaAF6/XLEpD2FM5+wtPBboKlO22FbAHA+lwtkzv4FIekvX1EXCoIC0IrgIkUg+spwgVLsbwYD/loUQJGnwlFrUJRXcDN5IDxsVEHGqQqPvV41QmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=EIQm+Lt6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="EIQm+Lt6"
ARC-Seal: i=1; a=rsa-sha256; t=1774278456; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CpWNkjw/c+Nob3jm0MO8pwdQIZJVcZvHZZNytJsUVsJasf/jGz64mCrG4c1OgsZRd6JfZJili5E8EzzmLaAQ487U7DWf4rr9hDi9BKh99a170IUhP8lSDs5ULfBy+7WAtjryQK9bieTVt+6BZeWVLr63ompzflJ+G6+k3SGCDDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774278456; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ckBFU08fKfFFjC2twRLCfjh33pz6Tr9cNq4u45K8YS0=; 
	b=WI/AFEdjmhti/jejrJUJkNdrFOsDOCZ51KjnexwD8lQu44LORoIxZBof29KtU9CWfKfz2WFGR+YGrptZRKgaKdWzFahX8DIekK+JrQbRupjfX8oxsr1ZI3mjGl9qzm+xNmbI5Z8XOTHOgybQ2k96m07SrCGtF9YY3VcLfFFVIVY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774278456;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ckBFU08fKfFFjC2twRLCfjh33pz6Tr9cNq4u45K8YS0=;
	b=EIQm+Lt6zv9MHFPzr2lGCsOYECU644v1nDj8vJQU7uPqNMEuVZhdEDwxWuwII+HE
	YPxuWp/FIO4oPZkUn+nZwjIOt4v5WZrm4bP1oQZQJnklW9s83FbnNZGeP7Svs0MzkrI
	gxKoHdYJWdPB07gl7OYPPV2DpXbp1rIuFvV63Dmw=
Received: by mx.zohomail.com with SMTPS id 1774278453274597.0253853134676;
	Mon, 23 Mar 2026 08:07:33 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 0/9] Run hooks in parallel
In-Reply-To: <xmqqtsuae7nt.fsf@gitster.g>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <xmqqtsuae7nt.fsf@gitster.g>
Date: Mon, 23 Mar 2026 17:07:28 +0200
Message-ID: <87h5q660un.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 20 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Range-diff v3 -> v4:
>>  1:  6686d92867 =  1:  ec274c24e5 repository: fix repo_init() memleak due to missing _clear()
>
> This one is not included in the set.  This cover letter identifies
> itself as [0/9], but the range-diff implies it should have 10
> patches.
>
> Curious.
>
> In the meantime, let me resurrect the corresponding patch from the
> previous, trusting that range-diff deems them identical.

Yes, it's identical. Sorry for missing that 1 patch.

I mis-typed git format-patch HEAD~9 instead of HEAD~10. :)
