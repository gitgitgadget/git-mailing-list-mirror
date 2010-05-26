From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Wed, 26 May 2010 11:52:03 -0300
Message-ID: <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 
	<1274488119-6989-4-git-send-email-erick.mattos@gmail.com> 
	<7vzkznqmir.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 26 16:52:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHHyE-00010y-RQ
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 16:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab0EZOw3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 10:52:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53507 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab0EZOw2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 10:52:28 -0400
Received: by gyg13 with SMTP id 13so2944723gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bQ+sN+f9X50dPl5iSdh1kJhJP0w54xhBaWJrvxbEeXw=;
        b=UqW8/DePyACHFXlx18YDisi0Esn9b/4wcmj1y5BmE0RQe0NBli3jj/zkvDsxN3l7nb
         Agc/FjHazcDnqWvyE3EYk4GdVWH+7C8c58Jih7l1RwFsBAxzRBlNQcsMdeuqP7iPWJ93
         o6nsT+gVyogg76c57GzTiE+MqHCuZ+MzJ07Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l3nO0pnD7G00KcEeOLvnB3/cq2NZsSgAtJfDoy0Uny9Gb+9gqOIQLSROL/DBR3u8Wc
         cU8s3X/LS9HCUKQM3vNYhXqYeyP+kUSOxe0XVsHy0ztc5k7mV541nawixwBaRbhzE8Bx
         pal53DnccS1hPtCrr9CfAN8EvdWpnGy5onR50=
Received: by 10.151.89.35 with SMTP id r35mr120167ybl.52.1274885543172; Wed, 
	26 May 2010 07:52:23 -0700 (PDT)
Received: by 10.151.39.17 with HTTP; Wed, 26 May 2010 07:52:03 -0700 (PDT)
In-Reply-To: <7vzkznqmir.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147803>

Hi,

2010/5/26 Junio C Hamano <gitster@pobox.com>
>
> Erick Mattos <erick.mattos@gmail.com> writes:
> > @@ -684,8 +709,8 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
> > =C2=A0 =C2=A0 =C2=A0 if (opts.new_orphan_branch) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts.new_branc=
h)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("--orphan and -b are mutually exclusive");
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts.track > 0 || o=
pts.new_branch_log)
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("--orphan cannot be used with -t or -l");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts.track > 0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("--orphan should not be used with -t");
>
> Why s/cannot/should not/? =C2=A0Just being curious.

I have typed that text, not changed the original so this is not a fix
to your text.=C2=A0 Anyway for me "should not" is more polite, like "yo=
u
should not yell" meaning you really can not do it.=C2=A0 Or "you should=
 not
disrespect the captain".

But that is not a fix.

> > +test_expect_success 'giving up --orphan not committed when -l and =
core.logAllRefUpdates =3D false deletes reflog' '
> > + =C2=A0 =C2=A0 git checkout master &&
> > + =C2=A0 =C2=A0 git checkout -l --orphan eta &&
> > + =C2=A0 =C2=A0 test -f .git/logs/refs/heads/eta &&
> > + =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show eta &&
> > + =C2=A0 =C2=A0 git checkout master &&
> > + =C2=A0 =C2=A0 ! test -f .git/logs/refs/heads/eta &&
> > + =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show eta
> > +'
>
> I don't quite understand the title of this test, nor am I convinced t=
hat
> testing for .git/logs/refs/heads/eta is necessarily a good thing to d=
o
> here. =C2=A0"eta" branch is first prepared in an unborn state with th=
e working
> tree and the index prepared to commit what is in 'master', and the fi=
rst
> "git reflog" would fail because there is no eta branch at that point =
yet.
> Moving to 'master' from that state would still leave "eta" branch unb=
orn
> and we will not see "git reflog" for that branch (we will fail "git l=
og
> eta" too for that matter). =C2=A0Perhaps two "test -f .git/logs/refs/=
heads/eta"
> shouldn't be there? =C2=A0It feels that it is testing a bit too low l=
evel an
> implementation detail.

So I need to explain the solution:

When config core.logAllRefUpdates is set to false what really happens
is that the reflog is not created and any reflog change is saved only
when you have an existent reflog.

What I did was to make a "touch reflog".=C2=A0 Creating it, when the ne=
w
branch get eventually saved then the reflog would be written normally.
 But in case somebody give up this new branch before the first save,
moving back to a regular branch would leave a ghost reflog.

I have coded the cleaning commands for that and the test is just a
check of this behavior.

The first "test -f .git/logs/refs/heads/eta" tests if reflog was
created and the second if it was deleted.=C2=A0 No big deal.

Regards
