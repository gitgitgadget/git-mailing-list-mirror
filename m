From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 10:31:22 -0700
Message-ID: <1225387882.19891.9.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
	 <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org>
	 <20081030150135.GG24098@artemis.corp>
	 <alpine.LFD.2.00.0810301105350.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:43:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvbY6-0000TS-5G
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbYJ3Rli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754404AbYJ3Rli
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:41:38 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:32876 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318AbYJ3Rlh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:41:37 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id EDFF721C83C; Fri, 31 Oct 2008 06:40:54 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=failed version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 7FECE21C83C;
	Fri, 31 Oct 2008 06:31:27 +1300 (NZDT)
In-Reply-To: <alpine.LFD.2.00.0810301105350.13034@xanadu.home>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99505>

On Thu, 2008-10-30 at 12:53 -0400, Nicolas Pitre wrote:
> > Seconded.
> > 
> > Having git-checkout $foo being a shorthand for git checkout -b $foo
> > origin/$foo when origin/$foo exists and $foo doesn't is definitely handy.
> 
> No.  This is only the first step towards insanity.
> 
> In many cases origin/$foo == origin/master so this can't work in that 
> case which is, after all, the common case.

I don't understand that argument at all, can you explain further?

>   Therefore I think this is 
> wrong to add magic operations which are not useful for the common case 
> and actively _hide_ how git actually works.  Not only will you have to 
> explain how git works anyway for that common origin/master case, but 
> you'll also have to explain why sometimes the magic works and sometimes 
> not.  Please keep such convenience shortcuts for your own scripts and/or 
> aliases.

It's not about magic, it's about sensible defaults.  Currently this use
case is an error, and the resultant command is very long to type, and
involves typing the branch name twice.  I end up writing things like:

  git checkout -b {,origin/}wr34251-do-something

For the user who doesn't know to use the ksh-style {} blocks this is
voodoo.  The longer form is cumbersome.

For the case where the thing you type is a resolvable reference, it
would just check it out, as now.

Sam.
