Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818F374FA
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661716; cv=none; b=rOfzPXcXgAmjzNgdlW0EPl9+ky5oQwaiasVXLIrUkqPVF3WhzxmCt4s7DihiOB/38lUu3ZwCswUPd+zFLypw78bItLcA0X1SsJxsyvfwED1YRSPzpyWivr2lzmdnpo8cf/dcpnm8tIV7KZX9Fog6iimN47A9jXNsUq2rsV2AHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661716; c=relaxed/simple;
	bh=n1Jcr0oxWYj2vgxeEsx2o4yde5Y3t5ZPFA5jdnK2Gto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YEdu+JlF6uHdu4AOrG9bAsjCJ+ueKgaSCgNPG8hJmP+4nvQK2rE7pUjfFvd2Obfu8sEhh6R7DojxMr1Zqr6F2GokkOiu9x90yi88SJtZ4bn7qXjSIB5mqMZexjte5bugrYC3N7B5U2rufGY5GxbH5KXiKk1zfHICwsewgsxpFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SLdA97k5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLdA97k5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E074B1977E;
	Wed, 14 Aug 2024 14:55:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n1Jcr0oxWYj2vgxeEsx2o4yde5Y3t5ZPFA5jdn
	K2Gto=; b=SLdA97k5NgSytwi5R46yZIKvsYt+M0OLR2d7K0iGP2iNbjNUcG0aRa
	Mtca4lJG0ZnKZazU5P8ycqdG+BpkuZuDd98t68E+WTYMZ7y9yon9rmbEjOjBRc+2
	5+kJy96qFNh++9l1I5A7FjMHAxTcOP3R+75/2/LQwhe5ovcLEGZq0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8C391977D;
	Wed, 14 Aug 2024 14:55:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F95F1977C;
	Wed, 14 Aug 2024 14:55:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alex Galvin <agalvin@comqi.com>
Cc: Alex Galvin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Alex Galvin <alex.v.galvin@gmail.com>
Subject: Re: [PATCH v2] git-svn: mention `svn:global-ignores` in help+docs
In-Reply-To: <2edfbfad-bfae-4fe1-8f26-4310fc54b2a0@comqi.com> (Alex Galvin's
	message of "Wed, 14 Aug 2024 13:53:57 -0400")
References: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
	<pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>
	<xmqqzfpg2gup.fsf@gitster.g>
	<2edfbfad-bfae-4fe1-8f26-4310fc54b2a0@comqi.com>
Date: Wed, 14 Aug 2024 11:55:12 -0700
Message-ID: <xmqqplqbx7cf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BCDF30F6-5A6E-11EF-A8EF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Alex Galvin <agalvin@comqi.com> writes:

> On 2024-08-13 6:33 p.m., Junio C Hamano wrote:
>>> diff --git a/git-svn.perl b/git-svn.perl
>>> index a2a46608c9b..d8dc485e50d 100755
>>> --- a/git-svn.perl
>>> +++ b/git-svn.perl
>>> @@ -219,11 +219,11 @@ my %cmd = (
>>>   	                "Set an SVN repository to a git tree-ish",
>>>   			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
>>>   	'create-ignore' => [ \&cmd_create_ignore,
>>> -			     'Create a .gitignore persvn:ignore',
>>> +			     "Create a .gitignore per directory with an SVN ignore property",
>> Hmph.  Is it intentional that this "create" side uses a single
>> property while ...
>> ... the other "show" side talks about "ignore properties" (plural),
>> implying that both svn:ignore and svn:global-ignores may get
>> involved?
>
> I was trying to be precise that the create command makes one .gitignore
> file in each directory it visits, regardless if that directory only has
> one of the attributes or both. Would using "any SVN ignore property"
> instead of "a SVN ignore property" make this clear?

You are creating a .gitignore file per each directory that has some
"ignore" properties on the subversion side, so I do not have any
trouble with "_a_ .gitignore" being singular in the description.

And you anticipate that each such directory has one or more [*]
svn:ignore or svn:global-ignores properties attached to it, and that
was why my reading hiccuped after seeing "with _an_ SVN ignore
property".

    Side note: * if there is 0 such properties given to the
    directory, you obviously do not muck with .gitignore file in the
    directory.

So I am not sure how much difference "any/a" before "SVN ignore
property" makes.

Thanks.
