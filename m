From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in
 C
Date: Mon, 16 May 2016 18:45:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605161830200.3303@virtualbox>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-4-git-send-email-pranit.bauva@gmail.com> <CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
 <alpine.DEB.2.20.1605161508230.3303@virtualbox> <CAPig+cQ=Gche_uO840wF6qE4WD-ZNZj1HFzNNgaBi_UjG1sjEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 18:47:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2LgH-00030h-S3
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 18:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbcEPQrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 12:47:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:63427 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358AbcEPQrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 12:47:40 -0400
Received: from virtualbox ([88.128.80.193]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M5cpk-1bmJVp3ofw-00xc8d; Mon, 16 May 2016 18:46:34
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cQ=Gche_uO840wF6qE4WD-ZNZj1HFzNNgaBi_UjG1sjEg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:d+A43vypVcJtmwaLrPkex+vpaESsVLWKum7FlA4S1Bo5QXZY9oL
 Dvw8KjRvDB2Stgrnp8dDIPLxsg3ije3k/7jTDC1S2lX2UlOWZ4nin6p0PCpeeea8saO58H5
 B/qMMEONXAP+QY9NyyIc0smQXqA3LtfnQS/J9V1k1YfATjZ5auBV0HEOpAvEDNlLVylm5Xv
 EY05qXCdsBDF8QxzUSdKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qLA29P87u+0=:BbWYTdj5JOfEE1INtg9UQe
 gqXBcLfeu8qMdevhVoCg06c6kDD++mrbeyxAlOHVfUQahBtqm18O2MaJT5IuXgQQgZ/kLR3ph
 dNx4mdIK9IV4m2JOpR49LAO1+5ZhTut2Pj0Yu3Lsb0akBk+tOGxpntMH+d6/mC3eJeXayTDJ9
 I5rw8NRbSBXLrW9pgVNk/g4kysAUH4JXQII1YlNq4CfMSIGeRgrsYgNO0vP/JQ2geGpPr5TJk
 tlrt83gjtPXmNHVZWE6t3wU+vT3qLXyR3nlz/n5YeyTaZUZFcowT2uEZxmzF/WduYJHtbAF3B
 g9rDWIXjx4Iqirhd1Mg0Neg0K6ezLFQJDQNhts4+HlBEeDgiHUuaJSMar+4AQx7l/l09a+Lr/
 9xKqOIsHxe6pv7BlirjKKZKFI6qT6co8cttbJT6ZPh2e9j+1eavwaVEUvT3zt1DbHUDOlvglt
 k2svO2cCdmqbdBE43jcKGfTeAC2Qt2Vi9nHBVTir9q+Id5PGwAKfsFJfF/pwFpqToh/QuBeFJ
 skyV6j9dnSY0Fhk5dG8tLKch5wr3joawo7Io9uZSIO9W4x6NthVRraUoaeXdQ5nSlgv1mSC5y
 c9EJqj34EWaqq6FCXL8+drOlPgfYFF70Pewy2l1IFlf5oZ1pWyTYyFIMvjQI52RUOrg746SxA
 DrwXA67u0cdBhR1XRB41oaFneYJo8xDrVqFcZ2LgP7b96FJloX1Js/Z/4p2zCNzaZjN4sXCk0
 LoVGJkCswOoBhrSVSr6QtKNbSzOOK9bDmVnlnmMX3eKvfqBPc+g6fTAfJf9taEy1hYY+n0Rh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294753>

Hi Eric,

On Mon, 16 May 2016, Eric Sunshine wrote:

> On Mon, May 16, 2016 at 9:16 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 16 May 2016, Eric Sunshine wrote:
> >> On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> >> > +       fp = fopen(".git/BISECT_TERMS", "w");
> >>
> >> Hardcoding ".git/" is wrong for a variety of reasons: It won't be correct
> >> with linked worktrees, or when GIT_DIR is pointing elsewhere, or when ".git"
> >> is a symbolic link, etc. Check out the get_git_dir(), get_git_common_dir(),
> >> etc. functions in cache.h instead.
> >
> > Maybe in this case, `git_path("BISECT_TERMS")` would be a good idea. Or even
> > better: follow the example of bisect.c and use
> > `GIT_PATH_FUNC(bisect_terms_path, "BISECT_TERMS")`.
> 
> Thanks for pointing this out. My review time is severely limited these
> days so I didn't go the distance of re-studying and re-digesting which
> function was the correct one to use.

I am constantly amazed how much you manage to review, and how helpful your
comments are. I am glad if I could contribute a little.

> >> > +               strbuf_release(&content);
> >> > +               die_errno(_("could not open the file to read terms"));
> >>
> >> Is dying here correct? I thought we established previously that you
> >> should be reporting failure via normal -1 return value rather than
> >> dying. Indeed, you're doing so below when strbuf_write() fails.
> >
> > The rule of thumb seems to be that die()ing is okay in builtin/*.c, but not
> > in *.c. So technically, it would be okay here, too. However, I think that
> > this code should be written with libification in mind, so I would also
> > prefer it to error() and return, to give the caller a chance to do other
> > things after an error occurred.
> 
> Agreed. Specific to the "established previously" I wrote above, I was
> referring to [1] from just a few days ago which explained why 'return
> -1' was preferable to die() in a similar case that had an odd mix of
> 'return -1' and die() in the same function.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/289476/focus=293556

Yes, this is an excellent link. Maybe we would want something like this,
too?

-- snipsnap --
(From: Eric Sunshine <sunshine@sunshineco.com>)
CodingGuidelines: mention that die() is for fatal errors only

Let's formalize the rule when to use die() and when to use error().

diff --git a/Documentation/CodingGuidelines
b/Documentation/CodingGuidelines
index 0ddd368..5d2d65f 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -333,6 +333,10 @@ For C programs:
 
  - When you come up with an API, document it.
 
+ - Use die() only to signal an exceptional conditions which should
+   abort the program. All other error conditions should instead
+   return e.g. using "return error(...)".
+
  - The first #include in C files, except in platform specific compat/
    implementations, must be either "git-compat-util.h", "cache.h" or
    "builtin.h".  You do not have to include more than one of these.
