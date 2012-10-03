From: Phil Hord <phil.hord@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 10:15:42 -0400
Message-ID: <CABURp0okOXpZGGawAUfUEUq3ahSHic-80qsfr5oJ4jX5ZFUh4g@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
 <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
 <7vhaqc7in6.fsf@alter.siamese.dyndns.org> <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
 <90464C79DA97415C9D66846A77ECAA4A@PhilipOakley> <CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
 <vpq626s6kwu.fsf@grenoble-inp.fr> <CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
 <vpqvcer4xvo.fsf@grenoble-inp.fr> <CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
 <CABURp0oHez6j8+FPG8Zm52TGVyC1XwWhE55TBDrXRGFrW6kWww@mail.gmail.com> <CAB9Jk9DmFQcgd2jT4c1eMx91mikchVcKfNVLsmfjxaZL_G3vTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 16:16:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJPkG-0007Eu-L4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 16:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab2JCOQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 10:16:07 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42224 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab2JCOQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 10:16:04 -0400
Received: by lbon3 with SMTP id n3so6237575lbo.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=49sz6/1B9zTK7Mef2cAeOz99j3w0ZBXE9AgqadbNQY4=;
        b=hSZdQ8HBYyPT9e7q8Q958d2KLrdSm6pyqbe/f90Ao9eGGajJPfT7RShIikU5vbRTCz
         pC+ldzKnWNLurfkZkdLotrRCMmMZNB9q0QmlDvEV3D8cxzIK9kFMTjq0/PwWz5mQBAk+
         mZUMLjg+NA4xCWNdoQwaeQGbv/yIA68dbygc3zRBORafxo4/Utb2Kl8pxFT1V8dRSXf2
         GdrlQXI156yGGWbVgmMPvYKIcBDJahG0QlogGXA+wg/uNDupcsU5E02cwIk07mYlyLSo
         qm0PHGX147At5XE9N5wouZ3PNxvR4V7BC2QxF0+79fafU4AbyNA8QXCi/oVvHshk1tKC
         V2JQ==
Received: by 10.152.110.229 with SMTP id id5mr1835648lab.36.1349273762918;
 Wed, 03 Oct 2012 07:16:02 -0700 (PDT)
Received: by 10.114.17.225 with HTTP; Wed, 3 Oct 2012 07:15:42 -0700 (PDT)
In-Reply-To: <CAB9Jk9DmFQcgd2jT4c1eMx91mikchVcKfNVLsmfjxaZL_G3vTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206898>

On Wed, Oct 3, 2012 at 9:35 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hi Phil
>
>>
>> I think what you are missing here is that the script does _not_ have
>> to take care for this special case.  The script can do the same thing
>> it does for all the other cases and it will work just fine.  This is
>> because your goal, as I understand it, is this:
>>
>> A. Take this branch,
>> B. Copy it but remove the binaries,
>> C. Push it to the remote (with no binaries)
>>
>> If the branch has no binaries to begin with, then B is a no-op.  Your
>> insistence that the new commits get unique SHA1's is unnecessary and
>> is what is causing your trouble.
>
> Suppose the branch has binaries. Then the only way to avoid to push
> them is to create an orphan branch (one that has no parents),
> otherwise git push will upload also the parent with its binaries.

This is true only if the root commit also has binaries.  Otherwise it
is fine to push a branch with the common ancestor.

Suppose A does not have binaries but B and C do.

A---B---C

Now we need to make a new branch ending at C' which has no binaries:
A---B---C
 \
  ---B'---C'

A already has no binaries, so we did not need to make an A'.  Now we
can push C' to the server and no binaries will be pushed.  That is
because the server will receive only these commits:

A---B'---C'


> This is why there is a need to make the script perform different
> actions depending on the presence of the binaries. In the attempt to
> make the script handle both cases in a simple way I tried to make an
> empty commit, and discovered the time-dependent behavior of it.

Every commit is time-dependent.  You tried to make a _unique_ empty
commit, and this is where you ran into trouble.  I think your
uniqueness constraint is overkill.


>> Consider this analogous operation:
>>
>> A. Take this file,
>> B. Remove every line that does not contain foo,
>> C. Cat the result to the console (with only foo lines)
>>
>
> This example differs from the commit one in that the user has to cope
> with data that s/he can fully control (the contents of files), while
> in the other s/he has to cope with the passing of time, which s/he
> cannot control. So, taking the files I can predict the result, but
> taking the commits, I cannot because I do not know exactly when they
> will actually be run. Time is a sort of independent variable that I
> know only approximately (or very approximately when the commands are
> embedded in scripts).

You need not be concerned with the time on the commit, nor the
uniqueness of the SHA1.


>> It seems to those more familiar with git that you are saying that this
>> is "the problem", that the operation did not work because the results
>> are not unique each time.
>
> Exactly.
>
>>
>> But if you ignore the SHA1 of the commits and just rely on the branch
>> names, I think you will be happier.  This is because two branches can
>> refer to the same SHA1 commit without causing any problem.  You may
>> find that sometimes when you push there is no update applied to the
>> server.  But this is not a mistake.  It is simply that the server
>> already has the same contents as you are pushing, even though your
>> local branch name is different than it was before.
>
> Actually I ignore the SHA1 of the commits, and rely on the branch
> names I have topic branches and /src/topic branches. Developers push
> when they have something new. Of course the scripts must take care of
> when they are called and there is nothing to push, but that is not a
> big problem.
> I eventually found a workaround, which is to change the commit
> message, forcing then git commit to create a brand new commit.

Doesn't this force git always to push new commits even though the
contents match commits already on the server?

>> I think when you say "orphan" you mean it has a different SHA1 than
>> any other commit.  But this is not what "orphan" means.
>
> No, I mean that it has no parents.
>
> Actually, in the special case in which there are no binaries, I could
> create a branch that points to the same commit as the branch that it
> is mirroring, and push it. However, this has two disadvantages: 1.
> that it will not be an orphan while in the more general case it is,
> and 2, that the history of commits will be pushed to the remote
> server, while in the general case (with an orphan) it will not. I
> preferred to have a unique branch topology so as to make the picture
> as simple as possible for the developers.

It seems to me that you are creating unnecessary work for the server
and for your scripts.  But perhaps I do not fully understand your use
case.

> Note that eventually I solved the problem with a tweak. I still
> believe that the git commit command does not behave properly, and that
> changing nothing (implementation or documentation) leaves a drifting
> mine on which someone (or even myself) will stumble sooner or later. I
> am spending time to write all this because I care for git and I would
> really see it improving over time removing weak spots, and believe
> that you do the same.

You may suggest improvements to the documentation.  But be careful to
understand the existing documentation completely before you do.

Thanks for helping.

Phil
