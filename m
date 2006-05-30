From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Mon, 29 May 2006 21:26:59 -0700
Message-ID: <7vslms3zos.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
	<7virno79a7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
	<7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605292112530.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 06:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkvov-0005tL-K6
	for gcvg-git@gmane.org; Tue, 30 May 2006 06:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWE3E1B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 00:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWE3E1B
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 00:27:01 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20192 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751487AbWE3E1A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 00:27:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530042659.BSLL24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 00:26:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605292112530.5623@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 29 May 2006 21:17:06 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21010>

Linus Torvalds <torvalds@osdl.org> writes:

> Having to move around whole patches in the editor is not what you want to 
> do.

I know.  What I meant was:

	$ format-patch >those-patches
        $ am -i those-patches
	.. say no to the first two and yes to the third one
        $ am -i those-patches ;# again!!
        .. say yes to the first two

> I was thinking more along the lines of
>
>  (a) git-rev-list --pretty=oneline "$upstream"..ORIG_HEAD > rev-list
>
>  (b) edit the rev-list, moving the single lines around, deleting them, etc
>
>  (c) cat rev-list |
>      git-format-patch -k --stdout --stdin --full_index |
>      git-am
>
> because the "--pretty=oneline" format is actually very nice as a way to 
> re-order things and select single commits to be deleted or whatever..

I like this approach as well.
