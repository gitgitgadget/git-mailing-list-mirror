From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Tue, 18 Nov 2008 18:19:26 -0800 (PST)
Message-ID: <206215.61260.qm@web37901.mail.mud.yahoo.com>
References: <49236F67.6080807@pcharlan.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2cgO-0006CL-ST
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 03:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbYKSCT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 21:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbYKSCT2
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 21:19:28 -0500
Received: from web37901.mail.mud.yahoo.com ([209.191.91.163]:30576 "HELO
	web37901.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751875AbYKSCT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 21:19:28 -0500
Received: (qmail 61517 invoked by uid 60001); 19 Nov 2008 02:19:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=KvTDEYGyS1FKXbLQ0EttX88msy+RMP+QDggrcnnMl8nYHxLEmN9Ns4zPyfUGEwqCjnD+HSGUdewgOp3CgiycB3Fx3KGxMTy/cDn7nEdkyirMEdW3Xs/jywaGEXPgQHHVtx56JgEKHD39SJz8giIh9u+9ufYbdeq9kLrLPJ2POqY=;
X-YMail-OSG: XW4KJUAVM1lI.h6Jbn9NP5BNJfahGnBMT_JaYXbDctTtvbvnzORSp50zHn4bI1v8TSIty7vfZHUD3J.3s6d33iYlfJyu0Zb142DWwsVTWX771A0_cLXzfEUJr2VS43LFKgWtfGblJ2ePkkveM3eomqNAJFCfZ0_dyNCjvKj456Lxx0w-
Received: from [76.195.33.70] by web37901.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 18:19:26 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <49236F67.6080807@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101309>

FYI,

Pete helped me solved the problem. Somehow I got two gpg keys. Pete discovered that and suggested me the proper command to tag the code. I am going to figure out how to remove the extra key. Many thanks to Pete.

git tag -u 'For git' -s some-tag

Sincerely,


Gary



--- On Tue, 11/18/08, Pete Harlan <pgit@pcharlan.com> wrote:

> From: Pete Harlan <pgit@pcharlan.com>
> Subject: Re: "secret key not available". "unable to sign the tag".
> To: garyyang6@yahoo.com
> Date: Tuesday, November 18, 2008, 5:44 PM
> Hi Gary,
> 
> No output doesn't mean anything is wrong, just that my
> suggestion wasn't
> useful.
> 
> I saw from your other post that you use C-shell.  I tried
> things here
> using C-shell and it all worked as expected.
> 
> One odd-looking thing is that when you show it working from
> the
> command-line it says:
> 
> > > > You need a passphrase to unlock the secret
> key for
> > > > user: "Gary Yang (For git.)
> > > > <garyyang6@yahoo.com>"
> 
> whereas when you show it not working within Git it says:
> 
> > gpg: skipped `Gary Yang
> > <garyyang6@yahoo.com>': secret key not
> > available
> > gpg: signing failed: secret key not available
> 
> which leads me to believe that you have two similarly-named
> keys, and
> that the command-line gpg is finding the one that has
> "For git" in the
> name, but git is finding the one that doesn't, and this
> second one
> doesn't have a secret key available.
> 
> If you try specifying the first key to git:
> 
>   git tag -u 'For git' -s some-tag
> 
> does that work?
> 
> --Pete
> 
> 
> Gary Yang wrote:
> > Hi Pete,
> > 
> > I got no output of the commands you told me. That
> means I have no environment setup. Can you please tell me
> what kind of environment variables need to setup? Thank you
> very much!
> > 
> >> env | grep -i gnupg
> >> env | grep -i gpg
> >> env | grep -i pgp
> > 
> > 
> > Gary
> > 
> > --- On Tue, 11/18/08, Pete Harlan
> <pgit@pcharlan.com> wrote:
> > 
> >> From: Pete Harlan <pgit@pcharlan.com>
> >> Subject: Re: "secret key not available".
> "unable to sign the tag".
> >> To: garyyang6@yahoo.com
> >> Date: Tuesday, November 18, 2008, 5:16 PM
> >> Gary Yang wrote:
> >>> Hi Pete,
> >>>
> >>> What I should export? Do you have any idea?
> >> Hi Gary,
> >>
> >> I'd look for anything that says gnupg or gpg
> in the
> >> environment.
> >>
> >> env | grep -i gnupg
> >> env | grep -i gpg
> >> env | grep -i pgp
> >>
> >> I'm afriad it's not much of an idea.  If
> the above
> >> don't match
> >> anything, I don't know what to suggest.
> >>
> >> Good luck,
> >>
> >> --Pete
> >>
> >>
> >>
> >>>
> >>> Thank you,
> >>>
> >>>
> >>> Gary
> >>>
> >>>
> >>>
> >>>
> >>> --- On Tue, 11/18/08, Pete Harlan
> >> <pgit@pcharlan.com> wrote:
> >>>> From: Pete Harlan
> <pgit@pcharlan.com>
> >> Subject: Re: "secret key not
> >>>> available". "unable to sign the
> >> tag". To: garyyang6@yahoo.com Date:
> >>>> Tuesday, November 18, 2008, 2:18 PM Gary
> Yang
> >> wrote:
> >>>>> Peter,
> >>>>>
> >>>>> The gpg works. But, git tag dose not
> work. Any
> >> idea?
> >>>> Could gpg be using something from your
> environment
> >> that you're not 
> >>>> exporting, so git can't see it?
> >>>>
> >>>> --Pete
> >>>>
> >>>>
> >>>>> gpg --detach-sign foo.bar gpg:
> WARNING: using
> >> insecure memory! 
> >>>>> gpg: please see
> http://www.gnupg.org/faq.html
> >> for more
> >>>> information
> >>>>> You need a passphrase to unlock the
> secret key
> >> for user: "Gary
> >>>>> Yang (For git.)
> >>>> <garyyang6@yahoo.com>"
> >>>>> 1024-bit DSA key, ID A3F6A45E, created
> >> 2008-11-14
> >>>>> Enter passphrase:
> >>>>>
> >>>>>
> >>>>> [garyyang6@svdclc313
> ~/git-repository]%
> >>>>>
> >>>>>
> >>>>> It successfully signed.
> >>>>>
> >>>>>
> >>>>> Gary
> >>>>>
> > 
> > 
> >


      
