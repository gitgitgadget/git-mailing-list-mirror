Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630976D1CC
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402314; cv=none; b=qmPK5Ms5pWMJ37kOtMGqoVM1RJCjSA/ATMfUaXwzSHdTS1zBsfW78pWEgKRA4shIcZSoCiiR7YVGtYW7eN/6O2zAWb8nYWLvTEEOEwCbfY1Aumj1kDQdQeL0AwwJOr/WtYpqF5lAzraCeSkj6qZ1E0wlCABfa8PAPOQ2jAm1qX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402314; c=relaxed/simple;
	bh=W7ldLYURrZ8oLdoQbjOG17BrhhDhEY0LBm/e3EKhfg8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hr2RoHGwaj+VdyLk7vcqBfOcKBFr7RaAkwA51xK867cdQXK2moPznX16EVvP6WyzCgdTd4PVeHvWS3Kjlp9XU80Rs5rQw4EU2G43SbJGDe7rgHbU9rV1ZaH8p6rhaxKIDBbOxNR3Z/sAaCn3tDJF0d7CSR3s8HJxOGBkr9IcJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=Uto+1OXB; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="Uto+1OXB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k/XP83eOV6XU/gMRjsr3Mxd9YZLLlKY84K2KNFK26Xw=; b=Uto+1OXB9vjx+xb12uFWVsSZjw
	4HWo6SJkIvy+XInZgDTxbtCHZbKjDFvx1XWKQ15XgXcWnDrVqm3MuUH5frPEl9gdjQFYRkb1ODwMK
	8x9vOwcPGvqZstmgoal4VcKBGiU85xghdsegk/dp7XF8EVJXR6zMp8xHV+ia4wmZ0+qUDvuEcVfw6
	bvJIsAE3FlvCm7KOJ5EQI8kx8BurNoOwPGKQzj0NwqDoA/vM8kL4GtyZeuCPs2oD19q6P7RwrLCGA
	+CN9C0opk2rqK591FPg6KgILM9tVQ3e0TyvECjfCC9ksMu3z8Wskhe0Lzibb2Vyos2mVwHlnOH1Tz
	ODhYGx3g==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:58810 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1roqup-0000000HPCe-0S7y;
	Mon, 25 Mar 2024 21:27:31 +0100
Date: Mon, 25 Mar 2024 21:27:30 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: bisect does not respect 'log.date'
In-Reply-To: <4e2b22fb-7496-4f67-a89f-9fcbffc73a1a@siemens.com>
Message-ID: <25d716fa-bd32-4ff0-20f2-05ff51750911@softwolves.pp.se>
References: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com> <xmqq7ci6c7mn.fsf@gitster.g> <4e2b22fb-7496-4f67-a89f-9fcbffc73a1a@siemens.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

Osipov, Michael (IN IT IN):

> Interesting thought, but that also means that "git show" misbehaves because 
> it respects "log.date" and there is no "show.date". I still think that 
> consistency shouldn't be obeyed.
> I'd be happy if someone could consider this improvement.

I've also been annoyed at this. Everything else respects the date 
setting.

Bisect displays the commit through an invocation of "git diff-tree 
--pretty". This command does not respect the log.date setting, but it 
can be passed the --date parameter to format the date.

The question is what is the correct way of fixing this; is it to make 
"git diff-tree --pretty" respect the "log.date" option, or to make 
"git bisect" pass a --date pate parameter to the invocation of it?

Or perhaps everything should just be made support the "TIME_STYLE" that 
GNU tools use? GNU ls is so much nicer to use with "TIME_STYLE=long-iso" 
set.

-- 
\\// Peter - http://www.softwolves.pp.se/
