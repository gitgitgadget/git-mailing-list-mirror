From: Subho Banerjee <subs.zero@gmail.com>
Subject: Re: GSoC Application [ Parallelism + Git.pm ]
Date: Thu, 22 Mar 2012 00:22:30 +0530
Message-ID: <CAB3zAY0atsiXkBDxaRkC+WGzQUSOYgTnRZmOXdqKiXRw_DKkjQ@mail.gmail.com>
References: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
 <m37gyhlvkz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 19:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAQeX-0000zH-1F
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 19:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab2CUSww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 14:52:52 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57947 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2CUSwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 14:52:51 -0400
Received: by vcqp1 with SMTP id p1so1317133vcq.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Q54aS2HDNHdXWdMljupx0pnt8nxLZ6lHwS8Idppu//o=;
        b=bWJCSJOfHgjwI+JLG+jSroaNrK8+HswOnd8uT/00Fg1iidNp3AzLFY0kSPtqDLbOAa
         r+tpeg9X8XCUo4ELA6CFNJv28Z1DNzQdhTQ3CbwCUdBj0373A0XxiC/gCAR5sUfPuxyN
         ljNTfflg8X36aIm2rVk7hcVKrV1nOh/gSlnKavrdep1AfOsEij/OtY5PliVjInO6PY3l
         UlQ4RxPAZheaYb9o8kr3MwjFl+lk8UQx+iicwSXiV9JRY+fO9YERzKY9wsPC7c/pilld
         OIxEfUq5kPtWNXJx5/X3QYGU620zwtsDZdDspEfU7mzvGJOJxauhakYyz8LckAhUSQp+
         dvQQ==
Received: by 10.220.141.201 with SMTP id n9mr2330810vcu.66.1332355970904; Wed,
 21 Mar 2012 11:52:50 -0700 (PDT)
Received: by 10.220.141.193 with HTTP; Wed, 21 Mar 2012 11:52:30 -0700 (PDT)
In-Reply-To: <m37gyhlvkz.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193599>

Hello Jakub,
I had some time to look through the perl module in the Git sources and
I wanted to summarize the changes that need to be made -

[Primary Task]
[1] Move exception handling from Error::Simple to Try::Tiny and Excepti=
on::Class

[Additional]
[2] A Git::Config module that parses the .gitconfig file and the
=2Egit/config file in each repository(Is it one of these files or both?=
)
[3] Parsing Tree and Commit objects and then traverse the tree
structure in Perl through a Git::Commit module.
[4] Cleaning-up improving the API.
In general move towards an module that can access and change data in
the configuration and commit status using Perl instead of the fork and
IPC being used now.

Is this what you expect as a part of the GSoC work? Could you please
tell me if I am missing something.

Cheers,
Subho.

On Sun, Mar 18, 2012 at 10:01 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>
> Subho Banerjee <subs.zero@gmail.com> writes:
>
> [...]
> > I had a look at the "Ideas" page on the GSoC website and I really
> > liked two particular project ideas, in which I believe I can
> > contribute to a larger extent.
> >
> > * Improving parallelism in various commands
> > * Modernizing and expanding Git.pm
>
> [...]
> > From what I understand of these tasks --
> [...]
> > * For the second one, which aims at improving the Git perl module. =
I
> > tried looking around for this one on the net. I was a little confus=
ed
> > since I could not make out which module this was on CPAN. Is this o=
ne
> > of the Git::* modules or is it all of them. Because the the
> > functionality of the Git::Config and Git::Commit as mentioned in th=
e
> > Ideas page seems to be there in the Git::Repository module on CPAN.
> > Could some one please clarify this.
>
> The "Modernizing and expanding Git.pm" project refers to the Git
> module in git sources[1], that is used by git commands implemented in
> Perl like git-svn, git-send-email, and interactive part of git-add.
>
> It is not on CPAN (though if you feel like it putting it on CPAN migh=
t
> be part of this project, but it must be "dual-lived").
>
> [1]: http://repo.or.cz/w/git.git/blob/HEAD:/perl/Git.pm
> =A0 =A0 http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;hb=3DHEAD;f=3D=
perl/Git.pm
> =A0 =A0 https://github.com/git/git/blob/master/perl/Git.pm
>
> You can of course take inspiration and code (if it is with compatibil=
e
> license) from various Git::* modules on CPAN to implement the
> "expanding" part of this project.
>
> Note that Git.pm must remain extremly portable, which includes
> ActivePerl on MS Windows (msysGit or Cygwin). =A0Use of non-core modu=
les
> (for 5.8.0) should be also probably limited.
>
> > I would really appreciate any ideas or advice for making my
> > application for GSoC 2012 better.
>
> HTH
> --
> Jakub Narebski
>
