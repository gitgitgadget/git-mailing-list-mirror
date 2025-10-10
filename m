Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EF22A4F1
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078458; cv=none; b=Sjj2Rb1nL/iXpp476KR3dGzghQ4wwO3+hBmrYEWCYApjy+L6HWhz7eJ+H0QvkMul+coueyFpj18+pJdVMkuVewSe5CUExRrgp70/e1ckpUU0phlrBX0om0b4BUbk5/OSJz0xus3ldm542ytsO8GqD92wxw5vEFnPd37pOeCS7E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078458; c=relaxed/simple;
	bh=PfygPn7v8/NKTitK4A43G6uhadr+hU5W42SASun9Q54=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L1KLABUbVC/nnB0LYWgpNh6oxekI85KQXmPhJNfureGpk5v//+Q/eQ7jRmGe0oA5iSFFzifE+qgRhrPP7uwkSeSXHB4h9Ahd00pww/hlnYn7MPF+VhzyxLIoh/EfD84I96blhG9JFs7btpZvcJQ6wNoJKieHPcXm58Mj9aUakHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=LZ/Kx4lP; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="LZ/Kx4lP"
Received: from [192.168.43.16] (unknown [37.168.15.219])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 25B032003C8;
	Fri, 10 Oct 2025 08:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1760078447;
	bh=PfygPn7v8/NKTitK4A43G6uhadr+hU5W42SASun9Q54=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LZ/Kx4lPl6CDTfDBeu4gIdGjBCc4K5vTy83qN4+XYj8NLNd49ycx11UuYh6mkzQWX
	 o+kOl1JWxZBmD53aMeQ7QXQlvJbhEeC6yDWmlchlL0OmGTOSovlLMeRXFhR0Xb8QwH
	 hG1Iu8KfChZ3ABfG5ob4YXS2gcH4LDIYv49tI/H2VPdc+5TaLlKBapz9cKgH/z+YV3
	 USqs03fUn8Q5QB7D0xYAm6LSM6AusMlT6rx+g/yEeMj611VNwJ++1Pbw/JVNnfJgUb
	 hjR9cwsHq2xTe6t97BzEEmzLNq0nJ44RLPNwUMQ//0IopyAUGCA3QgU/K/oKwM2GLh
	 DQdcBuZVq5jGg==
Message-ID: <bb0f530b-96f3-4655-8448-1d322413cd1f@free.fr>
Date: Fri, 10 Oct 2025 08:40:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc: convert git-stash.adoc to synopis style
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
 <3f3e5a87e834a6cd1d5d7769bdd2c0dcfaa4b6ae.1759698702.git.gitgitgadget@gmail.com>
 <02383db0-545a-4f4c-9fa9-30a819a30de2@app.fastmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <02383db0-545a-4f4c-9fa9-30a819a30de2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 10/10/2025 à 01:48, Kristoffer Haugsbakk a écrit :
> On Sun, Oct 5, 2025, at 23:11, Jean-Noël Avila via GitGitGadget wrote:
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>> - Switch the synopsis to a synopsis block which will automatically
>>   format placeholders in italics and keywords in monospace
>> - Use _<placeholder>_ instead of <placeholder> in the description
>> - Use `backticks` for keywords and more complex option
>> descriptions. The new rendering engine will apply synopsis rules to
>> these spans.
>>
>> Also do not refer to the man page in the description of settings when this
>> description is already in the man page.
>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>>  Documentation/config/stash.adoc |  29 ++++---
>>  Documentation/git-stash.adoc    | 134 ++++++++++++++++----------------
>>  2 files changed, 85 insertions(+), 78 deletions(-)
>>
>> diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
>> index e556105a15..7fc32027f7 100644
>> --- a/Documentation/config/stash.adoc
>> +++ b/Documentation/config/stash.adoc
>> @@ -1,19 +1,28 @@
>> -stash.index::
>> +ifndef::git-stash[]
>> +:see-show: See the description of the 'show' command in linkgit:git-stash[1].
> 
> Okay, here you use 'show' and not `show` because this conditional
> attribute will pass on `show` and render it as such, not as
> inline-verbatim “show”. Bare 'show' is indeed better than bare `show`.

TBH I did not spot the issue when I did this. I wasn't aware that
Asciidoc does not automatically handle inline formatting in attributes.
But it seems we can force it. This "show" keyword should definitely be
inline verbatim.

Wil try and reroll.

> 
>> +endif::git-stash[]
>> +
>> +ifdef::git-stash[]
>> +:see-show:
>> +endif::git-stash[]
>> [snip]

