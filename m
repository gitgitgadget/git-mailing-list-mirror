Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBF1CDFD2
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937286; cv=none; b=jigHGZ9oRigwpdWUPzk4ViI+FikghesTBunh0Suk4dwATeZABfpdUAJdniZMhcffHsCdE3xWz1ws0PuZJiMyMeMPRh8zLmkbXOjU+lfGNyDGfyHXAW6qB0z6b97fvWWm4Qo0z55WMVU1sxrELFwUDO+qRb6Xj3bJDPnVVDxg0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937286; c=relaxed/simple;
	bh=E+UrGV6ncfGRtWCkc4Cjz7w67SgVxPQjoF9tVmWdI7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC0g7z1YmqjUSWnpikKzvyWWMbrAh7IOte6OouvWExLoqH9nAFkghhCQn8yuS4UPR2v8IiHQjA8mCiN03HpxlXYACGw5/ZNdEZ76dJgOkeVAwjnm8Y0J/3zS5VtrotkdXek6/tSJmqN4ImdCFEE35HLZR1E3JJ5eQe/MhVa5uEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=CT5O6FDD; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="CT5O6FDD"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 0RW6tzzWxy9pX0RW7tmNf6; Mon, 14 Oct 2024 21:18:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1728937093; bh=dm3I8GC1aoNwslOv7uxH/h/Q7qXAMMq6FLsjygNRhsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CT5O6FDDgTqRe+0if0IRzoNDUWsGyiPg2OmRS5uH0JuzTaFKvrAESNbO55LI2QrNj
	 vfESgn2RsG+02EgUXoP6lfrO7tkQTgj98E8sq/ztAqOuY7KmOS6Mocx4mZCa4tCOMW
	 gQ1YG9ISIxCqmhJb3NAqwlztlrhI4A9ONQhwBuTAdwDAnmYGVx7lDpCzVlTYVeav9I
	 MnphM4K/qaw85QlGzZ4IJQJc6qL8Up1Ya3aKY6aVW7UFMmhH5VMldDEJf7fmx43ySK
	 UZb+ekLJukdl48fgGvYwCD4FeAT2jzeo7HGCb6nAWEP004fSKVl71hkVWrdJjSUAOA
	 YPWWmcd/5pWbQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JYgfrlKV c=1 sm=1 tr=0 ts=670d7c85
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=dYdzlRXR2cQIcYpYj_oA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <4dd62151-38d8-48ac-b5ad-d8e2d00fa820@ramsayjones.plus.com>
Date: Mon, 14 Oct 2024 21:18:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modernize the build system v2 problem
To: Eli Schwartz <eschwartz93@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>
References: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>
 <cd118725-f820-494c-8d10-81aba32e4064@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <cd118725-f820-494c-8d10-81aba32e4064@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBmiIX+o/9ms+8713a379dN192oKz0iQ59imbH3Aumc7TQFtb438oJq/tpG/l4lVRPzWdLodUbqmpt5GFdyJc0jXFAiYXFiZh8668DOSIi198U0o3Cht
 9esWjZbXhygwlq/a1OrLDw4LZPk2YrC0p4iQkWvURXcLe6bIpSKSbWB52B2hybQ6qNhXMa0wLtTEqYAe2zb/Fa/d/yD84/uPm7U=



On 14/10/2024 20:19, Eli Schwartz wrote:
[snip]

>> So, keeping in mind that I know absolutely nothing about meson, it seems that
>> the 'configure_file' function is mangling the 'gitweb.perl' file. I assume
>> that you are not seeing this, so I suspect that you are using a newer (fixed)
>> version than me. :(
>>
>>   $ meson --version
>>   1.3.2
>>   $ ninja --version
>>   1.11.1
>>   $ 
> 
> 
> I recognize this: https://github.com/mesonbuild/meson/pull/13302

Yep, that looks pretty much on point. :)

Having said that, after squinting at the patch text for about ten
minutes, I'm still not sure it would leave all valid perl syntax
alone. So, ...

> 
> Note that for files which can change semi-regularly as part of
> development it may be better to avoid configure_file() and create
> something like edit-files.sh.in which then produces build rules, not
> configure-time changes. This would sidestep the problem entirely as
> you'd then process gitweb.cgi via e.g. a sed script.

Showing ignorance of meson, I don't quite follow the 'edit-files.sh.in'
suggestion, but I had intended (before Patrick's email) to use a script
to generate 'gitweb.cgi' as the 'command' in the 'configure_file'.
It feels like you are suggesting something else.

> (The main reason though is because it avoids reconfiguring meson when
> the gitweb.cgi script is modified via a patch / git pull.)

Thanks.

ATB,
Ramsay Jones

