Received: from mail.codeberg.eu (aburayama.m.codeberg.org [217.197.91.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A314B96E
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.91.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625608; cv=none; b=mVx0ls4J/rNbxkQh9mFB8ArULWc0f5XS0eM/801TH8LFNqrQF9sYE4aMKwFZCfutvBuryddiR8fOhWhzlLlto9jAn7KcaHPF8/vkmIGB+mrz0BCMORvNROMHCSEMWaN5YuvQc4pAdtK4C2HWjE9vAsqFO2DCqv3Lz2qZfaBnVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625608; c=relaxed/simple;
	bh=PbLMB7KZcEmbxV7DquFGH3PhZbNtbLCfjXAfDvyMCis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwP7MmbLQDCnjlnTRx4coTLlmzGo0nkvqKvl5ylSXE6eQWW/sXAA12fTlHzDcfqqCe1LQCSLrpARz9RoPKjt0lUUKxomioLHkmt0RasxxI+7JFfdP2pdlbpEMN93S527dNsTHHN62WXiD/1FwYkLQrB3Ap4rBWRKZ86SCyPT9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org; spf=pass smtp.mailfrom=codeberg.org; dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=pjTff/Ln; dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=htVVQp91; arc=none smtp.client-ip=217.197.91.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="pjTff/Ln";
	dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="htVVQp91"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767625599; bh=ngrzzIIH/duooxjHHyPAgi3
	3IK6wZhyFGCEzzFP7gA0=; b=pjTff/Ln72lxA8eRz5FkTTxyaOT+j9xfC5k/O9QJVD5J91wXOl
	TR2v0CrA6vBQSv9Fo4AmV6Kjtmt9l1Ec6jNdDxnJZolKs1RJ/LP8ScqVnRwgZFERkxtBkiBjyVN
	7IAJTLn97mLyC8iQxD4RmPMjL21+NocH8SiRnI8e2uTid1xOCSFDhGO84XpsvHJnyUX7vLdR7PK
	1xDdYEQj+nU1Uxr0rTeXjdkY/uO/OKpixxHjeN2gKhg2F04+JSLNG+ZTC6x4uCXflirmBERfJ03
	8PQyNveM1yucXhcF6goOenOPkMC9EMFG0qhbhS7RYIOuNW2KQiCdIZxIRBYCAZLWOZw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767625599; bh=ngrzzIIH/duooxjHHyPAgi3
	3IK6wZhyFGCEzzFP7gA0=; b=htVVQp91Nebo5XR6pKEql0ieIOUKEMQFWSYs2O7JbbcVyAP+b0
	Z9BgxP29Wg20t3yuwGpd2bxtV9+GOQfqX4AA==;
Message-ID: <8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>
Date: Mon, 5 Jan 2026 16:06:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-last-modified on bare repository
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im>
Content-Language: en-US
From: Gusted <gusted@codeberg.org>
In-Reply-To: <aVvSwkK7RdpFDaVv@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 4:03 PM, Patrick Steinhardt wrote:
> On Mon, Jan 05, 2026 at 02:35:56PM +0100, Gusted wrote:
>> Hi,
>>
>> Now trying to actually make Forgejo use git last-modified after being
>> pointed to the non-yet-documented options but I quickly noticed that it
>> looks like it does not work as intended on bare repositories when looking
>> specifying files.
>>
>> $ git clone https://codeberg.org/Gusted/math-accuracy
>> $ cd math-accuracy
>> $ git last-modified -- LICENSES
>> 768f05837e7db2832425bc3b65d0f524e81b2769        LICENSES
>>
>> And on a bare repository:
>>
>> $ git clone --bare https://codeberg.org/Gusted/math-accuracy
>> $ cd math-accuracy.git
>> $ git last-modified -- LICENSE
>> fatal: ambiguous argument 'LICENSE': unknown revision or path not in the
>> working tree.
>> Use '--' to separate paths from revisions, like this:
>> 'git <command> [<revision>...] -- [<file>...]'
>>
>> Is a worktree required for this to work?
> 
> A worktree is not required for this to work. The problem is that you've
> got a typo in there: you say "LICENSE", but the actual file is called
> "LICENSES". If you spell it correctly it should work alright.
> 

Ah, sorry the typo is on me from copying the wrong command from the 
shell history. It produces the same output with using LICENSES as path.

$ git last-modified -- LICENSES
fatal: ambiguous argument 'LICENSES': unknown revision or path not in 
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

>> Because it was talking about revision, I quickly checked a refspec as input
>> and it looks like I found another way to trigger a BUG.
>>
>> $ git last-modified -- HEAD:LICENSES
>> BUG: builtin/last-modified.c:456: paths remaining beyond boundary in
>> last-modified
>> [1]    202076 IOT instruction (core dumped)  git last-modified --
>> HEAD:LICENSES
>>
>> On the bare and non-bare repository.
> 
> This looks like a bug to me indeed. Cc'ing Toon.
> 
> Thanks!
> 
> Patrick

Kind Regards
Gusted
