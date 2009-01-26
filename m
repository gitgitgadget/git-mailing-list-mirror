From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 18:37:26 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251836150.12651@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <7v1vuqdcjp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 03:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRHQQ-0001Hk-5k
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 03:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbZAZChh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 21:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbZAZChg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 21:37:36 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:41597 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbZAZChf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 21:37:35 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0Q2bR76021212;
	Sun, 25 Jan 2009 18:37:27 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0Q2bQh0021209;
	Sun, 25 Jan 2009 18:37:27 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <7v1vuqdcjp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107162>

On Sun, 25 Jan 2009, Junio C Hamano wrote:

> I suspect it is pretty much orthogonal to the "use user's default without 
> being told from the command line", but it might be a worthy goal to introduce 
> a mechanism for the scripts to accept "safe" default options from the end user 
> while rejecting undesirable ones that would interfere with the way it uses 
> plumbing.
> 
> For example, gitk drives "git rev-list" and many options you give from the 
> command line (e.g. "gitk --all --simplify-merges -- drivers/") are passed to 
> the underlying plumbing.
> 
> This is a double edged sword.  When we add new features to git-rev-list, (e.g. 
> --simplify-merges or --simplify-by-decoration are fairly recent inventions 
> that did not exist when gitk was written originally), some of them can be 
> safely passed and automagically translates to a new feature in gitk.  
> However, use of some options (e.g. --reverse) breaks the assumption the tool 
> makes on the output from the underlying plumbing and should not be accepted 
> from the end-user.
> 
> It would be a good addition to our toolset if scripts like gitk can declare 
> which options and features are safe to accept from the end user to pass down 
> to the plumbing tools.  "git rev-parse", which lets the script sift between 
> options that are meant to affect ancestry traversal and the ones that are for 
> other (primarily diff family) commands, does not do anything fancy like that, 
> but it would be a logical place to do this sort of thing.
> 
> And it is not limited to "scripts" use.  A recent topic on rejecting colouring 
> options from being given to format-patch would also be helped with such a 
> mechanism if it is available to builtins.
> 
> Just an idle thought.


Yes yes yes yes!!!!!  I've been working on a response to your previous message, 
in which I address exactly this possibility.  Coming soon.
