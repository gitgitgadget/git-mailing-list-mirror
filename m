From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash.txt: Add new example
Date: Wed, 05 May 2010 12:46:32 -0700
Message-ID: <7v39y6jfmv.fsf@alter.siamese.dyndns.org>
References: <1273045035-7292-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Wed May 05 21:46:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9kYT-0000zW-Sz
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 21:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187Ab0EETqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 15:46:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880Ab0EETql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 15:46:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2E2B045E;
	Wed,  5 May 2010 15:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p8kSMQ00d7STUONqw97IKJ0tW4o=; b=X1CZTO
	NN3RH75JThVYTKymzEyIO1yfTcHJKvmooykmCQ9WfVmUUFsw7SPbflMbBgNJ/vVV
	CyXnWGyF7nNQgx53mS7wurRAhguPQOeBVhiaJ7eg6JRLQ+48kIq3GY7w7FaG0H0D
	utU8xevrJ6z3Pv7gT1eCfwf4HuSueVfM9Kl+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1EmxivLz8q9QS9K77/3ZQEsEfXQ9cpG
	/Myyj0HoIjaPc/nng/8vKaQxtNdTO+/plKf4eXeBTMLVLE6ysLqHzQ24dILenw7G
	7afVzUWx6XOPiQrFcTooegpVRwerlUCvKGlLvPbiI4f2Rz2qXoWLtk66YhiF2Mhl
	s0BXkkRrM/A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4570B045B;
	Wed,  5 May 2010 15:46:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2FA0B0459; Wed,  5 May
 2010 15:46:33 -0400 (EDT)
In-Reply-To: <1273045035-7292-1-git-send-email-jari.aalto@cante.net> (jari
 aalto's message of "Wed\,  5 May 2010 10\:37\:14 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA6B3382-587E-11DF-89BD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146414>

jari.aalto@cante.net writes:

> From: Jari Aalto <jari.aalto@cante.net>
>
> Add new example "Saving selected files to stash" thanks to
> ideas by Johan Sageryd <j416@1616.se>.
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-stash.txt |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 473889a..7d9f9e1 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -230,6 +230,18 @@ $ edit/build/test remaining parts
>  $ git commit foo -m 'Remaining parts'
>  ----------------------------------------------------------------
>  
> +Saving selected files to stash::
> +
> +You can use `git stash save --keep-index` to put only selected files
> +into the stash. Let's suppose the files A, B, C and D are modified and
> +you want to stash only C and D:
> ++
> +----------------------------------------------------------------
> +$ git status			# Verify what's modified
> +$ git add A B			# ...not these
> +$ git stash save --keep-index   # ...but stash all the others
> +----------------------------------------------------------------
> +

While the above is not _wrong_ per-se, it was somewhat hard to understand
for me without a description on _why_ you might want to do this.  It
didn't help that "put only selected files" really meant "get rid of
selected _changes_ from the working tree and the index temporarily".

I'd perhaps suggest rephrasing it like this:

        Sifting the Wheat from the Chaff::

        When you have changes to the working tree that mix what are
        necessary for the immediate task at hand, and what are needed
        later but not right now, you can first `git add` only the former
        and use `git stash save --keep-index` to get rid of the latter.
        The latter is temporarily stored in the stash.  

        Suppose you have changes to file A, B, and C, but only the half of
        changes to file A and C are necessary for what you are doing:

        $ git reset                     # make the index clean
        $ git add -p A C                # add necessary bits to the index
        $ git stash save --keep-index   # the remainder goes to the stash
        ... test, debug, perfect ...
        $ git commit
        $ git stash pop                 # get the remainder back
        ... and continue to work ...
