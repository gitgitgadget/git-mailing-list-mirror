From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Wed, 2 Jun 2010 18:01:04 +0200
Message-ID: <AANLkTikUsYOvB26DI2IWi6mghFM6Fj2bVuasaSKUfXba@mail.gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	<4BF7B751.7050704@pileofstuff.org>
	<4BFB7F7F.5090407@drmicha.warpmail.net>
	<4C041656.7000008@pileofstuff.org>
	<AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 18:01:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJqNV-0006hW-Jf
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 18:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030Ab0FBQBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 12:01:07 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43727 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab0FBQBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 12:01:05 -0400
Received: by wwb28 with SMTP id 28so3012151wwb.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 09:01:04 -0700 (PDT)
Received: by 10.227.157.134 with SMTP id b6mr7895693wbx.12.1275494464151; Wed, 
	02 Jun 2010 09:01:04 -0700 (PDT)
Received: by 10.216.154.211 with HTTP; Wed, 2 Jun 2010 09:01:04 -0700 (PDT)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148264>

On Tue, Jun 1, 2010 at 18:00, Daniele Segato <daniele.bilug@gmail.com> =
wrote:
> On Mon, May 31, 2010 at 10:04 PM, Andrew Sayers
> <andrew-git@pileofstuff.org> wrote:
>> On 25/05/10 08:42, Michael J Gruber wrote:
>>>
>>> Feel free to contribute to the Git Wiki maybe at
>>>
>>> https://git.wiki.kernel.org/index.php/GitDocumentation
>>>
>>> in the "User contributed Documentation" section.
>>>
>>> Michael
>>>
>>
>> Thanks for the hint - this turned into rather more than just uploadi=
ng a
>> PDF, and I've now finished a complete write-up here:
>>
>> =A0 =A0 =A0 =A0https://git.wiki.kernel.org/index.php/SvnMigration
>
>
> That's a great job!
>
> I want to point out some difficulties I encountered switching from
> Subversion to Git-SVN.
> I'd like to discuss them here before, eventually, contributing them t=
o
> that page.
>
>
> =3D Empty directories =3D
> Git do not track directories, it tracks content. That means you'll no=
t
> get/commit empty directory in your
> working tree.
> Sometimes empty directory may be needed by some fancy script or
> external software you use with your
> project (example, ANT).
>
> Developers should be aware of this: if they really need to create an
> empty directory they can both
> create it through subversion both create a "dummy" file in the
> directory and commit it, if that's an option.
>
>
> =3D Subversion ignore =3D
> You can't control subversion ignores from git-svn. And git-svn do not
> automatically synchronize with the
> subversion ignores. The team should be aware of these to avoid issues=
=2E
>
>
> =3D Local patch =3D
> Most subversion user keeps some modified files in their local checkou=
t
> never committing it remotely.
> This may be handy for some situation where you want to enable some
> debug-specific feature or whatever you need.
> With Git, if the file is remotely tracked (with Subversion you'll say
> "already committed") you can't keep a file like that:
> it will prevent you from "pushing" files to the remote repository or
> checking out other local/remote branches.
> You'll had to "stash" your patch and re-apply it later.

AFAIK you're not obliged to have a clean working tree to push.
If you want to keep patches on a branch you push regularly, creating a
new branch and committing on it is more appropriate, keeping the
patches as stash is not very handy.
Personally I only use stash when I'm on the middle of something and I
have to checkout another branch to check something.

>
> =3D local/remote branches =3D
> Git-svn branches "track" the remote branches by adding a string in
> each commit you "git svn dcommit" on
> subversion repository. You can have many local branches tracking the
> same remote subversion branch.
> To start to track a new remote branch you have to "git checkout -b
> localBranchName remoteBranchName",
> which is not very user friendly :)
>
> You also can't create new Subversion branches or tags with git-svn,
> you'll had to use subversion directly for that.
>
>
>
> Feel free to correct me or better describe those issue with a
> better/more friendly english.
> Feel also free to add to this list.
>
>
> Regards,
> Daniele Segato
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Sylvain
