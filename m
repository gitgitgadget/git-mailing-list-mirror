From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] 64bit issue in test-parse-options.c
Date: Wed, 30 Jul 2008 14:44:52 +0200
Message-ID: <20080730144452.797d8686@pc09.procura.nl>
References: <20080730141656.41ce02ec@pc09.procura.nl>
	<20080730123713.GA31392@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 14:46:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOB43-0002NC-Tk
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbYG3Mo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbYG3Mo7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:44:59 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:3328 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbYG3Mo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:44:58 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UCiqSL010052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 14:44:53 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080730123713.GA31392@artemis.madism.org>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90777>

On Wed, 30 Jul 2008 14:37:13 +0200, Pierre Habouzit
<madcoder@debian.org> wrote:

> On Wed, Jul 30, 2008 at 12:16:56PM +0000, H.Merijn Brand wrote:
> > git-1.5.6.4 - HP-UX 11.23 64bit compile
> > 
> > * expecting success:
> >         test-parse-options -s123 -b -i 1729 -b -vv -n > output 2> output.err &&
> >         test_cmp expect output &&
> >         test ! -s output.err
> > 
> > --- expect      2008-07-30 11:52:05 +0000
> > +++ output      2008-07-30 11:52:05 +0000
> > @@ -1,5 +1,5 @@
> >  boolean: 2
> > -integer: 1729
> > +integer: 7425998454784
> >  string: 123
> >  abbrev: 7
> >  verbose: 2
> > * FAIL 2: short options
> > 
> > I'm sure you can come up with a more sensible change, but the current
> > code is definitely wrong
> > 
> > 
> > --8<---
> > --- test-parse-options.c.org    2008-07-30 11:57:16 +0000
> > +++ test-parse-options.c        2008-07-30 12:08:56 +0000
> > @@ -2,6 +2,7 @@
> >  #include "parse-options.h"
> > 
> >  static int boolean = 0;
> > +static unsigned int int_integer = 0;
> >  static unsigned long integer = 0;
> 
>   long is wrong in the first place, parse-opt only uses ints.

If I change it to int, the date parsing goes bogus.

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
