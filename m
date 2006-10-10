From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 12:19:04 -0700 (PDT)
Message-ID: <20061010191904.99261.qmail@web31809.mail.mud.yahoo.com>
References: <egfo99$lg6$2@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Oct 10 21:19:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXN8R-00083V-B0
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 21:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWJJTTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 15:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWJJTTJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 15:19:09 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:50611 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030200AbWJJTTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 15:19:05 -0400
Received: (qmail 99263 invoked by uid 60001); 10 Oct 2006 19:19:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JtW70lYAYRGLg4JCQLUOMeFLmEC1rkEfPpk2ZT3SQ3/6jQ23hRLLtWO6w1z3biHzlbQEITVlbX4ysohy5J4m+h6d9GBEjXnsW70z5ftiyARggRx4gTZAjOj0Urrgf1HjemJkqz37QtbEEsL+WjDk7UxkTTcx95lHXYMJKxXNsNo=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 12:19:04 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <egfo99$lg6$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28657>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> >> It probably is wise to resurrect those "redundant" links.
> > 
> > If someone does this, can they also remove the now "other"
> > redundant link? (the link at the pathname itself) A simple
> > code analyzer would show the duplicate code in gitweb.
> 
> Easy, easy now.

Can you please CC me when replying to a post of mine?  Else
I have to go chase in the git folder as opposed it coming to
my inbox.  Thanks!

> I'd rather add some more "hidden" links, but for each hidden
> link (which are convenience only, to have larger are to click,
> or to have closer area to click) I'd like to have clearly marked
> link (marked as a link, i.e. using default link style; and with link text
> denoting _kind_ of link) which leads to the same contents. 

Why would you like all this?  If users start using those other links
all the time, what is the purpose of the "hidden" links as you call them?

Consider the "tree" link between "commitdiff" and "snapshot" (if enabled)
in shortlog view.

Consider the "hidden" link of each entry (file/directory).

Can you see how they are different?

Introducing this to an engineer who has little knowlege about git:
   "Click on the file or directory name, to get the file or go into
    the directory"
Simple and intuitive, no need to mention "blob" or "tree" or "object".
Or,
   "Click on the 'blob' link to get the ... Click on the 'tree' link to
    get the ... Oh you didn't know what a 'tree' or 'blob' object is?
    A 'blob' is ... A 'tree' is ..."

At which point the engineer has lost 90% of his interest.

It even gets even worse for the obnoxious "tree" link next to each commit
in shortlog view:
   "The tree link is the the tree object which is part of a commit object.
    Oh you don't know the internals of a commit object?  A commit object
    binds a tree object and a (parent) commit object, but blah, blah, blah..."

Can you see how all this apparent "simplicity" you're trying to introduce
contradics the mere links you're introducing it with?

Surely "we can", but should we?  The "tree" link in shortlog next to each commit
is one such example of "we can", but we shouldn't.

The question is: Given the average engineer, what is the gitweb interface
such that they can start using it fastest with the minimum amount of
questions?

> But we agreed (I guess) to disagree on the whole redundancy in user
> interface issue (although I agree on the issue of reducing clutter).
> BTW. we can reduce redundancy in the code without need for removing
> "alternate entry points" in interface, I think.

Clutter and redundancy is just a part of it.  A larger part is
how much git or non-git oriented we want to make the interface, which
seems related to the overall simplicity and intuitiveness.

The golden question:
What is the interface such that both git-experts and never-seen-git-
but-know-about-SCMs engineers can find it intuitive to use with minimal
amount of questions?

    Luben
