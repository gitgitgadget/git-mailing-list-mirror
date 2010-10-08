From: Kevin Ballard <kevin@sb.org>
Subject: Re: Alternate .gitignore
Date: Fri, 8 Oct 2010 14:45:58 -0700
Message-ID: <6FF71159-7AB3-46D2-A417-77ED61458D4A@sb.org>
References: <loom.20101008T141929-221@post.gmane.org> <AANLkTimG188_8qg-DTtJtvX-wkpotgp7+f8Bu4b4ayMn@mail.gmail.com> <loom.20101008T225637-152@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Oct 08 23:46:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4KlU-0006yY-LN
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 23:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979Ab0JHVqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 17:46:03 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49313 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0JHVqB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 17:46:01 -0400
Received: by pzk34 with SMTP id 34so426155pzk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 14:46:01 -0700 (PDT)
Received: by 10.114.75.16 with SMTP id x16mr3486377waa.189.1286574361235;
        Fri, 08 Oct 2010 14:46:01 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id d31sm3585619wam.5.2010.10.08.14.45.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 14:46:00 -0700 (PDT)
In-Reply-To: <loom.20101008T225637-152@post.gmane.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158544>

On Oct 8, 2010, at 2:39 PM, Maaartin wrote:

> =C6var Arnfj=F6r=F0 Bjarmason <avarab <at> gmail.com> writes:
>=20
>> Have you looked into storing your binaries in a git-submodule(1) ?
>=20
> I've look at it just now and it doesn't seem to be the thing I need. =
According=20
> to my very basis understanding submodules seem to be useful for embed=
ding other=20
> projects, but I'm working with a single project only. I'm speaking ab=
out a=20
> single project and need to store it in different repositories at diff=
erent=20
> "ignorance levels".
>=20
> To make it clear, just imagine that compilation would be many thousan=
d times=20
> slower. In such a case you could prefer to store the history of the *=
=2Eo files as=20
> well, but you'd still want to avoid the pollution of the source tree.=
 So you'd=20
> maybe use .git for the sources as usually and .git2 (or whatever) for=
 the object=20
> files (maybe together with the sources). This comes very close to my =
situation.
>=20
> I could switch to using .git2 using $GIT_DIR, but with "*.o" in my .g=
itignore I=20
> see no way how to include the ignored files. Maybe I could use $GIT_D=
IR/info/
> exclude somehow instead of .gitignore, but this could be quite cumber=
some.

Submodules are usually used to embed other projects, but they can also =
be used for this "ignorance levels" thing you want. Make the core repo =
have what everyone wants, and each "ignorance level" should go into ano=
ther submodule. Lots of binary files that only some people need? Make i=
t a submodule. People can then init the submodules they care about and =
update just those ones and ignore the others. You'll probably want to h=
ave some sort of documentation telling people what the different submod=
ules are, so they don't just blindly `git submodule update --init --rec=
ursive`, but with just a little bit of effort it can work pretty well.

-Kevin Ballard