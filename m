From: David Aguilar <davvid@gmail.com>
Subject: Re: Help creating git alias
Date: Thu, 31 Oct 2013 10:40:15 -0700
Message-ID: <20131031174008.GA39079@gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
 <CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
 <CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
 <xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
 <CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
 <xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
 <CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 18:40:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbwEK-0008Jn-S1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 18:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab3JaRkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 13:40:18 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63278 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab3JaRkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 13:40:17 -0400
Received: by mail-pb0-f41.google.com with SMTP id um1so3203017pbc.28
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Co4EXLGekHX2K16U36dzLRRMPa23oFUhzCFHcVvvic0=;
        b=y+ptryHuwr8YNxqb0wA4XipdpASW/HKFJ4X3jPTqk94hWmNAlxQBptHtQrho0/BYIV
         Wcnnm5H2K344xfCCx+YOHFS5vERIn4wfNlpT4nSLz9PtTsGyVqiLEgF/eYqeejOL+dlT
         CdhnQDNfMUlh7Sy3tW2zg/qwQ1viyttEtg0yj1Dp3yRaVkNkA2dhLNnM10AYXUarl6mB
         CmL5ArKTBd9v1Loa6f8FPDmbCKsy8kHKYIvMhyGd2/7ITQU/a8qgudyZKf0QakrQW8dF
         nB7zxIBxUsYovy4Ao7D4q8x18tLk4tVEaa+eDvEr0IkT1QPozvENl5HGCchEb0hjVyjg
         6Npg==
X-Received: by 10.68.180.131 with SMTP id do3mr3182024pbc.34.1383241216806;
        Thu, 31 Oct 2013 10:40:16 -0700 (PDT)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id ql10sm4113070pbc.44.2013.10.31.10.40.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 10:40:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237133>

On Thu, Oct 31, 2013 at 11:36:59AM -0400, Eugene Sajine wrote:
> On Wed, Oct 30, 2013 at 11:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Eugene Sajine <euguess@gmail.com> writes:
> >
> >> That was my initial intention, because I would like to be able to pass
> >> parameters like to git log or git blame correctly without the explicit
> >> use of $1. Could you please advise about how to make it work with the
> >> !sh -c ?
> >>
> >> Because the same exact (sed 's/@\\S*//') syntax didn't work with "sh -c".
> >
> > You can make it work if you think step-by-step.  First, this is what
> > you want to run:
> >
> >         sh -c 'git log --format="..." "$@" | sed "s/@\S*//"' -
> >
> > so that "git euguess master..next" would turn into
> >
> >         sh -c 'git log --format="..." "$@" | sed "s/@\S*//"' - master..next
> >
> > Now, you want to wrap it into an alias, i.e.
> >
> >         [alias]
> >                 euguess = "!sh -c ..."
> >
> > That ... part is read by our configuration reader, so you need to
> > quote the double quotes and backslashes with backslash, which would
> > give you something like:
> >
> >         [alias]
> >                 euguess = "!sh -c 'git log --format=\"%h %ae %s\" --date=short \"$@\" | sed \"s/@\\S*//\"' -"
> >
> >
> 
> Junio,
> 
> Thanks for taking the time - I appreciate that a lot.
> It does work properly now except there is some difference between the
> required pathnames:
> 
> when i'm in a subfolder in git repo i can say
> 
> git log filename
> 
> But it seems that if the alias is used i need to specify full path
> from the root of the repo no matter where i am.
> 
> git log a/b/c/filename
> 
> the difference is obviously in the working directory
> 
> when i add an alias:
> 
> pd = "!sh -c 'pwd'"
> 
> i get this:
> 
> $ git pd
> /home/users/euguess/repo
> 
> $ pwd
> /home/users/euguess/repo/a/b/c
> 
> Is there any way to help that situation?

Here's the relevant details from Documentation/config.txt:

"""
If the alias expansion is prefixed with an exclamation point,
it will be treated as a shell command.  For example, defining
"alias.new = !gitk --all --not ORIG_HEAD", the invocation
"git new" is equivalent to running the shell command
"gitk --all --not ORIG_HEAD".  Note that shell commands will be
executed from the top-level directory of a repository, which may
not necessarily be the current directory.

'GIT_PREFIX' is set as returned by running 'git rev-parse --show-prefix'
from the original current directory. See linkgit:git-rev-parse[1].
"""

The $GIT_PREFIX variable should be available to the alias; it is
a path relative to the root which corresponds to the current
directory.

That doesn't quite play well with these aliases because they use
"$@", though.

One way to do it is to add another layer of indirection.  Maybe
someone else on this list has a better suggestion, but this
should do the trick...

Create a shell script to contain your alias, and then point
your alias at it.  e.g.

[alias]
	example = "!/path/to/alias-script \"$@\""

and then the script can look like:

#!/bin/sh

unset CDPATH
if test -n "$GIT_PREFIX"
then
	cd "$GIT_PREFIX"
fi
git log --format='%h %ae %s' --date=short "$@" | sed 's/@\\S*//'


...or something like that.  I hope that helps.
I'm also curious if there's a way to avoid needing the extra script...

...

A-ha.. I think adding the chdir to alias is possible using a function.

[alias]
	example = "!f() { cd \"${GIT_PREFIX:-.}\" && git log \"$@\"; }; f"

Does that work for you?
I hope that helps.

cheers,
-- 
David
