From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Fri, 16 Oct 2015 09:21:27 +0200
Message-ID: <20151016072126.GL11304@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
 <1444911524-14504-3-git-send-email-tklauser@distanz.ch>
 <vpqzizkysyh.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:21:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmzKZ-0004AU-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbbJPHVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 03:21:31 -0400
Received: from sym2.noone.org ([178.63.92.236]:57616 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675AbbJPHVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:21:30 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ncf6c6Z3hzQWh1; Fri, 16 Oct 2015 09:21:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqzizkysyh.fsf@grenoble-inp.fr>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279734>

On 2015-10-15 at 18:52:54 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > --- a/Documentation/git-stripspace.txt
> > +++ b/Documentation/git-stripspace.txt
> > @@ -9,7 +9,7 @@ git-stripspace - Remove unnecessary whitespace
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git stripspace' [-s | --strip-comments] < input
> > +'git stripspace' [-s | --strip-comments] [-C | --count-lines] < input
> 
> I'm not sure it's a good idea to introduce a one-letter shortcut (-C).
> In scripts, --count-lines is self-explanatory hence more readable than
> -C (which is even more confusing since "git -C foo stripspace" and "git
> stripspace -C" have totally different meanings. Outside scripts, I'm not
> sure the command would be useful. I'd rather avoid polluting the
> one-letter-option namespace.

Ok, I'll drop the -C. Didn't consider the `git -C stripspace' case, so
that's definitely unwanted.

> > +Use 'git stripspace --count-lines' to obtain:
> > +
> > +---------
> > +|5$
> > +---------
> 
> In the examples above, I read the | as part of the input (unlike $ which
> is used only to show the end of line). So the | should not be here. I
> don't think you need the $ either, the --count-lines option is no longer
> about trailing whitespaces.

Will drop both | and $. Seems I didn't check the output careful enough,
both don't make sense for this option.

> > +static const char * const usage_msg[] = {
> 
> Stick the * to usage_msg please.

Will change in v2.
