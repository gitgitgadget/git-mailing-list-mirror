Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89974153BED
	for <git@vger.kernel.org>; Sat, 17 May 2025 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747466419; cv=none; b=R5uqU0b2KyY9Q3Ky2d8+j3f5n3aQM+ALFtmcHL5uCIZi1Hbud4/lYxjI1B08q1k1X1wMjdZQprnix51cnEfFyNd4kaIkjh5YpwaHk731t77YcPfQQfoLKY+VSsDbgMaBW0stKbviLb/zLmDC+pHIFNqMlSRaAPBgPbT7cMb3soE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747466419; c=relaxed/simple;
	bh=PwhjxEwwG3h6KXWXyi908XKYgMXx35tpC3k6a40n9Es=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+ZnQ73LGb96cMySBLYsj0P28qOnDjPrTVjE3l+Xg9IkZh5eUucB4Khr3sKHFkOJLgY1qLn1JJz3vy5t/jLVjdM9IQPEykkOxoK7J6jzcJ0twLwufbi4LEhln30N0/kx1iiflIGk2B8+dsS7TsW587cORZbEP2Sva4Rn9E5cDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=txRs/HRI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="txRs/HRI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2320d2a7852so579345ad.3
        for <git@vger.kernel.org>; Sat, 17 May 2025 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747466416; x=1748071216; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o44CwTw0n6FX0LrzD5+x8dqgASpzJwv5sr0/aqUC3e0=;
        b=txRs/HRI6R6MC+sGeFf/INtzUrwCxfKSFpxPNk5ny26Zbg36hCeix2QdEU0d0bblua
         PHE4TgbCFC4V6rnril4Q/7G/sSeZa4/RyqjMTBIgzpZhjo5wBZHafJW8FoFVEm7RyqwE
         eIDDnQLwDCCyDX0NJ38Tq73MmAiv/++4c0SUcGo/qhKKKpbMBYe2+cr+BToyrYm1Nwim
         fCVeJWaYorabbhiF7ELyZ35Nq1v8LKAr94tp3oCj5sTG1C6oZRfDGI60lnnQ5tsw0gim
         VPvNXV8YaoWLQFpFzca4xQ6F7bB/6jhnF8MuNCsGD52HlGNtch4tvIylOB8eRSP662H+
         XvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747466416; x=1748071216;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o44CwTw0n6FX0LrzD5+x8dqgASpzJwv5sr0/aqUC3e0=;
        b=c4ebBwQdnDkODN7dF8E+gNCUP16XFlGsUwI1lIUZ9Ek+8IKc1GUg2ToxQJEwXNIaTI
         2tioQhwstqgqKJMl5XLLADR/iW93XB/0Z288x3bPGiYrLDkzRpTupWdXJLJG4stkgpg6
         LYh6yJWeR8Y6yFEOxLk5o1qgqq6WuFV0owwuQ0tiH1STufKdrF+q1c9adZ/Ncv8g7cWq
         aMscdbu7aWz9HOykSnqF2efBCClFFAt1HeY54nhZnemfTLPcvH/+/CVSN1sfpC3o3gdh
         FDJM0eBelJwWoLXtcPzWhrqUuzdNwXFoHd3VG7g2BxEu0T5x5lqp0UKcsUm7L1VYb5Cd
         JACA==
X-Gm-Message-State: AOJu0YyPjIKr6arxvazLEXt4RlQsjB5A80CbZlCcRgCK8hdwQjA+2REN
	1k8ouFcTlNVPBGJBg2fRp12NGNx9N+adLAYMCJiOsNUXPYFMIz0MEjQ3gqKw0LrWe7SrDVmwSwA
	9uT1g
X-Gm-Gg: ASbGncvEO9Y9GBGVTUOFFeW7gU3s9XpffVmUW4bCo+tMZUabFjcQ0tXmwS5PXS9CP6S
	ipIOQgqwUCUm0J9K7IycPkU/kUxg3s53Ajr8geg6wb52lsDzLfiSqbx6O9l8fM5pQ9aUggw906M
	JKbJsQyZAn3FULy7wJHZ1CIBZvMKfdG+QJx3DvUAgquG1KP93zqI9nWC5bDExa4TIfbrNHwjypa
	xPztlIg/Xk5Uiaq+NI2WAPz0aafgo8wtjRKC++2NoELy57IwLvllCfBBzJ2ouJsywQXP+swt5Y9
	2hKUqx6oCNMjVyo1weH2HKpK8k+5REs0tjpif2FJAuS/WvxxFUWs5j76tzV4xJ7H
X-Google-Smtp-Source: AGHT+IEVNWHlTk4EIuncwrG2wJ9imFegknRcTVkSM8DVSRaDq1JKljzralu9jge6l2RS1PmBD7vzog==
X-Received: by 2002:a17:903:32ce:b0:21f:61a9:be7d with SMTP id d9443c01a7336-231de3b9f64mr75813305ad.49.1747466416313;
        Sat, 17 May 2025 00:20:16 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:245:6ef:bd3e:6a19:ff75:ab35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e9828esm24911565ad.114.2025.05.17.00.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 00:20:15 -0700 (PDT)
Date: Sat, 17 May 2025 15:19:59 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: Small patch to add support for MPTCP on Linux
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Message-Id: <BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
In-Reply-To: <aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
	<aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Brian.

On Fri, May 16 2025 at 08:33:03 PM +0000, brian m. carlson 
<sandals@crustytoothpaste.net> wrote:
> On 2025-05-16 at 17:56:07, Muhammad Nuzaihan wrote:
>> 
>>  Patch to enable the use of MPTCP on Linux (when available)
>> 
>>  IPPROTO_MPTCP v1 (not the old v0) has been improved to go about the
>>  limitations of middleboxes.
>> 
>>  MPTCP protocol is an extension of vanilla TCP which enables multiple
>>  IP to aggregate bandwidth at layer 4 of the OSI stack across
>>  as said IP(s).
>> 
>>  Similar to link aggregation which works at layer 2. MPTCP works on 
>> top
>>  of IP layer.
>> 
>>  Other than aggregating bandwidth, MPTCP also allows seamless 
>> failover
>>  when one network path (not just link) is down (or having high 
>> latency)
>>  by reinjecting the packets to a path that is available.
>> 
>>  This patch enables IPPROTO_MPTCP if IPPROTO_MPTCP is available and
>>  uses plain TCP if the Linux system does not support it.
> 
> What happens here if I compile this on a system that has a kernel that
> supports MPTCP but then switch to one that does not?  The reason I ask
> is that I have worked at places where we shipped binaries, including
> Git, based on a standard CentOS or RHEL system, but then some people
> used our software on a system with a very stripped down kernel (in 
> some
> cases, where IPv6 was not even compiled in) because doing so meant 
> that
> they could make about $5 more per server per month.
> 
MPTCP supports *both* IPv4 and IPv6. Don't tell me people would also 
remove
even IPv4 as well? I had written an #ifdef statement to check if 
IPPROTO_MPTCP
exists and enables that.


> Do the operating systems which support MPTCP make it a compulsory part
> of the TCP stack, or could we end up with cases where we're unable to
> connect here?
> 
> In addition, Wikipedia mentions that FreeBSD has only IPv4 support, 
> but
> I don't know if that's up to date.  What happens if we run on a system
> where MPTCP is used, but it doesn't work with IPv6 and the only remote
> IP is IPv6?  Do we fall back properly, or do things fail?

This patch *specifically* targets Linux to check if IPPROTO_MPTCP exists
in the Linux system. I think you have not read my initial patch 
description
properly nor even read about the new changes for MPTCP.

MPTCP support is now officially in the mainline kernel and not 
out-of-tree.

This *current* implementation of MPTCP is v1 and not v0 (v0 had 
problems and
v1 already solved the issue with middleboxes. again, please read my 
patch
description properly)

Please read up on how MPTCP falls back to regular TCP if it could not 
connect
using MPTCP.
> 
> I ask these questions not because I'm opposed to this feature but
> because I want to be sure we don't accidentally break things for 
> users.
> 
I'm not sure but you have not even bothered to read the documentation 
about MPTCP.
> I know that for instance Go 1.24 enabled MPTCP and that ended up 
> causing
> problems in some environments, so I would recommend that we make this 
> a
> configurable option instead.  We can definitely default to MPTCP, but 
> we
> probably need an option to fall back.
MPTCP v1 (again i am repeating myself) and not the old MPTCP v0 does 
the fallback
more effectively.

Do you know of any references that mentions that Go 1.24 with MPTCP 
enabled
(normally this is the current MPTCP v1) is causing the issues?

If you could give me evidences of such issues, maybe i can reconsider 
it again.
> 
> Of course, this code path is only used by the unauthenticated Git
> protocol usually run on port 9418, which practically nobody uses 
> anymore
> (because it lacks the privacy, integrity, and authentication which are
> necessary and prudent on the modern Internet), so maybe nobody cares
> about edge cases there.  My guess, though, is that the people most
> likely to be using something that isn't HTTPS or SSH are also the 
> people
> most likely to be using odd or unusual configurations, so we may very
> well want to add an option for them.

Again, the unauthenticated Git protocol is the *most basic* setup that 
anyone
can use to test MPTCP out. I understand from your point of view but it 
does
not make sense to support ssh and http when the most basic git protocol 
is
not supported.

git protocol is the *most basic* protocol. For ssh and https that would 
fall
under other project's implementing (like openssh or apache)

I would consider adding an option to read from .gitconfig to enable 
MPTCP
where i can leave MPTCP disabled by default.

But what you explained about the downsides of MPTCP (without evidences)
and not even implementing MPTCP for git protocol does not make sense.

Regards,
Zaihan
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA


