From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Thu, 5 Apr 2007 10:05:18 +0200
Message-ID: <200704051005.19076.chriscool@tuxfamily.org>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org> <7virck8txp.fsf@assigned-by-dhcp.cox.net> <200704051001.52592.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 09:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZMqL-0002ig-FF
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 09:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946058AbXDEH5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Apr 2007 03:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946065AbXDEH5K
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 03:57:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:56660 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946058AbXDEH5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2007 03:57:08 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 30654B92F9;
	Thu,  5 Apr 2007 09:57:08 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <200704051001.52592.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43806>

Ooops again! Sorry, this message was sent before it was finished.
Please ignore it. I will resend a good one latter.

Thanks,
Christian.


Le jeudi 5 avril 2007 10:01, Christian Couder a =E9crit :
> Le jeudi 29 mars 2007 08:06, Junio C Hamano a =E9crit :
>
> [...]
>
> > The thing is, the more you add policy to a building block, the
> > less generally useful the building block becomes.  The reason I
> > took "git bisect run" is because for the simplest use case, it
> > can be used without writing a specialized "run script" (you can
> > give "make test" to it, for example).  And more importantly, in
> > the case of "run", there is not much policy involved.  It is a
> > good command to have in a building block because what it does is
> > purely to automate what the user would perform mechanically by
> > hand anyway.  One thing I would want is to keep the bisect
> > subcommands to the minimum, so that people can easily use it as
> > a building block in their automation, without having to hunt
> > through many workflow-specific subcommands that do not suit
> > their particular needs.
>
> I understand this.
>
> > Catering to their particular needs are
> > better handled in their scripts, including your "I have one
> > known good commit, I do not know if the tip is good, and I want
> > to dig down from the tip only when the tip is bad" case.
>
> But I think this is not a specific need. Many people are doing nightl=
y
> builds and it's a good practice, so we should encourage them by makin=
g it
> as easy as possible.
>
> Perhaps a new git subcommand instead of a git bisect subcommand.
>
> For a nightly build you want to do something like:
>
> my_build_script || {
> 	git bisect start &&
> 	git bisect bad &&
> 	git bisect good good_rev &&
> 	git bisect run my_script
> }

[...]
