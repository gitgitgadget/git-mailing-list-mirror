Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379721;
	b=rRv4DL3QIII73lTnLEF/MNJTlhUU9Te3+m95TKscx8txd6XqdkIBnEdXOawUX0ML3lWu
	 CxnHJF+vtlMvvZl7PH3RT/+lF5uTIq0aH5Gg5XecTCajzbGK6GHEZbF+d3W3oiBKcOhMn
	 jjUB99ncZcFDk9qcq8x59mRMdqI4psbQfi36DUoHaQbnsk+ClZJpwP/Xykkp+o/R6F58w
	 o56iSYuwRkz9XkHi1fAuLGuPbXRPJfSm20lASqEqNFRy7tuNs9j0aQiAaSO2hJhmmecR1
	 CPeafSlM95iKdN2t/j0LIUM/cJi7jm+TL/EZeiBNyeOmPNIzxojshiupzc9Eg3q20jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379721;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cyFP2F/zTbAYWpmkOrJRcqXV+LItK7iurfH6/WHjWkc=;
	b=r19WMJrMSWKqKFVUmbYZpyxk8MUTVYBKBBezv0Vy1V9NyHWMqv4y1X2Hh16Vubm6pwH6
	 LqFDLc/A2lkhCBYnRL6ZBWjRXss03D/dIPUn6rGI3g4UYUBz4i3b4FRUIRrfY3JsHh46i
	 tNBdeubLQc6jqznrgBWS7JafF4hmT3taFAzdlDupp7EI4rkigb9XD7Vme/MpMQzt3brKC
	 Q775AxcGhsRTHPZRQcCpmcC10czuNrO63JnXcRIBzGe9ry7294WCC2iJrOO3SxDRtMooR
	 wVEWTE2sPy6NZe4JsUSJcEG8Rr1N8Q4QnMmyk4lyHNgylvPVY1+e7itExbuAOtz9Vpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b="n5m/tkCO";
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE5606A327
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88DE5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=n5m/tkCO
Received: from [192.168.9.110] (198-27-206-187.fiber.dynamic.sonic.net [198.27.206.187])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AB6mVf0031567
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Nov 2026 01:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794379713; bh=cyFP2F/zTbAYWpmkOrJRcqXV+LItK7iurfH6/WHjWkc=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=n5m/tkCO7154eLUx12zDvVAD929/l72u7qqYimj4/60srqwD36GzrJed4M/uGBKHI
	 S/Elc1LuUXuWO9hiMqW+lkv0D4dhKuiDvRQDSuTrpkFPXHbISF1MpwtNWNC4ADxvqD
	 uGWii5bnatItsup3z1tkXbPwGIb+ZvUdxUepi+1h5S1ZZkhUiHDAqenpYjpTmTUI1b
	 O88p66ciFYdrZmE1x8w9uHAfE5oQMnJLrfIklqCQOcnfyYnUP7iU8EspVDiqcA5g16
	 LSSub2rLcCem3IPNN5Nwy6WgCeH4YHYjoPm7o/vNkY2P/RcYgTPN5myWriO2uISPrn
	 aFYS0oK1oGQmg==
Message-ID: <3e1639a1-2d27-4814-b57e-660e045da04b@mit.edu>
Date: Tue, 10 Nov 2026 22:48:31 -0800
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] worktree: notify post-worktree hook when pruning
To: domen@cachix.org, git@vger.kernel.org
Cc: gitster@pobox.com
References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
 <cover.1791152172.git.domen@cachix.org>
 <f7ead9bc-fe6e-49c1-bb7d-6efd14eb6766@mtasv.net>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <f7ead9bc-fe6e-49c1-bb7d-6efd14eb6766@mtasv.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/26 16:09, Domen Kožar wrote:
> +	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
> +	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
This substitution misfires if we’re inside a path containing another 
‘w2’ as a substring.  How about

     cp .git/worktrees/w1/gitdir .git/worktrees/w2/gitdir &&

(There’s already another instance of this bug in 
t2401-worktree-prune.sh, and I observed that failing in 
https://launchpad.net/~git-core/+archive/ubuntu/candidate/+build/33960210.)

Anders

