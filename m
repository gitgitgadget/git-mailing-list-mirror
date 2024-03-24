Received: from www555.your-server.de (www555.your-server.de [78.47.83.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E74F18EB3
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.83.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300697; cv=none; b=JAI39UmdaRhP6McH13ZfsKfOUkKXm+4Jh8yePiiz2aK3b67Mzt0HkNK0C0FOk0lBI6fJ2TMIEMTLqTqufd14ZkUC10ru9Ez0opWFIX/JTskCOru1ZYkdGv8N+x8863XEYN5Uc5PwiiLy4RWOSje6CeM4uGrrG4VYBAQhPr3DoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300697; c=relaxed/simple;
	bh=g17DrGTC1eY9cDgHgjnfHHncplp4tZuzL5XMfPrvBUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtqFV2gBtsOXKul8SiEwdf1DpNS1bWCUzXY6FIEZ9N8l1IUu3BUuhhDnncjhfTToAbSBPx2o+35+qP2anmDysgBw/aAD4UIYaI4k8vJlmg/hfV3TQ0uAvn0jLHngoOlRgGYsn7KgLn+o50W1fhjQLlvgKCrN/GJLZ1IiqxpVtZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x14.nl; spf=pass smtp.mailfrom=x14.nl; dkim=pass (2048-bit key) header.d=x14.nl header.i=@x14.nl header.b=k8SkycCJ; arc=none smtp.client-ip=78.47.83.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x14.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x14.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x14.nl header.i=@x14.nl header.b="k8SkycCJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=x14.nl;
	s=default2204; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WnHDpwa1TFGa5yxKswQSv/QOu8O2ogX/ulLr5Aro+JQ=; b=k8SkycCJKjvLY9H27qkrmGs70L
	oE7tyQ9bvRNvHpyattnwqeyPHcf8C5lSXrQ2zkoDNwYoVoBhT1dRxohgsrLH3UeqJVLk12R/KaQuy
	ioFIASPLQMCiJSRtnVaHz07s70KcABSFvYJeKaJJtYDO5kkZdaVA+j4wWTxReNCT9BeH/82daPr2k
	z+S+BpIvEDfXbY9x1jP+on2plYLEEntFZQArYhMmqym3UOgScKGY6zdViWgT0go68sqYyevl4SnxY
	yLDAvf11dLPe5qBmGCyDvyAATS5ev0U9oWVonbtak4yCr58xedaKh3FQGIZ14iRyEBTf6gxDs/bd5
	sl9YXriQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www555.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mb@x14.nl>)
	id 1roRTw-000Amy-S5; Sun, 24 Mar 2024 18:18:04 +0100
Received: from [145.53.151.92] (helo=[192.168.2.31])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mb@x14.nl>)
	id 1roRTw-000GG8-1v;
	Sun, 24 Mar 2024 18:18:04 +0100
Message-ID: <379141b4-d715-41b9-973f-ec0349ed11a5@x14.nl>
Date: Sun, 24 Mar 2024 18:18:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-prompt: GIT_PS1_SHOWCONFLICTSTATE variable fix
To: Justin Donnelly <justinrdonnelly@gmail.com>
Cc: git@vger.kernel.org
References: <20240319203244.799796-1-mb@x14.nl>
 <CAGTqyRykxy2GJV6b4yavWnegbz0HwykaT7bExOXK4wENdoF+Qg@mail.gmail.com>
Content-Language: en-US, nl
From: Michiel Beijen <mb@x14.nl>
In-Reply-To: <CAGTqyRykxy2GJV6b4yavWnegbz0HwykaT7bExOXK4wENdoF+Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: mb@x14.nl
X-Virus-Scanned: Clear (ClamAV 0.103.10/27224/Sun Mar 24 09:31:10 2024)

On 19-03-2024 23:58, Justin Donnelly wrote:

> Hi Michiel,
> This is my code, so I'm really glad somebody else finds it useful!
>
>
> On Tue, Mar 19, 2024 at 4:33 PM Michiel W. Beijen <mb@x14.nl> wrote:
>> There are a few environment variables that can influence the output for
>> the __git_ps1 macro in git-prompt.sh. All settings that are 'on/off'
>> types such as GIT_PS1_SHOWUNTRACKEDFILES and GIT_PS1_SHOWDIRTYSTATE
>> just take any value, and in the tests are tested with 'y', however
>> GIT_PS1_SHOWCONFLICTSTATE must be set to 'yes' otherwise it will not
>> work.
> I had actually considered using set/unset (for the same reason as you
> - consistency), but was advised to use a boolean flag.
>
> See: https://marc.info/?l=git&m=165897458021238&w=2 and
> https://marc.info/?l=git&m=165903017715652&w=2

I read the comments in that thread. While requiring the setting be set 
to 'yes' explicitly might make it possible to change it to a three-way 
switch in some unknown future, I think right now it is confusing and 
strange that of the many settings for GIT_PS1 only this one requires the 
explicit value 'yes'.

So I would still request to consider this change.

--

Michiel

