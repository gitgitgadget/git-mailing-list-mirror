From: Yann Dirson <ydirson@altern.org>
Subject: Re: [ANNOUNCE]: PyGit and libgit-thin
Date: Wed, 25 Jul 2007 21:50:10 +0200
Message-ID: <20070725195010.GA30277@nan92-1-81-57-214-146.fbx.proxad.net>
References: <e28f90730707230535q33658efevf665d795cf1df87c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Luiz Fernando N. Capitulino" <lcapitulino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 21:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDmt6-0002xd-Jc
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 21:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbXGYTvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXGYTvI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 15:51:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:36305 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXGYTvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 15:51:06 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8BD615A210;
	Wed, 25 Jul 2007 21:51:03 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 508965A19D;
	Wed, 25 Jul 2007 21:51:03 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2C1631F084; Wed, 25 Jul 2007 21:50:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e28f90730707230535q33658efevf665d795cf1df87c@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53708>

On Mon, Jul 23, 2007 at 09:35:47AM -0300, Luiz Fernando N. Capitulino wrote:
> Now I need to know whether this' really useful to other people and
> if so, what would be missing for you to start using it.

The python module would really be useful to StGIT.  Currently, an
stgit commands typically has to fork several git commands at least,
and using library calls instead would surely help with the
performance.

I had a quick look at the current pygit API (as described in the
README), and I find the current revlist one somewhat confusing.  Why
using post-contructor methods, and not using named args in the
constructor itself ?

That is, the example reading:

>>> rv = repo.revlist()
>>> rv.include('8d9107e8c50e1c4ff43c91c8841805833f3ecfb9')
>>> rv.count = 10
>>> rv.show_merges()
>>> for commit in rv:
...  print commit.id()
... 


would be IMHO much nicer to use as:

>>> rv = repo.revlist(include=('8d9107e8c50e1c4ff43c91c8841805833f3ecfb9'),
...                   count = 10,
...                   show_merges = true)
...
>>> for commit in rv:
...  print commit.id()
... 


What do you think ?

Best regards,
-- 
Yann
