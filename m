From: Erez Zilber <erezzi.list@gmail.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Sun, 2 Feb 2014 22:38:15 +0200
Message-ID: <CALMr_pVP-YVJ9K7ZpQxk3d5YBFQmCZBonFeUYY1fxdZNHHZJHA@mail.gmail.com>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
	<20140130181643.GG27577@google.com>
	<20140130185104.GV3241@zaya.teonanacatl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 21:38:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA3oS-0003Yb-6I
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 21:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbaBBUiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 15:38:17 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:39185 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaBBUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 15:38:16 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so7156588obc.32
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 12:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8LnH0AifvDpfPMTdBLq3YaK6d921QS77Wk+12h+I49c=;
        b=WOodrd8gXOUGH6c/zmIhgcpWZiBAQmAor2SyUR1X9NBPTmoHKIOB3u8GoJ6YItOcSt
         Jm87VY+k7kQ/ZGFRlk30w6vyCwvOvAyHoxCMNrxYIdlO+kvFnGQk8SLy0aP0R2SRdU7X
         4CcyIEo59kLkRgfsy4ZqYZWAoVrdysipjKCDepAhjwz1MmqyR0aOml/yPRk7eSJTJj9I
         kj9NqxMMt1jWS2RRzbyAGiTXwfw99Yxo6PL83kklHCJhByPuN2P+1XQFrZAfY8lHrgnE
         tN2JpIe2qwaLP+IWLK/1oSzBGXKgADvtjdNghtITegV5cLWCMAAMMA4nwMrn/rSbpGGM
         MGSg==
X-Received: by 10.182.194.78 with SMTP id hu14mr26900911obc.8.1391373496039;
 Sun, 02 Feb 2014 12:38:16 -0800 (PST)
Received: by 10.60.68.99 with HTTP; Sun, 2 Feb 2014 12:38:15 -0800 (PST)
In-Reply-To: <20140130185104.GV3241@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241383>

Thanks. I will try to use the rpm from Todd's build. BTW - if I want
to create such a build on Fedora that will create el6 packages (e.g.
git-1.8.5.3-2.el6.x86_64.rpm), what's the procedure?

Thanks,
Erez

On Thu, Jan 30, 2014 at 8:51 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Hello,
>
>
> Jonathan Nieder wrote:
>>
>> Erez Zilber wrote:
>>
>>> Writing perl.mak for Git Writing perl.mak for Git rename MakeMaker.tmp =>
>>> perl.mak: No such file or directory at
>>> /usr/share/perl5/ExtUtils/MakeMaker.pm line 1024. make[3]: perl.mak: No such
>>> file or directory make[3]: perl.mak: No such file or directory make[3]: ***
>>> No rule to make target `perl.mak'.  Stop.
>>
>>
>> Looks like MakeMaker is racing against itself.  Alas, (on a fairly current
>> Debian system, with perl 5.14.2) I'm not able to reproduce that.
>>
>> Instead, I get this:
>>
>> | $ make -j8 rpm [...]
>> | make[2]: Leaving directory
>> `$HOME/rpmbuild/BUILD/git-1.8.5.3/Documentation' | make[1]: Leaving
>> directory `$HOME/rpmbuild/BUILD/git-1.8.5.3' | + exit 0 |
>> Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.WqNYnx | + umask 022 | + cd
>> $HOME/rpmbuild/BUILD | + cd git-1.8.5.3 | + rm -rf
>> $HOME/rpmbuild/BUILDROOT/git-1.8.5.3-1.x86_64 | + make -j12 'CFLAGS=-O2 -g'
>> \        DESTDIR=$HOME/rpmbuild/BUILDROOT/git-1.8.5.3-1.x86_64 \
>> ETC_GITCONFIG=/etc/gitconfig prefix=/usr \      mandir=/usr/share/man
>> htmldir=/usr/share/doc/git-1.8.5.3 \      INSTALLDIRS=vendor install
>> install-doc | make[1]: Entering directory `$HOME/rpmbuild/BUILD/git-1.8.5.3'
>> | make[1]: warning: -jN forced in submake: disabling jobserver mode. |
>> make[1]: *** write jobserver: Bad file descriptor.  Stop. | make[1]: ***
>> Waiting for unfinished jobs.... | make[1]: *** write jobserver: Bad file
>> descriptor.  Stop. | error: Bad exit status from /var/tmp/rpm-tmp.WqNYnx
>> (%install) | | | RPM build errors:
>> |     Bad exit status from /var/tmp/rpm-tmp.WqNYnx (%install) | make: ***
>> [rpm] Error 1
>>
>> Known problem?  A build without -j8 gets further.
>
>
> It seems like it's not a problem with el6 or git's Makefiles themselves.  I
> haven't used the spec file from git.git in ages, but I have tried to ensure
> that the one we use in Fedora builds cleanly on el{5,6}.  I use this myself
> to keep an update git on el6, where Red Hat has left git at 1.7.1 since the
> release of el6 however many years ago. :(
>
> Here's a build I ran just now using the latest Fedora SRPM, showing it
> succeeds with make -j5:
>
> http://kojipkgs.fedoraproject.org//work/tasks/3049/6473049/build.log
>
> The build task, with all of the resulting rpms and logs is here:
>
> http://koji.fedoraproject.org/koji/taskinfo?taskID=6473049
>
> (That will remain for a few days or so, at least.  Scratch builds like this
> aren't kept indefinitely.)
>
> This makes me think that there's something in the git.spec in git.git that
> differs from what we use in Fedora/EPEL.  I don't have time to dig into that
> now, but perhaps someone with time and inclination can diff the spec files
> and find the cause.
>
> I know the Fedora/EPEL spec file and what's in git.git have grown apart a
> good bit, unfortunately.  That's the cost of having a spec file that is
> meant to work across a very wide array of RPM-based systems, I guess.  The
> Fedora/EPEL spec file is fairly specific to the Fedora/EPEL build tools
> (mock is the primary build tool).
>
> Hope this helps a little in narrowing down the issue.  I'm sorry I can't be
> of more assistance at the moment.
>
> --
> Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> How am I supposed to hallucinate with all these swirling colors
> distracting me?
>     -- Lisa Simpson
>
