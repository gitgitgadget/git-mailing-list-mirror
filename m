From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFC: repository of handy git aliases?
Date: Tue, 16 Aug 2011 15:55:51 +0200
Message-ID: <4E4A76E7.2090100@drmicha.warpmail.net>
References: <CAH3AnrpSeWytri-bHEi_9qkAKG1fjL0pVuYFOrrmZumJ6dv_wg@mail.gmail.com> <CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com> <CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com> <CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 15:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtK7c-0006ap-Sb
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 15:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab1HPNz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 09:55:56 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:34387 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751996Ab1HPNzx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 09:55:53 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 87D032235A;
	Tue, 16 Aug 2011 09:55:53 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 16 Aug 2011 09:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=QKviQjT3lDYMiQxTHiRrUt
	JA6D0=; b=txRMCJjdNpxzN+9f8xlK1ohyijfP77rArZwVnOKONVK7IT47PWUozI
	Fc7JcFnC5dmxXrxQgiNCpNPd2zOYKXLonM5eNsAN3+fuqawgi5sDjdJmIPIK7AG+
	I8XZYuI0hWtLhM2pallrqxW8rRez0wcGRcaU8DTb/aeByCSavhjxY=
X-Sasl-enc: hZK6oKcNKxRtmsr5b5rGJe1kCdcG8iX5+BRvclIOnwu6 1313502953
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E4C8745F920;
	Tue, 16 Aug 2011 09:55:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179449>

Jon Seymour venit, vidit, dixit 08.08.2011 12:43:
> On Mon, Aug 8, 2011 at 8:22 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
>> On Mon, Aug 8, 2011 at 7:45 PM, Jakub Nar=C4=99bski <jnareb@gmail.co=
m> wrote:
>>> On 8/8/11, Jon Seymour <jon.seymour@gmail.com> wrote:
>=20
> I've also added this...
>=20
> Listing the tips of branches in pu that are not in master
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Suppose you have two aliases defined like so:
>=20
> [alias]
>         oneline =3D !/usr/bin/xargs -L1 git log --decorate --max-coun=
t=3D1 --oneline

How about

oneline =3D git log --no-walk --decorate --oneline

>         tips =3D "!_() { t=3D$(git rev-list --no-merges --max-count=3D=
1
> \"$@\"); if test -n \"$t\"; then echo $t; _ \"$@\" ^$t; fi; }; _"
>=20

That one is way over my head, but if

> Then:
>=20
> git tips origin/pu ^origin/next | git oneline

is your typical use case you may like

git branch --merged origin/pu --contains origin/next

(or with --no-merged, but put it first.)

> might show something like this:
>=20
> 9dcca58 filter-branch.sh: de-dent usage string
> 704c335 On Cygwin support both UNIX and DOS style path-names
> 1c460f9 t3030: fix accidental success in symlink rename
> 9e81372 test-path-utils: Add subcommand "prefix_path"
> ad733bd revert: Propagate errors upwards from do_pick_commit
> 76cf946 fixup! xdiff/xhistogram: rework handling of recursed results
> df6a9c7 fixup! describe: Refresh the index when run with --dirty
> c9f57a0 squash! ls-files: fix pathspec display on error
> a1288bc add--interactive: add option to autosplit hunks
> 365b78a t5800: point out that deleting branches does not work
> c997182 limit "contains" traversals based on commit generation
> 914b6fb doc/fast-import: document feature import-marks-if-exists
> b792c06 branch -v: honor core.abbrev
> b166408 mergetool: Don't assume paths are unmerged
> b29d76f merge: mark the final "Merge made by..." message for l10n
> 942cf39 receive-pack: Allow server to refuse pushes with too many obj=
ects
>=20
> which is a list of the tips of branches that are in pu, but not in ne=
xt.

That's not quite the standard --decorate, is it? ;)

Michael
