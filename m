Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2105223
	for <git@vger.kernel.org>; Fri,  9 May 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804397; cv=none; b=KP4wNL/ao2mSpSUsuPrGhUnlMI/UZ0WXSglrDwIwFfPzFbaM6HfHkqVJzS+VkrzM9mgHUDeuGllvWjIz62rgECydq2pG4uMHH1tz9wB3JQi3xXQycart5Dq7vRmr4vBPGR+R8YxZg6oPDN7tEk9YAsJBHwSf54aGCwWxIwpvi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804397; c=relaxed/simple;
	bh=iV7yvqqZR5pq4qWD/BhNzfcmy/bxo4mJ9u1ncRyEDvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njS/7VlwUtW0WzUWCRC4PvwdT51tUOmVu5EIx7cGn18JjdZRxtxokDpGqJAW5yrnyla5uyzlTrCikZe3QAiFzKBkd4VPMaZH8jd5Ak+yfSYT5olmsZKI7aG47YD9caLnXHQMbIY7eIB4ayApQN5e1CiHytJ3CP9V9c2chMF4G2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nnute47q; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nnute47q"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id DPZIuKKykXacADPZJuVBvk; Fri, 09 May 2025 16:23:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746804205; bh=rbX0fkicpGeCj+34fd4aUSaLQmuf8fISpc900XnAXrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nnute47qqDvXGlyn8fxSx5OItc/YMvv1teFa5kWKqgG/KvpiSovaoAxKPYiSGUG7L
	 mI2TcDob0h84ZRNvt2PZ/MRslREqLQ/EQp/T1M49QPsPumR9QtOqRcmzzbZ+1IwIXR
	 TAJFx3OuPc21IeiOKERkoFsvb6qRrkDqngVQGIvZ/3f4rrCeIyI7a5qHmfhSA230zq
	 MRANEVHg7aSEj+wi1bdjNMlSGfiY3fq16+/BOdmJOApHjkQQoRismRc7fgMv1a6pfr
	 aI+FylbMF4tlz3sCvcN6hckGRudVBHDKbZnAtdcT3mZDBEJiiF0ivHPuNm6KIf6yCX
	 8RoO8GpYpaeJQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=X9rxK3Te c=1 sm=1 tr=0 ts=681e1ded
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ukH1R-b_AAAA:8 a=kEb-AwymRv2rEsFlSO8A:9 a=QEXdDO2ut3YA:10
 a=Wk8CdDEMYW0A:10 a=zUGFzhdS3I8ccRoxxLmr:22
X-AUTH: ramsayjones@:2500
Message-ID: <348ccba5-66c1-4c09-a478-3cffdd862d8b@ramsayjones.plus.com>
Date: Fri, 9 May 2025 16:23:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] meson: correct path to system config/attribute files
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Eli Schwartz <eschwartz@gentoo.org>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <aB3CDOljn9zJsVwt@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aB3CDOljn9zJsVwt@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHj8XZAGDyuRKW65vmkfOI95XYU/09k/CbutLLwaongnvjUSmng7Ew76L1XgG48OcdeK+FKCV6rwBdB9gsLy8l9SyN0V9HWh+WkZdDmHQt+g2DzBJIU2
 N9jcSye8aMm6DERVhZwvfRe0fW0KXbS28D5ED2Y7a9x404jhWW4rBWYkqFCWD+vbFIu0DVuuTK8rBtUmKt9S5/t36kZjpxZs7V0=



On 09/05/2025 09:51, Patrick Steinhardt wrote:
> On Thu, May 08, 2025 at 05:44:37PM +0100, Ramsay Jones wrote:
>> diff --git a/meson.build b/meson.build
>> index 48f31157a0..106cb17612 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -757,8 +757,6 @@ endif
>>  libgit_c_args = [
>>    '-DBINDIR="' + get_option('bindir') + '"',
>>    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
>> -  '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
>> -  '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
>>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
>>    '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
>>    '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
>> @@ -769,6 +767,18 @@ libgit_c_args = [
>>    '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
>>  ]
>>  
>> +system_attributes = get_option('gitattributes')
>> +if system_attributes != ''
>> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
>> +else
>> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
>> +endif
>> +system_config = get_option('gitconfig')
>> +if system_config != ''
>> +  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
>> +else
>> +  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'
> 
> Instead of `get_option('sysconfdir') + '/gitconfig'` you can say
> `get_option('sysconfdir') / 'gitconfig'`. It's a bit pointless in this
> case and not really needed, but '/' has some special magic for handling
> absolute and relative paths.

OK, TIL. I just looked this up ([0]) and I am not sure such 'magic' is
always a good thing. ;)

[0] https://mesonbuild.com/Syntax.html#string-path-building

>> +endif
>>  editor_opt = get_option('default_editor')
>>  if editor_opt != '' and editor_opt != 'vi'
>>    libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
> 
> Nit: let's maybe add an empty newline after each of these blocks to make
> it a bit easier to see where handling for each specific option stops.

OK, will do.

>> diff --git a/meson_options.txt b/meson_options.txt
>> index 8547c0eb47..4d78d4c7ac 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -3,9 +3,9 @@ option('default_pager', type: 'string', value: 'less',
>>    description: 'Fall-back pager.')
>>  option('default_editor', type: 'string', value: 'vi',
>>    description: 'Fall-back editor.')
>> -option('gitconfig', type: 'string', value: '/etc/gitconfig',
>> +option('gitconfig', type: 'string',
>>    description: 'Path to the global git configuration file.')
>> -option('gitattributes', type: 'string', value: '/etc/gitattributes',
>> +option('gitattributes', type: 'string',
>>    description: 'Path to the global git attributes file.')
>>  option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
>>    description: 'Environment used when spawning the pager')
> 
> Makes sense. Should we maybe document the default values here now that
> they aren't immediately obvious anymore?

good idea.

Thanks!

ATB,
Ramsay Jones


