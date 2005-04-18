From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [patch] fork optional branch point normazilation
Date: Mon, 18 Apr 2005 02:23:26 +0200
Message-ID: <20050418002326.GC1461@pasky.ji.cz>
References: <Pine.LNX.4.44.0504171614150.2625-100000@bellevue.puremagic.com> <Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad Roberts <braddr@puremagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:19:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJzM-0000s5-0L
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVDRAXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDRAXc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:23:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48282 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261578AbVDRAX1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 20:23:27 -0400
Received: (qmail 521 invoked by uid 2001); 18 Apr 2005 00:23:26 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 01:39:10AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Sun, 17 Apr 2005, Brad Roberts wrote:
> >
> > braddr:x:1000:1000:Brad Roberts,,,:/home/braddr:/bin/bash
> > 
> > All gecos entries on all my debian boxes are of the form:
> > 
> >    fullname, office number, office extension, and home number
> 
> Ahh, ok.
> 
> I'll make the "cleanup" thing just remove strange characters from the end, 
> that should fix this kind of thing for now.
> 
> I'd just remove everything after the first strange number, but I can also 
> see people using the "lastname, firstname" format, and I'd hate to just 
> ignore firstname in that case.

> +       /*
> +        * Go back, and remove crud from the end: some people
> +        * have commas etc in their gecos field
> +        */
> +       dst--;
> +       while (--dst >= p) {
> +               unsigned char c = *dst;
> +               switch (c) {
> +               case ',': case ';': case '.':
> +                       *dst = 0;
> +                       continue;
> +               }
> +               break;
> +       }

Am I just slow or does the first dst-- make it miss the last trailing
/[,;.]/?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
