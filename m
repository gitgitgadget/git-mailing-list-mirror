From: Daniel <daniel@netwalk.org>
Subject: Re: dependable submodules
Date: Tue, 22 Mar 2011 07:55:26 -0700
Message-ID: <AANLkTinrvg=UkZJWCQt3hZXpAAgW=manhGPvk9s9KsCs@mail.gmail.com>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
	<7vd3lmv2k1.fsf@alter.siamese.dyndns.org>
	<AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
	<4D877A70.8070907@jku.at>
	<AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>
	<201103221428.p2MESAkG018553@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Pollak <robert.pollak@jku.at>, git <git@vger.kernel.org>,
	apenwarr@gmail.com
To: in-gitvger@baka.org
X-From: git-owner@vger.kernel.org Tue Mar 22 15:55:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q22zf-0004gf-Q3
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 15:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab1CVOzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 10:55:31 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab1CVOz3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 10:55:29 -0400
Received: by wwa36 with SMTP id 36so8913219wwa.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 07:55:27 -0700 (PDT)
Received: by 10.227.196.208 with SMTP id eh16mr5303226wbb.224.1300805727388;
 Tue, 22 Mar 2011 07:55:27 -0700 (PDT)
Received: by 10.227.141.84 with HTTP; Tue, 22 Mar 2011 07:55:26 -0700 (PDT)
X-Originating-IP: [216.228.174.132]
In-Reply-To: <201103221428.p2MESAkG018553@no.baka.org>
X-Google-Sender-Auth: fRfc3ZoYDiv9ETw2XX-qjmCKgwc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169742>

On Tue, Mar 22, 2011 at 7:28 AM,  <in-gitvger@baka.org> wrote:
>
> In message <AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.=
com>, Dani
> el writes:
>
> =A0 =A0I tried git-subtree. thanks but this is not what I wanted. Thi=
s
> =A0 =A0removed the .git dir for the subtree and hence updating the su=
btree is
> =A0 =A0not easy.
>
> =A0 =A0I want the functionality of git submodule except that I don't =
want the
> =A0 =A0version checked in as part of the superproject to have to be f=
etched
> =A0 =A0remotely.
>
> Could "remotely" be a local shadow master? =A0gitslave is another opt=
ion
> to git-submodules and git subtree merge for provide a superproject
> with attached slaves, but like git submodules it does require fetchin=
g
> from "upstream". =A0However, there is nothing requiring that "upstrea=
m"
> be the true Internet upstream. =A0It could be a local shadow copy of =
the
> master. =A0I describe this scenario in more detail on the gitslave ho=
me
> page starting with the third paragraph under "Gitslave is not
> perfect". =A0I wrote this with gitslave in mind, but there is nothing
> stopping you from using the concept with git-submodules (aside from
> the pain of the submodule update pain added to the shadow repository
> update pain breeding).
>
> However, if you really really have a good reason to want *everything*
> in one repo, perhaps you could play games with branches and subtree
> merge. =A0For each slave repository, create a new branch with the
> content you want (or do a merge from the slave onto the new branch to
> get the history or whatever). =A0Then attach the local repository to
> itself using git-submodules (bonus points if you can use a
> repository-relative URL), set the correct SHA corresponding to the
> branch of the "slave", and then (if it works, and I don't see why it
> would not) you are all done. =A0I would hate to have to use and updat=
e
> such a repository, though.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0-Seth Robertson
>

My current setup is that I'm simply versioning my home directory with
mercurial. Some vim plugins are under git and since it's a different
version control system I can check in the plugins easily. When I need
to update those plugins, I just run git update, and check them into
mercurial again. No problem, very easy.  I'm looking into what it
would take to convert my repo to be completely git, and so far I have
no exact way of dealing with those vim plugins since via submodules I
have to rely on the external repos being present when I clone my
homedir repo. Granted, if the repos have gone away a decade from now
and my vim plugins are not present, it won't be the end of the world,
but I want to see how close I can get to my current functionality when
using git instead of mercurial.
