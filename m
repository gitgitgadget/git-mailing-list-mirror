From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Wed, 17 Oct 2007 15:59:04 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171553580.26902@woody.linux-foundation.org>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
 <471302D2.6010405@trolltech.com> <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
 <200710150902.52653.johan@herland.net> <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
 <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
 <0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com>
 <85ve98gl57.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	David Symonds <dsymonds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Marius Storm-Olsen <marius@trolltech.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:01:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiHsv-00014O-1c
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759864AbXJQXAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760163AbXJQXAe
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:00:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54769 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759146AbXJQXAc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 19:00:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HMx6xN000326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 15:59:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HMx4pW012595;
	Wed, 17 Oct 2007 15:59:04 -0700
In-Reply-To: <85ve98gl57.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.217 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61436>



On Mon, 15 Oct 2007, David Kastrup wrote:

> Geert Bosch <bosch@adacore.com> writes:
> 
> > On Oct 15, 2007, at 13:53, David Symonds wrote:
> >> That's also why I suggested "skip"; you might not be able to test a
> >> particular commit, but you might also not *want* to test a particular
> >> commit for some reason.
> >
> > Skip seems a great choice: it directly expresses the wish to
> > not consider a certain commit. The reason is unimportant.
> 
> But it is an _action_, while "good" and "bad" are properties.

Well, this has been debated to death, but I actually think that "skip" is 
a good choice, exactly because it's an action.

"good" and "bad" do indeed describe properties of the commit, and are used 
to describe the state of the tree in question. In contrast, "git bisect 
skip" says not somethign about the state of that tree - it talks about 
what we should *do* with that tree.

IOW, I think "git bisect skip" in some sense has more to do with an action 
like "git bisect start", than with "good" or "bad". 

(Yes, "good" and "bad" have an action associated with them too - namely to 
start the next bisection event - but they are not named according to the 
action they cause, but because they describe the tree state)

			Linus
