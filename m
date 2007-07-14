From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fall back to mozilla's sha.h if openssl/sha.h is not available
Date: Sat, 14 Jul 2007 17:12:31 +0200
Message-ID: <20070714151231.GD2544@steel.home>
References: <11844050771857-git-send-email-madduck@madduck.net> <20070714142350.GB2544@steel.home> <20070714145013.GA14488@piper.oerlikon.madduck.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 17:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9jIV-0006CX-FV
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 17:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbXGNPMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 11:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756771AbXGNPMe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 11:12:34 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:52723 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889AbXGNPMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 11:12:34 -0400
Received: from tigra.home (Fc894.f.strato-dslnet.de [195.4.200.148])
	by post.webmailer.de (mrclete mo48) (RZmta 8.3)
	with ESMTP id R00299j6EAOVWX for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 17:12:32 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 29E08277BD
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 17:12:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 97CF7C164; Sat, 14 Jul 2007 17:12:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070714145013.GA14488@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+by+8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52486>

martin f krafft, Sat, Jul 14, 2007 16:50:13 +0200:
> also sprach Alex Riesen <raa.lkml@gmail.com> [2007.07.14.1623 +0200]:
> > > This should possibly go to configure.ac, but maybe *also* to Makefile to make
> > 
> > Definitely. It should it least skip the test if NO_OPENSSL is already
> > defined.
> 
> Reading this as a yes, here is the patch adding this. ...

I was not clear. Read it as NO.

> My autotools knowledge is limited, but I might then look at adding
> the fall back to configure.ac too.

Some (me, for one) will consider it the only place where it should be

> Btw: I've done a lot of things wrong on this mailing list already,
> for which I'd like to apologise. Thanks to those who told me
> privately off my faux pas. I hope those won't be necessary anymore.

If I were you, I would have considered CPPFLAGS and CFLAGS and added a
check if HAS_OPENSSL already set.

And BTW doesn't it strike you as a little bit odd that noone has done
that in Makefile before you? Could that be because configure is
considered the _right_ place for this kind of stuff?
