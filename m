Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D9221271
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673371; cv=none; b=qUL+z8MNJG9uaxbq8+cELDvQuf44Rd2FPu8BGzMR1MfU/N5KkTCQzEqUYAzx/usoGfu+17/Qlki8f0oB7huS1beYoMlvanWopEkx9pHcWUfaaIg7V3FMPp5Cysujtq+cMbUjDhzj2fh17sDadykgYUmcltxcTuxuXXYKJ385fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673371; c=relaxed/simple;
	bh=huGNj6NJjXMVnv8gAx5svb2pZINQQWmyUpwG6x+lNbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TzgvhDs6TF59JXIr8jDR/qQ2YQPd7IpHGUVAITpy0BU1yCkE9JLVwlz3f6PJAgr10fVxqCUmLHgP1zDOEJtg8Xh1Pcj9YK2ba45q/sRdub6lsyJuDIRrAX0m/+ES98s/BwUTHLLI4Fq2EZ0f2HvmOMmabQ8Z9JU0l8xSJXAhJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=J/eAJojn; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="J/eAJojn"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id MC0TvuzihEAJ1MC0Vvej76; Thu, 20 Nov 2025 21:15:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1763673359; bh=sA6Fi0E7tbSdlacxUSpOfQ+QBpD5hcMRsgKEybhHSt4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=J/eAJojnpjf/w26QYaHDRh3OK7Blc+INzT6jYENYxoHKFjj63/5n2ejRtJNp2wDgj
	 KcG+8MggJjSzyHixWSVsEkFSq+IxRK4dX3imQbcszFVCwT12CbJ+343WeS6gqGUFrE
	 duHFclhurd0hDUO1OA4uGg38BjKPelaeejl7NTI1dE/bMSCdqapLIsyeg872CA5bW3
	 htSzjI4+OnTOjLpidPJZsAKIKpGkTH2gmV0BABUS8qzpQLEwJprhdPI8mx/10LbMT/
	 0OavJ41tA9PvaYLvOHH35UkpkekG7c0VHPRIb6qudEwPWBn5LsHBIzFXiy8vSqEc2I
	 TQ5eENlW7PSrw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NOl2+F6g c=1 sm=1 tr=0 ts=691f850f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=-WYQMsXXwuiOJqZiOigA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <e67ee4f6-9516-4561-b9f4-06e9049ff2ba@ramsayjones.plus.com>
Date: Thu, 20 Nov 2025 21:15:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config: mark otherise unused function as file-scope
 static
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtsyo7b4y.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqtsyo7b4y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIYTa/07Po8QxDsVjiB7KyL+eTY8jDEdnQxlyCrQ5s9o05LZm+VnWVSVTkEFlE9tkR8EYRk33iDAV4+ZkI67WnlTiXT7ogjvl5o96SWN9jcepBMifjt0
 5sskkUZzNZQqYXxESgg8WewMuaFaGVcKT2838VXfr8tQVs30L1gwzDKnsSKZbQf5v3P1scur7BM+Ly+x8wbSk7EcLd3tKOzvE30=



On 20/11/2025 7:32 pm, Junio C Hamano wrote:
> git_configset_get_pathname() is only used once inside config.c; we do
> not have to expose it as a public function.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Not related to anything in particular, but something I noticed
>    while I was in the vicinity.
> 
>  config.c | 2 +-
>  config.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 

Similarly, not related to anything, but ...

I have been meaning (for years and years) to look at all of the symbols
that my 'static-check.pl' script produces to see if any of them can be
treated similarly. Note that there are a few ('sc' for master branch,
'nsc' for next branch and 'ssc' for seen branch):

  $ wc -l sc nsc ssc
    102 sc
    102 nsc
    120 ssc
    324 total
  $ 

The symbols from config.o:

  $ grep config.o sc
  config.o	- git_config_from_parameters
  config.o	- git_configset_get_bool_or_int
  config.o	- git_configset_get_int
  config.o	- git_configset_get_maybe_bool
  config.o	- git_configset_get_pathname
  config.o	- git_configset_get_string
  config.o	- git_configset_get_ulong
  config.o	- git_die_config_linenr
  config.o	- repo_config_copy_section_in_file
  config.o	- repo_config_get_bool_or_int
  config.o	- repo_config_set_multivar_in_file
  $ 

Note that the 'seen' branch add quite a few new symbols:

  $ diff nsc ssc
  0a1,2
  > add-interactive.o	- clear_add_i_state
  > add-interactive.o	- init_add_i_state
  38a41,44
  > hash.o	- git_hash_alloc
  > hash.o	- git_hash_free
  > hash.o	- git_hash_init
  > hash.o	- hash_algo_ptr_by_number
  52a59
  > packfile.o	- mark_bad_packed_object
  54d60
  < packfile.o	- packfile_store_close
  84a91
  > setup.o	- check_repository_format
  85a93
  > setup.o	- setup_git_env
  99a108,117
  > trailer.o	- blank_line_before_trailer_block
  > trailer.o	- format_trailers
  > trailer.o	- free_trailers
  > trailer.o	- parse_trailers
  > trailer.o	- parse_trailers_from_command_line_args
  > trailer.o	- parse_trailers_from_config
  > trailer.o	- process_trailers_lists
  > trailer.o	- trailer_block_end
  > trailer.o	- trailer_block_release
  > trailer.o	- trailer_block_start
  $ 
 

ATB,
Ramsay Jones

 
