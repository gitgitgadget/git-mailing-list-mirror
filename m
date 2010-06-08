From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 8 Jun 2010 16:09:20 +0000
Message-ID: <AANLkTimtWrp1yimeooJ-ptAaDoxwpUc5KOP9HJUxx0X2@mail.gmail.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
	<201006080912.31448.johan@herland.net>
	<4C0E630A.7020803@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:09:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1Mm-0007vG-MI
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab0FHQJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 12:09:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48692 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0FHQJX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 12:09:23 -0400
Received: by pvg16 with SMTP id 16so1972328pvg.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j36+pXJWym0eY5oxoblhzs1ovlvgMyrOgcRl4JVJQrs=;
        b=l/HDcdwviNSXCNJmPr0uLbgyWj2Taq9wsaHLnmgEsryQ01SNsUWEslIh57a3ywer9y
         SZCHRuz66bm63lvPPLrzkWA8RHkKZ9wPvCdfAt6zlRpGEAWyIb1N7cfBi0WtXll+Vm34
         7DdHR2orby1Ujk2EbmkJD8zpzvLOhBrKOwVyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fxVcHmxk69SNx11t6bzvU/nQEzd5dx3FAbz6HDuirpDtMMSV6Ln4RrLlrIW289Gwhc
         Ik63OnDmzXQz+brSXBm/1nPpgMIEKygES/6LybbSiXbecJlPiyw4fpuTplOvGMUrWEyA
         Pmes05w1v476YM+BVj1EDNzbBxOIlT4hZk8qo=
Received: by 10.229.249.145 with SMTP id mk17mr5962193qcb.163.1276013360799; 
	Tue, 08 Jun 2010 09:09:20 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 8 Jun 2010 09:09:20 -0700 (PDT)
In-Reply-To: <4C0E630A.7020803@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148683>

On Tue, Jun 8, 2010 at 15:34, Marc Branchaud <marcnarc@xiplink.com> wro=
te:
> On 10-06-08 03:12 AM, Johan Herland wrote:
>>
>> There are probably more issues that escape me now...
>
> Thanks for bringing this up! =C2=A0I'm also very interested in this t=
opic.
>
> The main issue I see is that I don't always want my submodules to tra=
ck (or
> not track) a branch. =C2=A0What I want changes depending on the circu=
mstances.
>
> One aspect I really like about submodules is the ease of tagging. =C2=
=A0I can tag
> the super-repo, and know that whenever I checkout that tag I'll alway=
s get
> the corresponding versions of the submodules as they were when the ta=
g was
> made. =C2=A0It would actually be disastrous, at least in my case, if =
the
> submodules were at the latest HEAD of some branch instead.
>
> This goes for almost any commit in the super-repo's history, not just=
 the
> tagged ones: =C2=A0Whenever I checkout a historical committish, I wan=
t to get the
> submodules as they were when that commit was made. =C2=A0Even if I'm =
working at
> the HEAD of some branch, often that branch is based on a historical c=
ommit
> and I want to use the submodules as they were when that historical co=
mmit was
> made.
>
> All that said, I do think submodule branch tracking is useful. =C2=A0=
Quite often a
> development topic will change the super-repo and one or more submodul=
es. =C2=A0It
> would be extremely helpful to do that work in a branch that spans the
> super-repo and (a subset of) the submodules. =C2=A0(In my mind this c=
apability is
> one of the main benefits Google's "repo" tool has over submodules.)
>
> So, back to the issue at hand: Sometimes I want static (non-tracking)
> submodules, and sometimes I want dynamic (tracking) submodules. =C2=A0=
IMO, this
> makes =C3=86var's proposed configuration-based approach impractical. =
=C2=A0(Of course,
> I'm not looking to replicate svn's externals...)

I'm proposing that you be able to configure how you want to handle
submodules on a per-submodule basis.

The exact semantics that I proposed may be impractical for some
reason, but the idea is that it'd be opt in. We'd perhaps have
multiple approaches (via config) to submodules, instead of the current
monolithic scheme.

So if you didn't want a svn:externals like "always track trunk"
repository you'd just not set your superproject up to treat the
submodule like that.

> I'm not sure what the right approach is, but I have some thoughts:
>
> =C2=A0- Maybe "git branch" should be able to create submodule-spannin=
g branches.
>
> =C2=A0- If so, then checkout, merge, pull and other branch-related co=
mmands should
> honor submodule-spanning branches. =C2=A0"checkout" in particular nee=
ds to
> distinguish between when it's checking out an actual branch vs. some =
other
> committish, and if the branch being checked out is submodule-spanning=
 it
> should checkout the latest HEAD of that branch for the submodules as =
well.
>
> =C2=A0- It *may* be good enough to assume that matching branch names =
in the
> super-repo and the submodules are in fact submodule-spanning branches=
=2E

That won't work for submodules that you don't control. I have a
repository that includes a lot of foreign code, they have a lot of
different names for their "main branch" between them. So it needs to
be configurable in the superproject.

> =C2=A0- Automating all this is tricky. =C2=A0In my super-repo I almos=
t never want to
> checkout the master HEAD of all my submodules. =C2=A0In fact, many of=
 my
> submodules are big (e.g. they're different Linux kernels), and are on=
ly
> needed when building particular things, so that checking all of them =
out at
> once is almost always a huge waste of time.
>
> All this is probably not the kind of feedback you were hoping for! =C2=
=A0:)
