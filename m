From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable and world-readable
Date: Sat, 12 Apr 2008 15:01:59 +0300
Message-ID: <20080412120159.GC31039@zakalwe.fi>
References: <20080411140916.GA30667@zakalwe.fi> <7vfxtrnban.fsf@gitster.siamese.dyndns.org> <20080412030021.GB31039@zakalwe.fi> <7vzlrzlluj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 14:03:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkeRg-0001m4-0o
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 14:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbYDLMCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 08:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757629AbYDLMCC
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 08:02:02 -0400
Received: from zakalwe.fi ([80.83.5.154]:40911 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757531AbYDLMCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 08:02:01 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 031C62C331; Sat, 12 Apr 2008 15:01:59 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vzlrzlluj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79348>

On Fri, Apr 11, 2008 at 09:48:36PM -0700, Junio C Hamano wrote:
> Heikki Orsila <shdl@zakalwe.fi> writes:
> 
> > On Fri, Apr 11, 2008 at 05:53:36PM -0700, Junio C Hamano wrote:
> > ...
> >> For example, you may want to enforce "ug+rw,o=" in a repository.  How
> >> would you do that?
> >
> > Isn't that PERM_GROUP? The user always keeps u+rw for oneself.
> 
> My question was about the "o=" part.  I did not see you dropping bits for
> others in your patch.
> 
> And if your answer is "the user should have xx7 umask", that defeats the
> whole point of your patch, as you are trying to dissociate the umask used
> by the user for his usual task and enforce particular permission policy
> for the repository.

You're correct. There are two options, do you have a preference on this 
matter?

1. current method + mask off others when needed

2. core.sharedRepository=0xxx

I think I like option 2 better (preserving backwards compatibility of 
course).

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
