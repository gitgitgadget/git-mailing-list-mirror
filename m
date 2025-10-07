Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92202155389
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858887; cv=pass; b=FXw4SmQYQCTFY7RtqcllfFjmmAOJ4AuVJgo8mXqyAGCXNdexNEfHQRBw3xGHoEFm5QO6tD9Ed5sZwWUB9lURqWF3nXjh7DEbE3zg2YInuI9OtgT7bZiiJPFoIIYRIWjb8cz2GRb8dyo1zU3LN9xYhKqcboy8Zz2OiFVqK4/zv/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858887; c=relaxed/simple;
	bh=AhcJ2lFZcgrg021Hvo1x7tSIasbAR+p8JV+UYjNEWME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qE3Apm/M7hoik+s0TthVSrtRBwDLWIgVPqw5gVT0YX8/A2rz/HKKdsA0U4cKkUcLWPC1XIBFmjNoYAtsMBg7g9AwINAPBRaRQejQeesHBABVqAiJZ6Ao44oC1ArmWbYc5wqhCnVeIE8/3RSevarGXRO83rNnsrS0U4Mo4yl/mbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=dk2M2gG8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="dk2M2gG8"
ARC-Seal: i=1; a=rsa-sha256; t=1759858869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dzrR6lHHsSsRoCKPM04boaRmEYhpXE3xe1J579muMCkJ+n6C9HzJjPRMIBLNxfMr0kp+3rmhR9MZdaU+6UXh4Av29j1ggOmHCpbUFKCJRDBG2SAUo3m5rxXTrkW/ZLg+Y7+P7UmstvrLOYhTyZntIgs851diLAUR8sTOr4wn2+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759858869; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZMywTciLpqLK9vh8eR56SVtQRmBKaHFqfXhtrQegIMY=; 
	b=UbkdlRSZhZg++Yh0jHoBgQxc2XDE6uuKL1jTy6f8ArZXT3IKp7qjktf89T71Oy/jGMjOoLSkEWOacya2BWgRtzjJuux0Q5DaDhAE/ofT3AVp+w/bvTQo3YfuxiEcvEtal3aYIdBhC1oH0EDkR4BFPnPvj/3LoQpQhHDt3iW8O1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759858869;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ZMywTciLpqLK9vh8eR56SVtQRmBKaHFqfXhtrQegIMY=;
	b=dk2M2gG8cJSXX4G6TtG5HkDNzxwc5hCdI265kWHZpB/ILFVv1+tNvF3wH4aSwuW4
	5BrnYwuz4D/WTynWmtVNwtG/3FT+TqZ2LFP0WN5H9WZhVfWAOfC17s5GJAydDl/ciCN
	0aueXyzGnPMADVewaM5NQZxVZcpnA+nEQvEk0BSU=
Received: by mx.zohomail.com with SMTPS id 1759858866498781.0752848622795;
	Tue, 7 Oct 2025 10:41:06 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/5] submodule: encode gitdir paths to avoid conflicts
In-Reply-To: <xmqqo6qik4r9.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-5-adrian.ratiu@collabora.com>
 <xmqq347wq87s.fsf@gitster.g> <87cy6y4xb4.fsf@collabora.com>
 <xmqqo6qik4r9.fsf@gitster.g>
Date: Tue, 07 Oct 2025 20:41:02 +0300
Message-ID: <87347u4nkh.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 07 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> I will percent encode the upper case by modifying 
>> is_rfc3986_unreserved(). 
> 
> Again, do we really need to encode everything?  We need to only 
> when (1) there are other submodules that would collide with us 
> (e.g., by being only case-different, or by having our name plus 
> a slash as the prefix of their name, make us overlap with them) 
> or (2) our name is not filesystem friendly and needs munging.  A 
> letter being in an upper case is not a crime. 

Right, I see what you mean now.

The problem becomes how to detect (1) and (2), for example: a 
specific name is filesystem-friendly or is case-folding happening 
or not?

(ext4 for example can be mounted with casefolding on/off)

This is not a trivial problem, however I think it is solvable. We 
can write a few runtime tests to detect things like case-folding, 
to decide if encoding is required or not (better ideas welcome).

On the other hand, by always encoding everything we avoid the (1) 
(2) detection problems. :)

> 
>>>> For now url-encoding is the only option, however in the 
>>>> future  we may add alternatives (other encodings, hashes or 
>>>> even  hash_name).  
>>>  Let's not say "For now".    Choose a single encoding that we 
>>> can use forever so that we do  not have to upgrade 
>>> extensions.encodeSubmoduleName with suffixes  like 
>>> extensions.encodeSubmoduleNamev2, 
>>> extensions.encodeSubmoduleNamev3, etc. to cover our earlier 
>>> mistakes and force renaming on users.  
>> 
>> Understood. Will drop that idea. 
> 
> If we are to consistently use submodule.<name>.gitdirpath as the 
> authoritative collection of name-path mapping, then the exact 
> algorithm to derive path from name can be improved over time 
> without having to worry about an old submodule whose path was 
> computed by older iteration of the algorithm colliding with a 
> new submodule whose path is derived by the more modern 
> algorithm.  So I do not mind to make ourselves aware of the 
> possibility that we can tweak and improve.  But as I said 
> elsewhere, I do not think we need to even say what exactly 
> algorithm is used to the end-users. 

Got it. I'll do the submodule.<name>.gitdirpath centric design in 
v4 and will not mention the encoding algorithm to users.
