From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] diff-* --with-raw
Date: Tue, 11 Apr 2006 02:23:11 +0200
Message-ID: <20060411002311.GW27689@pasky.or.cz>
References: <7v7j5x7zh3.fsf@assigned-by-dhcp.cox.net> <7v3bgl7z80.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 02:23:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT6f5-0006bo-PH
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 02:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWDKAXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWDKAXL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 20:23:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5329 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932204AbWDKAXK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Apr 2006 20:23:10 -0400
Received: (qmail 6765 invoked by uid 2001); 11 Apr 2006 02:23:11 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bgl7z80.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 11, 2006 at 02:06:07AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Pasky wanted to have an option to get both diff-raw output and
> > diff-patch output.  This implements "git-diff-* --with-raw"
> > (which obviously implies -p as well) to do so.
> >
> > Because all the necessary information is already on extended
> > header lines such as "index xxxxxx..yyyyyy" and "rename from"
> > lines, this is not strictly necessary, but if it helps
> > Porcelains...
> 
> And this alternative gives raw upfront followed by patch.  It
> was unclear which one Pasky wanted, so...

Technically, I don't really care, I can parse both. :-) But I prefer
this format since then people can use it even when visually inspecting
the diff output, as a kind of quick patch summary followed with the
patch itself. It might be nice to separate the patch by another newline,
like my patch does (but again, I can parse both).

Your patch is nicer, but the --with-raw option name is strange -
git-diff-* output is by default the raw format, and with the --with-raw
option you tell it to furthermore include the raw format... sounds
wrong, doesn't it? ;-) I'd call it --patch-with-raw or -P.

Also, it would be nice to handle the -c case as well. Not strictly
necessary for cg-log right now, but other cg-Xfollowrenames users might
want to have that for merges... (Potentially, this might break renames
detection but the case is really obscure.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
