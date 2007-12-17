From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first
 argument.
Date: Mon, 17 Dec 2007 12:26:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171223210.9446@racer.site>
References: <20071217095014.GF7453@artemis.madism.org>
 <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org>
 <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4F42-0004MW-04
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935867AbXLQM0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 07:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935861AbXLQM0z
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:26:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:34141 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935751AbXLQM0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 07:26:54 -0500
Received: (qmail invoked by alias); 17 Dec 2007 12:26:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 17 Dec 2007 13:26:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mbRsoW6fmnThtzA35V0trWMv2uPQlNkH6RWc4pT
	Vnh56RVSrLPhpa
X-X-Sender: gene099@racer.site
In-Reply-To: <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68555>

Hi,

On Mon, 17 Dec 2007, Wincent Colaiuta wrote:

> Yes, we know what it does because we know that "git ... log ..." is 
> actually two commands and each one handles one of the -p switches, but 
> it is much easier to present git as a single tool to the newcomer (and I 
> guess I don't need to argue that case here seeing as the decision has 
> already been taken long ago to talk using dashless forms), and it is 
> much easier to explain to a newcomer something like:
> 
> git log --paginate -p
> 
> Than:
> 
> git -p log -p

How about

	git log -p

Hmm?

Fact is: you make the tool easier by having sane defaults.  Not by moving 
around command line options.  The option "-p" for git is an option that 
holds for _all_ subcommands.  That's why it belongs _before_ the 
subcommand.

> But it doesn't really matter. The proposed changes allow old-timers to 
> continue putting their special options between the "git" and the 
> "command". If you don't want to deprecate the -p special because of the 
> confusion it might cause, I think we should at least not give it a very 
> prominent place in the documentation, nor use it any examples.

I think it is wrong to go out of our way to support "git status -p" as a 
synonym to "git -p status".  I simply do not believe that newcomers are 
not intelligent enough to understand that "git -p <subcommand>" means that 
the output goes into their pager.

Ciao,
Dscho
