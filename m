From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Fri, 15 Jan 2010 17:11:07 +0100
Message-ID: <20100115161107.GC12982@vidovic>
References: <4B4F6000.4070005@sofistes.net> <20100114195234.GA26684@coredump.intra.peff.net> <7vljg0bfox.fsf@alter.siamese.dyndns.org> <20100114203928.GA26883@coredump.intra.peff.net> <20100115153419.GA12982@vidovic> <20100115154816.GA1579@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 17:11:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVoln-00083n-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 17:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab0AOQLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 11:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378Ab0AOQLM
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 11:11:12 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:63468 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab0AOQLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 11:11:12 -0500
Received: by gv-out-0910.google.com with SMTP id n8so68833gve.37
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=SWpNNKGPsU8C0KYSWVGpmAdx4DADtJsCGH3F2h6p1gc=;
        b=rUr0xQbutp6I73a9jadUTfK6gzBTjdkO6MM4cb35mfqp4A5LJEEUugwt5P7gbBpYzh
         +f4PtN3Q/O8FZPO2fF+wLMJYMUbKfGtFF54LrEOCnW47k6EerpBTDAjlRzYmrLZMzUFO
         z7cb2rQKdDkUJTX+csOdKckNLpmKVoze6fUHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d9HCYUhSUJGYBIERjbspUSdMi7Catv68T/7rz9cp5ynKP2NSrJOHpDKn3rYELBR/a6
         7inSUeHrJEPwn/ecO9ZHZdr5YmQzGyWmuNt8LYxzUO6vgZvLiMhYrn8rJzvgVDSICLuq
         +OZLnCFPzrPEa7uyamdg/S1mQ3auTsbgXcEP0=
Received: by 10.223.6.142 with SMTP id 14mr2894373faz.43.1263571870332;
        Fri, 15 Jan 2010 08:11:10 -0800 (PST)
Received: from @ (91-165-137-43.rev.libertysurf.net [91.165.137.43])
        by mx.google.com with ESMTPS id 12sm1845902fgg.22.2010.01.15.08.11.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 08:11:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100115154816.GA1579@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137079>

The 15/01/10, Jeff King wrote:
> On Fri, Jan 15, 2010 at 04:34:19PM +0100, Nicolas Sebrecht wrote:
> 
> > >   1. Most programs don't take their own globs. Without knowing that git
> > >      can do so, there is no reason to discover it in this instance. I
> > >      can see searching the manpage for options, but not for a discussion
> > >      of globbing behavior.
> > > 
> > >   2. They would have to know that using a git-glob will magically change
> > >      the error-checking behavior.
> > 
> > Not sure. This isn't a Git-particular issue.
> > 
> > Users may hit this with a lot of other unix tools (sed, grep, find,
> > etc). So, we can expect either
> >   they already know the issue;
> > or
> >   they are discovering it using Git.
> 
> I don't understand what you mean. How does "sed" do its own globbing of
> the command line?

Well, we are in the same dilemma as the other tools. The internal
globbing rules are explained in the related man page.

> > Most of the tools I talk about do have a manual section about globbing.
> > Users could learn globs with Git too and expect the same behaviour
> > somewhere else.
> 
> Sure. git-add(1) talks about globbing, too

Oops, I was missing that; thanks.

> My complaint was more that as a user, I am not likely to see this
> problem and think "I'll bet git-specific globbing can solve it."

Yes. My point is that we are not talking about a Git specific issue.
What you're raising here is true whatever the command is. So, as long as
we clearly explain how 'git add' works, we are fine. Don't we?

>                                                                  And
> when I look in the manual, I am more likely to look for a command-line
> option that helps me rather than to read all of the text

True. All I can see is to improve the man page with a dedicated section
"Globbing" instead of loosing it in a "random" place.

-- 
Nicolas Sebrecht
