From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: mention ORIG_HEAD in am, merge, and rebase
Date: Tue, 08 Jul 2008 12:23:54 -0700
Message-ID: <7vmykstc1h.fsf@gitster.siamese.dyndns.org>
References: <35BBB0D4-B3E1-4097-AF11-E0F6223125EA@silverinsanity.com>
 <1215490342-46590-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGIoF-00027X-4R
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbYGHTYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbYGHTYJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:24:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbYGHTYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:24:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0D6E14538;
	Tue,  8 Jul 2008 15:24:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F34E614532; Tue,  8 Jul 2008 15:24:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E0C0B3A-4D23-11DD-9145-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87789>

Brian Gernhardt <benji@silverinsanity.com> writes:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f3459c7..37382c4 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -26,7 +26,8 @@ of commits that would be shown by `git log <upstream>..HEAD`.
>  
>  The current branch is reset to <upstream>, or <newbase> if the
>  --onto option was supplied.  This has the exact same effect as
> -`git reset --hard <upstream>` (or <newbase>).
> +`git reset --hard <upstream>` (or <newbase>).  This includes setting
> +ORIG_HEAD to the pre-rebase tip of the branch.
>  
>  The commits that were previously saved into the temporary area are
>  then reapplied to the current branch, one by one, in order. Note that

I found the above "This includes" part very hard to understand --- it took
me three re-reads to connect "This" and "the exact same effect".  Is it
just me?

I wonder if this is easier to understand:

        The current branch is reset to <upstream>, or <newbase> if the
        --onto option was supplied.  This has the exact same effect as
        `git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
        to point at the tip of the branch before this resetting happens.
