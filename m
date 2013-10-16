From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] doc: git-foo was obsoleted several years ago
Date: Wed, 16 Oct 2013 14:38:27 -0700
Message-ID: <xmqq7gdc7v70.fsf@gitster.dls.corp.google.com>
References: <1379763429-3443-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:38:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYnf-0007vC-5u
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab3JPVib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:38:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991Ab3JPVia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:38:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8214BCF9;
	Wed, 16 Oct 2013 21:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cOgh4g3iA26LHUvIJM2m/Yx1Yms=; b=sUpFySyq494aRubBBED9
	kzUp2XeIVtkD7lfCYELIaB2IjLCuR1YyD7bzVn1QxPdQLyVP6gpb0EdeJx169bWJ
	UGxz2UEBUwHbXagZPdA21etDu6bj9P/tMdyjcVAblI2tCX7EL6sEZDhtdmWrXrLA
	MK1RVEcQ0fFgjWVLkqq1xio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Y8WtRAozWrojM/i9CNgkZY6UbzHaopYtXcw1leNM05N/s7
	AFEj7r33bJn8F5JZOfsjWeP9gl42dFiZT5XNSGD2j9Ss7BTrWVBvAoU6bC6QyR8H
	0RVjc74ZH5k0c9hg5VC6ma1mCxCV2gzAd1EgyTj6NsXXSMznxT4skItmgOmQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114574BCF8;
	Wed, 16 Oct 2013 21:38:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 677FE4BCF7;
	Wed, 16 Oct 2013 21:38:29 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4C0AF632-36AB-11E3-8DF9-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236263>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So replace 'git-foo' with 'git foo'.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-checkout.txt | 4 ++--
>  Documentation/git-commit.txt   | 4 ++--
>  Documentation/git-rebase.txt   | 4 ++--
>  Documentation/git-status.txt   | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Running

    $ head Documentaiton/git-c*.txt

shows that others e.g. git-cat-file.txt also begin with the same
pattern, i.e. git-dashed-command(section) as the first header, and
name section also lists the command in the dashed form, which makes
one wonder why only these four are singled-out. It could have been
"This is merely an RFC to show the kind fo things the submitter
thinks we need to do; the real version, if list agrees that it is a
good thing to do, would cover a lot more files.", but then it would
have saved wasted time guessing if the message said so.

I recall that I wanted to see this change happen myself long time
ago, and suspect that there may have been some reason that prevented
us from doing so.  I might have found that AsciiDoc back then did
not like the input if the headline name "git-checkout(1)" did not
match the filename "git-checkout.txt" and the command in the NAME
section "git-checkout", or links "linkgit:git-checkout[1]" from
other pages couldn't have SP there, or something silly like that.

Also doesn't our build infrastructure slurp the one-line description
"git-checkout - Checkout a branch ..." from these files and expect a
dash to be there?

In short, I personally do prefer to see dashless form at the top of
the manpage, if it does not break other things, and there may need
changes necessary to avoid breaking other things may to files other
than these documentation-proper source files.

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index ca118ac..8d98383 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -1,9 +1,9 @@
> -git-checkout(1)
> +git checkout(1)
>  ===============
>  
>  NAME
>  ----
> -git-checkout - Checkout a branch or paths to the working tree
> +git checkout - Checkout a branch or paths to the working tree
>  
>  SYNOPSIS
>  --------
> ...
