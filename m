From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 29 Apr 2009 09:52:16 +0200
Message-ID: <200904290952.17789.jnareb@gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3r5zdnhqu.fsf@localhost.localdomain> <46a038f90904282355g43bf0cv909905f6028f054f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 10:01:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz4ht-00028P-Dl
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 09:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbZD2H7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 03:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbZD2H7m
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 03:59:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:64132 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbZD2H7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 03:59:42 -0400
Received: by qw-out-2122.google.com with SMTP id 5so910794qwd.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KDMOxQ5PrLC6FnXx6iTk5O1Il6bnKD6ClB0bn/GcZEc=;
        b=S/492/C0cQAszZgOUqeyBS1ydPcc0FayTI2zSDx/1F9Wf2rCydC9ax7j/sqLJx5wzi
         vEfwujXPwxxB00zSim1u2tcpz7H60ZyPN+U9KyPXjjGYb7SGjHIG5yYHS5Rxs5Bv9UKG
         highIe19HLBWW2xs1jEZr+2RYW772oeSnF6c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eGB+hWq/ZJIeaC9TLTL3wq4adBkZWUxUjCjMh7gi94C/2mo9noEKoRSVXTEZuhCZvO
         R4HoEN5lG+63qplk/H3Nc5x68f1gpKUM1deokypMNkOsSKPGIS6SatsNyOpgdb5Y/T2N
         N9aUrJ6lBR0s3sydBMwNT9/pHrlNi7YtyUOkE=
Received: by 10.220.83.194 with SMTP id g2mr40747vcl.74.1240991548275;
        Wed, 29 Apr 2009 00:52:28 -0700 (PDT)
Received: from ?192.168.1.13? (abwr45.neoplus.adsl.tpnet.pl [83.8.241.45])
        by mx.google.com with ESMTPS id 33sm2265018yxr.32.2009.04.29.00.52.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 00:52:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90904282355g43bf0cv909905f6028f054f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117864>

On Wed, 29 April 2009, Martin Langhoff wrote:
> On Tue, Apr 28, 2009 at 1:24 PM, Jakub Narebski <jnareb@gmail.com>
> wrote:=20

[I think you cut out a bit too much. Here I resurrected it]

JN> 1. Different limitations on file names (e.g. pathname length),
JN>   different special characters, different special filenames
JN>   (if any).
[...]
JN>   The answer is convention for filenames in a project. Simply
JN>   DON'T use filenames which can cause problems.
[...]

> > =C2=A0 DON'T DO THAT.

What could be proper solution to that, if you do not accept social=20
rather than technical restriction?  We can have pre-commit hook that=20
checks for portability for filenames (which is deployment specific,
and shouldn't be part of SCM perhaps with an exception of being example=
=20
hook) but it wouldn't help dealing with non-portable filenames on=20
filesystem that cannot represent them that are there.

If I remember correctly Git for some time has layer which can translate=
=20
between filenames in repository and filenames on filesystem, but I'm=20
not sure if it is generic enough for it to be a solution to this=20
problem, and currently there is no way to manipulate this mapping, I=20
think.


JN> 2. "Case-insensitive" but "case-preserving" filesystems. [...]
JN>
JN>     The answer is like for previous issue: don't.  Simply DO NOT
JN>     create files with filenames which differ only in case [...]

> > =C2=A0 DON'T DO THAT, SOLVABLE.

By 'solvable' here I mean that you should be able to modify only one of=
=20
clashing files at once (checkout 'README', modify, add to index, remove=
=20
from filesystem, checkout 'readme', modify, etc.), and deal with=20
annoyances in git-status output.  It can be done in Git, with medium=20
amount of hacking.  I don't think any other SCM can do even this, and
I cannot think of a better, automatic solution that would somehow deal=20
with case-clashing.

Note that all deals are off in case-insensitive and not preserving=20
filesystem.

By the way, wouldn't be a better solution to use sane filesystem, rathe=
r=20
than complicating SCM? ;-)

>=20
> As I mentioned, Eric is taking the perspective of offering a supporte=
d
> SCM to a large and diverse audience. As such, his notes are
> interesting not because he's right or he's wrong.
>=20
> We can be "right" and say "don't do that" if we shrink our audience s=
o
> that it looks a lot like us. There, fixed.

<quote source=3D"Dune by Frank Herbert">
  [...] the attitude of the knife =E2=80=94 chopping off what's incompl=
ete and
  saying: "Now it's complete because it's ended here."
</quote>

I could not resist posting this quote :-P

>=20
> But something tells me that successful tools are -- by definition --
> tools that grow past their creators use.
>=20
> So from Eric's perspective, it is worthwhile to work on all those
> issues, and get the right for the end user -- support things we don't
> like, offer foolproof catches and warnings that prevent the user from
> shooting their lovely toes off to mars, etc.

Warnings and catches I can accept; adding complications and corner case=
s=20
for situations which can be trivially avoided with a bit of social=20
engineering aka. project guidelines... not so much.

I simply cannot see the situation where you _must_ have dangerously=20
unportable file names (trailing dot, trailing whitespace) and=20
case-clashing files...

>=20
> His perspective is one of commercial licensing, but even if we aren't
> driven by the "each new user is a new dollar" bit, the long term hope=
s
> for git might also be to be widely used and to improve the version
> control life of many unsuspecting users.
>=20
> To get there, I suspect we have to understand more of Eric's
> perspective.=20
>=20
> that's my 2c.

By the way, I think that the article on cross-platform version control=20
(version control in heterogenic environment) is quite good article.
I don't quite like the "10 Issues"/"Top 10" way of writing, but the=20
article examines different ways that heterogenic environment can trip=20
SCM. =20

In my opinion Git does quite good here, where it can, and where the=20
issue is to be solved by SCM and not otherwise (extra metadata like=20
resource fork).

--=20
Jakub Narebski
Poland
