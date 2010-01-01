From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/4] Documentation: reset: add some tables to describe
 the different options
Date: Thu, 31 Dec 2009 21:15:34 -0800
Message-ID: <7vd41uo16x.fsf@alter.siamese.dyndns.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
 <20091230055448.4475.83629.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 06:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQZrq-00016z-14
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 06:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267Ab0AAFQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 00:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236Ab0AAFQA
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 00:16:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0AAFP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 00:15:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72C9EABFFB;
	Fri,  1 Jan 2010 00:15:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=j/UTGMPNyq+4DSrpNOVo6h+E7yc=; b=DkzMVYNyZGlohHL78eXqtYH
	Q+2RnH5RaLUcI/gFP2kXWsWlFbBoZiskDlsF31hmZ6fZLUghDLkSc9TliXu+ydPh
	Od1tzLJFpxf6BDHWSHeNEIULu6sMcscttnGfsmSNcHoGYhNxm7Ge2Td0cpTApZ5d
	gH9PJMqu1rCzBRu6CyfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=doTBLWIoJJkj7FBNO2iwtJ1rIFrjm2sYmJHMA+m+ssfvJsTrx
	OEVCALQ6D1UJo5LtziD4nWeqOzRt2p1meLdPfvdCVQrg4pkKR+d4l98bEVf0sZu6
	xzbwJA2duvEDAWJSdlgvLx9sNcaJ+a/XIJq6qjoWydEzAtS38UBk4qyC4g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1005ABFF9;
	Fri,  1 Jan 2010 00:15:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA669ABFF0; Fri,  1 Jan 2010
 00:15:35 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B91064F2-F694-11DE-A2BE-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136001>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch adds a DISCUSSION section that contains some tables to
> show how the different "git reset" options work depending on the
> states of the files in the working tree, the index, HEAD and the
> target commit.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Much nicer.

>  Documentation/git-reset.txt |   66 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 66 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 2d27e40..c9044c9 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -67,6 +67,72 @@ linkgit:git-add[1]).
>  <commit>::
>  	Commit to make the current HEAD. If not given defaults to HEAD.
>  
> +DISCUSSION
> +----------
> +
> +The tables below show what happens when running:
> +
> +----------
> +git reset --option target
> +----------
> +
> +to reset the HEAD to another commit (`target`) with the different
> +reset options depending on the state of the files.

Together with these "mechanical definitions", I think the readers would
benefit from reading why some are disallowed.

> +      working index HEAD target         working index HEAD
> +      ----------------------------------------------------
> +       A       B     C    D     --soft   A       B     D
> +                                --mixed  A       D     D
> +                                --hard   D       D     D
> +                                --merge (disallowed)

"reset --merge" is meant to be used when resetting out of a conflicted
merge.  Because any mergy operation guarantees that the work tree file
that is involved in the merge does not have local change wrt the index
before it starts, and that it writes the result out to the work tree, the
fact that we see difference between the index and the HEAD and also
between the index and the work tree means that we are not seeing a state
that a mergy operation left after failing with a conflict.  That is why we
disallow --merge option in this case, and the next one.

> +      working index HEAD target         working index HEAD
> +      ----------------------------------------------------
> +       A       B     C    C     --soft   A       B     C
> +                                --mixed  A       C     C
> +                                --hard   C       C     C
> +                                --merge (disallowed)

The same as above, but you are resetting to the same commit.

> +      working index HEAD target         working index HEAD
> +      ----------------------------------------------------
> +       B       B     C    D     --soft   B       B     D
> +                                --mixed  B       D     D
> +                                --hard   D       D     D
> +                                --merge  D       D     D

> +      working index HEAD target         working index HEAD
> +      ----------------------------------------------------
> +       B       B     C    C     --soft   B       B     C
> +                                --mixed  B       C     C
> +                                --hard   C       C     C
> +                                --merge  C       C     C

As this table is not only about "--merge" but to explain "reset", I think
other interesting cases should also be covered.

w=A	i=B	H=B	t=B

This is "we had local change in the work tree that was unrelated to the
merge", and "reset --merge" should be a no-op for this path.

w=A	i=B	H=B	t=C

This "reset --merge" is like "using checkout to switch to a commit that
has C but we have changes in the work tree", and should fail just like
"checkout branch" in such a situation fails without "-m" option.
