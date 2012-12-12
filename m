From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 07:43:06 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121212124306.GC25981@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
 <CACh33Fpk8_ZXw8Ladx83J+rmdRYf7ruYAMMkqOKcoH3OApKPJQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 13:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tileu-0001Gl-C5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 13:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab2LLMnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 07:43:15 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34982
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab2LLMnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 07:43:15 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 12C3C4408D; Wed, 12 Dec 2012 07:43:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACh33Fpk8_ZXw8Ladx83J+rmdRYf7ruYAMMkqOKcoH3OApKPJQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211351>

Patrick Donnelly <batrick@batbytes.com>:
> On Tue, Dec 11, 2012 at 10:30 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> > It might be a good fit for extending git; I wouldn't be very surprised if
> > that worked. However, I do have concerns about the "Oh, we'll just
> > lash together a binding to C" attitude common among lua programmers; I
> > foresee maintainability problems and the possibility of slow death by
> > low-level details as that strategy tries to scale up.
> 
> I think this is quite a prediction? Could you give an example
> scenario?

Everything old is new again.  I'm going by experience with Tcl back in the day.

>        How would another language (e.g. Python) mitigate this?

The way you mitigate this sort of problem is to have a good set of
high-level bindings for standard services (like socket I/O) built in
your extension language and using its abstractions, so you don't get a
proliferation of low-level semi-custom APIs for doing the same stuff.

I have elsewhere referred to this as "the harsh lesson of Perl", which
I do not love but which was the first scripting language to get this
right.  There is a reason Tcl and a couple of earlier designs like csh
that we would now call "scripting languages" were displaced by Python
and Perl; this is it.

My favorite present-day example of getting this right is the Python bindings
for GTK.  They're lovely.  A work of art.

> I don't see how these languages are more appropriate based on your concerns.

Your previous exchange with Jeff King indicates that you don't
understand glue scripting very well.  Your puzzlement here just
confirms that.  Trust both of us on this, it's important.  And
reread my previous three paragraphs.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
