From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 20:56:15 +1000
Message-ID: <BANLkTikKp9-uFGLavBT0UA5+maV5xiEJZA@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:56:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFOtS-0004wr-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 12:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab1D1K4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 06:56:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51842 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1D1K4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 06:56:17 -0400
Received: by eyx24 with SMTP id 24so783718eyx.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8enB9M+yC0Ynjy247ZeRb1AqhiXqIfTGfgAbWyqiZo8=;
        b=GcfbtaSO8aEXlpsq1th40no1elDrNmIRbHec11ribmt2xnjNox3fxwTQdMJWviBPzJ
         V6adU/AZ9IGuvxhLYU2ulD0xt8/TcCSHrVf4ahLDoO1LzRguP1+3AbYqMKwYPf2gEwZ5
         qfSy7VTth828U08p1aBGDiGl5vPZq3gMx5vMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pgahY4DkgQpykOKfJ2NQRbuyfCMzaDnF3GSd04QkdYqb+RJGIiC6tZkoMLCy+HHmJz
         NvTFFZv1YBxunJAjdutrXos/bF/KwmR7thsI4HLw/gjD7ER2qZkZbhmwyZQLQvAqOfNw
         tBJMZvUN3N5UTVNNUH3IUosgIEWHdBhqTkIR8=
Received: by 10.14.7.1 with SMTP id 1mr1453705eeo.245.1303988175670; Thu, 28
 Apr 2011 03:56:15 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Thu, 28 Apr 2011 03:56:15 -0700 (PDT)
In-Reply-To: <4DB9329E.7000703@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172350>

On Thu, Apr 28, 2011 at 7:25 PM, Andreas Ericsson <ae@op5.se> wrote:
> On 04/28/2011 04:49 AM, Jon Seymour wrote:
>> On Thu, Apr 28, 2011 at 12:15 PM, Jon Seymour<jon.seymour@gmail.com>  wrote:
>>> Then a command like:
>>>
>>>     git install gitwork
>>>
>>> would trivially work across all distributions precisely because the
>>> distribution has provided the implementation of the git install
>>> interface contract that git-core has helpfully mandated.
>>>
>>
>> Or better yet, git-core could provide a trivial git install
>> implementation that selects between different distribution manager
>> supplied plugins selected according to some heuristic, allowing
>> several distribution managers to happily manage plugins in the same
>> git instance.
>>
>> I have to ask.
>>
>> Is such an architecture really "absolutely horrid"? Is it  "crap"? Really?
>>
>
> Yes, because it forces all distributions to name their extensions
> the same and it forces all distributions to carry the same extensions.

False.

Distributions maintain a N:1 registry of git plugin names to
distribution specific package names. This registry would most
naturally be maintained by the author who maintains the git package,
but of course, such responsibilities could be delegated to others if
required.

During installation, the package manage aware "install" plugin
consults such a registry to determine which packages need to be
installed in order to obtain the requested plugin. It then asks the
package manager to install said packages.

> It also makes it impossible to support 3rd party extensions that core
> git doesn't know about and that aren't already packaged, unless you
> want the "git install" command to have knowledge about all package
> management systems and *very, very good* heuristics when guessing what
> a particular extension is called on that system.
>

Again false. That is the role of the registry that is maintained by
some package author.

> What will happen though is that the distributions will happily ignore
> that and the "git install" command will fail for some extensions on
> some distributions.

Yes, but it can fail in a extremely precise way. In those cases, it
could fall back another package manager
such as one that is capable of checking out a git repo and running make install.

I realise that most people could not accomplish such a task without
writing vast amounts of spaghetti code, but there you go.

>
> Besides that, it forces users to install git from their distribution
> packages so we're hard-shafting the git developers who usually have
> at least some installations done from source.
>

No it doesn't. My suggestion allows deploy by drop-in configuration to
a subdirectory of plugins/ followed by the invocation of a command
such as.

  git plugin activate foobar

I realise this may "hard-shaft" the git developers who are unable to
invoke a git command, but I guess they could also put such a command
in their make install scripts. Now there's an idea.

> We just went far beyond "absolutely horrid" and into the realms of
> "steaming pile of abominably manure-like ideas whose inventor should
> be slapped silly for their own good".
>

Thanks, I'll add that to my vocabulary of terms that git developers
use when they let fly to their emotions for completely unaccountable
reasons. I'd suggest,. perhaps "grow up", but that would strike some
as rude. So, I won't.

> So let's get back to the basic wish you have here. You want people
> to be able to easily find, download and install "git work" so that it
> works nicely with man-pages and all.
>

What is so  hard about:

  app install plugin.

Forget git. Forget git work.

What is so hard about the concept of an application providing a
facility that allows it to request, merely request, the installation
of a plugin for itself by what ever happens to be the users choice of
package manager or distribution.

Is such a concept really, fundamentally flawed?

if so, replace "git" with "linux", "app" with "apt-get", "plugin" with
"git-core" and explain to me why

apt-get install git-core

is such a bad idea.

Yes, different levels of abstraction, but the principles are the same.

Like it or not, git is a platform, there is absolutely no reason why
it can't have sane plugin manager, other than complete lack of
imagination.


> The wiki-page with known extensions and the patch to core git so that
> "make install" can put man-pages in the right directory are the first,
> simplest and smallest steps that takes us the farthest towards that
> wish without burdening people you have no control over with more labor.
> In short; It's both good engineering and polite to implement that and
> then consider what new possibilities open up and see what people do
> with those possibilities. You might be surprised.

Yep, that's what unix package management was like before people
invented the idea of package managers.

How quaint.

jon.
