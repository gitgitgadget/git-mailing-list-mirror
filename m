Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9537353365
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642497; cv=none; b=f/cnfjJ6PhRjhXzicuHwt3u+ecidgShHShIz2Nj3Z7msiq6oYoa48y85vSQAtJ27kFym+7XpgwfJzECtwuCUilJmssHWmi6mKNuv2ZBrAgqyqY8/JhYtBVLMdpC0c1QDKLDLdITnWmsucrsHsH2SLaDUySlgmKIY64sa8Woe+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642497; c=relaxed/simple;
	bh=ZKoW/xQvXxH1a2x4j9ANPXE+fAidX4Q5AhMHyN27EH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPDaFYQhlg9qRJ0bnHRjAlfMdo38jjCrQNzzC43aN9Zp8peOlqLq5n36YkbjwW9p0P4OKeNNKgRiisL40/ldxEzBCmGUdqV3KDVFXRxZyDk4MTJJ0uO2CwLg3YPwatG9uXIRL0X2xUZk7Xw2/UN9csuJy1uhDo8m9hldteB+TGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Yyk5fmWM; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Yyk5fmWM"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id oUlKu3s6qwzI9oUlLuDDS2; Tue, 19 Aug 2025 23:25:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1755642304; bh=VKEIOBM/ukjCu87wF557eKuRKp4LyRogIz8lqv3xSNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Yyk5fmWMgMseehzSN3M78PtcRA/uxXApHjQyDmB2S8CySEALHcdC74MpznFfn3awV
	 IY4S+9p9uVTnUmcxPQXYHaFP+d4zLSUsCSnRkyHibP6FrEWky6vtZXt7pC3F0nnqB7
	 vb9B+EowRMMEy0zk3W2zvWRIwzKDI+1Ls3zn8XscNiYsV91DcxI9XjDZAP/TuqiQ02
	 x20xbn2TION/tKlsulmgtxvhY/xWl/uGPXCSA43s+2ZKmyuUqVc2XrhYjNSXicC1Uj
	 LQ9z4QE/G3JRyF4e02aTzc1tctKEQ1LwvnU6CuevPVrjM2j4tb5K+MB/NJK5I6hutw
	 pNJayivSE7ODA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbvFvdbv c=1 sm=1 tr=0 ts=68a4f9c0
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=EBOSESyhAAAA:8 a=zZUV6f2MH4c7RsnI3j8A:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <3571209f-2f4d-4549-978b-ad262ab3b274@ramsayjones.plus.com>
Date: Tue, 19 Aug 2025 23:25:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] meson: wire up gitk and git-gui
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJblUkKSwO9XFaT4X5Qm6PWsfMZ2Q3xXP5AwgaRM1joREK0ENY0hVjGL3WC7z79AfLp1V892BEK+CKewS+HcoT/AF8lVFq6zgp5Cq9Mv9qqvy5ZffIAX
 dJdUak3CRdIU2/ORWf+pmCfEhlYWRsUOGqvikOMRR4Mpvf+f7zE7aMcM+/V0SzMEeRfs790dni2EqfO1ufx4qgBM2vOwtP/0W+I=



On 19/08/2025 09:18, Patrick Steinhardt wrote:
> Hi,
> 
> I have upstreamed support for Meson into both gitk [1] and git-gui [2].
> This small patch series wires up support in Git.

Just a quick FYI, but I think git-gui needs some changes equivalent to
commit 586919c3b2 ("meson: fix installation when -Dlibexexdir is set",
2025-07-16).

[I don't understand the difference between subdir() and subproject(), so
I'm not quite sure how to proceed, but I guess git-gui is a separate
project root and 'options' will be passed as-is with a new context?]

gitk doesn't install anything in the libexecdir, so should not need a
similar change.

> To the best of my knowledge this is the last missing piece for feature
> compatibility with our Makefile. As such, from my point of view, I think
> that we can stop treating the Meson build system as experimental and
> instead officially endorse it. Once merged I'll thus send another patch
> series that updates our documentation in various different places to
> also mention how to build Git with Meson.

Hmm, that seems a little soon to me. ;) I still have quite a few 'misc build
updates (part #3)' patches to send to the list (yes, I have been a bit tardy;
sorry about that).

Also, let's not forget the 'quoting nightmare' [0], which has still not been
addressed.

ATB,
Ramsay Jones

[0] https://public-inbox.org/git/a5795bfa-cc02-4c9a-b7d2-4924a94cd0db@ramsayjones.plus.com/


