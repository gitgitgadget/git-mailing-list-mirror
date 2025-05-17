Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96704257D
	for <git@vger.kernel.org>; Sat, 17 May 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747506695; cv=none; b=JkVnEgUmsnPVV4qhTvpSbl3RAMWjVoAc/+cDnygqi4xDnPJ8wNY8xo+EKIpIXoDhR2fjDzdf8oSDfQGSyVS5v3nrky2m6/P3pkh6pGPIrYDhNK+4SrXxmlLZpGoTZKGV8bGvjdqy/l6wLTkMHEp7VQe1AgLfybwMD84EAqey59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747506695; c=relaxed/simple;
	bh=Wm7ARzwvip0UeKnOmFy6Eryli2nTSILORgCtgQMsPRA=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f91IBNblR8MzmJkCtkflWzPXOdZHE5fO5/2ScM8X8RT6Gh5yMd5WRZ4tSpdgjZJOjIWJSlAV4b9YGlT2KUi10+ly5STYr6TiIxZhO3By+usVQMM1yLVFlkQHF+0R7JfaOJSvxc2R7z6YBqkQNwsedU0MF7N6cTV9QryrarwRFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=J9xW1gcd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="J9xW1gcd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7423fb98cb1so3446871b3a.3
        for <git@vger.kernel.org>; Sat, 17 May 2025 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747506692; x=1748111492; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJsrLcHZ+ZBUlHnO718Ht8kiQcaWFYWdt2y1qHoBEHk=;
        b=J9xW1gcdFkNapZEcCXxAmiInlLsFsspRUH/VSOarLtEIe4wEkfr/R+YPA5+3sEqJO4
         3rpFItGx3zvk36Z471w/j0ifIF+WOVCY02CILZABHsqjTrpFU3k5DmsrB/D0BBERENPC
         reXQKkvEcfiYepMttKZM9GS5f2WOsZfnGVgEjK+zwuK5tw0U770dRZvTLX/CoQKo6jJt
         4K5+xEwLAvjI2EfwtRGfBg/CqZwlkp18b2L7pLF5qeurMNtdhyARRpd/oRtfxI6Y7RRn
         ZZR4U40rHStQAWPzq3X3g6Szp2xPBYUx0cZbtJtZZIwzSkTAxa9xSVMbT5fw3UXhhF+E
         lliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747506692; x=1748111492;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJsrLcHZ+ZBUlHnO718Ht8kiQcaWFYWdt2y1qHoBEHk=;
        b=deJepKDPBmh3eopqCYZ5UNv3OsixDTpweOmZJ3PqaR4x/J4VomcrEwbgjKldynh22e
         6c0DfsguUtKXHvxu4r+pPAAJK4OchjzAk9LHU3NUakolGehxfhhk+Gzpm5yRmySrOq1d
         6Ykz+X+1bBEt1a8qsQyp+u9j5f1NYXx7mIUaFq95F5wBFgHgKopfaeuXwvb8xuYVP7En
         zUTzu01n+Uu53QG/a4CgVi+rj4Wk5aagrU0HaxYF3DZF49IlW9Cv8IWRNSZubLU+HTQY
         WZRHKxWyV9PLbpQFSqS53IVOPSdBRcVsGhoW/qXexE66Yyn5VyOyaNymeb2vW+KRTOOL
         m4/w==
X-Gm-Message-State: AOJu0Yy31JwPLqVviq2Wr1UAja0s1DXcfpEV7AkzzO+MgoRENUS13LVL
	HmcXVrBYtDEmoZbtLzsfh1SsWaE35xkC7/lmp+H14cQsAokMy/u1xo+OoX/BEFrSi35JFy68XnM
	UyaZD
X-Gm-Gg: ASbGncvlOLO38/en5lWT5x8zNiOfy2WI9GXio1VrSQYhxt/CslS4hkD0ktUo4/OS8l2
	Lc014gg3hN8qEYq5FA9srIQMBt7zYmq1wQWC+Tsj0Z5xj3cGPwiEXAwYJw5jJ/3ZGjqR/V5Jqz+
	p9Ti2fzaSDhnkBz85KlD625+rmC8+juxUj+/3wYOsIEnunWu1RWxcJq1hAdbPZguw/4C6oYHDOI
	N3omj2SpjLC7tJ5aEjq80cle33W8M608r471wBmmhZAZ5JzTWsCXI4rkzPhZp90QTBzF2ul1x9m
	2fiL3cXUjOg2s0aNVq2PDVQ13gHOss+qUTRj9gMSxJbyXMlZreMOQqmZwhCyKNa/p0w=
X-Google-Smtp-Source: AGHT+IEa5EUrezp8Tk51BBRXk8RLXiE3yKfwua3CLQxdUgMgHUTPDxDjvVfI6RLj1In2d06cwxvZIA==
X-Received: by 2002:a05:6a00:2387:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-742a98c140cmr11491472b3a.21.1747506691921;
        Sat, 17 May 2025 11:31:31 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:824a:b6f7:7ddd:bcc9:e7f9:46b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970bd2asm3453435b3a.44.2025.05.17.11.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 11:31:31 -0700 (PDT)
Date: Sun, 18 May 2025 02:30:45 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: PATCH v3 [1/1]: MPTCP support for Git on Linux
To: git@vger.kernel.org
Cc: "phillip.wood" <phillip.wood@dunelm.org.uk>, "brian m. carlson"
	<sandals@crustytoothpaste.net>
Message-Id: <9R4FWS.9NR30V555Q5S@unrealasia.net>
In-Reply-To: <6O0FWS.8JJP67DO2U1M1@unrealasia.net>
References: <6O0FWS.8JJP67DO2U1M1@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi,

This code below in v2:

+#if defined(__linux__) && defined(IPPROTO_MPTCP)
+ if (mptcp)
+ hints.ai_protocol = IPPROTO_MPTCP;
+ else
+ hints.ai_protocol = IPPROTO_MPTCP;
+#else
+ hints.ai_protocol = IPPROTO_TCP;
+#endif

Has a small bug, which i realised in the v2 patch while debugging the
traffic with wireshark.

So i'm correcting this minor mistake where the else statement
should fallback to regular TCP if flag is disabled in v3:

+#if defined(__linux__) && defined(IPPROTO_MPTCP)
+ if (mptcp)
+ hints.ai_protocol = IPPROTO_MPTCP;
+ else
+ hints.ai_protocol = IPPROTO_TCP;
+#else
+ hints.ai_protocol = IPPROTO_TCP;
+#endif

Changes in v3:
- fix a bug with regards to mptcp flag should switch to regular TCP if 
false.

Changes in v2:
- Check for whether git is being built for Linux and also if it's on 
Linux, check if
  IPPROTO_MPTCP exists in both connect.c (client) and daemon.c (server)
- Check for whether the glibc version support IPPROTO_MPTCP in 
getaddrinfo() function,
  old versions of glibc does not support this even though header 
definitions netinet/in.h
  had already for years. Running getaddinfo() will return EAI_SOCKTYPE 
error
  if IPPROTO_MPTCP is not supported and we fallback to regular TCP.
- In both client side (connect.c) and server side (daemon.c) check if 
socket() supports
  IPPROTO_MPTCP if the git is built in Linux including checks for 
version 5.6
  and above and below 5.6 for proper error return values,
  else skip and run regular TCP (IPPROTO_TCP)
- Add client side enable/diable environment variable option 
GIT_ENABLE_MPTCP
  for client side (connect.c) to enable/disable MPTCP on client side.
- Add git server side enable/disable flag "--mptcp" to enable or 
disable server/side MPTCP.

Link to v2: 
https://lore.kernel.org/git/6O0FWS.8JJP67DO2U1M1@unrealasia.net/T/#u
Link to v1: 
https://lore.kernel.org/git/a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com/T/#t

Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin
<zaihan@unrealasia.net>

On Sun, May 18 2025 at 01:02:30 AM +0800, Muhammad Nuzaihan 
<zaihan@unrealasia.net> wrote:
> Hi,
> 
> This patch is about Multi-Path TCP.
> 
> Multi-Path TCP (MPTCP) had been in development for the past 15 years
> which started with MPTCP v0 (version 0) which initially had issues
> for middleboxes and NAT Gateways.
> 
> The current iteration is MPTCP v1 which has a fallback mechanism to
> regular
> TCP to avoid issues with middleboxes and NAT Gateways.
> 
> Started to add this code change as a need as i have large git 
> codebases
> with around 50 gigabytes and i have multiple WAN links which i can
> aggregate
> bandwidth across and even when network one path (even in between my
> CPE router
> to internet) is down, i will not get interrupted.
> 
> Also i am using a Linux laptop that has WiFi and 5G module. So this 
> kind
> of adds my reason of adding support for git (on Linux)
> 
> To get MPTCP to be fully working, both ends of client and server must
> implement
> MPTCP.
> 
> My implementation adds support for the basic git protocol.
> 
> MPTCP helps in situations when one of my WAN links have a high latency
> and
> automatically choose a link with a path with less latency.
> 
> Also, MPTCP aggregates the MPTCP connection by using subflows where 
> two
> or more
> links can be utilised with subflows. A single flow of data can have
> multiple
> subflows across different IP interfaces and thus increases network
> throughput.
> 
> Apple for example had been using MPTCP for their cloud services since
> MPTCP v0
> which had issues with middleboxes (not MPTCP v1) since 2013.
> 
> The downside, even though i had never experienced it for other
> applications
> on Linux like Google Chromium[1], is that the fallback might induce
> delays
> in connectivity, if i've read it somewhere which i cannot recall 
> where.
> 
> How this patch works:
> 
> This patch enables MPTCP protocol option only when it's built on Linux
> with
> IPPROTO_MPTCP support in netinet/in.h.
> 
> On Linux, if IPPROTO_MPTCP is not defined in netinet/in.h, it will
> skipped.
> 
> IPPROTO_MPTCP should and never be enabled when it detects being built 
> on
> an OS other than Linux with defined(__linux__) check.
> 
> Another challenge is that although "getaddrinfo()" is a POSIX 
> function,
> not all glibc "getaddrinfo()" implementation is written with
> IPPROTO_MPTCP support out of the box, especially on older glibc
> versions.
> 
> getaddrinfo() IPPROTO_MPTCP support had only been added to recent 
> glibc
> in 2025 eventhough IPPROTO_MPTCP definition had been around for
> much longer in netinet/in.h.
> 
> So we run getaddrinfo() which is a code in glibc and check for errors,
> specifically "EAI_SOCKTYPE" return value which tells us that the 
> socket
> type
> is not supported and fallback to regular TCP (IPPROTO_TCP)
> 
> Also we will also check that we are building on Linux and depending on
> version number of Linux we will initialize the socket() accordingly 
> and
> if
> there is an error return value (like
> EINVAL/EPROTONOSUPPORT/ENOPROTOOPT),
> we will fall back to regular TCP.
> 
> Enabling and disabling MPTCP:
> 
> By default on the client side, MPTCP will not be enabled in git 
> client,
> however MPTCP
> can be enabled by setting an environment variable "GIT_ENABLE_MPTCP" 
> to
> any value.
> 
> Persisting the configuration can be done in your shell.
> 
> Also for server side git server (daemon.c), there is a flag to
> optionally
> enable mptcp with "--mptcp", example:
> 
> git-daemon --base-path=/all/my/repos --export-all --mptcp
> 
> This will tell the git server daemon to accept mptcp connections but
> fallback to regular tcp when mptcp connection is not available.
> 
> PS: Can someone point me about having a "knob" in Makefile or is this
> already sufficient?
> 
> [1] https://chromium-review.googlesource.com/c/chromium/src/+/6355767
> 
> Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin
> <zaihan@unrealasia.net>
> 


