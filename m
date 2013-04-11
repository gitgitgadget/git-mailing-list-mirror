From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Git 1.8.3 l10n round 1
Date: Thu, 11 Apr 2013 12:28:59 +0800
Message-ID: <CANYiYbF-cCeaL61AubF8Mx9XmKyxzcSytw9pKq5==W2r2R17Rg@mail.gmail.com>
References: <CANYiYbGsX0KoHnSJya91Mwo3UQasJUSF_fCE9aSuzqS6QsJxNA@mail.gmail.com>
	<7v8v4qmcwg.fsf@alter.siamese.dyndns.org>
	<CAN_hzmptrZhUJo_WRnLdPD9jR85F10nHZpEXU64RMFWimLxqkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>,
	Git List <git@vger.kernel.org>
To: Harring Figueiredo <harringf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 06:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ98J-0003ir-5m
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 06:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab3DKE3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 00:29:05 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56622 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab3DKE3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 00:29:04 -0400
Received: by mail-wi0-f178.google.com with SMTP id ez12so129636wid.5
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AYzt6eX8CFAK8k5+k0ELLO0Ye41MPgMuV6dBk0tj5Rs=;
        b=skzXkdpgjB+KEp/iHYhGya6d84h0fnvth2ardP0+Ibow8ENiv3ilozgdQpLwsD+jbA
         2eXzSOPK4fU15WtkKTXK+wsJLJVMs98sOjwvzpNtIxh7XMSEqdX/W68XR2qe369LCstr
         YBJbvAdlEkj3+FApaKABY85Pfady6+baLPe/TbIu0ko/IJtNhF4jsnDmbUC8gqN9zMWL
         bhb1yxNp4b0+zdCc1ncirXckxQdzfHokiitkd5bvktPHhEOgQRysCM/DH5W6tjSLPvHc
         PqKTYFbP5KxqkQZWrAFxZxLmfzzD7S1FZRP/CPI7yfbLW2cIC2gXhFdSblU0DCLxfIF+
         Xqtg==
X-Received: by 10.194.89.169 with SMTP id bp9mr7606897wjb.57.1365654539288;
 Wed, 10 Apr 2013 21:28:59 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Wed, 10 Apr 2013 21:28:59 -0700 (PDT)
In-Reply-To: <CAN_hzmptrZhUJo_WRnLdPD9jR85F10nHZpEXU64RMFWimLxqkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220815>

2013/4/11 Harring Figueiredo <harringf@gmail.com>:
> How do I pull the git.pot from my upstream?

First add git://github.com/git-l10n/git-po.git as a new remote if you have not
do this and fetch from it.

    $ git remote add git-po git://github.com/git-l10n/git-po.git
    $ git fetch git-po

After that, the commit with the update 'git.pot' is stored in branch
remote/git-po/master.

    $ git log --oneline -1 git-po/master
    c138a l10n: git.pot: v1.8.3 round 1 (54 new, 15 removed)

Run the following command, you can find your local commits not in upstream.

    $ git log --oneline git-po/master..
    0ade1 l10n: Translation updates.
    3a731 ln10: Added more translation. No merge needed.
    69989 l10n: Merge remote-tracking branch 'upstream/master'
    b32bb l10n: Translated 61 messages
    8e534 l10n: Init of Brazilian Portuguese translation

I found there is a merge commit (commit 69989) already.

In order to update your local 'po/git.pot' file, you have TWO selection.
One is merge, another is rebase.

If you choose merge like the follows,

    $ git merge -q --no-edit git-po/master

, then there would be a new merge commit in your local repo but not in upstream:

    $ git log --oneline git-po/master..
    8a699 Merge remote-tracking branch 'git-po/master' into WIP/pt_BR/master
    0ade1 l10n: Translation updates.
    3a731 ln10: Added more translation. No merge needed.
    69989 l10n: Merge remote-tracking branch 'upstream/master'
    b32bb l10n: Translated 61 messages
    8e534 l10n: Init of Brazilian Portuguese translation

But if you use rebase instead of merge,

    $ git rebase git-po/master
    First, rewinding head to replay your work on top of it...
    Applying: l10n: Init of Brazilian Portuguese translation
    Applying: l10n: Translated 61 messages
    Applying: ln10: Added more translation. No merge needed.
    Applying: l10n: Translation updates.

after rebase, then your may find in the polished master branch
of you local repo, the old merge commit (such as 69989
l10n: Merge remote-tracking branch 'upstream/master') is discarded.
(Please note after rebase the commit-ish would be changed, and
 yours must be different.)

    $ git log --oneline git-po/master..
    a338e l10n: Translation updates.
    0d36a ln10: Added more translation. No merge needed.
    2a7a6 l10n: Translated 61 messages
    70b2 l10n: Init of Brazilian Portuguese translation

After rebase, you can not push directly, must push with --force option, like

    git push --force origin

> Once I do that, what else do I need to do to update my .po and leave my repo
> in a manner that I can commit to my remote?

You can find instructions in "Updating a XX.po file" section of
'po/README' file.

1. change cwd.

    $ cd po/

2. Current statistics of your pt_BR.po

    $ msgfmt -o /dev/null --statistics pt_BR.po
    158 translated messages, 1851 untranslated messages.

3. Update pt_BR.po from the new update git.pot

    $ msgmerge --add-location --backup=off -U pt_BR.po  git.pot

4. Then you may see pt_BR.po changed:

    $ msgfmt -o /dev/null --statistics pt_BR.po
    155 translated messages, 14 fuzzy translations, 1879 untranslated messages.

5. Commit the changed pt_BR.po, and start your translation.

When you feel translations of 'pt_BR.po' is ok for me to pull, send me
a pull request. But you'd better squash all these trivial commits into one
big initial commit, because so many trivial commits are boring, and may
have bad impact on git repository statistics. Junio has a blog on how he
do statistics:

* http://git-blame.blogspot.com/2013/03/so-how-well-are-we-doing-lately.html

BTW, kick back to the list for future reference.

--
Jiang Xin
