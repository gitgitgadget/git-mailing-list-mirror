From: John Keeping <john@keeping.me.uk>
Subject: Re: no luck with colors for branch names in gitk yet
Date: Fri, 5 Feb 2016 23:28:49 +0000
Message-ID: <20160205232849.GJ29880@serenity.lan>
References: <CAC4O8c-MPwrJ2H+iHjQxk+XoX4_vPm80Lz1=wbuHHd2gsB8R0Q@mail.gmail.com>
 <B88DD991725D43E19185D46EED20FDDF@PhilipOakley>
 <CAC4O8c81h-JEGN2mS=SgUnBQM+A-RojDBOY65f=Jmubo6CZCwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Britton Kerin <britton.kerin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:36:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRpvJ-00007x-BX
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 00:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbcBEXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 18:36:13 -0500
Received: from mta1-jackal.aluminati.org ([72.9.247.211]:54820 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750765AbcBEXgL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 18:36:11 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2016 18:36:11 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 013FB866006;
	Fri,  5 Feb 2016 23:29:05 +0000 (GMT)
X-Quarantine-ID: <PNq1jtHOs0YV>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PNq1jtHOs0YV; Fri,  5 Feb 2016 23:29:02 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 07AD3CDA5A6;
	Fri,  5 Feb 2016 23:28:51 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAC4O8c81h-JEGN2mS=SgUnBQM+A-RojDBOY65f=Jmubo6CZCwA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285653>

On Fri, Feb 05, 2016 at 01:29:26PM -0900, Britton Kerin wrote:
> On Fri, Feb 5, 2016 at 12:25 PM, Philip Oakley <philipoakley@iee.org> wrote:
> > From: "Britton Kerin" <britton.kerin@gmail.com>
> >>
> >> Someone suggested using color.branch.upstream, I tried like this and
> >> variants
> >>
> >> [color "branch"]
> >>  local = red bold
> >>  upstream = red bold
> >>
> >> Doesn't seem to matter what I put in for upstream, including invalid
> >> colors, gitk just ignores it and does the dark green for local
> >> branches
> >> --
> >
> > Alternate, try
> > https://github.com/oumu/mintty-color-schemes/blob/master/base16-mintty/base16-default.minttyrc
> > (or any of the other colour schemes) and copy them into your .minttyrc file
> > (works for me on g4w : git version 2.7.0.windows.1 )
> 
> I'm on linux so I think mintty is not an option.  Also, I'm a little
> surprised in affects the rendering of branch tags in gitk, I would
> have thought that would be an X or window system thing.

I think Philip missed that you were talking about gitk.  It seems that
the problem comes from updating to Tcl/Tk 7.6, which makes green darker
as described in commit 66db14c (gitk: Color name update, 2015-10-25) and
by TIP #403 [1].

However, it seems that gitk won't actually use the updated colour if you
have an existing ~/.gitk file.  You can just replace "green" with "lime"
in that file to get the new defaults, but I wonder if we should force
that for users who already have the previous defaults saved.


[1] http://www.tcl.tk/cgi-bin/tct/tip/403.html
