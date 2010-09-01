From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Wed, 1 Sep 2010 20:22:49 +0000
Message-ID: <AANLkTim6=OTwzRd2H0GzNO3T0JuJxox8-Hfs_iKV=Xxy@mail.gmail.com>
References: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Knut Franke <k.franke@science-computing.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 22:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqtpk-0002p7-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab0IAUWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:22:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48492 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab0IAUWv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 16:22:51 -0400
Received: by fxm13 with SMTP id 13so5061241fxm.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HQ/jBROiaMWqrvf+QBuzoPJneVmCUojDiqe9v6mt5Fw=;
        b=O9g4khhT7Yy8KGV4b/CGEt9LaWL7vEr8cKWqP6vFR2Rz15xO9Qk6UEdf3uB8+pzdMZ
         9g1eZ4q3H+uoXYu0QSuAM2icGRGrXsxTCWlzFTuENeWbhB7CCOZMWf6fsgXv+Ik95NQO
         karHEF9cW4UXw4AXk4kgo/WAhJu8alNkJUYck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HFa3ZnnPwsReE4QfIMtMaIcba/1xdZCl+TYHQq+R8+yCZkBedcgJVTcXcIftrEhC3p
         hPUqkh5yI29LtZ0+62cD2OO35C7HmxF+TiHYGW0hg0punP31qtulco2RhP1x29T+ROZk
         vUxzAQh9LjEXK7eDJ8xXhVP27A3izb3pW7xmo=
Received: by 10.223.109.130 with SMTP id j2mr6076159fap.54.1283372569773; Wed,
 01 Sep 2010 13:22:49 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Wed, 1 Sep 2010 13:22:49 -0700 (PDT)
In-Reply-To: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155076>

On Wed, Sep 1, 2010 at 19:51, Junio C Hamano <gitster@pobox.com> wrote:

> As I didn't want to worry about the early parts of ab/i18n topic, whi=
ch
> was accidentally merged to 'next' due to my lazyness (another topic,
> ab/test, seemed to be ready for the upcoming release, but a patch to =
that
> topic had interaction with ab/i18n, which made ab/test unmergeable to
> 'master' without dragging 'ab/i18n'), I reverted ab/i18n topic from '=
next'
> and merged a rebuilt ab/test topic to 'next'. =C2=A0The i18n topic is=
 merged
> to 'pu'.

Cool, whatever makes release engineering easy for you. But the
"gettext: Make NO_GETTEXT=3DYesPlease the default in releases"
monkeypatch should probably be ejected out of pu.

I only wrote it in case gettext wouldn't be ejected from next and
would make it into 1.7.3, but since that won't be the case there's
really no reason for it to exist anywhere but the mailing list
archive.

It's also broken as a proper way to disable gettext (in case we want
to go that route). There's no way to re-enable it if you use the
=2E/configure script.

It's really only a monkeypatch.

> * ab/test-2 (2010-08-30) 51 commits
> =C2=A0(this branch is used by ab/test.)
>
> As I'd like to have this in the upcoming release, the tip of old ab/t=
est
> topic has been rebuilt without the merge from ab/i18n topic.

Thanks, and sorry for tangling them up.

> * kf/askpass-config (2010-08-30) 3 commits
> =C2=A0- Extend documentation of core.askpass and GIT_ASKPASS.
> =C2=A0- Allow core.askpass to override SSH_ASKPASS.
> =C2=A0- Add a new option 'core.askpass'.
>
> Should be Ok to merge to 'next'; then will merge to 'master' shortly.

Is this facility also used for the smtp password promt in
git-send-email? Should it be?

> * jj/icase-directory (2010-08-16) 6 commits
> =C2=A0(merged to 'next' on 2010-08-26 at 9d8e1bc)
> =C2=A0+ Support case folding in git fast-import when core.ignorecase=3D=
true
> =C2=A0+ Support case folding for git add when core.ignorecase=3Dtrue
> =C2=A0+ Add case insensitivity support when using git ls-files
> =C2=A0+ Add case insensitivity support for directories when using git=
 status
> =C2=A0+ Case insensitivity support for .gitignore via core.ignorecase
> =C2=A0+ Add string comparison functions that respect the ignore_case =
variable.
>
> Depends on GNU FNM_CASEFOLD.

We're going to have to get this working on non-GNU if it's to make it
into 1.7.3. I can probably help with that if jj doesn't have time.

> * ab/compat-regex (2010-08-26) 9 commits
> =C2=A0(merged to 'next' on 2010-08-26 at c5cc9d2)
> =C2=A0+ Fix compat/regex ANSIfication on MinGW
> =C2=A0(merged to 'next' on 2010-08-22 at 40bce7c)
> =C2=A0+ autoconf: regex library detection typofix
> =C2=A0(merged to 'next' on 2010-08-21 at 632d60f)
> =C2=A0+ autoconf: don't use platform regex if it lacks REG_STARTEND
> =C2=A0+ t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEN=
D
> =C2=A0+ compat/regex: get rid of old-style definition
> =C2=A0+ compat/regex: define out variables only used under RE_ENABLE_=
I18N
> =C2=A0+ Change regerror() declaration from K&R style to ANSI C (C89)
> =C2=A0+ compat/regex: get the gawk regex engine to compile within git
> =C2=A0+ compat/regex: use the regex engine from gawk for compat
>
> Will merge to 'master' shortly.

I'll try to recall to get these patches we have on top of it into
gawk/glibc once it's settled a bit more.

> * ab/i18n (2010-08-31) 23 commits
> [...]
> Kicked back to 'pu' to give it a bit more time to experiment with a
> Porcelain command or a two, and an opportunity for a fresh restart if
> necessary in the next cycle.

Incidentally I'm just about to submit some more experiments :)
