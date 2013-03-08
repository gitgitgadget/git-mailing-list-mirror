From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Fri, 8 Mar 2013 18:29:31 +0100 (CET)
Message-ID: <886271566.251606.1362763771332.JavaMail.root@openwide.fr>
References: <7vboathkla.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Paul Campbell <pcampbell@kemitix.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 18:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE17G-0005GZ-Jb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 18:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805Ab3CHR3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 12:29:33 -0500
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:45695 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab3CHR3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 12:29:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id D4FFC280A1;
	Fri,  8 Mar 2013 18:29:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I4j8lrAdJd-K; Fri,  8 Mar 2013 18:29:31 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 6C17428065;
	Fri,  8 Mar 2013 18:29:31 +0100 (CET)
In-Reply-To: <7vboathkla.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217670>

----- Mail original -----
> Jeremy Rosen <jeremy.rosen@openwide.fr> writes:
> 
> > 506,513c506,507
> > < 		case "$2" in
> > < 		*\**) # Avoid pulling in multiple branches
> > < 			die "'$2' contains a wildcard"
> > < 			;;
> > < 		*:*) # Don't create a local branch for the subtree
> > < 			die "'$2' contains a local branch name"
> > < 			;;
> > < 		esac
> > ---
> >> 		git ls-remote --exit-code $1 $2 ||
> 
> You would need to quote $1 and $2 properly to prevent the shell from
> splitting them into words, no?
> 

yes... I'm not very good at shell programming, good catch

> >> 		die "'$2' is not a correct reference on '$1'"
> 
> > 535c529
> > < 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
> > ---
> >> 	revs=$(git rev-parse $default --revs-only "$1^{commit}") || exit
> >> 	$?
> 
> Is it guaranteed that your $# is 1 at this point, or is it something
> you would also need to check here, or perhaps in the caller of this
> function (I cannot tell offhand in a patch without any context)?
> 

I have checked the call sites and yes we can only have one arguement at
this point. so the $@ to $1 is more about future-proofing and readability


thx for proofreading
