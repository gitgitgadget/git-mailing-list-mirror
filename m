Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D028030E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408780; cv=none; b=X8oitDvgEflTMtBzcSub4Ql545NUJmMwo380Nj2479XDFSwF9gx9IHcWlsNbm8BVw9XuyW3JrkfXUTcAs5SzeRY8ArVcNHjxQnEQ7HgWJRkkcRdphOj1mMAOFfrNCH9CWsott1owlHxVotgkmsW3XvKgKTw5SKXqoPuj9MyxL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408780; c=relaxed/simple;
	bh=7EbV1OxY262sZP1xZi+TTszsQrejp7Vs2d9HB/9A46g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j5m7/wJ1rwOmy1/kW+KtW5u+DjYQrXweySJd59a5i7xPpRBrIMlWKRxXm3NyIySzBEAsuX36VUMBLgQM1RdRJ6YWts/2pXyKYvcAqgErcwK9c84fBBDbvVDaaaFXYVBxdf31e3BnVcn98h49GMBYgVYBGzcDCk0qMoQoHjlDYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; dkim=pass (1024-bit key) header.d=rawbw.com header.i=@rawbw.com header.b=JtG5EPzA; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rawbw.com header.i=@rawbw.com header.b="JtG5EPzA"
Received: from [192.168.5.3] ([24.6.215.85])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 63SKdbgA055933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 13:39:38 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rawbw.com; s=apr2026;
	t=1777408778; bh=7EbV1OxY262sZP1xZi+TTszsQrejp7Vs2d9HB/9A46g=;
	h=Date:To:From:Subject;
	b=JtG5EPzAS1Qvq8Hy3kNTTVKNq+dtSgbtjCcn/wpGraiJgf/CUHoFTDR6/BRQPCPNf
	 lsjIpjsfbBJyNTaUeY3zxd6DFhPM3Jzaa6Trn002FdSNxPX3YQHDt1cEJmXJ599YVP
	 C+5ftsAPSslZkgzpKMB5wowmRrHlhk9ad/NSo4TA=
X-Authentication-Warning: shell1.rawbw.com: Host [24.6.215.85] claimed to be [192.168.5.3]
Message-ID: <a650d44b-1ab1-4a20-9b17-c82cea604acb@rawbw.com>
Date: Tue, 28 Apr 2026 13:39:35 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
From: Yuri <yuri@rawbw.com>
Subject: git commit silently fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,


I was committing this way forever.


But today git failed:
[yuri@yv /usr/ports/devel/catch2]$ /usr/local/bin/git commit --verbose . 
-m "devel/catch2: update 3.13.0 → 3.14.0"
[yuri@yv /usr/ports/devel/catch2]$ echo $?
1
[yuri@yv /usr/ports/devel/catch2]$ /usr/local/bin/git --version
git version 2.54.0


No error messages, no verbose messages, just failure ...
What might be wrong?


OS: FreeBSD 15 STABLE amd64



Thanks,
Yuri


