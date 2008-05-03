From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH amend] git-bisect.sh: don't accidentally override existing branch "bisect"
Date: Sat, 3 May 2008 10:42:31 +0200
Message-ID: <200805031042.32190.chriscool@tuxfamily.org>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org> <200804302330.18354.chriscool@tuxfamily.org> <20080502085620.3361.qmail@17e811992e6d42.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat May 03 10:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsDGB-00065X-Px
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 10:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbYECIhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 May 2008 04:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbYECIhg
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 04:37:36 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52883 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755788AbYECIhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2008 04:37:35 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6D6121AB2DD;
	Sat,  3 May 2008 10:37:34 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 391CC1AB2CA;
	Sat,  3 May 2008 10:37:34 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080502085620.3361.qmail@17e811992e6d42.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81062>

Le vendredi 2 mai 2008, Gerrit Pape a =E9crit :

[...]
> @@ -328,8 +333,8 @@ bisect_next() {
>  	exit_if_skipped_commits "$bisect_rev"
>
>  	echo "Bisecting: $bisect_nr revisions left to test after this"
> -	git branch -f new-bisect "$bisect_rev"
> -	git checkout -q new-bisect || exit
> +	git branch -D new-bisect

Doesn't this output an error if the branch "new-bisect" does not exists=
 ?

$ git branch -D new-bisect
error: branch 'new-bisect' not found.

> +	git checkout -q -b new-bisect "$bisect_rev" || exit
>  	git branch -M new-bisect bisect
>  	git show-branch "$bisect_rev"
>  }

Thanks,
Christian.
