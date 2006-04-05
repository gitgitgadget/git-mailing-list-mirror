From: Junio C Hamano <junkio@cox.net>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 01:14:16 -0700
Message-ID: <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 10:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR39l-0002ZA-49
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 10:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWDEIOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 04:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWDEIOT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 04:14:19 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:8946 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751055AbWDEIOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 04:14:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405081418.ZRQV17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 04:14:18 -0400
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com> (moreau
	francis's message of "Wed, 5 Apr 2006 09:30:22 +0200 (CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18424>

moreau francis <francis_moreau2000@yahoo.fr> writes:

> For now they only send me the text updates through patch and attach new images
> with the patch email. Then I do:
>
>         $ git am < text_only_patch
>         $ git reset --soft HEAD^
>         $ git add <new images>
>         $ git commit -a -C ORIG_HEAD
>
> Now my question: is it the best way to achieve this process ?

If I were doing that today, I would be doing almost exactly the
above sequence, or:

	$ git am patch
        $ git add <new images>
        $ git commit -a --amend

It _might_ make sense to adopt a well-defined binary patch
format (or if there is no prior art, introduce our own) and
support that format with both git-diff-* brothers and git-apply,
but that would be a bit longer term project.


        
