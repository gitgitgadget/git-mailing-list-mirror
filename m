Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F503219EB
	for <git@vger.kernel.org>; Sat, 17 May 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487469; cv=none; b=WpAgNV9PBZW0gf7eKmDhMMPiqmZOBom8QaJOsiU1C/1oCqWVxCQ56SZVtLjrBFZ0ywcH1HXiv1nCYGedAIjQwkp6USei7xwIiNe7ueG3acgVn9LH3hIgAiTtbvALZq473vdDRbSgkiuRodMQ0SX7CC6CjH0TgU+ql9CDVwZWT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487469; c=relaxed/simple;
	bh=CLwyMJbgsmsPFJY81w3f1kTra0jbqrmrkNHnksiMFdE=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpLRjBxCRSQ0oulSuJ4NIK24RA6Fdl1TLwdsFOVsRLuM5z2yzvJkxmy+4iESTj2x1/04uNHMxGlWKleWwXd07yWHTHpAGVaEO/hoXDH2gmMvM2U6mJZXqZlDFRpum4p6CcXCaJUGAgPTfUN0LHnyHTaQB8ur6Bl/BhTH16ECcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=hKJ150r1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="hKJ150r1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74068f95d9fso2823683b3a.0
        for <git@vger.kernel.org>; Sat, 17 May 2025 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747487466; x=1748092266; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaTfArQu1SYDmVWISuIyE6251qXE0Rdqav/wfBZXvtI=;
        b=hKJ150r1Zu+YgdHYqmunwL7fsWxpEUnA9iXs70kzHtkJy2MdY/jjD9MFwNW/uEiHOo
         iV48lccgqNc9PF7plwfP+XfbfQEO/MR/m+Tfsy+JN04p7mrduUnDkIl8Sglod/zFyOl0
         PJtmJ+COjTYgr4dosT0XiJ0HEV8k4EO9AvJ7ScJYrOnFDRhTXrNk85jiyeChe/F2aIRL
         cYh4drLICzRzWJKZnlbSq2JlobWUsbSiCVY7aGv726T1ITnFywU58ipN6ALZdgiKwjdW
         yMYI97KPzFEU6UckhCGEuBdOySotdKhdiI7l2QP/XD7+wsUrnjMcQQftReHjMFO4ZDQi
         DmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747487466; x=1748092266;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaTfArQu1SYDmVWISuIyE6251qXE0Rdqav/wfBZXvtI=;
        b=Oy7SouUNNRfxGXJUHwiL0Drccyt7O9g4OvmwWDDxRPl/jrxF+E7MvAtxwrL/owCKmT
         4NcLXONMV+mOsrItNRihYWTlNU29yXdxahCIzE0d7dZLTqszBb1uAosxSPA6D7ZJPrFY
         ATFgK5GtoxJh5FzT/7zVGH0MxgEd1Nlvq4oGFWsuWDiPFoI5+/wbYWmizP9ejey2G4lv
         xw16WQn66KCBZXv7IwELI73lHGLN/hykySEGh/Ise+QNqrQmg5+C0idbDxhTfN/Mocsb
         Dhb/JE6Ys3tFahp0+rZiT2UIdKlr3e4gZpA2jFt9IxM1rnBOrQgpK3EOPliSpdpG4d/0
         HFNw==
X-Gm-Message-State: AOJu0YyhmMM/o6y5sanhmp5YclkDdPOK8uKXqk5MnCYcFbOIvDO/nb2t
	owRYz69pjGdlTxYIGPy6qbn1nD5cXYPVYSG//Uar/piMFYwWq8571fBhXy9LCdjJQ9azWHZKZdq
	vBFh8
X-Gm-Gg: ASbGncul7O0moNnm93n0FWahRIy4clArDXRcOOTSv5ECB+bXmDxGo6jQfmnHx37EC9I
	EZKkr52vXG2MmZDCIrg7sPwE53VopVo/Me/3iJnIwCja/PPE86mrQa4Ec+LLkWBaph3hO8+vQg/
	/MNrjiK7wt5LuTwNetIgZ1MAan7u5wVKcaXy+t74z24BKBs1hzl/swC8RFHPbam9fEra0TLkqMv
	rTq/4iFXN22HDxh+QKhgBSd44geRU67EMlsb6XDfU8ovJvWTCMcT+62boICf2+/fIYbaJT+ziOm
	c67WewfCEgNDwXZXuqM830QBSqE1KUIMfqkmI371rzG75aKMvpPafzV2T27lErco
X-Google-Smtp-Source: AGHT+IFYg7heTxM6qZVg814guK/VyzwsGS8Xd/NuAzE3/1DqNXxBEe0WsQHulTy9Z8Im/cpdAUSl5A==
X-Received: by 2002:a17:903:28d:b0:22d:b240:34c9 with SMTP id d9443c01a7336-231de37ff7bmr98789445ad.53.1747487466335;
        Sat, 17 May 2025 06:11:06 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:245:6ef:bd3e:6a19:ff75:ab35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebac6esm30313015ad.171.2025.05.17.06.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 06:11:05 -0700 (PDT)
Date: Sat, 17 May 2025 21:10:52 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: Small patch to add support for MPTCP on Linux
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Message-Id: <4YPEWS.J5JRNETKLXF1@unrealasia.net>
In-Reply-To: <aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
	<aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
	<BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
	<aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Sat, May 17 2025 at 10:15:33 AM +0000, brian m. carlson 
<sandals@crustytoothpaste.net> wrote:
> On 2025-05-17 at 07:19:59, Muhammad Nuzaihan wrote:
>>  Hi Brian.
>> 
>>  On Fri, May 16 2025 at 08:33:03 PM +0000, brian m. carlson
>>  <sandals@crustytoothpaste.net> wrote:
>>  > What happens here if I compile this on a system that has a kernel 
>> that
>>  > supports MPTCP but then switch to one that does not?  The reason 
>> I ask
>>  > is that I have worked at places where we shipped binaries, 
>> including
>>  > Git, based on a standard CentOS or RHEL system, but then some 
>> people
>>  > used our software on a system with a very stripped down kernel 
>> (in some
>>  > cases, where IPv6 was not even compiled in) because doing so 
>> meant that
>>  > they could make about $5 more per server per month.
>>  >
>>  MPTCP supports *both* IPv4 and IPv6. Don't tell me people would 
>> also remove
>>  even IPv4 as well? I had written an #ifdef statement to check if
>>  IPPROTO_MPTCP
>>  exists and enables that.
> 
> I provide this as an example of people compiling even "essential"
> features out of their kernel.  The question remains: if I compile on,
> say, Debian, which has this, and then I switch to the same version of
> Debian, but with a custom kernel that removes MPTCP from the kernel
> completely, does this change continue to work, or do we end up with an
> EINVAL from the `socket` call?
> 
> I want to point out that the kernel and libc headers used to compile a
> binary need not reflect the actual code in the running kernel.  With 
> the
> advent of containers, people frequently run a different operating 
> system
> inside a container than they do outside a container and thus we need 
> to
> consider all of the possible combinations.

In that case, i'll add a check for the OS that git is built on with 
"defined(__linux__)"
if that helps.

Also another check if a socket is supported by looking for a return 
value of
"EAI_SOCKTYPE" (not EINVAL) and fallback to regular TCP if that is 
returned.

EAI_SOCKTYPE should work across different UNIX systems as this is a 
posix error code.

MPTCP has been in development for the last 15 years and the major 
change/overhaul (MPTCP v1)
occured in 2020 and now is accepted in Linux mainline kernel.

I am working on this git code change as i have large git repositories 
with about 50 gigabytes
of code and i have multiple WAN links which i can aggregate bandwidth 
across and even
when one path (even in between my CPE router to internet) is down, i 
will not
get interrupted.

Also i am using a Linux laptop that has WiFi and 5G module. So this kind
of adds my drive of adding support for git (on Linux)

MPTCP helps in situations when one of my WAN links have a high latency 
and
automatically choose a link with a path with less latency.

MPTCP aggregates the MPTCP connection by using subflows where two or 
more
links can be utilised with subflows. A single flow of data can have 
multiple
subflows across different IP interfaces and thus increases network
throughput.

Apple for example had been using MPTCP for their cloud services since 
MPTCP v0 which had
issues (not MPTCP v1) since 2013.

Compared to MultiPath QUIC which is still years away from being 
implemented.

The main issue back then with MPTCP v0 was middleboxes such as 
firewalls and NAT gateways
that discards TCP options header which is crucial when using MPTCP.

> 
>>  > Do the operating systems which support MPTCP make it a compulsory 
>> part
>>  > of the TCP stack, or could we end up with cases where we're 
>> unable to
>>  > connect here?
>>  >
>>  > In addition, Wikipedia mentions that FreeBSD has only IPv4 
>> support, but
>>  > I don't know if that's up to date.  What happens if we run on a 
>> system
>>  > where MPTCP is used, but it doesn't work with IPv6 and the only 
>> remote
>>  > IP is IPv6?  Do we fall back properly, or do things fail?
>> 
>>  This patch *specifically* targets Linux to check if IPPROTO_MPTCP 
>> exists
>>  in the Linux system. I think you have not read my initial patch 
>> description
>>  properly nor even read about the new changes for MPTCP.
> 
> Git runs on lots of operating systems, not just Linux.  If the case is
> that the `IPPROTO_MPTCP` #define is only ever available on Linux and 
> no
> other operating system ever ships that option or ever will, then 
> that's
> fine, but the commit message needs to say that.  I know that many
> operating systems ship MPTCP, so I'm going to ask about how this works
> on some non-Linux systems because your commit message didn't explain
> that to me.
> 
>>  Please read up on how MPTCP falls back to regular TCP if it could 
>> not
>>  connect using MPTCP.
> 
> Again, your patch tells me how things work on Linux.  I am interested 
> in
> patches that work across a variety of other operating systems as well.

My main focus is Linux so i will add a check if it's built on a Linux 
machine.

macOS would be a later focus but it's not a priority for now. I would 
avoid
adding MPTCP on other systems such as FreeBSD as their implementation
for example is still considered experimental.
> 
>>  > I ask these questions not because I'm opposed to this feature but
>>  > because I want to be sure we don't accidentally break things for 
>> users.
>>  >
>>  I'm not sure but you have not even bothered to read the 
>> documentation about
>>  MPTCP.
> 
> On the Git list, we try not to assume that everyone has read all of 
> the
> technical documentation about a subject and instead we explain, at a
> high level, how the change is and how it's supposed to work.  Your
> commit message should convince me (and everyone else, especially 
> Junio,
> the maintainer) that your change is valuable and should be applied.

It's just a small trival amount of code but anyway.

I will email my latest patch in a separate email.

In my latest code i added checks for the OS it's built on 
defined(__linux__) and if IPPROTO_MPTCP is
defined. Additional checks for error if EAI_SOCKTYPE is returned, it 
will revert to
regular IPPROTO_TCP (regular TCP)
> 
>>  > I know that for instance Go 1.24 enabled MPTCP and that ended up 
>> causing
>>  > problems in some environments, so I would recommend that we make 
>> this a
>>  > configurable option instead.  We can definitely default to MPTCP, 
>> but we
>>  > probably need an option to fall back.
>>  MPTCP v1 (again i am repeating myself) and not the old MPTCP v0 
>> does the
>>  fallback
>>  more effectively.
>> 
>>  Do you know of any references that mentions that Go 1.24 with MPTCP 
>> enabled
>>  (normally this is the current MPTCP v1) is causing the issues?
> 
> I know that there were circumstances in which there could be kernel
> panics or similar problems with it enabled[0].  I haven't heard of
> actual network problems, though.  Since most people were previously 
> not
> using MPTCP and Go 1.24 enabled it by default, upgrading to that 
> version
> caused some people's systems to panic under load.
> 
My initial patch deals with *client* side of git. Not the *server* end 
of git (like daemon.c).

The crash that was reported was about the network pressure of the 
software that
runs as on a *server*.

But nevertheless it might still impact the client although the CVE does 
not state
that.

Look, i'm really under an impression you didn't look at the patch that 
says the code
change is in "connect.c" and not "daemon.c". If you look closer it does 
not have to do
with server side of things.
> 
> I do think that enabling features that cause Git to induce a kernel
> panic or the like, even though that's a bug in the kernel, should be
> configurable.
I've also added a flag for the git-daemon (git daemon.c code is a new 
code).

the flag would be `--mptcp` which can be enabled on the git-daemon 
server
side.

Example: ./git-daemon --reuseaddr --base-path=/all/repos/here 
--export-all --mptcp
> 
>>  But what you explained about the downsides of MPTCP (without 
>> evidences)
>>  and not even implementing MPTCP for git protocol does not make 
>> sense.
> 
> I'm not arguing any downsides of MPTCP.  I'm stating that we have a
> large variety of platforms that have to be supported and you haven't
> explained how this works or will work anywhere other than Linux; that
> there are people who compile out important features from their kernel
> and, though that is improvident, we should probably not break Git for
> them; and that we should be careful about enabling features which have
> been known to cause system problems.

Got it. I'll be more informed the next time. Anyway, i'll pass some 
links
that you might be interested.

https://www.mptcp.dev/faq.html#mptcpv0-vs-mptcpv1
https://www.mptcp.dev/faq.html#what-about-middleboxes

> 
> [0] https://www.wiz.io/vulnerability-database/cve/cve-2022-49198
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA


