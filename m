Received: from rush.cubic.ch (rush.cubic.ch [176.9.78.115])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453F4A3E
	for <git@vger.kernel.org>; Wed, 27 May 2026 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779854429; cv=none; b=iszzgq3Sst50rOv4No2Ai9Ksuk9cSdvLGReBYx6qdQTiIB3sECVpp5hA8rQvGRvNYs+j8MlzNjPe/1/KqlVmBA5p9k405JK2jtxLLHADidWCB8Ncbw5wUbLLn0m+LlRBMhRSAFaCQp7JNYuL+iSzQIkMmNEWE7PeLghMJ7GcnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779854429; c=relaxed/simple;
	bh=c2vYffJyznC355QfC302/l4CESzVoBS7Q0GlfJtvzEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUA7igFGREorSIx7CkOVtJGEzUZFynbYBgKXQn/Lds24YBZC1IxHS2EJ8CSA3LXFETnNU4stjB5GqnfhvktylmgW85LZrYJwv5oXkkcNu35QYZHJIGaKF48oJ3+vPHhJclLjAJsKReBo7FL7Pf1FRLQzcieTwBKQyTV4zQp0Mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch; spf=pass smtp.mailfrom=decentral.ch; dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b=HEK+J/+/; arc=none smtp.client-ip=176.9.78.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentral.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b="HEK+J/+/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa2;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=QITM+FKQiqtC17swuTMEZZa3A8Kg8y+TUGzQv7kPE38=;
	b=HEK+J/+/KwgY+PQljqj7Fhbg2meQuLec0j/zjZRRc95V9BTrjvB95BryRKqUGyoYirbasT5FA4noqZ3tgQhJwH0OuN+ZSbh2yF2vqtO64gxdyWqdgHpgLd7NAgEHJXeqJptOQ0wmdMjO+kLLrWEwHxcqHbrn8O93MuhBgoibe+H67s15Cnu3ELrN5LOnGtTc2mp5YUkRyxpSB2+oDs8JBGvpqaQWnWYvzBSTFGm4bM6qVPSUj2UxBDd/AtO68uUDVHtfaxX1mkAoDJJ+3HCgZ19U2OYCaJjPDJFiLclyrUAM3xHcbopq9F/5o4mNwg0TK/I1CtHTz9pDAS0Ic5pLNA==;
Received: from james.decentral.ch ([85.195.242.225] helo=[192.168.219.13])
	by rush.cubic.ch with esmtpa (Exim 4.76)
	(envelope-from <stuff@decentral.ch>)
	id 1wS4vL-0007oL-4F; Wed, 27 May 2026 05:27:15 +0200
Message-ID: <983b4ba0-d2b0-4d29-aabe-9e7b3987d514@decentral.ch>
Date: Wed, 27 May 2026 05:27:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git mv after the fact
To: Junio C Hamano <gitster@pobox.com>, Chris Torek <chris.torek@gmail.com>
Cc: Frieder Hannenheim <mail@fhannenheim.net>, git@vger.kernel.org
References: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
 <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
 <xmqqy0h5lfa0.fsf@gitster.g>
Content-Language: en-US
From: Tim Tassonis <stuff@decentral.ch>
In-Reply-To: <xmqqy0h5lfa0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, and while we're at at it: why not another patch for

git rm 
file_i_deleted_but_didnt_tell_git_and_dont_want_an_error_message_because_thats_offensive

because that's always very rude, too, telling me to have to use

git rm -f

Because I also am very sensitive and don't like to be told I fucked up 
and have to be more specific about what I actually want. That's just 
toxic, man.




On 5/27/26 05:09, Junio C Hamano wrote:
> Chris Torek <chris.torek@gmail.com> writes:
> 
>> On Tue, May 26, 2026 at 6:18 AM Frieder Hannenheim <mail@fhannenheim.net> wrote:
>>> I'd like to propose a new flag for git mv, that updates the index
>>> like git mv normally would but does not move the file. ...
>>
>> You may already know this, but technically no flag is needed:
>> you can just "git add" the new name and "git rm" the old one,
>> with the same effect.
> 
> Correct.
> 
>> A flag for "git mv" would be convenient (and slightly more
>> efficient, not in terms of storage but in terms of CPU time
>> spent discovering that the contents under the new name
>> already exist in the object database).
> 
> May be convenient, but I do not get the "efficient" part.  Do you
> mean that for two operations "add" and "rm", you need to spend two
> index writes plus one file contents hash, as opposed to one index
> rite without having to do any contents hash?
> 
>> But Git will discover
>> the rename on its own in the usual way regardless of how
>> you get to that point.
> 
> This is not incorrect per-se, but it is a confusing thing to say to
> somebody who does not know the equivalence of "mv" and "rm + add".
> It would not be clear to them that you are not talking about what
> happens during "mv" or "rm + add", but about what happend during
> "git log -M", "git diff -M", etc.
> 
> There is "git rm --cached" that can be used to recover from an
> "oops, I removed the file from the filesystem without telling Git".
> 
>      $ date >new-file.txt
>      $ git add new-file.txt
>      $ rm new-file.txt
>      $ git rm --cached new-file.txt
> 
> I think the requested "feature" is not all that outrageous.  It
> would be a similar value as a morning-after correction measure for
> "oops, I moved the file in the filesystem without telling Git".
> 
>      $ date >old-file.txt
>      $ git add old-file.txt
>      $ mv old-file.txt new-file.txt
>      $ git mv --cached old-file.txt new-file.txt
> 
> Thanks.
> 
> 

-- 
decentral.ch - IT Stuff
Tim Tassonis
Badenerstrasse 219
8003 Zürich
stuff@decentral.ch
+41 79 229 36 17

