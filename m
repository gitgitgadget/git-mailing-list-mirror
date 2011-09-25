From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Sun, 25 Sep 2011 13:58:18 -0700 (PDT)
Message-ID: <m3oby8pcfz.fsf@localhost.localdomain>
References: <4E7C9AAD.7060209@gmail.com>
	<m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com>
	<14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
	<op.v2byz2p80aolir@keputer.lokaal>
	<1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
	<201109242259.p8OMxqIM026259@no.baka.org>
	<1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net>
	<m31uv4rc47.fsf@localhost.localdomain>
	<1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 22:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7vmS-0007fC-KQ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 22:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab1IYU6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 16:58:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60950 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab1IYU6V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 16:58:21 -0400
Received: by fxe4 with SMTP id 4so5434874fxe.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=W72Cp+OmJHqKqSGwEZIDkkjGNcpVdcKOWPKFt9Jj84o=;
        b=ekQ/Cu0P5vedsJ5B6Fx6S8VY7ATZbyxohneDwSgPxfohHHyT6my6hMYhX86CvVEq2o
         6GcXuqz8kdkdxOB/AX+SQWPwC7yBGy/VzpxyiE8W+Q5DnpjVM5kJYeDqfJTsYQk0MTib
         1kLeeQk2sjfVHQ7dZnoKHaPFcKGkEdSTKgg7A=
Received: by 10.223.98.146 with SMTP id q18mr6939058fan.57.1316984300453;
        Sun, 25 Sep 2011 13:58:20 -0700 (PDT)
Received: from localhost.localdomain (abvf108.neoplus.adsl.tpnet.pl. [83.8.203.108])
        by mx.google.com with ESMTPS id e17sm17898307fae.17.2011.09.25.13.58.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 13:58:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8PKvrWc027020;
	Sun, 25 Sep 2011 22:58:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8PKvbSD027016;
	Sun, 25 Sep 2011 22:57:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182083>

tactical <a5158017@nepwk.com> writes:
> Jakub Narebski wrote:
>=20
> > With merging into branch with uncomitted changes your fairly well
> > understood 3-way merge (sometimes virtual 3-way merge in the case o=
f
> > multiple common ancestors) would turn into 4-way merge.
>=20
> I don't see why it would be a four-way merge rather than a three-way =
merge.

You have four version: "base" (ancestor version), "theirs"
(branch/clone being merged), "ours" (comitted changes on current
branch) and "new" (uncomitted changes on current branch).

Unless Mercurial does 3-way merge of "new", "theirs" and "base"...
with transaction based atomicity (saving "new" before attempting
merge) they can do that.

With Git you have additional complication: the index state.

> > Even if you
> > can automate it somehow (I do wonder how Mercurial manages that),
> > there could be problem resolving conflicts, unless you happen to to=
uch
> > different parts of file.
>=20
> This behaviour is by design in Mercurial.  It's simple, and it works.=
  I've
> never had a problem with resolving conflicts here, and I don't see wh=
y I
> ever would.

It if really is 3-way merge, you wouldn't.  If it isn't (e.g. it is
3-way merge + applying patch, like merge + stash apply in git), then
there are [nasty] corner cases.
=20
Anyway I hope that Mercurial does test this feature extensively.

[...]
> > What you use uncomitted changes for, I would use is a separate bran=
ch,
> > and keep it rebasing (something like using 'mq' in Mercurial).
>=20
> Yes, but, as I mentioned, rebasing is less flexible.  A rebase here i=
s
> effectively a merge and a commit in one step, whereas my approach sep=
arates
> the merge and the commit.

Errr... what?  You first commit your changes, then keep it rebasing to
keep them up to date on top of fresh version.
=20
> > > Another example of this is the lack of support for anonymous bran=
ching as
> > > part of a normal workflow in Git.  Anonymous branching is very po=
werful and
> > > very simple.  I use it all the time in Mercurial.
> >=20
> > What do you use anonymous branching for?
>=20
> Anonymous branching is great for minor divergence that isn't really
> significant enough to deserve a name.  It's also great for branches t=
hat
> *are* significant enough to deserve a name, but where you want to def=
er
> naming the branch right up until you merge it into another branch.  A=
t that
> point you can 'name' the branch in the commit message.

I think you can use detached HEAD for that, at least when working on
one issue at a time (you have to name branch when switching to some
other work).

> (Of course, you
> could also create a Mercurial bookmark at that point, and then you'd
> essentially have a "Git branch".)

Except for the fact that AFAIK Mercurial bookmarks have single global
namespace for branch (bookmark) names, while Git uses more flexible
but less newbie-user-friendly branch to remote-tracking branch name
mapping via "refspec".
=20
> > Note that with Git by default pushing "matching" branches, you can
> > create private local-only branches.  The have to have _some_ name
> > (even if it is 'foo/temp'), but I think that it makes them perhaps
> > more work to create, but easier to use (to switch branches)... and =
for
> > single anonymous branch you can always use "detached HEAD".
>=20
> From what I read, detached heads are subject to garbage collection.
=20
No, HEAD is protected against garbage collecting.  To be sure you
should name a branch when switching branches, though reflog would
protect you for 30 days (by default) even if you don't do that.

--=20
Jakub Nar=EAbski
