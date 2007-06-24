From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [PATCH][RESEND] Escape some tilde characters causing spurious subscripts in documentation
Date: Sun, 24 Jun 2007 14:40:01 -0700
Message-ID: <31e9dd080706241440s21025c26p68fda1595d531f1e@mail.gmail.com>
References: <11826426733115-git-send-email-jasonsewall@gmail.com>
	 <Pine.LNX.4.64.0706240109540.4059@racer.site>
	 <31e9dd080706231722v760b5a0cnc31e24b83deafb90@mail.gmail.com>
	 <7vbqf5wtrb.fsf@assigned-by-dhcp.cox.net>
	 <31e9dd080706241031m64c6be37sb4437036fda543c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 23:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ZoW-0005sf-Ur
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 23:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXFXVkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbXFXVkF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 17:40:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:15712 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbXFXVkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 17:40:03 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1287210wxc
        for <git@vger.kernel.org>; Sun, 24 Jun 2007 14:40:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GO5yRE4o4V5rTjFdkAA0MwwmRZ5BUZNQfyvHKS6Cda6li3w2gPb0AlFVoeu9gYKuSFEAYHt2ldUIrBNGqOP5q4ieAg9jfIsfdxi88cJeUPWns4iVWGFx4PhqpTSQUF8GpajQs0LFabYFqfsIUdcMK5vOt6oSiULKsY/G9UX9+Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S/be7G6gW8FOO4qdYIF2Pj84zkvAjGiOPUyBQTvTxpU+d4ROQpZ0fstRrFOnzxLyBdJO6JeFiYL5xHk34WSRHD9+qQLVn2GTakbGtQwNfwr4tZH7pQ1GAiT+3SxVq/EyaVfmf/qgT2Qzq+SVgJDYl16qEPbvpaFvedMO0AnZ7IM=
Received: by 10.90.75.10 with SMTP id x10mr3698220aga.1182721201086;
        Sun, 24 Jun 2007 14:40:01 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Sun, 24 Jun 2007 14:40:01 -0700 (PDT)
In-Reply-To: <31e9dd080706241031m64c6be37sb4437036fda543c9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50824>

On 6/24/07, Jason Sewall <jasonsewall@gmail.com> wrote:
> On 6/24/07, Junio C Hamano <gitster@pobox.com> wrote:
> > "Jason Sewall" <jasonsewall@gmail.com> writes:
> >
> > > On 6/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > >> I just checked with my copy of asciidoc, though, and there is no mangling
> > >> going on, at least in git-bundle.html (which is the only file I checked).
> > >> My asciidoc is version 8.2.1. What is yours?
> > >
> > > I've got 8.1.0; perhaps that's the problem. I wasn't so surprised to
> > > hear the asciidoc 7 and 8 don't get along, but I'm surprised to see
> > > that 8.1 and 8.2 are so different.
> > >
> > > Anyway, 8.1.0 is apparently what's in Fedora 7 (the distro I'm using
> > > right now) so it might be worth hanging on to the patch.
> >
> > FWIW, 7.1.2, 8.2.1 and 7.0.2 all seem to be Ok (the last one is
> > used to format the pages in html and man branches of git.git).
> > It is a bit annoying having to use name\~num at some places and
> > no backslash all others.
> >
> > Two requests:
> >
> >  - Documentation/git-rev-parse.txt has '{tilde}<n>'.  If you
> >    replace that {tilde} with a "~", how does your AsciiDoc
> >    format it?  Do you see the same breakage?
>
> Kinda. Replacing {tilde} with ~ actually causes asciidoc to fail while
> processing the file; that tilde is 'unmatched' and ends up crossing
> another tag or somesuch.
>
> >  - If it breaks, does it fix the breakage if you prefix the "~"
> >    with a backslash, instead of using {tilde}?
>
> The escaped tilde works fine.
>
> > If the answer to both questions are "yes", then perhaps we
> > should get rid of the {tilde} macro we define in
> > Documentation/asciidoc.conf file, and use your "\~" solution
> > everywhere.
> >
> > Also do you see any pattern?  It does not seem that all the
> > "master~3" are broken for you but only some.  If your commit
> > message can describe when quoting is needed, that would help
> > people who would modify the documentation in the future.
>
> I clearly need to read up on Asciidoc formatting directives before I
> could do that with confidence, but I look over it today and see what I
> can do.

Frankly, I don't see any pattern. The git documentation is very fond
of ~ and ^, naturally, and these are inline delimiters in Asciidoc.
Sometimes the places these appear in are unquoted, sometimes
double-quoted, grave-quoted, or single-quoted; any of these can cause
<sub> and <sup> tags in the html output.

I'd suggest that we put all inline revspecs inside $$...$$; this
"inline passthrough" quote  obeys outside quoting, and it's what
AsciiMathML uses to avoid fighting reserved characters. Since ~, ^, {,
}, [, ] and more all appear with great frequency in refspecs, this
will save us a lot of escape characters.

There's also a few places where ~ appears in a path name; perhaps we
could put $$...$$ around paths too.

Is there a documentation 'style' file or something like that for git?
Something like that might  be useful to help solve this sort of
problem; in addition to unintentional formatting problems like the one
under discussion, there doesn't seem to be a consensus on what sort of
quoting to use for special literal text, like git commands, refspecs,
pathnames, etc. - `, ', and " abound interchangeably.

Jason

P.S. I got smarter about how to find some of these formatting problems
and have found some more 'doc bugs' that I'll put into a patch once
we've decided how to handle this stuff
