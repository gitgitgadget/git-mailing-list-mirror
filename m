From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2 build issues
Date: Mon, 14 Aug 2006 15:29:23 -0700
Organization: YPO4
Message-ID: <20060814152923.bc295ef3.rdunlap@xenotime.net>
References: <20060814121156.84bc6e34.rdunlap@xenotime.net>
	<7vd5b3dl4c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 00:26:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCktH-0003KN-OF
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 00:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWHNW0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 18:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWHNW0c
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 18:26:32 -0400
Received: from xenotime.net ([66.160.160.81]:41690 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932538AbWHNW0c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 18:26:32 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <git@vger.kernel.org>; Mon, 14 Aug 2006 15:26:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5b3dl4c.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25416>

On Mon, 14 Aug 2006 15:10:27 -0700 Junio C Hamano wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > xmlto -m callouts.xsl man git-add.xml
> > I/O error : Attempt to load network entity
> > http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> > warning: failed to load external entity
> > "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
> > compilation error: file /tmp/xmlto-xsl.l27115 line 4 element
> > import xsl:import : unable to load
> > http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> > make[1]: *** [git-add.1] Error 1 rm git-add.xml make[1]: Leaving
> > directory
> > `/home/rddunlap/builds/git-snapshot-20060814/Documentation' make:
> > *** [doc] Error 2
> 
> Sorry, I am not docbook expert -- help from the list please?
> I seem to be using:
> 
>                         (home)		(kernel.org)
> 	asciidoc	7.1.2		7.0.2
>         xmlto		0.0.18		0.0.18

I have same versions as your (home).

> > make -C templates install
> > make[1]: Entering directory
> > `/home/rddunlap/builds/git-snapshot-20060814/templates' : no
> > custom templates yet install -d -m755
> > '/usr/local/share/git-core/templates/' (cd blt && tar cf - .) | \
> > (cd '/usr/local/share/git-core/templates/' && tar xf -)
> > tar: This does not look like a tar archive
> > tar: Skipping to next header
> > tar: Archive contains obsolescent base-64 headers
> > tar: Error exit delayed from previous errors
> > make[1]: *** [install] Error 2
> > make[1]: Leaving directory
> > `/home/rddunlap/builds/git-snapshot-20060814/templates' make: ***
> > [install] Error 
> 
> Hmph.  I suspect (cd blt && tar cf - .) is failing silently.
> When built, "make -C templates" creates templates/blt directory
> and leaves templates/boilerplates.made file.  Do you have them?

I have templates/blt directory but no boilerplates.made file.

> Ah, another possibility.  Does your "cd" say anything
> unnecessary even when running scripts, not interactively?  For
> example, do you have CDPATH set and _exported_ to the
> environment?  CDPATH might be a useful shell variable for
> interactive session, but you never want to export it to affect
> unsuspecting shell scripts you invoke directly or indirectly.

I suppose that could be the problem.  (I do have/use CDPATH.)
I started a new shell that does not have CDPATH and 'make install'
works fine. Thanks.
When CDPATH is set & exported, I don't see any responses from
"cd".

> I see many documents floating on the web that call CDPATH "an
> environment variable".  It is a disease X-<.

What is CDPATH then?  (other than trouble/disease)
I find it useful (usually :).

---
~Randy
