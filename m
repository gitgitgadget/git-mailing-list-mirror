X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Wed, 20 Dec 2006 11:37:12 -0800
Message-ID: <7vslfae4uv.fsf@assigned-by-dhcp.cox.net>
References: <200612200901.30584.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 19:37:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612200901.30584.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 20 Dec 2006 09:01:30 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34955>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx7Ff-0002HW-DU for gcvg-git@gmane.org; Wed, 20 Dec
 2006 20:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030305AbWLTThQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 14:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWLTThP
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 14:37:15 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60686 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030311AbWLTThO (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 14:37:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220193713.JWUB20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 14:37:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 17cX1W00V1kojtg0000000; Wed, 20 Dec 2006
 14:36:32 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Problems:
>  - git-prune in the submodule could destroy supermodule-referenced
>    commits
>  - no checkout support
>  - no merge support (other than what git provides for the .gitmodule
>    file)
>  - no check for dirty submodule before commit
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

I do not think these are insurmountable.

As you fix them and enhance the support, I suspect you would
want a separate command to manage .gitmodule file and submodules
referenced by it.  I think it would be better to keep the patch
to the template to the minimum (for example, run "git submodule
update" if there is .gitmodules file at the toplevel), and
implement the body of the processing in "git-submodule.sh", or
something like that.
