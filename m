From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Mon, 12 Apr 2010 10:09:42 -0400
Message-ID: <q2z76c5b8581004120709t860ff112i5dd057327b94ad0e@mail.gmail.com>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
	 <20100410042609.GA24295@coredump.intra.peff.net>
	 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>
	 <20100411102255.GB20484@coredump.intra.peff.net>
	 <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:16:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1KRM-0004ju-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017Ab0DLOQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 10:16:33 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33602 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0DLOQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 10:16:33 -0400
Received: by bwz19 with SMTP id 19so5054bwz.21
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n5eknhfJmJhpl3zdnZDAlqL6wUExKBuLgkT7atFOaLE=;
        b=QtonrAneAEYJ2KCGS/K1+Rvn4xck9gUhFwydOL8nDU74BpCjePpmOMvcxaqFgWTD2F
         o32R+KIKmyTbvkawUPgAc++7YEOpWM5uvnfA3RQP96iqRb49HXw92V2ZWQR36H4HKp8L
         vWeR6O3FW0TQFvh2gwRhOKDcn5b0KGwbQOYLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JSru3yk0JuMDwrsHPjGeXFJIWmq21ctRI4EHp05NW3Qxegf27c/owJhIJ1LXS5J+0X
         yzCc/bKpq9v4VQtpOmzWqRMqNGKdcclR1W+qgvRQpA2vCxG79/KcCkgOCvS8LAQDRzIU
         XcG3ghbpTH8p8Tyx5msDq48vYFJAAT5A56epQ=
Received: by 10.204.97.202 with HTTP; Mon, 12 Apr 2010 07:09:42 -0700 (PDT)
In-Reply-To: <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com>
Received: by 10.204.126.130 with SMTP id c2mr4851701bks.155.1271081382478; 
	Mon, 12 Apr 2010 07:09:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144729>

On Sun, Apr 11, 2010 at 10:06 AM, Eugene Sajine <euguess@gmail.com> wro=
te:
> I got your point about the HEAD which is by default get's added to th=
e
> end of the command, so it becomes
>
> git rebase --onto master topic HEAD
>
> I will think about it it more.
>
> I'm pretty sure that i was surprised by the fact that i've got
> different behavior in interactive and non-interactive variants, but i
> will recheck.
>
> I forgot to mention it was in windows version of git.
> I will try to provide the printout of my actions tomorrow when i will
> get to this machine.
>
> Thanks a lot,
> Eugene


Here is the printout of my actions with some comments:

esajine@ESAJINEWWW /c/git_repos
$ mkdir test2; cd test2; git init; echo "initial" > 1.txt; git add .;
git commit -m "initial commit"; git checkout -b next; echo "commit
from next" > 2.txt; git add .; git commit -m "commit from next"; git
checkout -b topic; echo "commit from topic" > 3.txt; git add .; git
commit -m "commit from topic"
Initialized empty Git repository in c:/git_repos/test2/.git/
warning: LF will be replaced by CRLF in 1.txt
[master (root-commit) 89c5353] initial commit
warning: LF will be replaced by CRLF in 1.txt
1 files changed, 1 insertions(+), 0 deletions(-)
create mode 100644 1.txt
Switched to a new branch 'next'
warning: LF will be replaced by CRLF in 1.txt
warning: LF will be replaced by CRLF in 2.txt
[next cec1eeb] commit from next
warning: LF will be replaced by CRLF in 2.txt
1 files changed, 1 insertions(+), 0 deletions(-)
create mode 100644 2.txt
Switched to a new branch 'topic'
warning: LF will be replaced by CRLF in 1.txt
warning: LF will be replaced by CRLF in 2.txt
warning: LF will be replaced by CRLF in 3.txt
[topic 9975772] commit from topic
warning: LF will be replaced by CRLF in 3.txt
1 files changed, 1 insertions(+), 0 deletions(-)
create mode 100644 3.txt

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ pwd
/c/git_repos/test2

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git status
# On branch topic
nothing to commit (working directory clean)

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git log
commit 9975772c641c438a0a77932c18c159e9551706ce
Author: Eugene Sajine <esajine@foo.com>
Date: =C2=A0 Fri Apr 9 13:04:24 2010 -0400

=C2=A0 =C2=A0commit from topic

commit cec1eebc8db042b1b8a1002b07767eac56884126
Author: Eugene Sajine <esajine@foo.com>
Date: =C2=A0 Fri Apr 9 13:04:24 2010 -0400

=C2=A0 =C2=A0commit from next

commit 89c5353c9b0cfc476b323db11565ea210341469a
Author: Eugene Sajine <esajine@foo.com>
Date: =C2=A0 Fri Apr 9 13:04:24 2010 -0400

=C2=A0 =C2=A0initial commit

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase master
Current branch topic is up to date.
<=3D=3D=3D=3D=3D=3D=3D Really? Topic is actually based on next =E2=80=93=
 what does this "up
to date" mean??

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase --onto master topic
=46irst, rewinding head to replay your work on top of it...
fatal: Not a range.
Nothing to do.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <=3D=3D=3D=3D=3D=
=3D=3D=3D topic..HEAD is not a range, agreed

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase --onto master
fatal: Needed a single revision
invalid upstream
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <=3D=3D=3D=3D=3D=3D=3D=
=3D=3D fine

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase --onto master next..topic
fatal: Needed a single revision
invalid upstream next..topic
=C2=A0 =C2=A0 <=3D=3D=3D=3D=3D=3D=3D=3D strange that this notation is n=
ot supported, considering
error above about the range

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase -i --onto master topic
Successfully rebased and updated refs/heads/topic. <=3D=3D=3D BUG =E2=80=
=93 here it
printed me =E2=80=9Cnoop=E2=80=9D in file to edit, when I exited it sho=
uld do nothing,
but it still did something and I double checked it.

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase --onto master topic
Current branch topic is up to date.

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git log
commit 89c5353c9b0cfc476b323db11565ea210341469a
Author: Eugene Sajine <esajine@foo.com>
Date: =C2=A0 Fri Apr 9 13:04:24 2010 -0400

=C2=A0 =C2=A0initial commit
 =C2=A0 =C2=A0 =C2=A0 =C2=A0<=3D=3D=3D=3D=3D=3D topic now points to mas=
ter, last commit from topic is
lost

esajine@ESAJINEWWW /c/git_repos
$ git version
git version 1.6.4.msysgit.0

Thanks,
Eugene
