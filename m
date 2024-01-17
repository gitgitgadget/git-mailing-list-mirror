Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DA1E515
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530914; cv=none; b=IHnS6eVY4Ev1p6IDs8hSMa7Ysm1gNNWjIOox97kJAMd7P0bSK+xPiIg9pXLPXUAJouhOZSUgHOy9P0o8hr3RbIjIh/Yfv315L2nFsiXTsdV6NgUqqyxdUNsGzREyJ+LwYfphSJznwfBerQi8WzJCd0gSuwbbVGwrKTyOhBTPE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530914; c=relaxed/simple;
	bh=9s9tb0G2yBAF3GJmUSmutFWued0AwPWbXkzhsF3UH/g=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID:Content-Transfer-Encoding; b=eBEP/qOgjlABjQx/JFFoqamXicNnONkWfGvWes4psn5gxAYVjaLrIP4TelN55YvxtGDbMMNJLTNZgaVMCJo8iO4UPZYrx9Nwts04wyLjDplnT3Gr9aCPLEfxlERPOhmgvAKgIIpfjDCPFOiUBeRM6OZzYNB0C/NEdNE7X1TWk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jjFnU25b; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jjFnU25b"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C69EB226D7;
	Wed, 17 Jan 2024 17:35:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9s9tb0G2yBAF
	3GJmUSmutFWued0AwPWbXkzhsF3UH/g=; b=jjFnU25b/jV21J+GDTv38wmcqz2S
	dPmc8yH0yocG+hlq2MGpkiAVEiaiYD1qqT/M82cV14Dk+uhkBYPTKqNXJF4yppjL
	QhQ2oJ3kaemYBmZKeK6Sls0h+WU0TLMVAWKsrrovrjCfOzUH0TtBnUWQVHcUZTOL
	vSRUThIpimpz6do=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ABDDA226D6;
	Wed, 17 Jan 2024 17:35:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9FC7226D5;
	Wed, 17 Jan 2024 17:35:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, "Nikolay Borisov"
 <nik.borisov@suse.com>,  Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: Fix documentation about used shell in -x
In-Reply-To: <b491d954-b1a4-4000-95fb-fc83bf815edc@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 16 Jan 2024 17:50:56 +0100")
References: <20240116141842.193151-1-nik.borisov@suse.com>
	<b491d954-b1a4-4000-95fb-fc83bf815edc@app.fastmail.com>
Date: Wed, 17 Jan 2024 14:35:01 -0800
Message-ID: <xmqqv87rtwq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A7A3C35E-B588-11EE-8D88-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Hi
>
> Some nitpicks since it seems like there will be another round (v2):
>
>> rebase: Fix documentation about used shell in -x
>
> Lower-case =E2=80=9Cfix=E2=80=9D is more conventional.[1]
>
>> SHELL_PATH constant at build time. This erroneous statement in the
>> documentation sent me on a 10 minute wild goose chase wondering why my
>> $SHELL was pointing to /bin/bash and my /bin/sh to dash and git was
>> using dash and not bash.
>
> I think anecdotes are not kept in the commit message, usually? Often th=
ey
> are put after the three-hyphen/three-dash line.
> ...
>     The shell used when using the -x option is the one pointed to by th=
e
>     SHELL_PATH constant at build time.
>
>     Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>     ---
>       This erroneous statement in the documentation sent me on a 10 min=
ute
>       wild goose chase wondering why my $SHELL was pointing to /bin/bas=
h and
>       my /bin/sh to dash and git was using dash and not bash.
>
>      Documentation/git-rebase.txt | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)

Yup, that looks better.  Here is what I will queue tentatively, with
the improvement suggested by Peff.

----- >8 -----
Subject: [PATCH] rebase: fix documentation about used shell in -x

The shell used when using the -x option is the one pointed to by the
SHELL_PATH constant at build time, not $SHELL environment variable.

We could leave the parenthetical explanation about what shell is
used, but it depends on the build and platform (Windows do not even
use SHELL_PATH build-time knob).  Because Git executes lots of
things using a shell, and it always uses the default shell, it
probably is better to just stop at saying "launches the command in a
shell" without going into more details.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We could say things like

    - it is a possibility for the future to add how the default
      shell is decided (including the use of SHELL_PATH) in a more
      central part of the doucmentation like git(1)

    - at least not giving a wrong information would prevent the
      future developers wasting time on experimenting various
      settings of the $SHELL variable

   in the log message, if we want.

 Documentation/git-rebase.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b4526ca246..51489ea686 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -957,8 +957,7 @@ The interactive rebase will stop when a command fails=
 (i.e. exits with
 non-0 status) to give you an opportunity to fix the problem. You can
 continue with `git rebase --continue`.
=20
-The "exec" command launches the command in a shell (the one specified
-in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
+The "exec" command launches the command in a shell, so you can
 use shell features (like "cd", ">", ";" ...). The command is run from
 the root of the working tree.
=20
