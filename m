From: Junio C Hamano <junkio@cox.net>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 12:00:44 -0700
Message-ID: <7vbqpja8wz.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	<20060913152451.GH23891@pasky.or.cz>
	<Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz93a9v9.fsf@assigned-by-dhcp.cox.net> <ee9jv6$ga0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 21:01:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNZya-0006lW-QR
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 21:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWIMTAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWIMTAq
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 15:00:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49104 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751103AbWIMTAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 15:00:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913190045.VHLV12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 15:00:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mv0a1V00E1kojtg0000000
	Wed, 13 Sep 2006 15:00:34 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ee9jv6$ga0$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	13 Sep 2006 20:51:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26932>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Using tag has an added benefit that you now have a place to say
>> why you dropped it.  So what we would need to support this is an
>> agreed-upon name under $GIT_DIR/refs/ that is omitted from
>> display by convention across Porcelains (the core side should
>> not ignore them because even when you are abandoning them, you
>> do not want to lose them),
>
> I think that using hidden directory (dot-directory), e.g.
> $GIT_DIR/refs/.abandoned/ is a good idea... unless it conflicts somewhat
> with the way lock files are named...

Names are not interesting.  Visualizers ignoring them
consistently is.

By the way, does gitweb still walk $GIT_DIR/refs hierarchy by
hand to find out the set of refs?  When Linus is done with his
refs/ work, that way would become unsupported.  You would need
to read from "ls-remote $GIT_DIR".
