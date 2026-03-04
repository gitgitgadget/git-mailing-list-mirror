Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF9286D5D
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631154; cv=none; b=fqGzMYoxu2Q1mp9OxFERm7AMZCHZFsFlqSfdH7k0CqG/G8v7Dnz4y9To9rbsF20PSW50IhEPs1My0svIPWVLS6RmIM4e8k+ycIhsRJd/ylTsfGKOInjAvbfNSMa7rQgFfqbJ16zgQFsuUP5usaZq7zK/ys2Q1312ySOuOLJt+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631154; c=relaxed/simple;
	bh=ML2oB8StrV8RhliGQ3szp6/lIf5f0qfKnZeEJuajKHg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQxtnvHmaX37cNvYEWZxQxoEsuAv4VMsUI0i355x29bVBQBaXSp/rckIps1ZieHhk7ajty8EYKzZlnMWRuK74VF6vqAf69XV/2b3DPARR9Ymoy5X34h07c/Lx52WgATnakvMFkeUioLDv7MGtpzko12RUfilZg1lJ7w9knYOADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RRELwikh; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RRELwikh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1772631142; x=1772890342;
	bh=qBQpUhic7lnyI+fz/5AqqsyFsaIoFuy3WihvJKHrTT0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RRELwikhXFdqyVWqNyOEeDKp2QB194tVpvjUdhDRe9GM2Ll18iNRdV1XqkJE4lb8N
	 2gquK88Ap1qO266IznFUN8xf0JwApyjFzflclMPpxBJpkZ6kZ3wlmqYRvWEYe29hna
	 IcnqivjNacVx34LxYZelApHQbHBFtWNe5hMwvLN4uKOVJKdADe0SteNnBR+bW2jVyz
	 5QoUK8ulwqOKNHV5rP3xCMWdB6kft3u82GsSPUP7QfBlqYj4CVbFALKLVwauzaxs33
	 hR3Sla2n1d12jhIX7IYO4IN/rSg0I36YqzeKCsN25/HtDwNL7OBFrwy9dDYoytL2vb
	 2ZC1ZgqLjg2pw==
Date: Wed, 04 Mar 2026 13:32:20 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: Chris Idema via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] git-gui: shift tabstops to account for the first column of context diffs
Message-ID: <Hf23ZjoLMdkhr77C9rfhukpwi1zKpjyEwhMPfsqHbL4Cqruu8WRHHeFrX7mtPzxbmV3uyEgK5yXDBxUUVparcHo0f3PSipKEfTipswpYC68=@proton.me>
In-Reply-To: <191b6fe4-e273-4ecd-9b73-725c2dff4306@kdbg.org>
References: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com> <pull.2179.v4.git.git.1769684944593.gitgitgadget@gmail.com> <191b6fe4-e273-4ecd-9b73-725c2dff4306@kdbg.org>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: a90a1071fc8f7bd86de9dc2863447a9f923ba3f1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Any updates? I see it hasn't been merged yet.

Chris Idema

-------- Original Message --------
On Thursday, 01/29/26 at 22:36 Johannes Sixt <j6t@kdbg.org> wrote:
Am 29.01.26 um 12:09 schrieb Chris Idema via GitGitGadget:
> From: Chris Idema <github_chris_idema@proton.me>
>
> When reviewing a file before staging you want its content aligned using
> gui.tabsize. The prefixing of lines with +, - or space characters should
> not change this alignment. In gitk this is done correctly. In Git Gui not=
.
>
> Signed-off-by: Chris Idema <github_chris_idema@proton.me>
> ---

>
>  git-gui/lib/diff.tcl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
> index 442737ba4f..8be1a613fb 100644
> --- a/git-gui/lib/diff.tcl
> +++ b/git-gui/lib/diff.tcl
> @@ -385,6 +385,8 @@ proc read_diff {fd conflict_size cont_info} {
>  =09=09#
>  =09=09if {[string match {@@@ *} $line]} {
>  =09=09=09set is_3way_diff 1
> +=09=09=09apply_tab_size 2
> +=09=09} elseif {[string match {@@ *} $line]} {
>  =09=09=09apply_tab_size 1
>  =09=09}
>
Just "else" without a condition would have been sufficient, but we can
do it this way as well.

I've rewritten the commit message like so:

    git-gui: shift tabstops to account for the first column of patch text

    When reviewing a change before staging, it is desirable to see text aft=
er
    tabstops aligned the same way as in the text editor. However, since the=
re
    is always an additional character in column one in patch text ('+', '-'=
,
    or space), the alignment is broken if text before the first tab charact=
er
    is just long enough to push the stop to the next tab position.

    Commit a43c5f51a4b1 (git-gui: add configurable tab size to the diff vie=
w,
    2012-02-12) added infrastructure that manipulates the tabstop positions
    of the Tk text widget. However, it does so only when a 3-way diff is
    shown and only so that it takes into account the one additional markup =
at
    the beginning of lines. This only achieved that alignment does not get
    worse for 3-way diffs compared to regular patch text, but left misalign=
ed
    text in regular patch text unmodified.

    Use and modify this infrastructure to shift tabstops by one position fo=
r
    regular patch text and two positions for 3-way diffs. Existing code
    already resets the tabstops to an unshifted position when contents of
    untracked files are displayed.

    Signed-off-by: Chris Idema <github_chris_idema@proton.me>
    [j6t: extend commit message]
    Signed-off-by: Johannes Sixt <j6t@kdbg.org>

In particular there was no bug; this is a new feature.

Thanks,
-- Hannes


