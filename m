Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D128315D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514214; cv=none; b=tFwb2uORTWLttOCCNlbJnOxtaLiuhd0fnrWJjvry+wIluMcg09vgCgR6WM21Eb7fFJnvps2FpfJrZHzqvLJzexqkZK6vI/8uhlP8NjyL5qPSCRp3kdL8M9D1uYJV+raq2gs0Smwhd3Op5MVSbjALtIeXCqcLhk95xOBjKMKEl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514214; c=relaxed/simple;
	bh=X3fRuffVH5/SgdOzbsnoRHoivvTvLuqSp1I4/fEwkvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXw79OXNfvlIgej////eEvbkQng7Aldex7W2mYTiXm6055gTkNTH2uImvMVRwpSnnAHfrlHxEwrxY403fNkHT60JgmPijyV3DYeqIvnMQF0v3l1OAto1HNnM5MPvSqi86vpHpZ05pIuYCqzxBbHPO6ZcEoRwB/ThxheBcO/uSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FZT+kmuu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FZT+kmuu"
Received: from MacBookPro (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0F9520B7166;
	Thu,  8 Oct 2026 19:50:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0F9520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791514212;
	bh=TgE+n0Z1E8icBbecJPgpvc99Nb2D/53YoMzNW6QVnVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZT+kmuux9ydOObQmliwcOfF20qQQ+Px7epXBnwMeibWKSexT7R3l9rXLcoPalbBY
	 lkAJmbEr9QuaRVRUukjdMdZawVKW5e4lYTr9iN+mrb7rexr8mS57/G6W11cdWGubDY
	 1c5zC37yGGosuT9XkQdPKnCMWI3QdPRDP4yraHLM=
Date: Fri, 9 Oct 2026 13:49:59 +1100
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Nils Fahldieck <nils@fahldieck.de>, 
	Patrick Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Delilah Ashley Wu <delilahwu@microsoft.com>, Derrick Stolee <stolee@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] path: use forward slashes in XDG config on Windows
Message-ID: <ashTpLXQBgqZ_UGw-delilahwu@linux.microsoft.com>
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
 <20260823-fix-config-list-global-home-and-xdg-v2-1-b29cc63f017b@microsoft.com>
 <xmqqecfkhify.fsf@gitster.g>
 <aqIvJhLLcCSnyaL4-delilahwu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqIvJhLLcCSnyaL4-delilahwu@linux.microsoft.com>

On Thu, Sep 10, 2026 at 02:49:05PM +1000, Delilah Ashley Wu wrote:
> On Wed, Aug 26, 2026 at 10:58:57AM +1000, Junio C Hamano wrote:
>> Is this "force forwared slashes to Windows users" a required part of
>> XDG/HOME global fix?  If not, please leave it out of the topic.
>
> I could drop this patch and change the tests in patch 3 to export a
> `XDG_CONFIG_HOME` value containing only forward slashes.

I've chosen to drop this patch and change the tests as above in v3.
Delilah =)
