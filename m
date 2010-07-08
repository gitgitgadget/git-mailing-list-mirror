From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitweb.css
Date: Thu, 8 Jul 2010 14:57:03 -0400
Message-ID: <19510.8063.606085.233114@winooski.ccs.neu.edu>
References: <19509.15171.909921.769184@winooski.ccs.neu.edu>
	<m3y6dmklg0.fsf@localhost.localdomain>
	<19510.3565.336183.72646@winooski.ccs.neu.edu>
	<201007082049.23550.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 20:57:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwHa-0004Dk-8O
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 20:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472Ab0GHS5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 14:57:07 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:49175 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758463Ab0GHS5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 14:57:05 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWwHP-0000Ro-Jw; Thu, 08 Jul 2010 14:57:03 -0400
In-Reply-To: <201007082049.23550.jnareb@gmail.com>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150594>

On Jul  8, Jakub Narebski wrote:
> Ah, all right.  I think I understand your problem, then.
>  
> The problem is that in included GITWEB_SITE_HEADER, GITWEB_HOMETEXT
> and GITWEB_SITE_FOOTER gitweb style applies to links and tables, and
> you want to have own style based on default HTML style values, isn't
> it?

Yes, sorry for not clarifying that I'm using the header/footer
feature.


> >> [...]
> >> I'd rather not add 'gitweb' class (or similar) to every element just
> >> to have common style for all links tables table header cells 
> >> table cells.
> > 
> > Why not add just a <div class=".gitweb"> container for all gitweb
> > content then have css for ".gitweb foo" for anything you want?
> 
> First, I dislike this solution.

I don't like it either -- but having similar problems in the past it
looked like the most convenient way to deal with such problems.
(Specifically, it doesn't require changing all elements in the page.)


> Second, similar solution would be beter, namely consistent division
> of page into gitweb_header, gitweb_body and gitweb_footer, moving
> style of 'body' to gitweb_*, and 'table' etc. to '.gitweb_body
> table'.  The problem is with the way CSS is structured currently: I
> had problems with some elements losing their margin, and some
> elements having double margin.

This is similar enough that I don't see any difference :)

As for the `gitweb_header' and `gitweb_footer' -- do you mean the user
included files?  If so, it doesn't sounds like something that is
needed, since users can do any formatting that they want there,
including using some of the gitweb classes.  Another point to consider
here: I found it convenient that the header/footer are included as is,
we have a bunch of stuff in the header -- and our footer is "</div>",
so wrapping them with some div will break this use.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
