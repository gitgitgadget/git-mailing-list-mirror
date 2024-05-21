Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7757318
	for <git@vger.kernel.org>; Tue, 21 May 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288136; cv=none; b=SLWrrIwrRQ700csm5Z3x6LQbJ5IlwFCj8DrioCBD+edz8fSIu3KM/8e0Pfc7w/7TUoWxkKm229ZMxZtk9WBMMfbD96zLRLnWhUj/nDg3Npl62o4l2SvoeLNqifV2VT6EyKCz+j40AhPOlAk3T7MCgomS3BHdG4RKnMw2GDCQFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288136; c=relaxed/simple;
	bh=8gAfo1mY9WjFfE6d5ZFS2Fsye0OysbVX2oYDugN3mEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RPx2snVQQhfDO4Z0IfLJ9proGDRzwTQNZTcKJgsEdblMpBbtv5NXOb69UoDFILpiC3zXsMGAMh66icm6ePy1TJE2LeRA3BRJNfdeNTVStgEvTVv9MRQFLSclybYDs2Y6gkPP3o1jIvVRFpZBEHUNgYlEUMY9E4nwMfVJA/+OS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=bmxar/Pw; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="bmxar/Pw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=8gAfo1mY9WjF
	fE6d5ZFS2Fsye0OysbVX2oYDugN3mEg=; h=in-reply-to:from:references:to:
	subject:date; d=aixigo.com; b=bmxar/PwVPybffyjN0B/nholA9e9dqiSo2WWpdny
	e0fpRBhUEsKdDZBwkxBDIEzG1A6jwZCWnxoZ2PLQWHhrpmHERzHm2Dv2DWjXI7r8u/18NF
	ZTV2xr6OF8wIbCK2IShxR1sBKV6d467cNZidVZC+xlqO66G5VRKHhThbJEGJc=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 156ff399 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 12:42:07 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44LAg7OS776324
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 21 May 2024 12:42:07 +0200
Message-ID: <3e4a7071-60b0-4f7a-b347-d584d5eb076e@aixigo.com>
Date: Tue, 21 May 2024 12:42:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: How to disable safe directories?
To: noloader@gmail.com, Git List <git@vger.kernel.org>
References: <CAH8yC8mPP_2jv8HDBdMxWv6TbiLXeDnD=KmNRMbno2bHQtfH1A@mail.gmail.com>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <CAH8yC8mPP_2jv8HDBdMxWv6TbiLXeDnD=KmNRMbno2bHQtfH1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-05-21 10:39:32, Jeffrey Walton wrote:
> Hi Everyone,
> 
> I've got a big DoS on my hands since safe directories landed on
> Fedora. I think this commit is the one responsible, but I may be
> mistaken: <https://github.com/git/git/commit/8959555cee7e>.
> 
> At this point I've wasted enough time on them. Now I would like to
> disable them completely.
> 
> How do I disable the safe directory changes?
> 

That is actually pretty easy: Kick out the commit. I would suggest
to turn the die() into a warning(), though, giving people time to
adopt this restriction.


Regards

Harri
