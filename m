Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30319CC29
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028638; cv=none; b=HYEjIuTiF6bQdkTcq4rxRYInsjVLEyvJQEOjTBXI0BqHgAphon/3Kk9s0g7tzNYoyM97ZYDuKyvvMaoXe65XUqJ08P93+Mtugg5cPCKfrI6OX9n/3kX10ADnr8wfdESZI4iBH/5fYMjI3T0rWxaBiHXKrFGP7sYEkZ+HbAAs3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028638; c=relaxed/simple;
	bh=1iV9OyyTS4yU87CH9hyJU6NKq/YjO21xWTNQ5N9hp+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlEk94B1L72WMbUAooEBRjbDr4qyDFnkthA9jmg1l4l+ahdXFQz14erbrDEJ//bCADb2IbsYh2o4r+brroFueTvnwpPHcmBHRmtnspMHDGq9WdTDlZ+2E5GsC4lZhXD1BTGfCZfFbWnP1aZYC4D8itAIPl480vCamy29aM3x/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dblZqYte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBqzv6bl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dblZqYte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBqzv6bl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0007D114012A;
	Fri, 23 May 2025 15:30:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 23 May 2025 15:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748028634; x=1748115034; bh=f0VOkh2Od5
	wqE+qG8WcGhtw3FULKAcUv1BIfxDwjvwY=; b=dblZqYtejKBVv099XKpAIxTcn+
	n+H+JMR1mOF51um/tJDIeZSKRXar1VZ6VjZglKaZHXFireGLaUUJQvXhDbZARJI2
	8TWTFV7KTcxmPyAoUkfTUw36GtLvpH2X1W9fkcz20JUu4umMWdCFWTcBX7SqCvaO
	vR49GeewJcNlS9ow24EsUHtr0eJ+5CX4wXhjGF0o2ML6YzqhAmInCxn6VvX6HX4u
	Cu3Yac1b3TOvhEcQRMSUVuy7vy/+Fee7SH7snVsaarO5UhEsmYMQpFTjWuqT9c/0
	WDUE0zzHWKSwKNckOgFg5mNwnpNh92qWzjBui/anrOHNkYSMI4HeRBL9SGKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748028634; x=1748115034; bh=f0VOkh2Od5wqE+qG8WcGhtw3FULKAcUv1BI
	fxDwjvwY=; b=dBqzv6blYHW86USPRWj69+8jtfWt/gYorRT2gJlYU4cdSFm9t3I
	BzfCwErIDrrHRE5SNr9OksatgDzOmk4khrOzJpCddNTsuyg0NgAfHQJhn8ucA+Qc
	OlA/P28zG/P+eVjzBaC45FnxRsPBlWE4OAaDqmqJd8uUdYYOp5W25PLa3SjPc3Qe
	0iR+RcOOSdD/Iq75zCrzwMsD05U67WJF3I2085DhlrSTW1xp6GtVNBD3PoUzr6t5
	KU2EeXsy7pH4bLUVHMwEHqVGFMvCI9depHhJOy3/2xdeH3jk6+bXFVu7dPedicYs
	D4S7GJn0XeXYkcsqRO9FyPn/BYxOr6nrQnw==
X-ME-Sender: <xms:2swwaCg4Wu7LAFVHBdSdkGG_SMcDUMSo6VCfKPNwop5Uf_nrzIY47A>
    <xme:2swwaDD1s0evQcd0qq3AGI0r0ChPsWkJa2V4Kkuba4z3Epvn9vr9c_s7wJgEu1Tpp
    9cevvGj14RlfrHDOg>
X-ME-Received: <xmr:2swwaKHdiNUNEWTNumdOvH6bUwKYZiuXdprvqr0TkEM4TZMK-MjxdCDj8-2l-VVlP4TLkR09xe8xT1-L26dXRjztr8SY0Oa83eHHeCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeljedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepudfgheetfedt
    ffffjeelueefudelleeijedtteegleefheeltdekudeuvdefkeeinecuffhomhgrihhnpe
    hthhhrvggrugdquhhtihhlshdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgihguhhouddtvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhuohekgeeisehpuhhrughuvgdrvgguuhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2swwaLRvtBUqYYK8ikv5F54j9Sr_5qRSJK4WpWSBq55hVaSjmQ3t7g>
    <xmx:2swwaPwLY6jQATS3KSn3Qs5KvQup4Yee1E4g5jYTuD7Imf_rRGgcDw>
    <xmx:2swwaJ4eJ8Srr-jGhv6XSpi4MCxJMdR8eea62ozecH8hHMHAk3uuQQ>
    <xmx:2swwaMyOb1pAmRPvXXnAyBotLC6IjQwdkKkK5AD-MLiyViqCiN_cVg>
    <xmx:2swwaOtVezmEOA-EEgsaXsUAh5sSZzZncpdBSuJIeVPsemNbrjOoOXi4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:30:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alex <alexguo1023@gmail.com>,  jinyaoguo
 <guo846@purdue.edu>
Subject: Re: [PATCH] Add a check to prevent max_children from being 0.
In-Reply-To: <pull.1975.git.git.1748017238130.gitgitgadget@gmail.com> (Alex
	via GitGitGadget's message of "Fri, 23 May 2025 16:20:37 +0000")
References: <pull.1975.git.git.1748017238130.gitgitgadget@gmail.com>
Date: Fri, 23 May 2025 12:30:32 -0700
Message-ID: <xmqq1psfxgyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alex via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: jinyaoguo <guo846@purdue.edu>

This name (i.e. the author ident when you do "git comimt") ...

>
> In function fetch_multiple and fetch_submodules, `multiple` is
> stored in `opt.process` and later used as a divisor in function
> `pp_collect_finished`, creating a potential divide-by-zero if it
> remains zero.
>
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>

... must match the name used here you sign your work off as.

Unless you are forwarding a patch that is signed-off by somebody
else, in which case, their sign-off comes first and then yours.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index cda6eaf1fd6..b668187627a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2591,7 +2591,7 @@ int cmd_fetch(int argc,
>  			die(_("--stdin can only be used when fetching "
>  			      "from one remote"));
>  
> -		if (max_children < 0)
> +		if (max_children <= 0)
>  			max_children = config.parallel;
>  
>  		/* TODO should this also die if we have a previous partial-clone? */
> @@ -2613,9 +2613,9 @@ int cmd_fetch(int argc,
>  		struct strvec options = STRVEC_INIT;
>  		int max_children = max_jobs;
>  
> -		if (max_children < 0)
> +		if (max_children <= 0)
>  			max_children = config.submodule_fetch_jobs;
> -		if (max_children < 0)
> +		if (max_children <= 0)
>  			max_children = config.parallel;
>  
>  		add_options_to_argv(&options, &config);
>
> base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0

I think you may have identified the right problem to fix, but I do
not know if the solution is correct.

If max_children can be 0 at this point due to loose parsing of the
end-user input, the config.parallel or config.submodule_fetch_jobs
configuration variables may be set to 0 due to the same kind of
loose parsing.

The command line parser parses -j0 as max_jobs==0 and then calls
online_cpus() to use.  If the function returned 0 on a platform
whose online_cpus() implementation is buggy, max_children may be
initialized to 0 there.  If fetch.parallel is given 0 by the user,
config.parallel gets value from online_cpus(), so it has the same
problem.  submodule.fetchjobs has exactly the same issue in
submodule-config.c::parse_submodule_fetchjobs().

But otherwise, I see no plausible way to have max_children to be 0
here.

And if we want to protect a buggy online_cpus() that returns 0 or
negative, which probably is a good thing to do anyway, perhaps we
should do so at the source of the issue, perhaps like the attached
patch.

Or if you are trying to be defensive to withstand the change to
other parts of the code that may affect max_children coming into
this function, I think it is better to add


	if (max_children <= 0)
		max_children = 1;

before we enter the trace2_region that calls fetch_multiple() and
fetch_submodules().

Hmm?


 thread-utils.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git c/thread-utils.c w/thread-utils.c
index 1f89ffab4c..a5d644bb38 100644
--- c/thread-utils.c
+++ w/thread-utils.c
@@ -36,7 +36,8 @@ int online_cpus(void)
 #elif defined(hpux) || defined(__hpux) || defined(_hpux)
 	struct pst_dynamic psd;
 
-	if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0))
+	if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0) &&
+	    0 < psd.psd_proc_cnt)
 		return (int)psd.psd_proc_cnt;
 #elif defined(HAVE_BSD_SYSCTL) && defined(HW_NCPU)
 	int mib[2];
@@ -47,12 +48,14 @@ int online_cpus(void)
 #  ifdef HW_AVAILCPU
 	mib[1] = HW_AVAILCPU;
 	len = sizeof(cpucount);
-	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
+	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0) &&
+	    0 < cpucount)
 		return cpucount;
 #  endif /* HW_AVAILCPU */
 	mib[1] = HW_NCPU;
 	len = sizeof(cpucount);
-	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
+	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0) &&
+	    0 < cpucount)
 		return cpucount;
 #endif /* defined(HAVE_BSD_SYSCTL) && defined(HW_NCPU) */
 

