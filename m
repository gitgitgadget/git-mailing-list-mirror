From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 18:20:08 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130120232008.GA25001@thyrsus.com>
References: <20130120200922.GC7498@serenity.lan>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 21 00:21:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx4CF-0003xD-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 00:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab3ATXUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 18:20:42 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60945
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3ATXUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 18:20:42 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 8ADCE4064C; Sun, 20 Jan 2013 18:20:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130120200922.GC7498@serenity.lan>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214057>

John Keeping <john@keeping.me.uk>:
> I don't think there is any way to solve this without giving cvsps more
> information, probably the last commit time for all git branches, but
> perhaps I'm missing a fast-import feature that can help solve this
> problem.

Yes, you are.  The magic incantation is

    from refs/heads/<branch>^0

I've just pushed a cvsps-3.9 with an -i option that generates these at
each branch root.  Combine it with -d and you get incremental
fast-export.

You get to integrate this.  I think the transition strategy Junio
has chosen is seriously mistaken, leading to unnecessary grief for users
who will be fooled into thinking it's OK to still use cvsps-2.x. Because
I do not wish to encourage or endorse this mistake and am tired of arguing
against stubborn determination to do the wrong thing, I am not going to 
sink more effort into the git project's end of the CVS-lifting problem.
There are too many better uses for my time.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
