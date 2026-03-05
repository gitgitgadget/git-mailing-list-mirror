Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE239E18D
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718081; cv=pass; b=X1M1+FZa5RnvUsPwUdEkiEOa9piQ/3i/VmeVBIvE9aK/SRsS1juw5fzlFVHzUl8EN7XFpEamQms8pGctmNw48DZmyLEP1+Z9iujbeUEZs9m3JAu6ygQSw+uMPoKYkLzytIshzT0RF6oSm18cDBnbhbiFCcwzbojrMDCXbxXyQNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718081; c=relaxed/simple;
	bh=s2690MZEczgI9xdOHkEWHI3c9skuduyLkWZRkKseqwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKEL4T0qr2dI0mldVG6clEdu6FkBmMAXY6boFXE1aTUDadbRhDez9MBtHt3ksRptMan/NjO5RNqNkpmccuPACwbL/Dxl6/JFageXQmRXrvVovm1D4+5+fF+Q9+CKXdO5vYfb1UPBJSvShHvxPkI/D/p6e/enAeCXDvc5kF2le9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WVxnGXAv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WVxnGXAv"
ARC-Seal: i=1; a=rsa-sha256; t=1772718071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f2xkUgtVnM/2hnuni3UMmnhVJW+nrcyeOc8Vikz+DHzhsO/wH/Z31nnbAVk9RmcdM5LB4Zcuia8YlzyGl46gpZSwptlktF321a44F6PtVMZtusVj+NVuASX//HD/0UWuEkz12bVpDkqyPUDFeCaQbLRRCADoIyhdlsGVXi/cMv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772718071; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D2cRPxOXa5EtrYFgvFslihq02QZXAhMhGxgld55nxBw=; 
	b=DQur3z7ODoSUQJusMrHfjuk7JWL4Qr2P2H0ENU6X355JseKrnjBE13dpXTIX5sXX+Ak2lTYmCXP6S5BVJeuen05Beh9lhsksj/g5rEFYntGTk7L3YYDZ0FMMbfcIZvwj1HqI1BHXUoHXb07DJV1xZMWBRkRdivcQLxkioTdvXtk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772718071;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=D2cRPxOXa5EtrYFgvFslihq02QZXAhMhGxgld55nxBw=;
	b=WVxnGXAvcIKJ0cf5/GhnJTYbF8pH70WHtudhNPnLwws43w9PnzzKOh6Q2FjjCAAr
	DFQflwdIltUUQK8QRueIc80rPNM5VEAzRow9BwGIINH4giN+th2KVC+16sg8YB8cVqA
	MxWGHe6UIZtQ8gM8Y9HApjHR6UoZjUQXZX/Wo+j8=
Received: by mx.zohomail.com with SMTPS id 1772718069381344.78776630816117;
	Thu, 5 Mar 2026 05:41:09 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Chandra Kethi-Reddy <chandrakr@pm.me>,
 Chandra Kethi-Reddy <chandrakr@pm.me>
Subject: Re: [PATCH v5] add: support pre-add hook
In-Reply-To: <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com>
References: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
 <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 15:41:05 +0200
Message-ID: <87o6l2xuku.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

Hi again Chandra,

On Thu, 05 Mar 2026, "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> Range-diff vs v4:
>
>  1:  9383395bb0 ! 1:  fc58c4cba2 add: support pre-add hook
>      @@ builtin/add.c: int cmd_add(int argc,
>        		string_list_clear(&only_match_skip_worktree, 0);
>        	}
>        
>      -+	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
>      ++	if (!show_only && !no_verify && hook_exists(repo, "pre-add")) {
>       +		run_pre_add = 1;
>       +		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
>       +	}
>      @@ t/t3706-pre-add-hook.sh (new)
>       +	git commit -m "initial"
>       +'
>       +
>      ++test_expect_success 'hook found via core.hooksPath' '
>      ++	test_when_finished "git reset --hard &&
>      ++			    rm -rf custom-hooks &&
>      ++			    git config --unset core.hooksPath" &&
>      ++	mkdir custom-hooks &&
>      ++	write_script custom-hooks/pre-add <<-\EOF &&
>      ++	echo invoked >hook-ran
>      ++	EOF
>      ++	git config core.hooksPath custom-hooks &&
>      ++	echo changed >>file &&
>      ++	git add file &&
>      ++	test_path_is_file hook-ran &&
>      ++	rm -f hook-ran
>      ++'

The test you added is rather surprising, was it written by Claude AI?

For clarification, what I asked for is to add tests which define the new
hook via configs like done in t1800-hook.sh tests, for example in your
case, you can define a simple test like this:

test_config hook.my-friendly-echo.event "pre-add" &&
test_config hook.my-friendly-echo.command "echo hello from hook" &&

See Documentation/config/hook.adoc for more details.

The turnaround in minutes between v4 -> v5 is also surprising.
Please give humans a chance to review & respond, at least a couple of
days between resvisions. :)

Thanks,
Adrian
