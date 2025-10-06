Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4C199237
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755587; cv=pass; b=rgbp9nLHLt9TtNnXXXHQeZOKwN2Nz9cgD3oR8vdAORy8bXYFGEw4ydBAZEC9FH7Lg7CeJqLUlWbAHfGJyk+vJeVCetleHxlPTbRx11wi7GyXCLMovbx5ibw1vYy1Mil9zKpA051Je9YDi14rgemBj8RrALJnKTYJvE/ekRwZ7oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755587; c=relaxed/simple;
	bh=/37wwPKig3XI0NGY4jGY2iL054l+fyq+rVdyqViHqIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jb4K7LjZIpxbrjqRi8pnmlRHMWJITNy7C3NbFjjY/Gu0iH8AO/r7saG829Me/30uZUtPM3LiMce+iF877ImVsw3dBAiJux9tbWc60cf6E7jLFmlPr/H1B6Uf7/D13j9wRRM2NDAyF0IfAE3S9e0oiy0Zw23O4KnH6duMVpDhpxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bMQXn2jP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bMQXn2jP"
ARC-Seal: i=1; a=rsa-sha256; t=1759755573; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RJLtgUGHCLVpWy/JRaNjdMv7z0h1/eups70kvldhCKC1OVnXPRJ35NDyxHOxHuModHxfD5jac1Iw0bjeqiT5m1zfjbHK3fGXwQ61CW19wDafE5bCAewEi3CetIWa5a2gUqxHuZoKJTPjW1y2cOgzv9ufR6DM6WSjKtpSgeHEur8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759755573; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RDhk6OpmwduBoMXKF/oOhnaSasXdrfyvkoMvkCCG5eM=; 
	b=M0EsY/nqzJrRk2qOf55NcoPTVM9WnSo38tqS9/95tylrQgDex2Dxwu4M707Lr85/QzXsK5vw731Co/qEOjrPw/VSfCSeFgc12Qs18qXBQwF5v5tvmQ+GxD2BFebjL8cmGqhRUEa5EZ3XgOylKfg+eQ37GK5UVWcc4lKmgCYM6Nk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759755573;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=RDhk6OpmwduBoMXKF/oOhnaSasXdrfyvkoMvkCCG5eM=;
	b=bMQXn2jPTtOAkavgs+ieFG1TiJub1j63NTaPA9w9GLJCxg5jDx9FeYiZ+qZ+4fVq
	NY00XB3BgnFUyFutNdn0QnYROKeGsjBotLj7q47j8Dqz+LyOPr2ZyR7T7RJwTqqbrVd
	7Hu9vUL7/S4pmGLU6RmuOlFJg1LIFOPyU0eLp9AE=
Received: by mx.zohomail.com with SMTPS id 1759755568777962.398220190538;
	Mon, 6 Oct 2025 05:59:28 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/10] run-command: add stdin callback for parallelization
In-Reply-To: <aN4c6l7gRi4auss1@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-2-adrian.ratiu@collabora.com>
 <aN4c6l7gRi4auss1@pks.im>
Date: Mon, 06 Oct 2025 15:59:24 +0300
Message-ID: <87v7ks424z.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

Hi Patrick and thanks for review! I'll fix in v2 all the issues 
you pointed out.

On Thu, 02 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
>> +		 * child input is provided via path_to_stdin when 
>> the feed_pipe cb is +		 * missing, so we just 
>> signal an EOF.  +		 */ +		if 
>> (!opts->feed_pipe) { +			close(proc->in); + 
>> proc->in = 0; 
> 
> Hm. It's curious that we use a valid file descriptor 
> here. Shouldn't we rather use `-1`? Otherwise I could see that 
> we might try to close this seemingly valid file descriptor at a 
> later point in time. 
> 

I actually asked myself this while preparing the patches, since -1 
is a better fit.

I only left = 0 for historical reasons, to not modify these 
patches too much. :) However I do 100% agree with both you and 
Junio that -1 should be used here.

Will do in v2.
