From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix 'git status --help' character quoting
Date: Sun, 19 Oct 2014 15:26:00 -0700
Message-ID: <xmqqwq7vr91j.fsf@gitster.dls.corp.google.com>
References: <1413728235-1504-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 00:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfyvg-00036Q-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 00:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbaJSW0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 18:26:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751476AbaJSW0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 18:26:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76E3917AEC;
	Sun, 19 Oct 2014 18:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ShfgZrdrfBG8SReFAhZ7w0wPXJI=; b=ZEUd5D
	kQYqi4PNOrsEKmdjeM5rMKTKi071SuWX4aR/9PIYSReYMSNYA6972Arfk0VneGnS
	qQXIW7xrLFjf2XdU8iNN2sqZYZE84CZs2I4g6v/iUe1+nw6pD56amNjddOv5wu/W
	uTu86eV4h4ci3UukG7/Ul0d4+Yx6v8Td9Bg10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L6LjAz3K/B1rRlaO9ngyJSX/ZtRtTU9Z
	aQOn6DkblzAwz9rPstqjGtZkfa0objnz4mIM60LmgqOnGvzDd8/iqvJ9b4vgA2o5
	T7ZoJTw700vRipMNLr6sUBmDesQT5radhyVtrDY/tmn9veMV9X1KdvKfKQENuFQ/
	T69rT0IgoCY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C54517AEB;
	Sun, 19 Oct 2014 18:26:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E616E17AEA;
	Sun, 19 Oct 2014 18:26:01 -0400 (EDT)
In-Reply-To: <1413728235-1504-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Sun, 19 Oct 2014 15:17:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E84A5402-57DE-11E4-AC20-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> Correct backtick quoting for some of the modification states to give
> consistent web rendering.

This is to match the way how "XY PATH1 -> PATH2" is typeset, I
presume.  Some in the body text are already `XY` to match, but some
others are not, and you are fixing them, all of which look good.

> While at it, use 00 for ASCII NUL to avoid any confusion with the letter O.

I do not think this is particularly a good change.  We try to follow
the convention of spelling ASCII value in decimal (e.g. "ASCII
double quote (34)"), and "00" is not the way how you usually spell a
number in decimal.  Existing description is perfectly fine; there is
no risk for anybody to mistake "O" (oh) as part of digits, whether
you use decimal or hexadecimal.

If you have an aversion to mentioning ASCII when clarifying which
character we talk about, you could of course do s/ASCII 0/'\0'/ but
I do not know if that is an improvement.

Thanks.

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> Noticed when reviewing a stackoverflow problem where the OP actually
> desired to just list those files with merge indicators present.
> ---
>  Documentation/git-status.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index def635f..1c01d3ac 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -116,7 +116,7 @@ In the short-format, the status of each path is shown as
>  
>  where `PATH1` is the path in the `HEAD`, and the " `-> PATH2`" part is
>  shown only when `PATH1` corresponds to a different path in the
> -index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
> +index/worktree (i.e. the file is renamed). The `XY` is a two-letter
>  status code.
>  
>  The fields (including the `->`) are separated from each other by a
> @@ -125,7 +125,7 @@ characters, that field will be quoted in the manner of a C string
>  literal: surrounded by ASCII double quote (34) characters, and with
>  interior special characters backslash-escaped.
>  
> -For paths with merge conflicts, `X` and 'Y' show the modification
> +For paths with merge conflicts, `X` and `Y` show the modification
>  states of each side of the merge. For paths that do not have merge
>  conflicts, `X` shows the status of the index, and `Y` shows the status
>  of the work tree.  For untracked paths, `XY` are `??`.  Other status
> @@ -189,7 +189,7 @@ There is also an alternate -z format recommended for machine parsing. In
>  that format, the status field is the same, but some other things
>  change.  First, the '\->' is omitted from rename entries and the field
>  order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
> -(ASCII 0) follows each filename, replacing space as a field separator
> +(ASCII 00) follows each filename, replacing space as a field separator
>  and the terminating newline (but a space still separates the status
>  field from the first filename).  Third, filenames containing special
>  characters are not specially formatted; no quoting or
