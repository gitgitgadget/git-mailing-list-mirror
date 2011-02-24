From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Thu, 24 Feb 2011 01:32:47 +0100
Message-ID: <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:32:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsP8Z-00036S-60
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629Ab1BXAcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 19:32:50 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59579 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1BXAct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 19:32:49 -0500
Received: by bwz15 with SMTP id 15so602971bwz.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 16:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LDHkX7Kv19tqiQFyYx4EP80ep906HXzAQp5c+Q6xTuQ=;
        b=eaZwj+jdncheA3vvPeSrB3YYl/ArenP77PgA4PuEiJ1tUp+kkde2bBTX+NK7049RHA
         +uU3PmZXhzYm4RKWwv2KOkXX2jhY8C+5Tz4ns7cCi9CbIx5gZdjL5bObG20/A0oqXcAF
         3XIXbsgzmyhz8akjLN1OLoaulZx7w9A4RljCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KvgmFgqHMztTcT8A8mDGmpzZHXpBm/D4/eOVMDq7+lcRg+/FzHe3DIGg8KVByfSDfo
         MLSKVMSaub4DC3WDkEknWIfdbMgQYD1V2JAWqJscl/Wj58JtWlY++IFO/vH1eSipKr4x
         XUhJNgeNaAX6jM7ERwAVLlcj8PRBEw8AheBAg=
Received: by 10.204.7.213 with SMTP id e21mr145534bke.47.1298507567539; Wed,
 23 Feb 2011 16:32:47 -0800 (PST)
Received: by 10.204.71.7 with HTTP; Wed, 23 Feb 2011 16:32:47 -0800 (PST)
In-Reply-To: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167756>

On Thu, Feb 24, 2011 at 00:26, Junio C Hamano <gitster@pobox.com> wrote=
:

> * ab/i18n (2011-02-22) 73 commits
> [...]
>
> Re^4-roll, coordinated between =C3=86var and Jonathan.
>
> I'd like to fast-track the basics (especially the bottom 3 patches), =
and
> am even tempted to rebase other patches on 'pu' that are not yet in '=
next'
> on top of them, to make the transition easier, so please lend extra s=
ets
> of eyeballs on an earlier ones to make sure they are sane (I thought =
they
> were, but I am far from perfect).

Great that we're moving this forward. After this has made it to next
(or master) I'm going to fix this up a bit and submit the shellscript
i18n-ize patches:

    https://github.com/avar/git/compare/5bd8b10...8fd2407

Open issues:

   * Write documentation for git-sh-i18n.sh and git-sh-i18n--envsubst
     like we have for git-sh-setup (already in WIP form).

   * git-sh-i18n--envsubst is still too fat:

        $ ldd -r git-sh-i18n--envsubst
            linux-vdso.so.1 =3D>  (0x00007fffc60fd000)
            libz.so.1 =3D> /usr/lib/libz.so.1 (0x00007f25cff9e000)
            libcrypto.so.0.9.8 =3D> /usr/lib/libcrypto.so.0.9.8
(0x00007f25cfbfd000)
            libpthread.so.0 =3D> /lib/libpthread.so.0 (0x00007f25cf9e00=
00)
            libc.so.6 =3D> /lib/libc.so.6 (0x00007f25cf67f000)
            libdl.so.2 =3D> /lib/libdl.so.2 (0x00007f25cf47b000)
            /lib64/ld-linux-x86-64.so.2 (0x00007f25d01c0000)

     It only needs to link to libc, but I didn't find out when I last
     checked how to convince the Makefile to only link against
     that. Help welcome :)

   * Deal with the changes in 92c62a3f4f93432c0c82e3031a9e64e03ba290f7:

        $ git --no-pager  grep -A1 abomination *.sh
        git-pull.sh:            # XXX: This is an abomination
        git-pull.sh-            require_clean_work_tree "pull with
rebase" "Please commit or stash them."

     The changes Ramkumar Ramachandra made in 92c62a3f4f, while good,
     are hard to square with i18n.

     I think I'll just leave those bits untranslated for now and deal
     with them later, since I'm trying to keep this minimal.

And then there's the issue that unlike the C patches these will not be
a no-op that'll be optimized away by the compiler. We'll be calling an
external program for displaying messages. While this is a trivial cost
on Unix (especially in the context we're using it, i.e. not in tight
loops) it's more expensive on Windows.

I don't see any way to deal with that short of implementing some
pre-processor, but I think the cost is worth it, but others might
disagree of course.

Anyway, I can submit these patches (around 53) real soon, or wait
until the current series settles. It's the same to me, which would you
prefer?

> * gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
> =C2=A0- Look for password in both CVS and CVSNT password files.

Given that this solves someone's problem I don't think there's any
harm in letting it through. The code and overall behavior is somewhat
nasty, but then so is the rest of git-cvs*.perl, so meh.

> * jc/checkout-orphan-warning (2011-02-18) 1 commit
> =C2=A0- commit: give final warning when reattaching HEAD to leave com=
mits behind

I like this sort of thing.

Generally speaking I don't mind Git being more friendly and verbose
about this sort of thing. I.e. for common pitfalls print a few lines
of help because it'll help more than it hurts. I think we've been to
conservative about that in the past.

There's a grammar error here though if I'm not mistaken:

    w git ((f11f53c...) $%) $ ./git co pu
    Warning: you are leaving 1 commit behind that are not connected to
    any of your branches:

=46or the singular this should be "1 commit behind which is not
corrected to any of your branches".

We're also being somewhat inaccurate by omission here, since we won't
give this warning if the commit is reachable from any named referenc,
i.e. if the user just tagged it. So perhaps this should say something
about "not reachable from any named reference" or something, but then
again that would confuse the sort of users that need this the most.

> * jh/maint-do-not-track-non-branches (2011-02-17) 1 commit
> =C2=A0- branch/checkout --track: Ensure that upstream branch is indee=
d a branch

I like it.

> * jk/merge-rename-ux (2011-02-20) 6 commits
> =C2=A0- pull: propagate --progress to merge
> =C2=A0- merge: enable progress reporting for rename detection
> =C2=A0- add inexact rename detection progress infrastructure
> =C2=A0- commit: stop setting rename limit
> =C2=A0- bump rename limit defaults (again)
> =C2=A0- merge: improve inexact rename limit warning
>
> The above three all seemed sensible improvements.

Agreed.

> * jn/test-terminal-punt-on-osx-breakage (2011-02-17) 1 commit
> =C2=A0(merged to 'next' on 2011-02-23 at d754139)
> =C2=A0+ tests: skip terminal output tests on OS X

Looks good, and maybe I'll debug the Perl one of these days.

> * jk/tag-contains (2010-07-05) 4 commits
> =C2=A0- Why is "git tag --contains" so slow?
> =C2=A0- default core.clockskew variable to one day
> =C2=A0- limit "contains" traversals based on commit timestamp
> =C2=A0- tag: speed up --contains calculation
>
> The idea of the bottom one is probably Ok, except that the use of obj=
ect
> flags needs to be rethought, or at least the helper needs to be moved=
 to
> builtin/tag.c to make it clear that it should not be used outside the
> current usage context.

I really like this as noted elsewhere. But it seems that it would go
down better if the helper was submitted later on.

> * jh/push-default-upstream-configname (2011-02-16) 1 commit
> =C2=A0(merged to 'next' on 2011-02-23 at b5c25fa)
> =C2=A0+ push.default: Rename 'tracking' to 'upstream'
>
> This is not "renaming" in the sense that breaks existing practice, bu=
t
> giving a new official name and deprecating the existing one.

I like the new name.

> * mo/perl-bidi-pipe-envfix (2011-02-15) 1 commit
> =C2=A0(merged to 'next' on 2011-02-15 at c36e816)
> =C2=A0+ perl: command_bidi_pipe() method should set-up git environmen=
s
>
> Looked reasonable.

Yeah, but fix up the typo in the subject. Should be "environments" :)
