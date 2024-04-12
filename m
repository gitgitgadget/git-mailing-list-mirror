Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C884A37
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941748; cv=none; b=kReAz3PqVe0BBF3tenTrQPqsu4elYrnnphhTCQXQii+AE9jsK6v6QtKsTQsvrITSpuYjyf5N4W7VidhY8LOAKAv7+UgBWf60gYEIz/gDFB9CF6jiWtaUwOBdksQcXogY2adgXzl8oYy99P0Nipm5Fx5Ax+IW/SmUS60FswxIk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941748; c=relaxed/simple;
	bh=7tphMLAC19jz8oZDXT4hUsEexwcdhToglAcNU5zFLso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2uxZflNtFqsf9BsP5TlLeVw5aYj6LNNgI3n6EZu/x0qMLSC+Ov2Tjkob+u35HZl9bJ2gxq5nCKlc9B3RXM4CTXdz3Y4gvAcN6vi5KuqbQ0U1XBPxRZdSJ/ck0jkIQDvERPSyXi/MzS9+3lfVi/RmeNsMm2rfonUHGDZH6Ux/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YpkrJIPH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YpkrJIPH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97B7B1E135C;
	Fri, 12 Apr 2024 13:09:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7tphMLAC19jz8oZDXT4hUsEexwcdhToglAcNU5
	zFLso=; b=YpkrJIPHs++CG6s9VQQJnWgz5KtfCkMcf/1SBo3l9LgvnVvN9shcai
	jEGg6ijN2BZlVMoOb62rfgEGiw3DBe6Bw4njHUsQqU21whxLdNaFzqcuZ9qU/x1Q
	DSVyg9tHoCgiMv7DULUxa62bdnHfQMOLUTApTDALjmHCRf+ePvSOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8979D1E135B;
	Fri, 12 Apr 2024 13:09:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D26D91E1359;
	Fri, 12 Apr 2024 13:09:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Kipras
 Melnikovas <kipras@kipras.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
In-Reply-To: <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Thu, 11 Apr 2024 23:32:13
	+0000")
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
Date: Fri, 12 Apr 2024 10:09:02 -0700
Message-ID: <xmqqsezqmrtd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5D27FB06-F8EF-11EE-A970-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Use a dash ("git-contacts", not "git contacts") because the script
> is not a core builtin command that is compiled into the `git` binary.

Pedantic, but "git mergetool" is how it is spelled even though it is
not a core builtin command and is not compiled into the binary.  The
reason why "git-contacts" is better is because we do not install it
to be usable by user's "git".

    ... because the script is not installed as part of "git"
    toolset.

An obvious alternative of course is to promote "contacts" out of
"contrib/" and install it as part of the standard toolset.  I gave a
brief scan of the script and did not find anything (other than "only
the recent 5 years worth of history matters") that is too specific
to our project and I suspect it should do a reasonable job when run
in any repository/working tree of a git-managed project.

But it is outside the scope of this series.  I'd still welcome the
thought to do that after the dust settles, though.

> This also puts the script on one line, which should make it easier to
> grep for with a loose search query, such as
>
>     $ git grep git.contacts Documentation
>
> . Also add a footnote to describe where the script could actually be

Let's drop ". "; it may leave the previous sentence appear hanging
unterminated, but the capital A that begins a new sentence is a good
enough sign that we finished the previous sentence, isn't it?

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e734a3f0f17..8b6e4bf0300 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -493,9 +493,16 @@ security relevant should not be submitted to the public mailing list
>  mentioned below, but should instead be sent privately to the Git
>  Security mailing list{security-ml-ref}.
>  
> +:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
> +part of the core `git` binary and must be called separately. Consult your +
> +package manager to determine where it is located. For example&#44; on Ubuntu-based +
> +systems it could be installed under +
> +`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
> +with `perl ...` if it does not have the executable bit set.]

I wouldn't call anything in /usr/share/doc/ "installed", though.

In the context of _this_ document where the user is working on _git_
project towards submitting patches to _us_, it is far simpler to
drop the above paragraph and tell them how to run the script in
contrib/, e.g.

    $ perl contrib/contacts/git-contacts <args>...

without hinting there is anything platform/distro specific, and
instead to have them all work from our sources.

I am assuming that any user who are reading this part of the
document would have a reasonably recent version of our sources
checked out (after all, they already have a patch or two to send but
they are learning the way to find whom to send them to).
