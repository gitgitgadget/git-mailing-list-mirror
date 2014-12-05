From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: make clear --assume-unchanged's user contract
Date: Fri, 05 Dec 2014 14:50:34 -0800
Message-ID: <xmqqtx19ogn9.fsf@gitster.dls.corp.google.com>
References: <1417818117-368-1-git-send-email-philipoakley@iee.org>
	<1417818117-368-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:50:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1i1-0002YC-Rp
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbaLEWuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:50:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751166AbaLEWuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 17:50:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB73C247B9;
	Fri,  5 Dec 2014 17:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3cPUCMYoklOYJYqd0guN1U37u3A=; b=LDHRDV
	89yZdRb/BegGDOhWKxK/YewptotMy4wqJGuK131z503nW3Xa4prQN8usWDUSD+FN
	XteuSQxCFFyBG2ddWrScDVqf6ndMA2BUXxpZYUjggMjSJP5PxkQoiEL+oZ4QLrOI
	qtUhLnStgQto3gBr87C9e9ByhaUV3f/jA2CBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYy8yJwYJaLG06gUjPRvmFZPQPRom1EM
	DAn0uibkcxF4YPUR3MvSQTuAACXq0HZnrqJIbDKTZZjkvDWLe0t+cvhozLB6Zdq6
	aWhaesXKCl+OW8Wu2tbZelvWjVqxrpAHik5fU1lUb485QtvPJmH9tAnU3o8Saqe3
	fsnafb5YZes=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E107F247B8;
	Fri,  5 Dec 2014 17:50:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F4C5247B7;
	Fri,  5 Dec 2014 17:50:35 -0500 (EST)
In-Reply-To: <1417818117-368-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Fri, 5 Dec 2014 22:21:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FF3FC48-7CD1-11E4-B87E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260906>

Philip Oakley <philipoakley@iee.org> writes:

> Many users misunderstand the --assume-unchanged contract, believing
> it means Git won't look at the flagged file.

Yeah, I suspect that many of them come from how-tos floating on the
'net (e.g. stackoverflow) that are misguided or outright incorrect.
I've stopped correcting people who advise "you can flip this bit and
squelch your changes from appearing in diffs" number of years ago.

> Be explicit that the --assume-unchanged contract is by the user that
> they will NOT change the file so that Git does not need to look (and
> expend, fore example, lstat(2) cycles)

Yes, but "so that Git does not ..." part is already very clear in
the existing part of the document.  Stressing that this is the user
making a promise to help Git help the user is indeed a good idea.

> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/git-update-index.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 929869b..c045509 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -82,13 +82,14 @@ OPTIONS
>          Set the execute permissions on the updated files.
>  
>  --[no-]assume-unchanged::
> -	When these flags are specified, the object names recorded
> +	When this flag is specified, the object names recorded

Thanks.  We are talking about a single flag bit.

>  	for the paths are not updated.  Instead, these options
>  	set and unset the "assume unchanged" bit for the

"this option sets/unsets"?

> -	paths.  When the "assume unchanged" bit is on, Git stops
> +	paths.  When the "assume unchanged" bit is on, the user promise
> +	is not to change the file, so Git stops

"the user promises not to".

>  	checking the working tree files for possible
> -	modifications, so you need to manually unset the bit to
> -	tell Git when you change the working tree file. This is
> +	modifications, so when you change the working tree file you
> +	need to manually unset the bit to tell Git . This is

This reads much better than the original, but you may want to go a
bit further.  How about removing the original a bit more, like so:

	... the user promises not to change the file and allows Git
        to assume that the working tree file matches what is
        recorded in the index.  If you want to change the working
        tree file, you need to unset the bit to tell Git.  This is

>  	sometimes helpful when working with a big project on a
>  	filesystem that has very slow lstat(2) system call
>  	(e.g. cifs).

Thanks.
