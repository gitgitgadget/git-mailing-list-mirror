Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06221109
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837217; cv=none; b=g4hqdX1aphgxdEKGP/Ekz2gbMpTUj8cGjF7H41n94zY9hEHGL3Y7jogz8OohsBf31Ned093+vGMGWprj7Bt4TngtM7CqeBS08nwGUIyS1N/LdbTamLVTNfFwogr1Mj3VM/DAZ5OFXGBafgLeEbcRDUn/PWZQJoyWE4XZC5kYWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837217; c=relaxed/simple;
	bh=RSfvE7eA+t1x5zCIZu5VhAAhqeq5FrGLrlSUm1wq8ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbK+jI4syK1VVURnKMPhuPNSs6ptUU0D0jtuggrKMwsuj0G3z8fE/kx80s4zpw/70K4O2okWL2xWafdVHcL4B4PrEez8zcYVGUXXQgtCzh562lv9hGpSOULk8xRh9UVUSxLRT0M3Zhyr8pBe8YtmFtOJ4OpZVyfLRoZMlkpQhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Wclwm55r4z5tp0
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 07:53:28 +0200 (CEST)
Received: from [192.168.1.102] (213-147-165-170.nat.highway.webapn.at [213.147.165.170])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4Wclwc30JNzRpKv;
	Mon,  5 Aug 2024 07:53:20 +0200 (CEST)
Message-ID: <5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org>
Date: Mon, 5 Aug 2024 07:53:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] doc: git-diff: apply format changes to
 diff-generate-patch
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <3c475a2ee4ecfb79a1174fa693b592ebafdbf5f9.1722801936.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <3c475a2ee4ecfb79a1174fa693b592ebafdbf5f9.1722801936.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 04.08.24 um 22:05 schrieb Jean-Noël Avila via GitGitGadget:
> @@ -134,17 +135,18 @@ or like this (when the `--cc` option is used):
>  
>  2.   It is followed by one or more extended header lines
>       (this example shows a merge with two parents):
> -
> -       index <hash>,<hash>..<hash>
> -       mode <mode>,<mode>..<mode>
> -       new file mode <mode>
> -       deleted file mode <mode>,<mode>
>  +
> -The `mode <mode>,<mode>..<mode>` line appears only if at least one of
> -the <mode> is different from the rest. Extended headers with
> +[synopsis]
> +index <hash>,<hash>`..`<hash>
> +mode <mode>,<mode>`..`<mode>
> +new file mode <mode>
> +deleted file mode <mode>,<mode>
> ++
> +The `mode` __<mode>__++,++__<mode>__++..++__<mode>__ line appears only if at least one of
> +the _<mode>_ is different from the rest. Extended headers with

I've a strong aversion to the formatting that this series applies,
because it introduces many (IMHO) unnecessary punctuation that
vandalizes the perfectly readable plain text. And this hunk now shows
where it goes too far. These lines under the new [synopsis] header just
aren't syopsis; they are comamnd output. The updated version abuses a
semantic token to achieve syntactic highlighting.

To me this series looks too much like "we must adapt to the tool" when
the correct stance should be "the tool must adapt to us". If the tool
(one of asciidoc and asciidoctor, I presume) does not cooperate well
with out documents, then it is the tool that must be changed, not our
documents.

I understand that some compromises are needed, but with this extent of
changes we give in to a sub-par tool too far.

Just my 2c.

-- Hannes

