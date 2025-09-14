Received: from mail.marc-jano.de (mail.marc-jano.de [116.203.25.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4152DC79E
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.25.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874429; cv=none; b=RS+2tYenu1NreSscywiNIHnySjmPOqg4anr+RZ8RwJ3/ekafgPHRLPqJvAjF9BzXRSsBHqlR6ylDU/pagWIpnHVc3ONSUD7KcY27EpLw/I9LyDBxZVxuq/mI1huOgV2yMMx7LSfUdc5UQnH/Pfmgf8zFsyQZAGOQDimtcZG1CUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874429; c=relaxed/simple;
	bh=8zJD6Wr4jCUd938tG2h6Xe1pc+s125Pcsui0jA0VXA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjb+tIDVKB9KhzdWxIpy2+9//QGucKB5hzM7Ng6ALc5WdWbOvBUw7PY4AatZApOKCRfTiWIk4lgDuBdweDVMm19F2093SMA/vuKQAIi8XQBuqSjBQLanyXiECBzHrRvFwctNloRHSHeKi7AN4KGUD/WaWvQKSf6V0P5fAzTblcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de; spf=pass smtp.mailfrom=marc-jano.de; dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b=SMd+VpsK; arc=none smtp.client-ip=116.203.25.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b="SMd+VpsK"
Received: from pc1.trash.bin (IP-212232090054.dynamic.medianet-world.de [212.232.90.54])
	by mail.marc-jano.de (Postfix) with ESMTPSA id D181B85B3D;
	Sun, 14 Sep 2025 20:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marc-jano.de;
	s=default; t=1757874416;
	bh=8zJD6Wr4jCUd938tG2h6Xe1pc+s125Pcsui0jA0VXA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMd+VpsKHCArOMoCMS/bhPTo0Cx4C1tqBqF0Sn37ddrMgXtj8iCjzfb6zx/JQC2Qr
	 dJcVxxGZg06nt1zlhzyLX4P0lEmmRU39wegguXMPZseERQbeXuhSJC3qDj+wYjyi+O
	 w+ll3aTfXRuRNWwHdI0vKD8yp2pJawPrlIIo5a6kha4ymCeSJoa/b3pPYWnUXchq5C
	 MSqng7Rarm0REwBvw6MkTgOT9SxVf6wo0wzVMOAtKYqHpPFaXHCgYefKd9vtSkpwfi
	 Jr7BJdVlWiR7aRUNh1QBGJZfYeBEcjeBEx8QLeDmxp7pjsk1nIaRkUdVLB3TtWfOWP
	 H7Qk7WRLQV3hQ==
Received: from pcdm2.trash.bin (unknown [192.168.4.71])
	by pc1.trash.bin (Postfix) with SMTP id 0779A1B0810D;
	Sun, 14 Sep 2025 20:26:54 +0200 (CEST)
Received: by pcdm2.trash.bin (sSMTP sendmail emulation); Sun, 14 Sep 2025 20:26:53 +0200
Date: Sun, 14 Sep 2025 20:26:53 +0200
From: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
To: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc: git@vger.kernel.org
Subject: [SOLVED] Re: safe.directory does not work at all (git 2.39.5, 2.51.0)
Message-ID: <hbghuae56gm6ypox6q34mt4q6awoeb3itxsnmgpouycn7qodch@4pjsh24jhmqs>
References: <duuus2ifgydpwpja6vccvxbcnxdgy6mc6h63okzv7xdqo23fpi@ermurkhms4j3>
 <lamzerhpp6kbgzbhztgaqvdcymaqvec232sen67t6wx4rmobih@lqqivgroonmp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lamzerhpp6kbgzbhztgaqvdcymaqvec232sen67t6wx4rmobih@lqqivgroonmp>

On Sun, 2025-09-14, at 00:13:14 (+0200), Carlo Marcelo Arenas Belón wrote:
> On Sat, Sep 13, 2025 at 07:38:53PM -0800, Marc-Jano Knopp wrote:
> > $ git clone myuser@my.server:/git/main/test.git
> > Cloning into 'test'...
> > fatal: detected dubious ownership in repository at '/git/main/test.git'
> > To add an exception for this directory, call:
> > 
> >         git config --global --add safe.directory /git/main/test.git
> > fatal: Could not read from remote repository.
> 
> it is a little confusing, but the message comes from the git command
> running in "my.server".

D'oh! Is there a way for the layman to see if a message comes from the
client or the server?


> doest it work if you run the same command after first doing ssh with "myuser"
> account into "my.server"?

Yes, it does! Thanks a million! *smooch* <3  :)


MJK
