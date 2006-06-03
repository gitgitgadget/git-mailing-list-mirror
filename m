From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Gitk feature - show nearby tags
Date: Sat, 3 Jun 2006 18:19:01 +0200
Message-ID: <20060603161900.GA4882@diku.dk>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com> <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net> <20060603151240.GA4024@diku.dk> <e5sa47$qv8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 18:19:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmYqJ-0004QV-Jq
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 18:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWFCQTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 12:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWFCQTG
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 12:19:06 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:23276 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751542AbWFCQTE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 12:19:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id E24B9770056;
	Sat,  3 Jun 2006 18:19:03 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14479-13; Sat,  3 Jun 2006 18:19:01 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 48904770026;
	Sat,  3 Jun 2006 18:19:01 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id F33806DF88D; Sat,  3 Jun 2006 18:15:45 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 33C28625C6; Sat,  3 Jun 2006 18:19:01 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5sa47$qv8$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21198>

Jakub Narebski <jnareb@gmail.com> wrote Sat, Jun 03, 2006:
> Jonas Fonseca wrote:
> 
> > I already took your hint from the other day on irc and have begun on
> > implementing this revision graph visualization for tig. :)
> > 
> > The problem is of course to come up with some ascii-art which is both
> > readable and dense. Below is my mockup of something not using line
> > graphics,[...]
> 
> As I can see you use 'vertical' layout. Do I understand correctly that '*'
> refers to commit on marked (by column) branch, and '|' means pass-thru?

Yes, and 'M' marks merges. Putting information in the "commit node"
should make certain things more obvious. You could encode information
such as whether a commit is a "unique head" (nothing other revisions
references this commit). For example the first commit will always be
unique, but when using --all other heads might show up "unique".

	+ [master] ...
	* ...
	| + [unmerged/topic] ...
	| * ...
	*' ...

> BTW. you might want to take a look at http://revctrl.org/ diagrams;
> AFAICT all the git documentation uses 'horizontal' layout, which is good
> for example but perhaps not for long-lived development...

Looking at the examples on http://revctrl.org/StaircaseMerge: it might
be more readable but not as dense as I would like, namely one commit pr
line.

-- 
Jonas Fonseca
