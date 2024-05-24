Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071991CFA9
	for <git@vger.kernel.org>; Fri, 24 May 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575266; cv=none; b=JRH6OGY5z4ryhl4blZqb0ArQq5m4TsP4iamY+Hk0Cy/DrY7VRC/EkKgtAzju2Oi2GXoUe7Vd/rmI/bC2I65B4QsVuHMLC56EaqfgiGN/suE0Tox+wiuHA3aw4Ufl31qqjmLrg69MbPb/hXat4ZGqE8ZigDcXzdziIyGciwZyogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575266; c=relaxed/simple;
	bh=XOyKqFrHdW2EfblHgQFk1IldO1+SBWTce1VfPGxJ5HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifGowQmq9Ll08quzQNs+W+pl9Rk4co1bGJwSuHE1xihiTWfiAJsS/Z1DW4Zwq3cg84VEpG5mnwLWePam7DphTZXQiiCb50PwKUlnXONPQ4JImSk6EXzWi16vHLxq5kTXBqCvcBeLOz0al34YVovii9boJOdsVTUlL/mz1gDYHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=oyemS+P4; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="oyemS+P4"
Received: from [10.0.2.15] ([51.6.185.229])
	by smtp with ESMTPA
	id AZaismNgDdfdlAZajsDHF1; Fri, 24 May 2024 19:24:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1716575073; bh=ZFVfuhN1ov/08YIZAHW9wgjsPG3I9joanFYiyBpxysA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oyemS+P4bo79APJjKqbvoJdq5m6tDTgfkBMrZBQgcLEGK+mDf7TyVl6E/zYUbRKxE
	 8KbW3hQVng6I0qx9EdnPSQ/FsyIJNaYqtZtxtrk5nvuCtBD0Co9qAJzVKUvo7WQ56M
	 k24VcNPTCG1U8w4tJc8/IkBLmr/FF5av8GnnDUADk0ltFWXrjW7WbeMaE0rutvXkxA
	 P1suY1KUP53z2/pzP2qxAH4VsP+/3dCU30+imTnbPM1k42JWcD7Cqep7WOnU+W8Fk1
	 FLK8TiKaRO0DAgY7bZpbFceeeYW9aUIczX0+Fz4POQDhtJePgtI1MxQLoZd9MpNxcT
	 NSEliiat+zUig==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DtP1+3/+ c=1 sm=1 tr=0 ts=6650db61
 a=7htyVA9VkOexEuxjfJyH6w==:117 a=7htyVA9VkOexEuxjfJyH6w==:17
 a=IkcTkHD0fZMA:10 a=a4KH0tAem0wY0KOr5xcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <54110fa9-02ba-4c9d-9ec2-c26e98a42730@ramsayjones.plus.com>
Date: Fri, 24 May 2024 19:24:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] builtin/refs: new command to migrate ref storage
 formats
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1716451672.git.ps@pks.im> <cover.1716545235.git.ps@pks.im>
 <0df17a51b43e1e9d007328aad6457363876b2e1d.1716545235.git.ps@pks.im>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <0df17a51b43e1e9d007328aad6457363876b2e1d.1716545235.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPS5r0bodocMYT6GacwDkDcivpTPx7u5vGInj3ZzPL/0/MFTz5o0EibEmqBFb22uRn3ZdH0LPHRRtNRcc5V27a6CoI+ld+RTvGQ6H8vuXfvUH+aYkSey
 HjjIiGubWqg0PKprNAVHur742AMjLLXXCjT0gp7jzPq7DyzxWNLcaiBWrOeTAeXwXArTwZuVTW5LcQ==



On 24/05/2024 11:15, Patrick Steinhardt wrote:
[snip]
> diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> new file mode 100644
> index 0000000000..3f73ad6aa6
> --- /dev/null
> +++ b/Documentation/git-refs.txt
> @@ -0,0 +1,62 @@
> +git-refs(1)
> +===========
> +
> +NAME
> +----
> +
> +git-refs - Low-level access to refs
> +
> +SYNOPSIS
> +--------
> +
> +[verse]
> +'git refs migrate' --ref-format=<format> [--dry-run]
> +
> +DESCRIPTION
> +-----------
> +
> +This command provides low-level access to refs.
> +
> +COMMANDS
> +--------
> +
> +migrate::
> +	Migrate ref store between different formats.
> +
> +OPTIONS
> +-------
> +
> +The following options are specific to 'git refs migrate':
> +
> +--ref-format=<format>::
> +	The ref format to migrate the ref store to. Can be one of:
> ++
> +include::ref-storage-format.txt[]
> +
> +--dry-run::
> +	Perform the migration, but do not modify the repository. The migrated
> +	refs will be written into a separate directory that can be inspected
> +	separately. The name of the directory will be reported on stdout. This
> +	can be used to double check that the migration works as expected doing
> +	performing the actual migration.

s/expected doing performing/expected before performing/ ?

ATB,
Ramsay Jones

