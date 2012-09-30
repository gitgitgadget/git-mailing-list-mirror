From: David Aguilar <davvid@gmail.com>
Subject: Re: Merging/joining two repos (repo2 should be a subdirectory of repo1)
Date: Sun, 30 Sep 2012 13:44:11 -0700
Message-ID: <CAJDDKr4sXp7qqhzHN2_5sJeqaV23Z_uDiFsU_eFJrT5ApuWiTQ@mail.gmail.com>
References: <506862A1.8000508@dirk.my1.cc>
	<1349018675-ner-5178@calvin>
	<50686605.6020909@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Sep 30 22:45:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIQNt-0006Z6-Fp
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 22:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab2I3UoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2012 16:44:13 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44339 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab2I3UoM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2012 16:44:12 -0400
Received: by vbbff1 with SMTP id ff1so4726850vbb.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VnxDuGZ9SJj5KNDu4Ex2YBC2jXjDDWByZ//naBdfIJE=;
        b=Z8Kgda578czuZRCAgYdIaq6GuRvtcM0u0aWXTVXmoh32bPlMjFH284DN4KneDBESGT
         Z9h/B8w3gBH+rTYKwxKEJArV/HD8gCiJYszOSDtp28Ie3CoSYVy8QOuvMtgGMM60c0MD
         aYr3ZG0Mw4K+TWgFjIxbQE8Iwt7Yw0wrLyuPL7uM50ajNdg11+o9p4dJrq26nyjM9OxO
         8V/gHSSrUEN49MOERMJ4YFf7zs1Np9czLSIm8mPc37p929nq6+sGXfozQyiQqd1Aosxu
         HQ4/rm/JX0Gb2Bd89eEO5YqxwOk01G/h2GkM/voGTbBNMe/2wTBqxA1jHpxJI1MClzoV
         JRKQ==
Received: by 10.220.148.211 with SMTP id q19mr7271747vcv.55.1349037851041;
 Sun, 30 Sep 2012 13:44:11 -0700 (PDT)
Received: by 10.58.180.39 with HTTP; Sun, 30 Sep 2012 13:44:11 -0700 (PDT)
In-Reply-To: <50686605.6020909@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206697>

On Sun, Sep 30, 2012 at 8:32 AM, Dirk S=C3=BCsserott <newsletter@dirk.m=
y1.cc> wrote:
> Am 30.09.2012 17:24 schrieb Tomas Carnecky:
>> On Sun, 30 Sep 2012 17:17:53 +0200, Dirk S=C3=83=C5=92sserott <newsl=
etter@dirk.my1.cc> wrote:
>>> Hi!
>>>
>>> I have repo1 with ~4 years of history and another repo2 with ~1 yea=
r of
>>> history, both of which I don't want to loose. Now I want to join th=
em so
>>> that repo2 becomes a subdirectory whithin repo1, including all the
>>> history of repo2.
>>>
>>> A simple git-merge won't do because both repos have some same files=
 (at
>>> least e.g. .gitignore) in their root directories. Of course I could
>>> resolve the conflicts, but I don't want that.
>>>
>>> My naive approach is "move everything in $repo2 one directory below=
" and
>>> then "merge $repo2 into $repo1". Actually I wouldn' call that a "me=
rge"
>>> but an "import".
>>>
>>> I know of "git filter-branch --subdirectory-filter foodir" but that=
's
>>> just the opposite of what I need.
>>>
>>> Is there a nifty trick to get this? Or will I have to do "git
>>> filter-branch --tree-filter 'mkdir subdir && git mv * subdir' --all=
" on
>>> $repo2 and then "git merge $repo2" in $repo1?
>>
>> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-su=
btree.html
>>
>>
>
> Wow! Thanks for that quick and *very* helpful answer! :-)

Hi Dirk,

You should also take a look at contrib/subtree/ in the git source tree.

"git subtree" does pretty much exactly what you're looking to do,
and it is a bit more user-friendly than the plumbing commands.

https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt
--=20
David
