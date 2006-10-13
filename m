From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Fri, 13 Oct 2006 14:59:42 -0700 (PDT)
Message-ID: <20061013215942.36919.qmail@web31806.mail.mud.yahoo.com>
References: <7vy7rjc2vg.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 23:59:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYV4E-0001X8-Gz
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 23:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWJMV7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJMV7o
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 17:59:44 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:22431 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932086AbWJMV7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 17:59:43 -0400
Received: (qmail 36921 invoked by uid 60001); 13 Oct 2006 21:59:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=U03Hxn7tOXIKZxTOFrIxiNm2qGwXEocXsGq0ADVxm43uC0/POfpIIDIE2C0KaKjyuYkRMqb2O2lCCRG49bw0PqCo8Pju1Zs765YAnYbVEAgIW93SKN5Omv/M8Y9nIjfdkGAjcKuhj9jELzY/8WgO4UaJFjzm64xr4wR1r8+Rzmg=  ;
Received: from [64.215.88.90] by web31806.mail.mud.yahoo.com via HTTP; Fri, 13 Oct 2006 14:59:42 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7rjc2vg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28865>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- Junio C Hamano <junkio@cox.net> wrote:
> >> Luben Tuikov <ltuikov@yahoo.com> writes:
> >> 
> >> > Junio, is it possible to also print the "previous" commit?
> >> > I mean, is it tenable to print the commit such that
> >> > a "git-diff C B -- A:file" will give a diff of the block of lines
> >> > we're looking at?
> >> 
> >> There is no single "previous" in general.  Which side of the
> >> merge would you take?
> >
> > The parent commit.
> 
> There is no single "the parent commit" in general.  Which side
> of the merge would you take?

Yes, I realise that...

I guess I'm trying to get to a successful implementation of
the intention of commit 65910395c08e3dc4be685a9a9f60adfa61c89aa5
(later reverted for a good reason).

It is ok if this is not possible.  After all, the absolutely
unambiguous way is blame->commit->blame->commit->..., etc,
due to multiple parenting.

> Also remeber, when we blame a line to a revision (unless we do
> not limit the blame with v2.6.18.. and --since=2.weeks which
> only git-pickaxe can do), the line is known to have been
> introduced by _that_ commit.

That is what we want.

(fully agree with your previous comment that we limit _after_
 placing blame on a commit...)

> If there were a corresponding line
> in "the parent commit" for that line, we would not have assigned
> the blame to the commit, but the blame would have been passed
> down to "the parent commit" already.

Indeed.

   Luben
