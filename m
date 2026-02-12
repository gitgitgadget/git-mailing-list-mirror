Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455428850B
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874678; cv=none; b=HQ+jwYelBI+vHhOm3k6XPhZBkWBI9Z5IWby9xuURn7Gqvdnqc5WaJBpNDGgnx8j0tx5HGJo0wmjfB6x7x5jhDpD7wCnMm71wtv0siDWrk9ZhiwoO9AIE77maMl7mgXtZxDjTlMZEbBimNRjT55k3na026iTBBroXEodkiOBKiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874678; c=relaxed/simple;
	bh=gVOYfld21GI1k7CvOVmQgVIq/qdNPKzEmej718/O1ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pi9vPPesR9UW4Pw81Nj0V9lJVzQjDgn9aJVd1gR6pB7tBhLIQZV/sXOkZRUWyv8/eH8bnXXiN9EZX5DnVzyd3JsMkNU3Z5YYhxQ6ZAIIEVIf6YudB96wTPQr3TmRrNhR7xcsV9E0Cmpbwq7zpLppzcm/jTuQfonmwEO1gX3QcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Iv5aEZrL; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Iv5aEZrL"
Received: from [172.168.17.249] (unknown [103.51.116.155])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id C78B82003CC;
	Thu, 12 Feb 2026 06:37:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770874674;
	bh=gVOYfld21GI1k7CvOVmQgVIq/qdNPKzEmej718/O1ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iv5aEZrLF2H5JsRqAaTBVNDwQY2BQjPQzQUOc+Ia6E/5/o6CzIAwtQ1e+mOl8y4M0
	 XD1W2ooRANe7iu2N+Uohq5WAv/lA+F5tHkwlUzrRUlWOYxAa6friEm0kyANFmSBDem
	 vEs8lYMWUeOodSawvYIHuHz14FHt2SvG+7e1rjVswqvEfqIwFU7FCdFKz5Wzw0rsjM
	 /vIa+1NuM4IrQnMUaNHWu4CBa1cRtQYbT1tFF3dhyupg1s0l9Yl2kkZ9/FVtzQKMGN
	 ezior0sKvj4x01MYLZvIiGQAZRCa/pbT7lVg9EZk0AF0EjILVg3M8skB0NgITh0mjz
	 yQThpuSC11iHw==
Message-ID: <1ce11655-eaef-407f-86af-956a190f5358@free.fr>
Date: Thu, 12 Feb 2026 06:37:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <doc_link_rerere.328@msgid.xyz>
 <1a4060f1-6607-4b50-859d-927642eb34df@free.fr> <xmqqikc3waju.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <xmqqikc3waju.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/02/2026 à 16:43, Junio C Hamano a écrit :
> Jean-Noël Avila <jn.avila@free.fr> writes:
> 
>>> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
>>> index b0b920144a6..115882edab1 100644
>>> --- a/Documentation/rerere-options.adoc
>>> +++ b/Documentation/rerere-options.adoc
>>> @@ -4,6 +4,6 @@
>>>  	the current conflict to update the files in the working
>>>  	tree, allow it to also update the index with the result of
>>>  	resolution.  `--no-rerere-autoupdate` is a good way to
>>> -	double-check what `rerere` did and catch potential
>>> +	double-check what linkgit:git-rerere[1] did and catch potential
>>>  	mismerges, before committing the result to the index with a
>>>  	separate `git add`.
>>>
>>> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
>>
>> I'm not fond of introducing linkgit macro that can create auto-reference
>> in manual pages. At the moment, we need to use conditional inclusion in
>> the manual pages source, but I wonder if we could simply filter out the
>> links in the macro itself.
> 
> FWIW, before deciding to accept the patch, I did check if
> git-rerere.adoc included this file (it didn't), but if we can make
> the macro smarter to do so, it would be great, as that would avoid
> people including this file there later without realizing that they
> now need to make the mark-up conditional.


Ah, adding the options of rerere in git-rerere manual page is then
something that will need to be done when reworking it.


> 
> This particular patch does not have to be blocked waiting for such
> an improvement, though, right?
> 

No it doesn't. I don't intend to scratch this itch soon.
