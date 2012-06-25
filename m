From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive.perl: Remove two unused variables
Date: Sun, 24 Jun 2012 22:41:58 -0700
Message-ID: <7vfw9khrrt.fsf@alter.siamese.dyndns.org>
References: <4FE7889E.2020009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: "Thomas \"Enki\" Badie" <thomas.badie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:42:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj23s-0004Zg-G8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 07:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab2FYFmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 01:42:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab2FYFmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 01:42:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 208143F42;
	Mon, 25 Jun 2012 01:42:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLxo626ZYMpp70TUUiOIl1BwH+k=; b=qEPhqR
	1QZ5YNmCp+1b5ueMKXuWOteR7kKH0hudIpG0Tu8cq47ijwV7D06S8ZVcYNx4zcDo
	ZHXr52s1AogaumrixEbsf4vuIcWbO1HdLDiEg8treG5nfcTrxugLzbRhJpIH/b+1
	9CRicyUrYVcOkA5ZwIt83tMCiJWf4smYBQ1Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wCxGf0uawzcIOYTIafXgQspT6GCdN63O
	ZVVrfB8IYXOD737OypG3TPTlFtzCqUYYlZEViMBULPBTu0lOWLMW7QrDi1c5Z4v5
	Gsih1omPK4cXFdeUznUuq6RULKhzf3UFeMwFuIrpRMpMiJHFI0+QiyJiN8VPkq7q
	0BIYdSaLulk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 121D73F41;
	Mon, 25 Jun 2012 01:42:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 686E33F40; Mon, 25 Jun 2012
 01:42:00 -0400 (EDT)
In-Reply-To: <4FE7889E.2020009@gmail.com> (Thomas Badie's message of "Sun, 24
 Jun 2012 23:37:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C14CEDA-BE88-11E1-B0C2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200546>

"Thomas \"Enki\" Badie" <thomas.badie@gmail.com> writes:

> The patch 8f0bef6 refactors this script and leaves the `$fh' variable
> unused in `diff_applies' and `patch_update_file'.
>
> Signed-off-by: Thomas Badie <badie@lrde.epita.fr>
> ---
> Hello,
> This is my first patch. It introduces a really minor change, and I
> also want to be sure the way I submit it is the right way. Thanks :)

The patch submission is almost perfect, except that:

 (1) the patch seems to be whitespace damaged; and

 (2) the author of the problematic commit should have been Cc'ed
     (especially when he is still an active participant on the list)
     to give him a chance to Ack it (I'm adding Thomas for this).

Thanks.  I like that you identified why this is a good thing by
quoting the problematic change.

>  git-add--interactive.perl |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index d948aa8..710764a 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1067,7 +1067,6 @@ EOF
>  }
>
>  sub diff_applies {
> -       my $fh;
>        return run_git_apply($patch_mode_flavour{APPLY_CHECK} . '--check',
>                             map { @{$_->{TEXT}} } @_);
>  }
> @@ -1514,7 +1513,6 @@ sub patch_update_file {
>        }
>
>        if (@result) {
> -               my $fh;
>                my @patch = reassemble_patch($head->{TEXT}, @result);
>                my $apply_routine = $patch_mode_flavour{APPLY};
>                &$apply_routine(@patch);
