From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: Reconstructing git-svn metadata after a git clone
Date: Sat, 8 May 2010 19:20:59 +0100
Message-ID: <t2l86ecb3c71005081120lf87fc99bh1566c82a4d21904e@mail.gmail.com>
References: <AANLkTikR5EpZhwFXmRfmE9jSNtiuFoGwTgGbpcwUBxnq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 20:21:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAoec-0003ei-V7
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 20:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab0EHSVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 14:21:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47527 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0EHSVU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 14:21:20 -0400
Received: by pwi5 with SMTP id 5so1050395pwi.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=5IM9Li1YV6j1XllgcsbcTolds3JwhWO/y7KA5aEfsgo=;
        b=ujM8rQVQ3/wByxhw6oYVDqJn6RXqOHtADCPBdfL5AnDIc+VtTI70mVWIoN7AUt5sLC
         NJ7aa2rDdji8ghlW+ugtVf78kds0yh5LFR/t9WAsUeHDtRg6EwTDyZlvCPGpFC6ypvoJ
         I7BKV8iExGQ1+p4dlF2m8ToebOAXK3ug4sa74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=SWn5CdJcswzPZDcom1KqMcuHArOnLHTCCiadpzu/NQ9pf+nz1ZR4GW8WF2LwjZLE1Y
         cbtSstzNVDbIkxIlZ5l2nTlqr+rXiMCy3wZV2dooKqUaiySfAxsHMQE36mf6bflytKnJ
         ami9ZRj7MYm56viqGJ+3+Z3PLUpNaDYm26BDg=
Received: by 10.143.169.5 with SMTP id w5mr1175250wfo.222.1273342879199; Sat, 
	08 May 2010 11:21:19 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Sat, 8 May 2010 11:20:59 -0700 (PDT)
In-Reply-To: <AANLkTikR5EpZhwFXmRfmE9jSNtiuFoGwTgGbpcwUBxnq@mail.gmail.com>
X-Google-Sender-Auth: 002779fda9fe4c46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146671>

On 8 May 2010 18:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> So:
>
> =C2=A0* Am I doing something wrong? If so I can't see what it is.
>

No

> =C2=A0* Is there something that works for the general case, i.e. you =
only
> =C2=A0 have to know the original `git svn init` options. If there is =
I'd
> =C2=A0 like to document that & submit a patch.
>

In my repo I have a branch with no anestors which has a config file,
setup.sh & fetch.sh

I instruct to clone repo, checkout "utils" branch, run setup.sh (it
overrides .git/config with config file committed to utils branch and
after it copied config it runs git svn init URL), fetch.sh just runs
git svn fetch =3D)

I have to do this because I have two svn remotes and both are not
standard layout. The only way for me to represet "same init options"
is by editing .git/config cause it's impossible for me to supply
git-init options on the command line =3D)

> =C2=A0* Depending on the above; can git-svn itself be friendlier here=
?
> =C2=A0 Maybe by having a `git svn bootstrap` command. E.g.:
>

It would be nice to have the git init info propogate with the git
clone. But this won't work. You are cloning *all* branches and
providing a git mirror, where as I want to to git init just my svn
branch or a subset of them. To achieve that I will clone just the
branches I need modify my .git/config and get the result I want.

So imho git-svn is ok here.

> =C2=A0git clone git://$some_url
> =C2=A0# Does all the work of setting up metadata/refs
> =C2=A0git svn bootstrap --stdlayout $remote_svn_url


If you are committing to svn regularly you are better of with bzr-svn
in my opinion. Because launchpad can run automatic imports for you
(webkit is already running btw) and the whole bootstrapping thing is
done the way you are expecting it.

#create repository to store revisions efficiently
$ bzr init-repo .

#on the first ever run it will rebuild meta-data
#subsequent runs just fetch missing revisions
$ bzr branch svn://path.to.any.branch

And you can commit from that =3D) and bzr can operate on your svn
checkouts. And every single clone done by bzr-svn is identical (unlike
git where everyone has to follow the same git-svn mirror to get same
revision-ids).

You have two options when commiting with bzr-svn. Regular bzr ci will
store bzr merge information in revision properties on svn server or
you can use bzr dpush which is like git svn dcommit.

IMHO bzr-svn is the best when you need to commit back to svn and
painlessly commit parts of the feature branch and merge other bits
later.
