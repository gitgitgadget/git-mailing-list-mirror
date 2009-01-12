From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable
	errors.
Date: Mon, 12 Jan 2009 13:31:49 -0800
Message-ID: <20090112213149.GL10179@spearce.org>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net> <20090112204030.GA23327@chistera.yi.org> <200901121527.21818.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adeodato =?iso-8859-1?Q?Sim=F3?= <dato@net.com.org.es>,
	Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:33:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUPU-0001Kw-9d
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbZALVbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbZALVbv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:31:51 -0500
Received: from george.spearce.org ([209.20.77.23]:55522 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbZALVbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:31:51 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1613D38210; Mon, 12 Jan 2009 21:31:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901121527.21818.bss@iguanasuicide.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105387>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> wrote:
> 
> Well, if the user want to run in "set -u" mode preventing it is bogus, IMO.  
> We could use subshells and unset at the top of _git and _gitk functions, that 
> would be only a +6/-4 patch.  It would also not be something future 
> contributors have to think (much) about.

Running in subshells is a bad idea.  We'd likely lose access
to the completion word array, and it would take a lot longer per
completion because you need to spin-up and tear-down that subshell.

We have spent some time to make the current completion code use as
few forks as possible to get the results we want, because it runs
faster that way.

-- 
Shawn.
