From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Mon, 18 Feb 2008 01:34:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802180133150.30505@racer.site>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org> <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org> <m3d4qvbt40.fsf@localhost.localdomain> <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802172050090.30505@racer.site>
 <7v3arrxd7q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 02:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQuuv-0001dw-Np
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 02:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYBRBfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 20:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYBRBfB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 20:35:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:45234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbYBRBfB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 20:35:01 -0500
Received: (qmail invoked by alias); 18 Feb 2008 01:34:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 18 Feb 2008 02:34:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BLV0AvkUBYSWJsHifb+eqDy5hBPkG3ojUCRuh/K
	c/v3NqmvR88rrp
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3arrxd7q.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74214>

Hi,

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 17 Feb 2008, Junio C Hamano wrote:
> >
> >> The more fundamental improvement was along the lines of what I suggested 
> >> soon after Kristian's initial round was posted, but what the current 
> >> code does is not wrong nor hack.  It is about a partial commit after all 
> >> and is not performance critical either.
> >
> > You mean: at this point, it is not necessary to be careful about the 
> > index, as the index that will be reloaded will already have the most 
> > recent timestamps, right?
> 
> I do not understand the question, but if you are referring to my "not 
> performance critical", I meant: "A partial commit is never performance 
> critical".
> 
> A partial commit is by its nature "oops, I earlier told you to git add 
> this and git add that but I did not mean that, eh, I do mean it but not 
> for this commit yet, sorry, I want to commit changes to these paths 
> first please and then I'll deal with the earlier added paths in later 
> commit perhaps.", i.e. very interactive.  Its performance requirement is 
> unlike an automated script slurping hundreds of changes per minute 
> applying exactly the change it wants in each commit to the index and 
> making commits in rapid succession.

Well, my workflow has lots of these moments.  I do not even feel "oops" 
about it.  More like "by the way, this needs committing _now_".

So I guess I'll be the guinea pig for this patch, and if it is too 
painful, I'll just go and fix it.

Ciao,
Dscho
