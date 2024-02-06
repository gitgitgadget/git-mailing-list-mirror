Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762C0745D1
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189409; cv=none; b=Y/9/smwj5rH9nIV2jby+MJOD8JsxRC/aDyCYDjjSa5QnkYAWBab3qxoXSTZOqcHBtuqpb0E+scpiVVXqek3JDgw6ioUOc9q1DscJfB+YbrEEymuapahjWpAonWTjxhvStzfJr0bdAufY6tlhoqcYoCpFXTt9PQHmdxPFTfF0p14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189409; c=relaxed/simple;
	bh=T7vzSqi1OiLrxVJ/M36XmQG7WvgMJvqnmsCavh+Ngek=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tm/yFwMtWVdabltVYK03jl7ovFVURdzOjVHKZCzPdGDirXCZlP3/s+P/65Hy1uO6B/6nzLrJ4l7xEp4kOzZRsKEyBN4pf/cesfKyToubFQP0afmbgdj5EPFmkPjQcAxs4iX+eLpU9JftZoKlu58H/fWYNjc90GQtSbeH1hGdugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=c0FXcbuO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="c0FXcbuO"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707189398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCuvSnL2GQvoDFh45NJ45RQU1T2cMiHjCjXCM2xJ8/U=;
	b=c0FXcbuODrPHA33nCrrQ9/mrHCh5gx7r0BL8jcm+3w+331qedK+j386fekCDTdWXD7mwSP
	+AE69sj09eSnnIqx3A9Iz0aiel4ZXniUmUHcZ0Ct+EYOWchZNu0r6iQquimC0WRGJ7GOOp
	w5KHIWXJUQjFdcnRl/pze0NRsDlc/6VOSnt01Z606oKW8Txp1Eab0IC/ytLow7f9u2LjCX
	zVvU+u7XnHksY0ZgKXJdl6gqa/rsCPn416nNvpb3tOyJxbmoLn20UJaL1wutVOxoExJPoR
	HTfRVl3SVBu4lN7KrykRKsjWBpsaZkOf6QSpjFbL8O+0oY1hpkCifK+3ib6aCg==
Date: Tue, 06 Feb 2024 04:16:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] branch: clarify <oldbranch> and <newbranch> terms further
In-Reply-To: <CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
References: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
 <CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
Message-ID: <c47dfda08567aa2f315069fb02351ce2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Kyle,

On 2024-02-06 00:53, Kyle Lippincott wrote:
> On Mon, Feb 5, 2024 at 4:45 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> 
>> Clarify further the uses for <oldbranch> and describe the additional 
>> use
>> for <newbranch>.  Mentioning both renaming and copying in these places 
>> might
>> seem a bit redundant, but it should actually make understanding these 
>> terms
>> easier to the readers of the git-branch(1) man page.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  Documentation/git-branch.txt | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/git-branch.txt 
>> b/Documentation/git-branch.txt
>> index 0b0844293235..7392c2f0797d 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -312,12 +312,14 @@ superproject's "origin/main", but tracks the 
>> submodule's "origin/main".
>>         option is omitted, the current HEAD will be used instead.
>> 
>>  <oldbranch>::
>> -       The name of an existing branch.  If this option is omitted,
>> -       the name of the current branch will be used instead.
>> +       The name of an existing branch to be renamed or copied.
>> +       If this option is omitted, the name of the current branch
>> +       will be used instead.
>> 
>>  <newbranch>::
>> -       The new name for an existing branch. The same restrictions as 
>> for
>> -       <branchname> apply.
>> +       The new name for an existing branch, when renaming a branch,
>> +       or the name for a new branch, when copying a branch.  The same
>> +       naming restrictions apply as for <branchname>.
> 
> The precision here makes me worry that I'm potentially missing
> something when reading this, and has made me re-read it multiple times
> to try to figure out what it is.

Thank you for your feedback!

I'd agree that the first sentence I sent isn't exactly a textbook
example of clarity, :) but it also isn't that bad;  it tries to say
something like "one thing when this, other thing when that".

> I think this would be cleaner:
> 
> The name to give the branch created by the rename or copy operation.
> The operation fails if <newbranch> already exists, use --force to 
> ignore
> this error. The same naming restrictions apply as for <branchname>.
> 
> I'm not super pleased with that second sentence, and maybe we
> shouldn't include it here. Maybe it belongs on the documentation for
> --move and --copy instead? It's sort of mentioned in the text at the
> top describing the -m/-M and -c/-C options, though it's not clear from
> that text what actually happens to the existing copy of <newbranch> if
> one uses --force. If we could include a better description of what
> happens to the existing branch when one uses --force, that'd be nice.

I agree that moving everything to the descriptions of the move and
copy operations, as Junio described further in his message, is a much
better way moving forward.  Describing the results of forced operation
is also needed for completeness.

I'll prepare and send a v2 that takes that approach.

>> 
>>  --sort=<key>::
>>         Sort based on the key given. Prefix `-` to sort in descending
>> 
