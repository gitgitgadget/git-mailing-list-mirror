From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 10:35:06 -0700 (PDT)
Message-ID: <m3y6cwkew7.fsf@localhost.localdomain>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tong Sun <suntong@cpan.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odo3g-0006t6-OF
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab0G0RfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 13:35:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46771 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab0G0RfI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 13:35:08 -0400
Received: by wwj40 with SMTP id 40so1483693wwj.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=zV2zywDe3xmQ1vYTZXbhVcbsP0J1jihpYr28g4K2tOg=;
        b=L6e+vXvTPO/eY8ymw/p3x90P/E0kDJr/+qgj3YqykEUM8BN8t/gFgpgNdN3WrrRSo8
         KQy+N6swDnk5a6Os7jz9SJLkvQLSIzCr9Da8S5HPBQNmAVV1Qi2jChGci2gIjCMzNGOD
         zKmUjddyGDzCmMclCPVNFUHxkkBms7fSl2hj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Jgrkz8ttUAPTWhmrcaB6iMienkUrdVpWAozyRMPQk0pJKhEDB6lkpytSURj7Qn22kK
         EpuFvxc7GFckYEAL6sJoid27gQshGCmA4jc67xehjJrKCBg48Az4kE4GV7GIT1Rt3lgI
         leEPVeEPVpdJgiiPGFliXE0ZtiJrCyjCVKFNQ=
Received: by 10.227.40.220 with SMTP id l28mr9239408wbe.84.1280252107150;
        Tue, 27 Jul 2010 10:35:07 -0700 (PDT)
Received: from localhost.localdomain (abvi50.neoplus.adsl.tpnet.pl [83.8.206.50])
        by mx.google.com with ESMTPS id w29sm2867268weq.42.2010.07.27.10.35.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 10:35:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6RHYXlL000579;
	Tue, 27 Jul 2010 19:34:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6RHYG8T000572;
	Tue, 27 Jul 2010 19:34:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151961>

Tong Sun <suntong@cpan.org> writes:

> Just trying to put all jigsaw puzzle together here. Please correct me
> if I'm wrong.
>=20
> First of all, philosophy for version control with git:
>=20
> . While developing, small/independent commits are good thing, so that
>   it's easy to decouple different changes.
>=20
> . But when integrating something in a main branch, commits should con=
tain all
>   logical/related changes.

I think that in final results, i.e. in patches that you send, or
commits that you send pull request for, you should have commits that
do one thing, and do it completely and without breaking.  Nevertheless
having small commits that you publish / send to maintainer is a good
thing; it is always easy to review a few small patches, than one
mage-patch.

>=20
> Steps (using grml-debootstrap as an example):
>=20
> - do initial git pull into grml-debootstrap
>=20
> =A0 git pull git://git.grml.org/grml-debootstrap master

Why not git-clone (possibly shallow, if you are working on one-shot
patch or patch series)?

If you plan to continue working on this repository, and it is not
one-shot patch or patch series, it would be better (easier in the
future) to use "git remote add".

>=20
> - Go into grml-debootstrap and start a new branch
>=20
> =A0 git checkout -b t/my-working-branch
>=20
> - work on the code, commit, hack, commit, hack, commit -- commit ofte=
n
>   & commit small

You can always use 'git commit' + 'git commit --amend' if you want to
fix previous commit, instead of creating new commit.

>=20
> - when AOK and need to integrate patches into main branch, squash all
>   patches into one
>=20
> =A0 git rebase -i origin/master

Reorder, edit, squash patches.

>=20
> - send in patches via email (to grml-devel@ml.grml.org)
>=20
> =A0 git format-patch origin

With larger patch series, it could possibly be of the form:

    mkdir patches/
    git format-patch -o patches/ --cover-letter
    [edit cover letter, filling in template]
    [edit patches if necessary, adding comments between "---" and diffs=
tat]

> =A0 git send-email --to grml-devel@ml.grml.org ...
>=20
> Please correct me if anything above is wrong.

You can also use some patch management interface, like StGit, Guilt or
TopGit.  I personally use StGit, so the above description is modified
in that there is 'stg init', there is 'stg new some-patch' and possibly
multiple 'stg refresh' when working on commit, there might be 'stg goto=
's
and 'stg push'es and 'stg pop's to go back and forth between patches,
and fix them.

It's a matter of taste whether to use some kind of patch management /
/ mail queue interface, or to use interactive rebase instead.

> Now, question, having done above, if I start to work some logically
> unrelated patches, what steps should I take? (I don't want 'git
> rebase' to pick up patches that I've already sent in).

If you want to start to work on some logically unrelated patches, you
should start a new branch for that.

Alternatively, when some or all patches are accepted upstream, you
download new changes using 'git pull' or 'git fetch' or 'git remote
update', and then rebase your branch on top of branch it is based on,
or to be more exact on top of branch your patches are now in.  'git
rebase' (or 'git pull --rebase' or even 'git pull', if configured
appropriately) would automatically skip patches that got applied
(sometimes you need to tell git to 'git rebase --skip' if it didn't
detect this).

It would be 'stg rebase <base branch>' (usually <base branch> is
'origin'=3D'origin/master' or 'master'), and 'stg clean -a' to remove
empty applied patches.


P.S. Doesn't GRML have web page / wiki page for developers?
     http://grml.org/git/

--=20
Jakub Narebski
Poland
ShadeHawk on #git
