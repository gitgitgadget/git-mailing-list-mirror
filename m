From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: What to expect after 0.99.8
Date: Mon, 3 Oct 2005 14:55:30 +0200
Message-ID: <200510031455.30187.Josef.Weidendorfer@gmx.de>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 03 14:57:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMPr5-0007Xm-GN
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 14:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVJCMzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 08:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVJCMzi
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 08:55:38 -0400
Received: from imap.gmx.net ([213.165.64.20]:4569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750851AbVJCMzh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 08:55:37 -0400
Received: (qmail invoked by alias); 03 Oct 2005 12:55:35 -0000
Received: from p5496B984.dip0.t-ipconnect.de (EHLO linux) [84.150.185.132]
  by mail.gmx.net (mp018) with SMTP; 03 Oct 2005 14:55:35 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9633>

On Monday 03 October 2005 02:14, Junio C Hamano wrote:
> * Perhaps accept patches to introduce the concept of "patch flow
>   expressed as ref mappings" Josef has been advocating about.

This was about a central place to store local/remote ref mappings.
I proposed the Pull/Push lines in remote/ files changing to hold
these mappings, and putting the defaults into Pull-Default and
Push-Default.

I changed my mind: IMHO for simplicity, porcelain commands should
mostly deal with refspecs (default: current head), and thus,
above mappings should be stored per ref/head, not per remote repository.
I.e. I won't provide a patch for this.

But why did we choose to make git-pull/git-push
to accept a remote repository as first argument, and not a head/refspec
in the first place? [Of course, this needs the remote repository be
retrievable by head name: see branches/ files. And currently missing here is 
the distinction between fetch and push direction].

In the current state, it would be better to get rid of branches/
parsing in GIT at all: By keeping it in, we force Cogito to keep the current
format.
[BTW: the git-push man page is wrong about branches/: the name of the file
in branches/ corresponds to a local refspec, and not to a remote name]

Josef
