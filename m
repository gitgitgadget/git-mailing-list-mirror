From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and Google Summer of Code 2012
Date: Tue, 20 Mar 2012 23:50:05 +0100
Message-ID: <201203202350.05686.jnareb@gmail.com>
References: <001636c5c21b02c35904bba0ff9a@google.com> <201203201637.10417.jnareb@gmail.com> <4F68DEC3.2090006@andrewalker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Andr=C3=A9_Walker?= <andre@andrewalker.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 23:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA7sg-0000yz-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 23:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758977Ab2CTWuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 18:50:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38242 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758951Ab2CTWuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 18:50:09 -0400
Received: by wgbdr13 with SMTP id dr13so285365wgb.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 15:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=p2Pt+KQeqfjaFpAf1ci7gLu1j+hQrTBuBfdb3yoj2HU=;
        b=VyUJjRX/oGB633bJrQB1JE+pFvJ/ZQlyxmKR6lau0dbTi2V4+1r1y0vGrHIdeZ1f3Y
         iZYVrvl5vwNP0K3+WjK5JbDfaOM4lbY1XKvcYHVzDe7KZhirM5kAu4DrENW4INMX5vQ3
         y1HI/qRmuolmYVykZ1j7bZgXLYYKhlGzFmIHgHpTOcBqOW/f1uCeJwgJkC3Ij3SZ+COt
         vtEJutcnCuCX15fvU0UHjqgl+ocf8Ohw/Qje7Unzw393fenQFzmM+0u20Ru9MBWgVfip
         gwE3ZrdVo8TGwN7fnG/rKKQLUnhj1q/ZFFw/USgrQTVUS0mEF5HPvKmp4ln5QosZPoFJ
         M5kw==
Received: by 10.180.83.198 with SMTP id s6mr3649974wiy.8.1332283807595;
        Tue, 20 Mar 2012 15:50:07 -0700 (PDT)
Received: from [192.168.1.13] (abwt72.neoplus.adsl.tpnet.pl. [83.8.243.72])
        by mx.google.com with ESMTPS id ex2sm12137106wib.8.2012.03.20.15.50.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 15:50:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4F68DEC3.2090006@andrewalker.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193545>

On Tue, 30 Mar 2012, Andr=C3=A9 Walker wrote:
> On 03/20/2012 12:37 PM, Jakub Narebski wrote:
> > Andr=C3=A9 Walker wrote:

> > > And, well, in the first one (Modernizing Git.pm) they pointed
> > > you as a possible mentor, so I'd like to know. First, how much of=
 Git is
> > > actually in Perl? In other words, how much of it is implemented i=
n Git.pm
> > > and related modules, or who would use it exactly?
> >
> > There are quite a few git commands implemented in Perl, and there w=
ere
> > even more before "builtin-ification" of git code (moving to C).  Th=
ose
> > include the interactive part of git-add (git-add--interactive helpe=
r),
> > git-cvsimport, git-cvsserver and git-svn, git-send-email, git-difft=
ool
> > and gitweb.  Not all of those use Git.pm module (git-cvsimport,
> > git-cvsserver and gitweb do not); changing this might be part of GS=
oC
> > project.
> >
> > Git.pm currently does mainly cover safe and portable (ActiveState P=
erl)
> > invoking of git commands, and a bit of converting / translating
> > output to Perl (e.g. config_bool() method).
> >
> > It is by no means complete; some of code could be refactored and mo=
ved
> > from individual commands to Git.pm module.
>
> Got it. I'm cloning git's code to help visualize it better.
[...]=20
> > More seriously, putting Git.pm on CPAN might be a part of this GSoC
> > project.  Not that CPAN lacks git modules: Git::Class, Git::PurePer=
l,
> > Git::Repository, Git::Wrapper, Git::XS (libgit2 based)...
> >
> > Note however that Git.pm must (in my opinion) remain "dual lived" m=
odule,
> > i.e. reside in git.git repository and be installable alongside git
> > with nothing but git sources.  This also means that any extra non-c=
ore
> > (or even not installed by default with "perl" package) modules that
> > Git.pm requires to work need to have copy in git.git repository jus=
t
> > like private-Error.pm (should be 'inc/Error.pm') does currently.
> >
> > Git.pm might ultimately be put in separate repository, and subtree-=
merged
> > into git.git like git-gui and gitk subsystems (or as submodule), bu=
t that
> > would require having real maintainer for this module.
>
> Right. Yeah, in a quick look on CPAN I saw those. I understand what y=
ou=20
> mean that it should remain dual lived. Is using local::lib a viable=20
> option? It would make it much easier to keep everything updated, and=20
> have new required modules, etc. Though I guess that's something that=20
> could be decided during development.

local::lib is a good solution (which probably didn't exist at the time
of writing Git.pm and putting private-Error.pm in 'perl/' subdirectory.
Whether it is good enough, or should we put required non-core Perl
modules in 'inc/' to be able to install them with Git.pm...
=20
Anyway it could be decided at merge time.

> > > It mentions replacing Error and Error::Simple for Try::Tiny and
> > > Exception::Class. What else should be modernized? And where else =
is there
> > > room for expansion?
> >
> > You could borrow from IPC::Run, Capture::Tiny and similar modules t=
o make
> > it possible to capture stderr of git commands to separate string or
> > separate filehandle, or just silencing stderr completely.  Perhaps =
even
> > allowing creating pipelines.
>
> I don't really understand what you mean by this. I should capture std=
err=20
> for Git.pm, or other git commands? And why would I do that? Is it to=20
> manually get errors instead of Try::Tiny?

Git commands might print some messages to stderr, even in the case wher=
e
result is not considered an error (e.g. "git rev-parse --verify", or
"git cat-file -t").  Gitweb uses string form of 'exec' (well, 'open "-|=
"'
to be more exact) with " 2>/dev/null" to silence warnings.  I'd like
to be able to silence stderr, or capture it (like command_oneline() etc=
=2E
capture stdout) with something like existing command_* commands.
=20
[...]
> > I think it might be too much work, though prototyping "Linus's ulti=
mate
> > content tracking tool" in Perl might be good idea...
>
> Yeah, now that you explained better, it's really too much work for GS=
oC.=20
> I'd better be realistic and pick one. Probably the Git.pm one is more=
=20
> realistic and could be used afterwards by "Linus's ultimate content=20
> tracking tool", if it's ever made in Perl.

Well, there is a question how many project will be funded by Google...
--=20
Jakub Narebski
Poland
