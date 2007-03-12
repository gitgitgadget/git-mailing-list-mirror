From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 21:40:41 +0100
Message-ID: <20070312204041.GA31018@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx> <20070312121226.GB2268@always.joy.eth.net> <20070312131253.GA16452@moooo.ath.cx> <fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com> <20070312140808.GA17450@moooo.ath.cx> <7vabyitlld.fsf@assigned-by-dhcp.cox.net> <20070312180837.GA22701@moooo.ath.cx> <7vird6qlbn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:40:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQrK6-00077K-Ne
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 21:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbXCLUkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 16:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbXCLUkp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 16:40:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:52730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752896AbXCLUko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 16:40:44 -0400
Received: (qmail invoked by alias); 12 Mar 2007 20:40:43 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp045) with SMTP; 12 Mar 2007 21:40:43 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18N5MlIZk0NSHpBCT2kZ7TUGj3MQ6JDdpLq1hijoD
	tdPbRwHVI/ZDpd
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vird6qlbn.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42080>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > I just thought that GIT_WORK_DIR should be relative to the current
> > working directory because it's more intuitive, e.g.
> >
> >     $ git --git-dir=/path/to/repo.git --work-dir=../.. add a
> >
> > where ../.. matches the path to the toplevel working directory from
> > cwd.  But this definitely is annoying when changing directories.
> 
> Not so fast.  That was a trick suggestion, only meant to see if
> you have thought through the issues, and you did not have to
> agree with me so quickly ;-).

Well, I have no strong feelings for either handling because I'll
probably always use `pwd`/relative/path anyway.

Is there anything more to this decision than this?

GIT_WORK_DIR relative to cwd:
    git --work-dir <path> [..] is more intuitive

GIT_WORK_DIR relative to $GIT_DIR:
    $GIT_DIR/workdir and $GIT_WORK_DIR are interpreted exactly the
    same way, which primarily makes it easier to implement git init
    with --work-dir :-)

> By the way, I do not find your command line example intuitive at
> all, whether the --work-dir= parameter is relative or absolute.
> Do you honestry expect that loooong command line is something
> people would use in real life?

For one-shot things I prefer --git-dir and --work-dir over
GIT_DIR and GIT_WORK_DIR because they are lowercase and for
GIT_WORK_DIR it's even shorter; and all the examples were one-shot
things (well, one used the same --git-dir twice).
