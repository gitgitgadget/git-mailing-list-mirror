Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E333F394
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719428; cv=none; b=Zl/5WXIRKqcopR3Xbw0CDXXfubyUdMPUQKB/ZDwPfhB+DQojfvtLeh/xh/5l36DiTXwqadQXJ46gfDzDU0B7o0fvHoj7JM0F+PsjW0oQWV4UdzDgUBdvbx9jc2IdfTT1+p1AIADSUoOLsXqvumd2vhfFOwS32q1grjn3qRD5REo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719428; c=relaxed/simple;
	bh=O5p4UAdtr3mNlIyKzTzPWUdCHkTRTENoPNM3FNUMGsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXw8PQ84Fa0uEsaqHVMArGhROK5rD/2Ucl2A41CUVB/kTiHqt8MjGpbung6ihBMpM23YrjTQI964OXkg5UdbZ7nDAvUbaaOEh1ZA2yXt95eyhwcnc3MpSZ/u04dw2jSw1tl63PvLJJl3JXLiks+WQnx6BQaSZXW4onXNd4676ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=gPsl9ITP; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="gPsl9ITP"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id dAWVvS8JlIjCTdAWXvQxEK; Tue, 06 Jan 2026 17:07:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1767719235; bh=hPlUhCSw0PTyFFDIAPwCWazNeltutS8c8ayXgyiWEl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gPsl9ITPXAOkGtkC/ljEPWmpwrrmbNzZRlcvMi7pU7ynOYOYzEFn5g0qPtRtgCNF1
	 nWPrEsCOGZhwPDpNEjIxINP+ts4K0E/4oaNMiiTNNg1KBOib+HrhBubSa78JE7nTe7
	 NSMLxANFYH9SYLyKU5z4yNpnSkpo/PcblxtPTd3frPW8j2QZAKAV1QITncyzeuL0GS
	 ohGwMd9uplsBuUz/kebpwya6FbaFLiK+Mc72euUGtxUTjqYQoQ0BH7M0Znk5BStGwN
	 KDTVDwjuEfO/1V8gWcTMdWosGSdcWM3b9f4Xzm242ubiWJcn3gnLLDq2kSMh9NqwP9
	 xabse+BzTvpIw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VvaAAP2n c=1 sm=1 tr=0 ts=695d4143
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=2rnwIQjNot_-GqdULVcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <1a430542-715e-4cf1-86f5-d9424951204a@ramsayjones.plus.com>
Date: Tue, 6 Jan 2026 17:07:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] more t/perf meson/GIT-BUILD-OPTIONS fallout
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20260106101043.GA3723319@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20260106101043.GA3723319@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfB7oH80y6DlSgzTg3BuXm0WVVoRiDr29t9LYbvtPSfZaCJSPBhMbeUtNIo5IktCOERMjobL2VdFM9I9HFUXFM/1RC6J3gTTzEbCWUsoZzORuV3YV+lmx
 gV7gyTOiYCenuKCTNqMNPaWn6lhQzBB0ZbcDpnzIzKdDWbjlFprmGVSYljesBm//NXtrMJKRs+U9J+41FgAIeUWlyXhFBGoYBFA=

Hi Jeff,

On 06/01/2026 10:10 am, Jeff King wrote:
> This series fixes two bugs when trying to use the t/perf/run script to
> compare two versions of Git.
> 
>   [1/2]: t/perf/perf-lib: fix assignment of TEST_OUTPUT_DIRECTORY
>   [2/2]: t/perf/run: preserve GIT_PERF_* from environment
> 
>  t/perf/perf-lib.sh |  3 ++-
>  t/perf/run         | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

I hesitated to send this email because I have been reduced to simply skimming
the git mailing list (very busy with other projects/real life!), and I may
have misunderstood what you aim to do here. ;)

In essence, I was triggered by the 'GIT-BUILD-OPTIONS fallout' phrase in the
subject line! That reminded me of a problem/patch I was looking at earlier
this (wait, last) year. The patch (below) was a complete 'hack' (as you can
see) to allow the environment to override the 'GIT-BUILD-OPTIONS' file. This
was in an old branch named 'meson-wip' which I have been meaning to look at
again to either delete or fix-up.

One of the many reasons (apart from being a disgusting hack) that I didn't
progress this patch is because I felt that not all 'options' in that file
should be able to be 'overridden'. So, that implies that the file needs to
be split into two; one file of options which can be overridden from the
environment and one that can't. If so, then someone has to decide which is
which.

[I'm sure you could do a much better job than the patch below!]

BTW, I can't remember why I wanted to do this anyway ... :)

Hopefully, this is not a complete waste of the list's time. If so, sorry in
advance!

Thanks.

ATB,
Ramsay Jones

-------- >8 --------
Date: Tue, 27 May 2025 21:53:49 +0100
Subject: [PATCH] test-lib.sh: allow environment to override GIT-BUILD-OPTIONS

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/test-lib.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 621cd31ae1..5239042b97 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -101,7 +101,18 @@ then
 	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
 	exit 1
 fi
-. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+
+# allow the environment to override the settings from GIT-BUILD-OPTIONS
+while IFS== read var val
+do
+	e_val=$(eval echo '${'"$var"'}' 2>/dev/null)
+	if test -n "$e_val"
+	then
+		val="'$e_val'"
+	fi
+	eval "$var"=$val
+done < "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+
 export PERL_PATH SHELL_PATH
 
 if test -z "$TEST_OUTPUT_DIRECTORY"
-- 
2.52.0

