From: Thore Husfeldt <thore.husfeldt@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Wed, 20 Oct 2010 11:53:52 +0200
Message-ID: <BED961D6-5C2A-4535-B706-BFB9727CE398@gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <vpq8w1v5gce.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 20 11:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8VMw-0002Ky-8G
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 11:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab0JTJx7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 05:53:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38581 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0JTJx5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 05:53:57 -0400
Received: by ewy20 with SMTP id 20so4411332ewy.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=cpK7Vlp/5qMCfaaUzAGdM1YH0y/D1l4fzVgdLHgGj7k=;
        b=fyBeOM/LZ46hcPK5Q2lei7MoyjKsl6OnV3/60i0w5P0SPG6F/7ry7dLEC6nkHfFtf5
         m4/kWJlDwOY6kyL7g/VVhXuIlMAUUIvngdvk1NmrMl8p25g5HtrKMYyTO+lCv+pbG0Wm
         MrJMwjJPhRt39WfI4wafecvZ/rRxrMG1wXP3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=wvkhJfGf5UVREnmOn0LsWQ67gAGixcPu7NU/u4MnbyHxBinA32Gke+2dIbpqzLaFnx
         /E4L60IelPjZweDxv9N/roLV/tcM5Hl/XjYxOtfXgFRvJ5xAqzPLZZiLwwk80Jz4mKg/
         Nv+uyQWWwK7fF0RetnG/L5bIwIQL8THrQ1a9c=
Received: by 10.213.98.78 with SMTP id p14mr6435889ebn.54.1287568436368;
        Wed, 20 Oct 2010 02:53:56 -0700 (PDT)
Received: from thoremba.cs.lth.se (thoremba.cs.lth.se [130.235.16.114])
        by mx.google.com with ESMTPS id x54sm15335943eeh.5.2010.10.20.02.53.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 02:53:54 -0700 (PDT)
In-Reply-To: <vpq8w1v5gce.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159404>

On 18 Oct 2010, at 23:41, Matthieu Moy wrote:

> We already came up with a better wording, namely "upstream", and used
> in in "git push --set-upstream". Probably a next step would be to
> deprecate any other occurence of --track meaning the same thing (git
> checkout --track seems to me to be a candidate, git branch has both
> --track and --set-upstream). One difficulty is to do that with
> backward compatibility in mind.

I=92ve tried to play around with this concept now, *in casu* by trying =
to edit the Pro Git source.

I=92m not sure we all agree on what is what, so let me try to clarify.

In the following, Alice has bobsstuff, bob/master, and (Bob=92s) master=
, which she got from

> alice% git checkout --track -b bobsstuff bob/master

(Or using `git branch`). Git tells her that

> Branch bobsstuff set up to track remote branch master from bob.

(By the way, I think =93remote branch=94 is useful and correct, here.)

Let me see if I can use the proposed terminology:

1. bob/master *tracks* master.
2. bob/master is a remote-tracking branch
3. master is a remote branch
4. bob/master has been marked as "upstream" from bobsstuff=20

Is master upstream from bobbstuff as well? The man page of `git branch`=
 seems to think so:

> Furthermore, it directs git pull without arguments to pull from the u=
pstream when the new branch is checked out.

So both bob/master and master are sometimes called "upstream", and both=
 bobsstuff and bob/master are sometimes called "tracking".

Let=91s try to look at the relevant Pro Git section, to get a feeling f=
or how this terminology work when you actually try to explain something=
 well:
>=20
> ### Tracking Branches ###
>=20
> Checking out a local branch from a remote branch automatically create=
s what is called a _tracking branch_. Tracking branches are local branc=
hes that have a direct relationship to a remote branch. If you=92re on =
a tracking branch and type git push, Git automatically knows which serv=
er and branch to push to. Also, running `git pull` while on one of thes=
e branches fetches all the remote references and then automatically mer=
ges in the corresponding remote branch.
>=20
> When you clone a repository, it generally automatically creates a `ma=
ster` branch that tracks `origin/master`. That=92s why `git push` and `=
git pull` work out of the box with no other arguments. However, you can=
 set up other tracking branches if you wish =97 ones that don=92t track=
 branches on `origin` and don=92t track the `master` branch. The simple=
 case is the example you just saw, running `git checkout -b [branch] [r=
emotename]/[branch]`. If you have Git version 1.6.2 or later, you can a=
lso use the `--track` shorthand:

This is a good section, and explains a lot. But, as with much of the Gi=
t documentation, the terminology is undisciplined. Take =93tracking bra=
nches=94. The section is about refs like bobbstuff, which is no longer =
called tracking, but =93a branch that has been configured to set up an =
upstream relation=94. Currently, if I understand the proposed terminolo=
gy, there is no word for what the Pro Git book calls =93tracking branch=
es.=94 (I=92d be happy to be wrong about this.)

Let me try

> ### Upstream branches ###
>=20
> A local branch can be set up in a direct relationship to a remote bra=
nch; we say the that the remote branch is _upstream_. In this configura=
tion, if you type `git push`, Git automatically knows which server and =
branch to push to. Also, running `git pull` on one of these branches fe=
tches all the remote references and then automatically merges in the co=
rresponding remote branch.
>=20
> When you clone a repository, Git automatically creates a `master` bra=
nch whose upstream branch is the remote-tracking branch `origin/master`=
=2E

This is not really good, because the immediately preceding section is a=
bout =93remote-tracking branches=94 (currently called =93remote branche=
s=94, by the way). And =93remote-tracking branches=94 and =93upstream b=
ranches=94 are the same =96 they both refer to bob/master, but from dif=
ferent perspectives. Now there are two sections about bob/master, yet t=
he conceptually interesting branches are bobsstuff (sometimes called th=
e =93tracking branch=94) and master (sometimes called the =93remote bra=
nch=94). bob/master is just an elegant implementation that facilitates =
the communication between these two branches. (This is not impossible t=
o fix with a good rewrite.)

I=92d be really happy to rewrite the documentation about this stuff (in=
cluding submitting a patch to Pro Git and other useful references), but=
 my enthusiasm is tempered by a nagging suspicion that the full termino=
logical effect of no longer having a word for the kind of branch that b=
obsstuff is has been fully realised. 