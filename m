From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Mon, 31 Oct 2005 13:27:26 -0800
Message-ID: <7vpsplcr7l.fsf@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com>
	<7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
	<20051031064105.GV8041@shell0.pdx.osdl.net>
	<43663EEA.5050102@zytor.com> <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 22:29:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhBk-0004mF-Ca
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVJaV13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVJaV13
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:27:29 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42404 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932083AbVJaV12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 16:27:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031212642.BKSX11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 16:26:42 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 1 Nov 2005 09:13:41 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10888>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Perhaps git-tla-glue, git-cvs-glue, git-svn-glue, where glue stands
> for importers, exporters, tools, etc?

That sounds sensible.  Also I think not having to install xlib
on the repository server is an advantage as you said in your
reply to Linus.

So here is a revised strawman, just to keep things in one place:

git::
	Depends on all of the below (may not be necessary).

git-*-glue::
	Tools to interoperate with foreign SCM systems,
	including importing (i.e. obtaining changes from them)
	and exporting (i.e. injecting our changes into them).

git-doc::
	Generated documentation from Documentation hierarchy.

git-scm::
	Depends on git-gitk and git-core -- people who want just
	a self contained SCM can install this and perhaps
	git-doc.

git-gitk::
	The gitk history browser.

git-core::
	The rest.  Meant for repository server installation.
