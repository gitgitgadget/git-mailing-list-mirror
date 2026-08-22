Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7533B993F
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391525; cv=none; b=NAqdPQy4QGjq3DWoYcqQL/pyzn4BEdVLFzbdNcKcUz++Ru5dSoEZI+vGWsUk1jjrO/CZZTJMGNYXnI0GFNuTVchP6xTFwdIZTu4ixVaFrYmAnKX1mJBgGR1Bd5JGJ/YSxs4yvAbns2zfIVj/UZP57mBJJqJlSPR77aGMNG095qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391525; c=relaxed/simple;
	bh=tFlabLwWNQjz923vi0gr9smp8rbp7Mpbltnd/l4FHS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw3Pvl+YYU6X3613KH1O/vTi/j6E2/FTTizmNk34y4v2MfPCaM2a8u4NEf6LY/4XU1X38bkuhcZ+qX+ZiW2cq45BJSG64aBNgBd4WkAg+m1hMUysXLJT08T2l7G4xS74kmC4ULyIx0BWl86cyP0Mtc8J4xR7obJWTscuTcSoWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KI/hTv4A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KI/hTv4A"
Received: from MacBookPro (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7875B20B7166;
	Sat, 22 Aug 2026 02:38:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7875B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787391487;
	bh=tFlabLwWNQjz923vi0gr9smp8rbp7Mpbltnd/l4FHS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KI/hTv4AUju06G0CzWUKiYiM6lUgzHrw/HQwM8unwTUqOw3C3HZPZx04Y8c4DE8JG
	 2gmgtJyzQGoEdlqnAance4F8D2dRP4K5k6r2ResOyD17Q7cepBcGwc81bPooh6ra8/
	 SA78Ar039wDUAcR6ao8Yq2r0y3q5df5h5dPM53qY=
Date: Sat, 22 Aug 2026 19:38:32 +1000
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
To: Nils Fahldieck <nils@fahldieck.de>
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org
Subject: Re: [BUG] git config --global: doc and behaviour disagree when
 ~/.gitconfig and XDG config file coexist
Message-ID: <aoln1Q33kxaTaq60-delilahwu@linux.microsoft.com>
References: <xmqqo6fojkds.fsf@gitster.g>
 <336EEC18-98D3-4068-8C5C-476749959814@gmail.com>
 <an1dekUM_fsM_l8d-delilahwu@linux.microsoft.com>
 <CAAdFe9z92-h8eQmwxzZ=1cCB_8ptTHKnL1QMWAO=VEJVHe07OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAdFe9z92-h8eQmwxzZ=1cCB_8ptTHKnL1QMWAO=VEJVHe07OQ@mail.gmail.com>

On Fri, Aug 21, 2026 at 11:21:02AM +1000, Nils Fahldieck wrote:
> I am very excited to be reading about your progress, patches and
> everything you've contributed so far.

Thanks for your support, Nils!

> When you have the v2 of your patch ready, please let me know and I am
> happy to provide any feedback.

I realised from your bug report that I need to test `git config --get
--global` in addition to `git config list --global`. Once I have that
working, I'll cc you in v2 =)
