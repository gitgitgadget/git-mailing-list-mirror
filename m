Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543EB18785A
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083494; cv=none; b=rtGz4UF5jqCW56mBrIxnIV/+VppwsdyTKVmg8B0tph+WVLpKR2poKxVIPBzzEa+2qzVQe6+oFE/hLkTk8W1p8varSknPlJAM7po/Z930Cm2s4r4RH1zC9fzz/nfnm37rJwmwFP0xFYC/s4/UpJI4oiKsJa8uLMOqUYaRSmuH6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083494; c=relaxed/simple;
	bh=V3fk64K+wRS0HA4ofEqqA3OjsWGI0YEjAL4Yt1VAYTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jxiRdFgl5GWj9yylNPXEqUUibZTDpuGLrMSq3tcfcNgT9YXf8KNRiVoYHyXh9yPsAA9JiokMwvwoaynpS7u3UJwgS7LnTXPX1tKNtJ9sV3LbJq9Wi9SKA6g8IDad+G1cyjYvrqJaX2h4D29bk2eTWkvW0GLgJNzD4Mx92IN6FGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NtI7lRlm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NtI7lRlm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42845215CF;
	Mon, 19 Aug 2024 12:04:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V3fk64K+wRS0HA4ofEqqA3OjsWGI0YEjAL4Yt1
	VAYTE=; b=NtI7lRlmYPTCY8bOgnSH7J6X/955XJjU9L8rl9iWpLMEEwJzww8PEe
	3KNRXI4mbQeqC9e/4ZTfc165MrYk0owc1aUDTI1MLzx+mrptyMIAywm/gqypeyC8
	DXY7g5Xv3Ss6lYg8dPPzPE4n7YEfhKL3E/PbyE0FHqSu337sJae3c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A896215CE;
	Mon, 19 Aug 2024 12:04:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94FF4215CD;
	Mon, 19 Aug 2024 12:04:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Yukai Chou <muzimuzhi@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: add --show-names for git config
In-Reply-To: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
	(Yukai Chou's message of "Mon, 19 Aug 2024 08:45:02 +0800")
References: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
Date: Mon, 19 Aug 2024 09:04:50 -0700
Message-ID: <xmqqcym4fqhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C4519DEA-5E44-11EF-B434-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Yukai Chou <muzimuzhi@gmail.com> writes:

> Option "--show-names" was introduced along with the "get" subcommand
> of git-config(1) [1]. It was used in Deprecated Modes doc examples,

There is no [1].

> normal and completion tests, but not documented.
>
> It's known by both "get" and "list", though has no effect on "list".
>
> Signed-off-by: Yukai Chou <muzimuzhi@gmail.com>
> ---

I'd probably write it more like so

    4e513890 (builtin/config: introduce "get" subcommand,
    2024-05-06) introduced "--show-names" option that is used to
    give the name of the configuraiton variable to each output entry
    in addition to the value.  It however forgot to document it,
    even though the option is used in a few examples.

    Document it.

if I were doing this commit.

> +--show-names::
> + Output also the names of config variables for `list` or
> + `get`.

Considering how long the later "Find the color setting" line is, I
think it is better to write that on a single line, i.e.

> + Output also the names of config variables for `list` or `get`.

It fills only 66-column counting the quote "> " and diff formatting
"+".

> +
>  --get-colorbool <name> [<stdout-is-tty>]::
>
>   Find the color setting for `<name>` (e.g. `color.diff`) and output

As to the name, I tend to agree that --show-names is a strange name
for the option, and I would have even suggest making "--all" to show
the name by default and give "--hide-name" option to countermand it
if we were adding this topic afresh today.  But that unfortunately
is all too late to change without much more effort than just changing
the name.



