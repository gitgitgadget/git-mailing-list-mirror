Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB6340402
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785664696; cv=none; b=nHZRLKMrJOvE9iYhhZMonykvNSq9T+QAke073DvQGV4aCFrcr4N9YngRFxOwMtsMB+325Jn6c950zGZ6l/akie47dWW97RasiEccqAZXsSjCRMBoVVL5vjiV/yx+ZmQqmfG8WsBepx/NXZU7rWS9DgHZxVdqChr/3qGybc2CC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785664696; c=relaxed/simple;
	bh=XShd5g3EqFDnr3k62F95tS0rKztj9dpPfLoPx4U+0d0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=slBP/DNhB8+8rFdcrDCmV3HGspEh8lp+A8MU4EYKnTCUKRnOECLgmvfv2yP2e+Y/GQPsW4F1jjx+H6HXyQS2NppgydoFBFRKMaLzoDwdWESa9TDQyTAwXpoi+I24l5l7IbOI4oQFtc0WyfRnS9ztHVN/q1Y0uRrbJ4lGw0uoMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gnM5afHX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gnM5afHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785664686; x=1786269486; i=l.s.r@web.de;
	bh=E1LwxJdeWqc7+VUMnfLVrguscPybDoc2ASigi0q5hoI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gnM5afHXJxhqtpRKsWnUPXbUjrRtdRhPri3WjcBaEYxdxsHOoA/D4CdyR8AXy3Bi
	 /VCIreslwZJERWgxa9UixJQY9HVN0Ex/hU+miX+7xmgjV9n8Klz/GduptJMEnDnjr
	 fSAKg2ZD5FnxCpRpggOjr6b1IqekmcDY0fGPV3mt9YUW6/+JYOpR9uLspgtWEKKyP
	 IgGrrOQSazimpM6h4HMyQ7H4QPzgzCyI+pXueTPO1ICI0GMFq3AZGGJKMEfmqhnXc
	 jyNu7MR8VzxgLrb93o0f2wS3JNAdWUhq6vyWt0GG6Ep+Ubfxydi8VbEQBeWY5tyHX
	 yaG8tryz4GQkFTGkxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVaf-1wloFj2397-00FATv; Sun, 02
 Aug 2026 11:58:06 +0200
Message-ID: <077f11be-489f-4174-adbc-82a610137a41@web.de>
Date: Sun, 2 Aug 2026 11:58:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] worktree: reject empty string
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Marc Branchaud <marcnarc@xiplink.com>,
 =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?=
 <mha1993@live.de>
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
 <ec682d75f3a7848dc36f82cf36bbdff6fd283e2d.1784978348.git.gitgitgadget@gmail.com>
 <f6b7af1a-29fd-4bec-b819-34b7962180fb@web.de>
Content-Language: en-US
In-Reply-To: <f6b7af1a-29fd-4bec-b819-34b7962180fb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:63AVS0ujlOle56Sjm3L0H9X7kErEgCRJgV8J198Ej7Ei5QYymjV
 HNao3LxAjIXvr1w2G8LVocug70dSOZVWJhUUbCtQlT46zB/++3o+aqCIblRyn+ybinTTh6c
 S6sHdfLvWXkprken6aaWzf75xJhRYGnOl1R2x2NCavWF3m/AdZyYsqLs6DpuJdmaCSwyeHH
 g9qSEhMj9iEX6A8KVI0VA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ngMsl5dAY+I=;X73YGN9xH0jSI1zFcVHXkCSf0qw
 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

On 8/2/26 8:26 AM, Ren=C3=83=C2=A9 Scharfe wrote:
> On 7/25/26 1:19 PM, Matthias A=C3=83hauer via GitGitGadget wrote:
>> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>>
>> `git worktree add ""` errors out with the message `BUG: How come ''
>> becomes empty after sanitization?`, but not due to a bug in the
>> sanitization code. An empty string should remain empty during
>> sanitization. Instead reject the argument as invalid user input,
>> if it's already empty before sanitization.
>>
>> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
>> ---
>>  builtin/worktree.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index d8188035db..113dbf98d3 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -496,6 +496,8 @@ static int add_worktree(const char *path, const cha=
r *refname,
>>  		die(_("invalid reference: %s"), refname);
>> =20
>>  	name =3D worktree_basename(path, &len);
>> +	if (!len)
>> +		die(_("the empty string is not a valid worktree"));
>>  	strbuf_add(&sb, name, path + len - name);
>>  	sanitize_refname_component(sb.buf, &sb_name);
>>  	if (!sb_name.len)
>=20
> Hmm, on my machine, with or without this patch:
>=20
>    $ git worktree add ""
>    Preparing worktree (new branch '')
>    fatal: '' is not a valid branch name
>    hint: See 'git help check-ref-format'
>    hint: Disable this message with "git config set advice.refSyntax fals=
e"
This hits the BUG by passing the empty string directly to add_worktree():

   $ git worktree add "" HEAD
   Preparing worktree (detached HEAD a97fcc37c2)
   BUG: builtin/worktree.c:498: How come '' becomes empty after sanitizati=
on?

Ren=C3=A9

