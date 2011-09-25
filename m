From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Sun, 25 Sep 2011 06:22:29 -0700 (PDT)
Message-ID: <m31uv4rc47.fsf@localhost.localdomain>
References: <4E7C9AAD.7060209@gmail.com>
	<m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com>
	<14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
	<op.v2byz2p80aolir@keputer.lokaal>
	<1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
	<201109242259.p8OMxqIM026259@no.baka.org>
	<1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 15:22:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ofF-0002CW-Mq
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 15:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab1IYNWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 09:22:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37430 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab1IYNWc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 09:22:32 -0400
Received: by eya28 with SMTP id 28so3041016eya.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 06:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hb1ICP+tRshAChT+7iAmjlb9uBJ3EUz1G00vRdtoa+w=;
        b=NtBytEQ5G2tcOmO4ZrLCH/8l8Fwt8ZURRK3oW92n60D761CA/77d0FIGtRBKnZ278C
         wsgNeIvLPq4sAZMscseDxSDd9B5udV5mv5UHk0wrnUcdOCpn03fxwCgu/vIAtZAbk2GM
         KYeLxgB4nNhuvMVs26JXAf7Hr+tQA6agO+euE=
Received: by 10.213.7.136 with SMTP id d8mr688897ebd.119.1316956950698;
        Sun, 25 Sep 2011 06:22:30 -0700 (PDT)
Received: from localhost.localdomain (abvl230.neoplus.adsl.tpnet.pl. [83.8.209.230])
        by mx.google.com with ESMTPS id f56sm50320046eea.0.2011.09.25.06.22.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 06:22:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8PDM1ed021721;
	Sun, 25 Sep 2011 15:22:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8PDLjUV021717;
	Sun, 25 Sep 2011 15:21:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182068>

tactical <a5158017@nepwk.com> writes:
> Seth Robertson wrote:
>=20
> > As I explained on IRC, you can use the following workflow to create=
 a
> > three way merge.
> >=20
> > git stash
> > git fetch
> > git merge @{u} stash
> > git mergetool
> > git stash drop
> >=20
> > You can then do whatever other work you want.  You can repeat this
> > workflow as often as you want.  When you are done, then you can
> > commit:
> >=20
> > git commit -a -m "My important work"
> >=20
> > This is of course easily scriptable so it becomes one command to yo=
u.
> > And since you mentioned it, if the merge went poorly and you wanted=
 to
> > start over (only before you dropped the stash of course), you can:
> >=20
> > git reset --hard HEAD
> > git merge @{u} stash
>=20
> Thanks.  It's a shame, however, that Git makes the user jump through =
hoops
> to achieve such a simple thing.

A short time after "git stash" was added to Git there was proposal to
automatically use git stash to allow merging with "dirty tree",
i.e. with uncomitted changes.  This idea was abandoned, if I remember
it correctly because a.) there were too many corner-cases b.) it
wasn't necessary in most cases.
=20
With merging into branch with uncomitted changes your fairly well
understood 3-way merge (sometimes virtual 3-way merge in the case of
multiple common ancestors) would turn into 4-way merge.  Even if you
can automate it somehow (I do wonder how Mercurial manages that),
there could be problem resolving conflicts, unless you happen to touch
different parts of file.

> > Of course, I would recommend you consider some of the more gitish
> > workflows.
>=20
> And that, I feel, is a problem with Git.  In some cases, you can't do
> things how you want -- you have to do things how Git wants.

Please take into account the fact that when you were creating your
workflow to suit your situation you were "forced" to fit it to
Mercurial abilities and best practices.  No wonder that it does not
fit Git-ish workflows.

What you use uncomitted changes for, I would use is a separate branch,
and keep it rebasing (something like using 'mq' in Mercurial).
=20
> Another example of this is the lack of support for anonymous branchin=
g as
> part of a normal workflow in Git.  Anonymous branching is very powerf=
ul and
> very simple.  I use it all the time in Mercurial.

What do you use anonymous branching for?

Note that with Git by default pushing "matching" branches, you can
create private local-only branches.  The have to have _some_ name
(even if it is 'foo/temp'), but I think that it makes them perhaps
more work to create, but easier to use (to switch branches)... and for
single anonymous branch you can always use "detached HEAD".
=20
--=20
Jakub Nar=EAbski
