From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 12:23:38 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603231223090.4690@virtualbox>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com> <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com> <alpine.DEB.2.20.1603221552100.4690@virtualbox>
 <alpine.DEB.2.20.1603221610370.4690@virtualbox> <CAFZEwPOV1oE=5uyyooM1kYKxbuY0Jn=ccxYwsc5sxi0e9cgS6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:24:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigtO-0000t4-B9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 12:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbcCWLXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 07:23:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:58381 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899AbcCWLXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 07:23:43 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LZhsq-1a45CR1UoW-00lTIF; Wed, 23 Mar 2016 12:23:39
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPOV1oE=5uyyooM1kYKxbuY0Jn=ccxYwsc5sxi0e9cgS6A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:HLHdYhfz9T9omQjFshZDhwXEaSpf0YDUgp6lYRZug1Sj+zV/FHv
 JpWO+s5xEmKP1oUaEATa2ChPFtTGp0R7VDhH3YXkpk+McmdUHtNuCqT7kIdmNTkn81Ir8s1
 8JTJ2uSkq/zc8vCGlSzl3OH8Ay7TDCUeEQ2Ourav9/klSN16Qx/A8q02N9JQryvz/E6j5iN
 yUgzvnBtQxlXSmyCOMxMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xrczLz0Ki+I=:0dDYVcMpc5WYHl1KSAz5e6
 PG9lzbaK2e6z9FqK7hNa6qn1NP4o8ssYlQVgjAetcg+FZMjOn8CK4+aQhIZrvJ6JGa2tga1XK
 pmrJTWUKkob9e9JVW9qLLdkEEW2SHN3932tu6DKBdtNOCcJnPRJpWSWB5cW5q6rby3IGGn1AR
 U8rUvqhZMtk5qPlrtCepc5q3jDAXDVd4tvpzjCl6bDJ5608pxGd1JhdJ9qYg9XZURjqsAgSU4
 bXeEs+Ibde/jGavlTllFD62XsaqUaGx8OqIqnDM5x+7wTVVJYzBU4unVocioHHlnErve0D0ek
 CGMJRQkDI+35VgElM1rn7QdNzJGHPrNSv8dP04SG2Yi1rsjMKwgOaTPeQJ7CpmuCtP8IxyQk/
 7cEkQnlADxEe6cenaRCrzHXcrRSqDSCBxou6F3657VE107Lj4fJ/JjofpMvUX+Ap48d752DQK
 AYjkogUW5aO35sOzXEkOWtGJywslmhscvE/o3YssKTg7W9L3YpKRhKyAEi789Vr2AnQEmSXbv
 pFLBBBU9huS4YELAprfQvq3E6RYoYPEJn+HQOx0uQbZ6Hpcze1TqAtKtg1K25FmpqI13pYqkE
 FnpHoq2+4XCOaWLNROK+aqc3nnct1yBaVXE33G7ntAR4FO6C7L1k7/tXMoT2RRHesil4ZZQVv
 DKtFq5PyTFBTn4plL2kXM1fr0nx5wt+iz69N5n3C8jVh8GeiQ0DuLos4eFsCD6xQXEZQQb54F
 Z+Bd7H3GGBk4vsfSFVqY+dFbzRr9LChJGFJSN7wr3TDo6K7F/mLddXgHBwQTKmsl59MliA6Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289651>

Hi Pranit,

On Tue, 22 Mar 2016, Pranit Bauva wrote:

> On Tue, Mar 22, 2016 at 8:41 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 22 Mar 2016, Johannes Schindelin wrote:
> >
> >> On Tue, 22 Mar 2016, Pranit Bauva wrote:
> >>
> >> > +   if (!strcmp(term, "bad") || !strcmp(term, "new"))
> >> > +           if(strcmp(revision, "bad"))
> >> > +                   die("can't change the meaning of term '%s'", term);
> >> > +
> >> > +   if (!strcmp(term, "good") || !strcmp(term, "old"))
> >> > +           if (strcmp(revision, "good"))
> >> > +                   die("can't change the meaning of term '%s'", term);
> >>
> >> These two can be combined. Actually, these *four* can easily be combined:
> >>
> >>       if ((one_of(term, "bad", "new", NULL) && strcmp(orig, "bad")) ||
> >>           (one_of(term, "good", "old", NULL) && strcmp(orig, "good")))
> >>               die("can't change the meaning of term '%s'", term);
> >
> > Completely forgot to mention: This conversion skipped the comment
> >
> >         # In theory, nothing prevents swapping
> >         # completely good and bad, but this situation
> >         # could be confusing and hasn't been tested
> >         # enough. Forbid it for now.
> >
> > Let's port that comment over, too?
> 
> Sure! Adding a comment won't harm anyone. We can remove it when its
> thoroughly tested.

I am actually not so eager to remove the comment...

Ciao,
Johannes
