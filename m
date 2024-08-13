Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCF13635D
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588405; cv=none; b=kgVuqi/9Hgw9+8W4MB51R1CdXIzs1EvkSnYwqyQMogMUgsGIe2vSHLuFKA4zf3peWnYHuDAjjOkxSKPHFVxknzMXcVYWYnhogNBLeyh+L7aER8yAWnYSYTu6Dt8gGAsyUqtpBWW4Q+QHuVdsRJCbKkXPlXf1PIwr0Qk8vSjEbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588405; c=relaxed/simple;
	bh=Zx8NcAnWX7gNSKTGBii6GkA0y8BpEctOpRG/tE0QyE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKvfWlJO1ZvjneDccGUD3e3DmjHTEURtrX5qazrtuVZ94riAuApfwaRBPrKZTFbzVuveof/9QnFobTHDwj9maHlJTk8iczwqJAfYxN5MDh8KRnQXtzIE2Fw2TNgkMJJ0j9EHqFLrSTz3qRTzlKKALpwtb+zYKHhhSOxAAuw6Vh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WsK26cI0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WsK26cI0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E156821AD9;
	Tue, 13 Aug 2024 18:33:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zx8NcAnWX7gNSKTGBii6GkA0y8BpEctOpRG/tE
	0QyE4=; b=WsK26cI0c+jMyxkdc/px/koha/rKoQt52pD9BS9+XBblFhaxQCm4k9
	6eJpSPIJkTdijxy7pjlRPL9dVySsPTJ1OEjcKRkS9P5/tVOqD/wT4LI2zfprrQlS
	fRA8Ovf5e7ejVCZyvsr3lE8uSxOyG13SSNAzi/1lVlk9TUO0qn34o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D2BBE21AD8;
	Tue, 13 Aug 2024 18:33:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4FB0521AD7;
	Tue, 13 Aug 2024 18:33:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alex Galvin <agalvin@comqi.com>,  Alex Galvin
 <alex.v.galvin@gmail.com>
Subject: Re: [PATCH v2] git-svn: mention `svn:global-ignores` in help+docs
In-Reply-To: <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com> (Alex
	Galvin via GitGitGadget's message of "Tue, 13 Aug 2024 19:55:46
	+0000")
References: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
	<pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>
Date: Tue, 13 Aug 2024 15:33:18 -0700
Message-ID: <xmqqzfpg2gup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0AEA7E46-59C4-11EF-BC86-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alex Galvin <alex.v.galvin@gmail.com>
>
> Git-SVN was previously taught to use the svn:global-ignores attribute

I think the noun they use is not "attribute" but "property".

> as well as svn:ignore when creating or showing .gitignore files from a
> Subversion repository. However, the documentation and help message
> still only mentioned svn:ignore. This commit updates Git-SVN's

"This commit updates" -> "Update".

> diff --git a/git-svn.perl b/git-svn.perl
> index a2a46608c9b..d8dc485e50d 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -219,11 +219,11 @@ my %cmd = (
>  	                "Set an SVN repository to a git tree-ish",
>  			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
>  	'create-ignore' => [ \&cmd_create_ignore,
> -			     'Create a .gitignore per svn:ignore',
> +			     "Create a .gitignore per directory with an SVN ignore property",

Hmph.  Is it intentional that this "create" side uses a single
property while ...

>  			     { 'revision|r=i' => \$_revision
>  			     } ],
>  	'mkdirs' => [ \&cmd_mkdirs ,
> -	              "recreate empty directories after a checkout",
> +	              "Recreate empty directories after a checkout",

Given that all other messages begin with capitalized verb, this is a
good change for consistency, but it was not advertised in the
proposed log message (just saying "While at it, capitalize the help
message for 'mkdirs' command. for consistency" would be sufficient).

>  	              { 'revision|r=i' => \$_revision } ],
>          'propget' => [ \&cmd_propget,
>  		       'Print the value of a property on a file or directory',
> @@ -234,7 +234,7 @@ my %cmd = (
>          'proplist' => [ \&cmd_proplist,
>  		       'List all properties of a file or directory',
>  		       { 'revision|r=i' => \$_revision } ],
> -	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
> +	'show-ignore' => [ \&cmd_show_ignore, "Show .gitignore patterns from SVN ignore properties",

... the other "show" side talks about "ignore properties" (plural),
implying that both svn:ignore and svn:global-ignores may get
involved?

>  			{ 'revision|r=i' => \$_revision
>  			} ],
>  	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",
>
> base-commit: cabe67c0d1819fd1e33079e92615c6c7a3dc560d

Thanks.
