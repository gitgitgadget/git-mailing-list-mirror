Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BB44CF35
	for <git@vger.kernel.org>; Thu,  7 May 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169037; cv=none; b=nDcLl8S3tgxh/PBsJBOUEQgZegSCQsPr/kXGw1ztK23x3i/SFFGg85H/P7ktmr+Bp4NSH0+t+rPj7sHji+mItUNI/Wefk8Jb0+7i+y/D0wwQMJ2UhpbOb2LPtftyGZfU/K2PvhwVgb5rjU1/1Gme2Rb10rP9bCojst0vJQ7JAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169037; c=relaxed/simple;
	bh=D07fZkTclEdm6ArIhIvJVSlTpDCS5np6rwqVFgGQmAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raaOannsnmyQU70Bn9ZHhV5yIcRS9aMNCmPMf3ap2bzDFE5sK+Ro7ekVDL3wOpeYxIUOvTfgc7tDteVBXNLGpOgFHHXtwGBwMJUh4WX76Gdz7zMQC322oQZEaL30SjCMg0S9/40iuwJdjOFoCmdGDZOREweKVeJtRP8QWhQcOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK8Nvf+l; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK8Nvf+l"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d6d5e45c43so109993485a.3
        for <git@vger.kernel.org>; Thu, 07 May 2026 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169033; x=1778773833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9N5PyatHch8RDJv+AhoksSBqwwK2QeOL5lSH2lbrAE=;
        b=FK8Nvf+lRwzIlmnmfVOA2hq2vIDK2sc7fDPrlm4fnGwjaJyWa7h7ldnFMlSZeH+KG9
         KWDll/OdYziOJ5EGvSsmgoPcQW7GkfZX2Zl5dsount/LKxs5FH0V7pKsgLHdNbi7saqv
         fVMifwRxOFcVqCiqPQXfOn+q4sA0ClYlXq1j3xpOjGfs8vyY60UFlNQxATWlI0tiFcod
         C/aykedmoa9XPLl6ku3mZ6h6qsMnWxumOMCbi7ukdj8BXZhtM2bfbOqDdHkA9gR7CpX8
         4ATN+Zbvk1mMDJBhtwaIdgkiRX2ziT0FZE1nseUTJD+31uyd3OxLiMc4BAcBLvZt4s/t
         Kg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169033; x=1778773833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9N5PyatHch8RDJv+AhoksSBqwwK2QeOL5lSH2lbrAE=;
        b=AFvUenGyGzkg5sLPZQBYPuYQnF92br/vvfXUxnY6s+mfT7LCQJeeiEhSFsbISOz9bO
         9LJkzMcQ4JIBxwrPd+LTX8JCx2ZC/VJw95i52vtsj0PqfWqPjRJHnw6k+YPCEgDnrWHa
         p9DQZR5WAXaVvaCJ/Qap6Ug+csu43A4oGlKNvw5CqATkNZ7qP0HWFqDX4bWAQS+5nrqW
         uSNNKebHPgTcLnn6gCLaujD0J8pXdRgWijVOsbtPzXLzddo0QtPLP46LjfhBhPYkMGHt
         vppZ+QoJStAANi6j5W8u5U1/8g/tUBlUEmtOCA/d66tBjgSJY4tl5WobJCQBmv6LurrT
         R9Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+8KaAQlwFfGObya1DvNBonFeOThQ2w6ukb0I2u5ovQd6j/HxjC2mIeSuYCoGZePTfr93k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1WY96VnQs3flGJWu1b3PqqswlY2dsZuUdT+EAQm7hMb+ZvmQW
	+PAK+vQjnRBiSU4imtsVaJ/TiFzJ3YafYuVfGEAlDXvHy5beGhxuAK3+X0HdLW2H
X-Gm-Gg: AeBDievOvYKGtPjncLkWboDxfBR4CS4x3UeGrG0zQT1cSWwmw8nPTVnDKxMEn8HL3Om
	gqSom+EjWUNC2okCas1soyKYjPgCYZPIl1usEReQKYutzpcxAQe4/4GGXkL1ZJFNGn8nTdJOklj
	ioWnx9YZueG+moAWI4ZC7eYdwNJyXg/ARzuuBGwR1AefcAttCAcGLAdTe/BgJPI6MYpbxoZhSeh
	iXaAk4ZDImN1CMMljQRlBuS5o/ceaqktsvGs1I7EJuMVc2bBP8EtXGsVMqlWBdyc3hmOcQasazq
	h00cS23o/ItlVoNk/alSufwwHXqZ2OLQ8ZD3OCAgeO7ebW1CCKY7Jbgt0BzQ2XfIFrgkoE8LwzM
	BQvJEs4PKLmekEFlNKy1tDw30r2i8Tx9S5S01Z589imG2y7PTV6GROhi+XMeDiKr/SJYYbaCe8r
	4tW6kf1LL+hSYl7GHTGtWPT0M5rPd85j1718T72LKOFbhamEPpflx5jP4=
X-Received: by 2002:a05:620a:280d:b0:8cf:c1c2:90f with SMTP id af79cd13be357-904d3fa3e6bmr1286016085a.7.1778169033168;
        Thu, 07 May 2026 08:50:33 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a8161csm1917565385a.13.2026.05.07.08.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 08:50:32 -0700 (PDT)
Message-ID: <54d3c28a-040e-470c-b061-8d3a1cfe4257@gmail.com>
Date: Thu, 7 May 2026 11:50:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] git-gui: handle GIT_DIR and GIT_WORK_TREE early
To: Shroom Moo <egg_mushroomcow@foxmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
 <20260506202751.3294-1-egg_mushroomcow@foxmail.com>
 <tencent_16BC933B6ECB562A74F4EE334828A2D23605@qq.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <tencent_16BC933B6ECB562A74F4EE334828A2D23605@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/26 4:27 PM, Shroom Moo wrote:
> +proc resolve_initial_environment {} {
> +	global _gitdir env
> +
> +	# Only act if both GIT_DIR and GIT_WORK_TREE are set
> +	if {[info exists env(GIT_DIR)] && [info exists env(GIT_WORK_TREE)]} {
> +		# Validate GIT_DIR by resolving its absolute path
> +		if {[catch {set _abs [git rev-parse --absolute-git-dir]} err]} {
> +			catch {wm withdraw .}
> +			error_popup [strcat [mc "Invalid GIT_DIR:"] "\n\n$err"]
> +			exit 1
> +		}
> +
> +		# Change current directory to GIT_WORK_TREE
> +		if {[catch {cd $env(GIT_WORK_TREE)} err]} {
> +			catch {wm withdraw .}
> +			error_popup [strcat [mc "Cannot change to GIT_WORK_TREE:"] "\n\n$err"]
> +			exit 1
> +		}
GIT_DIR could be relative to the startup directory. The absolute variant should be
exported before the next step.



> +
> +		# Verify that GIT_WORK_TREE is a valid Git worktree
> +		if {[catch {git rev-parse --show-toplevel} err]} {
> +			catch {wm withdraw .}
> +			error_popup [strcat [mc "GIT_WORK_TREE is not a valid worktree:"] "\n\n$err"]
> +			exit 1
> +		}
> +
> +		# Use repository path specified by environment variables
> +		set _gitdir $_abs
> +		set ::_prefix {}
> +
> +		# Unset GIT_WORK_TREE to prevent it from being inherited by child processes
> +		unset env(GIT_WORK_TREE)
> +

There are many places in the code that have pairs of set/unset env(GIT_DIR) &
env(GIT_WORK_TREE).
Now that we have cases where $_gitworktree == {} and we don't want that exported, and
these are all unguarded.

Perhaps we need to create set/unset procs that do the right thing (setx assures
GIT_WORK_TREE is not in the env when $_gitworktree == {}), unsetx does not thow and error
when unset env(GIT_WORK_TREE) fails as the value doesn't exist, and invoke those common
procs to instead.

Mark
