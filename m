X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Show project's README.html if available
Date: Tue, 24 Oct 2006 12:41:04 -0700 (PDT)
Message-ID: <701637.67420.qm@web31802.mail.mud.yahoo.com>
References: <20061024191915.GV18879@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 24 Oct 2006 19:41:53 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=SdoDkIx90weMCCkCFid3QbvKGm7tyqKuBCS3Lr4T+sAVPiM9biP1WQsPlIuxAnTnjL/t5+3J2jNHlh5Xx4OYvhy5B9ssVYxGm1EodhTppm6V94gfy+z7ljTzHrMh7bPGg9xoeSyKgu/tT1eJgEmLxv+x2f48V3WAQyXMkBY162s=  ;
X-YMail-OSG: sr30nysVM1kPCxvVA5WuxvRltJ_QbB8NeeYN6cPScg9Hasu4l.z5VKMg_ZemvfWU_zx_7dYhhy9KZmqI_oA2HmGaqDw.87LDuw05CgFzU0hGu1.HM2sx8iRmpi8YxOZmMfU_ySmjE8g-
In-Reply-To: <20061024191915.GV18879@pasky.or.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30005>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcS9R-0006kb-Lg for gcvg-git@gmane.org; Tue, 24 Oct
 2006 21:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030276AbWJXTlK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWJXTlI
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 15:41:08 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:52828 "HELO
 web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1752110AbWJXTlF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006
 15:41:05 -0400
Received: (qmail 67778 invoked by uid 60001); 24 Oct 2006 19:41:04 -0000
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Tue,
 24 Oct 2006 12:41:04 PDT
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

--- Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Oct 24, 2006 at 09:09:03PM CEST, Luben Tuikov wrote:
> > --- Petr Baudis <pasky@suse.cz> wrote:
> > > > Why not instead re-submit a patch implementing what was discussed
> > > > in this thread bearing the same name:
> > > > 
> > > > http://marc.theaimsgroup.com/?t=116044914900001&r=1&w=2
> > > 
> > > This implements
> > > 
> > > 	http://marc.theaimsgroup.com/?l=git&m=116047939517299&w=2
> > > 
> > > I see no other ideas I could take there except various naming proposals
> > > and perhaps using File::Copy but I'll wait until someone does a
> > > gitweb-wide change for the latter.
> > > 
> > > I don't really care _what_ name it bears, but I'd like to have it
> > > included. :-)
> > 
> > People have suggested that this functionality be folded into the
> > "Description" column, where the description printed is the
> > first line of the description file "description" and if clicked
> > on, it shows the whole "descrption" file.
> 
> Please look at the mail the mail I referred was a reply to:
> 
> 	http://marc.theaimsgroup.com/?l=git&m=116047773825208&w=2

I re-read that email.  And I also saw what you have at hed.git.

If anything I think we should want to _minimize_ shown material
before the "shortlog" in the "summary" page.

Why?

Well, in a production environment, people often view the "summary" page
to see what has been going on with a project and they are well aware
of what that project is for and/or what it does.  It is cumbersome to have
to scroll down each and every time past he annoying "readme", just to see
the first few commits.

Look, your hed.cgi has 7 lines for the description and URL, (as opposed to 4
of next:gitweb.perl) and those already have generous amount of inner-spacing,
making the whole thing extend half the page.  This would be annoying in
a production environment.

Now, if you use gitweb as a Web presentation tool of your projects then
this is another story.  Then you would want to put colors, graphics, lots
of text here and there, etc, etc.

If we start to include those little things to be supported "optionally",
then we incur bloat to gitweb.

I think what is best to do is to create another script which can show
the fancy-schmancy Web presentation content you want to mix with
with gitweb, and keep gitweb a tool for the enigineer as opposed to
a web presentation application.

That other fancy-schmancy script can keep track of developers,
statistics, bugs, bug counts, etc, etc, as well.

    Luben
