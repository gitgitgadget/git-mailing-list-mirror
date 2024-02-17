Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA618020
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193532; cv=none; b=jSSq+hgvYAOnqCdLT8EtsNyhkToKRcoOYlPwN63dny5oXUhmT7J7RP/WK9Z9jCpa813+i0ov5LQBRLD7RM6YLTXaspjCyoRBMywwSEFUR1HYopNHoz1xeWQW4hWDRdocpJ6AfPQx7I6zeWQQ91l1Gkikg+mC8StyfWucQXDd5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193532; c=relaxed/simple;
	bh=Qx8hvGhflFGDjR9s0AklUCNkU1OJo0zK/8lj+0Wpg84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otbEtE9PCJJSvLENrBTx9OxoH7dEi01BaOSd8Ob9WqA1wdTFehTLU2acDT/g6/vMtZLrKsTXnUKdLk1HXf3HBw0IthHf7a39En9mlPJ6MCHzqsBQ3bAlIibGr2BPl4nxGCrA5EkmCsw+oKJXMb4RhF8krsnwvz0fu1QDK6Q28Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kKNlVyOq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kKNlVyOq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 757591CED57;
	Sat, 17 Feb 2024 13:12:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Qx8hvGhflFGDjR9s0AklUCNkU1OJo0zK/8lj+0
	Wpg84=; b=kKNlVyOqd7OU4HV92xAyo5B2JY7KlfWjkBx3v3+s+JPkyEPuAzkE2Y
	jVN/zlERKtPDPy0j6wF2PovjJ7QW2EynZJZg6YrZwJEoDDqDpqCb+ANOgitjrJWu
	QcoF3tSJlbbx7YHBENmziGqtLrFeBEXh334JZWWWul7YIojMTiQyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64DC71CED56;
	Sat, 17 Feb 2024 13:12:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0AE11CED54;
	Sat, 17 Feb 2024 13:12:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] RelNotes: minor typo fixes in 2.44.0 draft
In-Reply-To: <20240217163753.301384-1-tmz@pobox.com> (Todd Zullinger's message
	of "Sat, 17 Feb 2024 11:37:45 -0500")
References: <ZdAX1Sfiq6gJCoEk@five231003>
	<20240217163753.301384-1-tmz@pobox.com>
Date: Sat, 17 Feb 2024 10:12:07 -0800
Message-ID: <xmqqsf1rez9k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 106CEA24-CDC0-11EE-BA3D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> Kousik Sanagavarapu wrote:
>> Todd Zullinger <tmz@pobox.com> wrote:
>> 
>>> - * When $HOME/.gitignore is missing but XDG config file available, we
>>> + * When $HOME/.gitconfig is missing but XDG config file available, we
>> 
>> s/file available/file is available
>
> Good point, thanks. :)

Thanks, both.  Will apply.


>
>  Documentation/RelNotes/2.44.0.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.44.0.txt b/Documentation/RelNotes/2.44.0.txt
> index 7dd8d75844..7cee544eee 100644
> --- a/Documentation/RelNotes/2.44.0.txt
> +++ b/Documentation/RelNotes/2.44.0.txt
> @@ -3,7 +3,7 @@ Git v2.44 Release Notes
>  
>  Backward Compatibility Notes
>  
> - * "git chekcout -B <branch>" used to allow switching to a branch that
> + * "git checkout -B <branch>" used to allow switching to a branch that
>     is in use on another worktree, but this was by mistake.  The users
>     need to use "--ignore-other-worktrees" option.
>  
> @@ -54,7 +54,7 @@ UI, Workflows & Features
>     gitweb behaved as if the file did not exist at all, but now it
>     errors out.  This is a change that may break backward compatibility.
>  
> - * When $HOME/.gitignore is missing but XDG config file available, we
> + * When $HOME/.gitconfig is missing but XDG config file is available, we
>     should write into the latter, not former.  "git gc" and "git
>     maintenance" wrote into a wrong "global config" file, which have
>     been corrected.
