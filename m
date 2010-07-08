From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitweb.css
Date: Thu, 8 Jul 2010 13:42:05 -0400
Message-ID: <19510.3565.336183.72646@winooski.ccs.neu.edu>
References: <19509.15171.909921.769184@winooski.ccs.neu.edu>
	<m3y6dmklg0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 19:42:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWv70-0003fe-FL
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 19:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab0GHRmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 13:42:08 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:48690 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881Ab0GHRmH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 13:42:07 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWv6r-0006El-BL; Thu, 08 Jul 2010 13:42:05 -0400
In-Reply-To: <m3y6dmklg0.fsf@localhost.localdomain>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150589>

On Jul  8, Jakub Narebski wrote:
> Eli Barzilay <eli@barzilay.org> writes:
> 
> > I've been customizing a gitweb server to fit with the rest of our
> > project pages (the result is http://git.racket-lang.org/).  This was
> > relatively easy to do except for a few places where gitweb.css
> > specifies formatting for generic tags like `body', `table', and `td',
> > which messed up our header.
> > 
> > Maybe it makes sense to localize these styles to to gitweb specific
> > classes?  (I know that I can just use my own css, but the file is big
> > enough that I prefer avoiding manually merging in updates.)
> 
> Can't you just override gitweb's CSS by your own CSS?  Later CSS
> wins.  You can have more than one stylesheet in gitweb
> (@stylesheets).

I know -- and I'm using that.  The problem is if there's a property
that we're not defining, then it won't get overridden -- and doing so
requires knowing what the default value is, and keeping our css
updated for future extensions (eg, if tomorrow you make add
`font-family' to the `table' entry, we'll need to add one too, etc).
And still, this means overriding your settings, which were probably
done for a reason...


> [...]
> I'd rather not add 'gitweb' class (or similar) to every element just
> to have common style for all links, tables, table header cells,
> table cells.

Why not add just a <div class=".gitweb"> container for all gitweb
content, then have css for ".gitweb foo" for anything you want?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
