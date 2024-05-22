Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152213FF9
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405220; cv=none; b=Xama9a6Qa/njuOtr3L/TbaB0Kk3Dkr3CSKbla2AYQNCql8lTY5WQAg1OxAAqwQcX0W9i97zgoEe8ISBr62saMTy8Q86r2/9huTJ4XQQGJk1xu7+wXmq7IzGFj5Q+Tfp0QB65gcSXYl1wbC0B0czSUMdX4cp1WBiL+K0EiWRNT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405220; c=relaxed/simple;
	bh=ANVkemM+zZ8lHj5+K/qfApEFJtb97gRdoUa3Ptg9muM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iO2ELihat6UxtRln+Qd50KFG/Jf/NobQMJvQdm0BBTILEsmwGhljNBHHxmJC5zglexu8FAC3eDZmHFAdA7q4kPqecPlO5JpCu7GD04zFLicrhgcoUOxNZybL3H/q6ame7AF2kjKfHqpnGnn3apPWLWx66249xgSZ+n77ogu4vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=w+cDvSy1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="w+cDvSy1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716405216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GATwr0wCAvRhL+YM9WCan3Usx+Qvc3qpgTUZNKwT08=;
	b=w+cDvSy15HI9ToKhRjcD4ngljjsJehyMbcNTa9ReF4Ji8ffMLloSxg91ksnhdPj0E+AG+v
	H2GsPGjJkwMTB7II5MrMYs1iENeSCCJs+4gQWt+DAoGshFly5Uf5/MxI3+vncqflvVqCQE
	XIWpYfmT4AO0KBS/0SBcogEpUbqdJbhigHYxiwonVjiBaRjz+IEeWpZJ+iXfGwy350DQ8R
	O5McKoP9uVtUP7GWdKCYblRcE271H0sFWxRckd4v3/NwBh9R4qxDzsE/kHeF3LyyfmqzKm
	PRvt3AodYNxBg/Y/e0R5t8qZI4aT0v6zeByNZpT37llAnfD1sf1UkY6bQlmgmw==
Date: Wed, 22 May 2024 21:13:36 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] blame: do not mention obvious default configuration
 values
In-Reply-To: <xmqqpltd4rfu.fsf@gitster.g>
References: <xmqqpltd4rfu.fsf@gitster.g>
Message-ID: <51e30846c62a1605dee8fd5b9d096222@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 20:44, Junio C Hamano wrote:
> diff --git a/Documentation/config/blame.txt 
> b/Documentation/config/blame.txt
> index 4d047c1790..36f965484c 100644
> --- a/Documentation/config/blame.txt
> +++ b/Documentation/config/blame.txt
> @@ -1,6 +1,6 @@
>  blame.blankBoundary::
>  	Show blank commit object name for boundary commits in
> -	linkgit:git-blame[1]. This option defaults to false.
> +	linkgit:git-blame[1].
> 
>  blame.coloring::
>  	This determines the coloring scheme to be applied to blame
> @@ -14,11 +14,9 @@ blame.date::
> 
>  blame.showEmail::
>  	Show the author email instead of author name in linkgit:git-blame[1].
> -	This option defaults to false.
> 
>  blame.showRoot::
>  	Do not treat root commits as boundaries in linkgit:git-blame[1].
> -	This option defaults to false.
> 
>  blame.ignoreRevsFile::
>  	Ignore revisions listed in the file, one unabbreviated object name 
> per

Frankly, I'd much rather see the same "If true, ..." twist [1]
applied here, rather than just deleting the descriptions of the
defaults.  To me, such an approach eliminates any doubts, while
not stressing out the actual default value.

[1] 
https://lore.kernel.org/git/54c318f42ce63f0575ea48f3dc1e8361@manjaro.org/
