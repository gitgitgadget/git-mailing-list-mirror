From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A Python script to put CTAN into git (from DVDs)
Date: Sun, 06 Nov 2011 12:29:28 -0800 (PST)
Message-ID: <m3zkg92dxq.fsf@localhost.localdomain>
References: <4EB6A522.3020909@pytex.org>
	<mailman.2464.1320597747.27778.python-list@python.org>
	<4EB6CFBB.2090901@pytex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: python-list@python.org, git@vger.kernel.org
To: Jonathan Fine <jfine@pytex.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 21:29:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN9LU-0003aD-AG
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 21:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab1KFU3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 15:29:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62429 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1KFU3b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 15:29:31 -0500
Received: by faao14 with SMTP id o14so4497425faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 12:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:newsgroups:to:cc:subject:references:from
         :date:message-id:lines:user-agent:in-reply-to:mime-version
         :content-type:content-transfer-encoding:posted-to;
        bh=e5MGxPMIsIaOMMX5ejkwR+m1Y8lHbh02QH2+EbjCvBw=;
        b=ATuOWrzAwaFU+93pt1G5b03w2XaRz3JEci+4UBE30/hX14P8ayH821YZaKF1cvj/po
         FetURqLWID+sJisq851KTndTg03dI5QPMo5bL3RXS+5DFiZfQlY5FcUW5KYmJAgOEFXE
         9/q2PbZvcb9KzS6xuZFv0k603mGPrqVp//6+k=
Received: by 10.223.63.206 with SMTP id c14mr41289333fai.3.1320611369843;
        Sun, 06 Nov 2011 12:29:29 -0800 (PST)
Received: from localhost.localdomain (aehn151.neoplus.adsl.tpnet.pl. [79.186.195.151])
        by mx.google.com with ESMTPS id o16sm28178185fag.21.2011.11.06.12.29.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 12:29:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pA6KTBqN000879;
	Sun, 6 Nov 2011 21:29:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pA6KSoTS000875;
	Sun, 6 Nov 2011 21:28:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
Newsgroups: comp.lang.python,comp.text.tex
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
In-Reply-To: <4EB6CFBB.2090901@pytex.org>
Posted-To: comp.lang.python,comp.text.tex
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184932>

The following message is a courtesy copy of an article
that has been posted to comp.lang.python,comp.text.tex as well.

Jonathan Fine <jfine@pytex.org> writes:
> On 06/11/11 16:42, Jakub Narebski wrote:
>> Jonathan Fine<jfine@pytex.org>  writes:
>>
>>> This it to let you know that I'm writing (in Python) a script that
>>> places the content of CTAN into a git repository.
>>>       https://bitbucket.org/jfine/python-ctantools
>>
>> I hope that you meant "repositories" (plural) here, one per tool,
>> rather than putting all of CTAN into single Git repository.

[moved]
>> There was similar effort done in putting CPAN (Comprehensive _Perl_
>> Archive Network) in Git, hosting repositories on GitHub[1], by the n=
ame
>> of gitPAN, see e.g.:
>>
>>    "The gitPAN Import is Complete"
>>    http://perlisalive.com/articles/36
>>
>> [1]: https://github.com/gitpan
[/moved]
=20
> There are complex dependencies among LaTeX macro packages, and TeX is
> often distributed and installed from a DVD.  So it makes sense here t=
o
> put *all* the content of a DVD into a repository.

Note that for gitPAN each "distribution" (usually but not always
corresponding to single Perl module) is in separate repository.
The dependencies are handled by CPAN / CPANPLUS / cpanm client
(i.e. during install).
=20
Putting all DVD (is it "TeX Live" DVD by the way?) into single
repository would put quite a bit of stress to git; it was created for
software development (although admittedly of large project like Linux
kernel), not 4GB+ trees.

> Once you've done that, it is then possible and sensible to select
> suitable interesting subsets, such as releases of a particular
> package. Users could even define their own subsets, such as "all
> resources needed to process this file, exactly as it processes on my
> machine".

This could be handled using submodules, by having superrepository that
consist solely of references to other repositories by the way of
submodules... plus perhaps some administrativa files (like README for
whole CTAN, or search tool, or DVD install, etc.)

This could be the used to get for example contents of DVD from 2010.


But even though submodules (c.f. Subversion svn:external, Mecurial
forest extension, etc.) are in Git for quite a bit of time, it doesn't
have best user interface.
=20
> In addition, many TeX users have a TeX DVD.  If they import it into a
> git repository (using for example my script) then the update from 201=
1
> to 2012 would require much less bandwidth.

???

> Finally, I'd rather be working within git that modified copy of the
> ISO when doing the subsetting.  I'm pretty sure that I can manage to
> pull the small repositories from the big git-CTAN repository.

No you cannot.  It is all or nothing; there is no support for partial
_clone_ (yet), and it looks like it is a hard problem.

Nb. there is support for partial _checkout_, but this is something
different.

> But as I proceed, perhaps I'll change my mind (smile).
>=20
>>> I'm working from the TeX Collection DVDs that are published each ye=
ar
>>> by the TeX user groups, which contain a snapshot of CTAN (about
>>> 100,000 files occupying 4Gb), which means I have to unzip folders a=
nd
>>> do a few other things.
>>
>> There is 'contrib/fast-import/import-zips.py' in git.git repository.
>> If you are not using it, or its equivalent, it might be worth checki=
ng
>> out.
>=20
> Well, I didn't know about that.  I took a look, and it doesn't do wha=
t
> I want.  I need to walk the tree (on a mounted ISO) and unpack some
> (but not all) zip files as I come across them.  For details see:
>  https://bitbucket.org/jfine/python-ctantools/src/tip/ctantools/filet=
ools.py
>=20
> In addition, I don't want to make a commit.  I just want to make a re=
f
> at the end of building the tree.  This is because I want the import o=
f
> a TeX DVD to give effectively identical results for all users, and so
> any commit information would be effectively constant.

Commit =3D tree + parent + metadata.

I think you would very much want to have linear sequence of trees,
ordered via DAG of commits.  "Naked" trees are rather bad idea, I think=
=2E
=20
> As I recall the first 'commit' to the git repository for the Linux
> kernel was just a tree, with a reference to that tree as a tag.  But
> no commit.

That was a bad accident that there is a tag that points directly to a
tree of _initial import_, not something to copy.

--=20
Jakub Nar=EAbski
