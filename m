From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 1/3] strbuf: make stripspace() part of strbuf
Date: Fri, 16 Oct 2015 09:09:54 +0200
Message-ID: <20151016070953.GJ11304@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
 <1444911524-14504-2-git-send-email-tklauser@distanz.ch>
 <xmqqsi5cghke.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:10:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmz9S-00010c-Pm
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbbJPHJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 03:09:57 -0400
Received: from sym2.noone.org ([178.63.92.236]:56539 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbbJPHJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:09:57 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ncdsH5MfZzQWbs; Fri, 16 Oct 2015 09:09:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqsi5cghke.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279732>

Thanks for the review.

On 2015-10-15 at 19:36:17 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > Rename stripspace() to strbuf_stripspace() and move it to the strbuf
> > module as suggested in [1].
> >
> > Also switch all current users of stripspace() to the new function name
> > and  keep a temporary wrapper inline function for topic branches still
> > using stripspace().
> >
> > [1] https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#make_.27stripspace.28.29.27_part_of_strbuf
> 
> I think Matthieu already mentioned this, but please explain why it
> is a good idea to do this in your own words here, without forcing
> readers to go to other places to find out.  Giving credit to an
> external page for giving you an inspiration to do something is good,
> but the proposed log message needs to justify itself.  In other
> words, when you are challenged to defend this change, you are not
> allowed to say "SmallProjectIdeas page said it is a good thing to
> do.  I just did it without questioning it." ;-)  Instead you are
> expected to justify it yourself.

Yes, makes sense. I'll adjust the commit message for v2 to justify the
change for itself and move the link below --- as Matthieu suggested.

> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> 
> A good rule of thumb to see if it is a good time to do this kind of
> change is to do this:
> 
> 	$ git log -p maint..pu | grep stripspace
> 
> which shows only one mention in a context, so this change may cause
> textual conflict with something else somewhere nearby but won't hurt
> other topics in flight.

Ok, thanks for the hint. I'll check again before resubmitting v2.

Thanks
