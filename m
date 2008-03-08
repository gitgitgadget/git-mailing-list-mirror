From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Sat, 8 Mar 2008 22:11:11 +1100
Message-ID: <18386.29775.512557.202621@cargo.ozlabs.ibm.com>
References: <47AAA254.2020008@thorn.ws>
	<20080207063020.GP24004@spearce.org>
	<200802071056.19370.robin.rosenberg.lists@dewire.com>
	<20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	<20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	<18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	<47C190E3.6000407@gmail.com>
	<18383.57540.26282.526111@cargo.ozlabs.ibm.com>
	<20080307111144.GA18108@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	442253-quiet@bugs.debian.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 02:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYX1C-00008j-MV
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 02:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbYCJBkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 21:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbYCJBke
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 21:40:34 -0400
Received: from ozlabs.org ([203.10.76.45]:48827 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbYCJBkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 21:40:32 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7FB96DDDFF; Mon, 10 Mar 2008 12:40:31 +1100 (EST)
In-Reply-To: <20080307111144.GA18108@piper.oerlikon.madduck.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76690>

martin f krafft writes:

> I can confirm that the behaviour is much better: the window size is
> restored, as is the position, but it gives preference to the
> Xinerama head. You'd think it restores at the same *relative*
> position on the current head, but it actually just restores
> somewhere $,1rt(B I cannot figure out the behaviour.

The position is entirely up to your window manager.

> However, I still wonder why we have to do this at all.

Well, try it without... :)

Restoring the overall window size and the positions of the sashes of
the panedwindows is the simplest and most reliable method I have found
for making the window come back the way the user last set it.

> I understand
> that Cygwin has issues and needs this code, but couldn't it then be
> made to run only on Cygwin, such that on "proper" Unix systems, the
> config file is *not* updated every time I move the window before
> closing the application?

What's the issue with updating the config file?

> As I said earlier, this is really the job
> of a window manager, *not* a configuration option. If your window
> manager cannot restore the window to a size you control, then it's
> broken. Let's not hack applications to work around that, please.

I disagree.  It's not a window manager's job to tell an application
how big its window should be.

Paul.
