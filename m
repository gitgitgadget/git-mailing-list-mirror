From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Advice and repo setup
Date: Wed, 10 Apr 2013 19:59:04 +0200
Message-ID: <5165A868.2020801@gmail.com>
References: <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Michael Campbell <michael.campbell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 19:59:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPzIg-0005EP-SB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 19:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936390Ab3DJR7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 13:59:10 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:52974 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934904Ab3DJR7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 13:59:09 -0400
Received: by mail-ee0-f54.google.com with SMTP id e51so377695eek.41
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nqldnhEflVHk1lxilqUPp9fVQBO/6lMT6s/muux4tMw=;
        b=POGvoJInCyx+Zmu7K443pgUK6TaVcSlMvNSSzx85w7Y2rdv64hjZ2pBBGg/XbnDUIK
         TE3LdaMcwPC61HGau3CFdpBiH2dEveklJLO8vC57w/lIIat/rpFHAQ87UXTMy7ex5iiv
         nnpZ4oNEWRGBxIH8JLsX3Wy3CtHHg56C48QKilBKRz4NxMTnczf3Nc7oSVMMATyHa3uD
         1evaXBmJZWqaNy4jKr6nBeXbSFwZe/t7EezctFe5xHfBf/z0Vvr17xmORgGgfbLZ2B0w
         6484HRo0Scvan3xqmLAilGVflW5nZcoJ6gsHFYJ4IanxDWuREQEScWJNt29tcDQb459G
         cqUQ==
X-Received: by 10.14.89.69 with SMTP id b45mr7852449eef.10.1365616747657;
        Wed, 10 Apr 2013 10:59:07 -0700 (PDT)
Received: from [192.168.1.14] (edx151.neoplus.adsl.tpnet.pl. [83.21.9.151])
        by mx.google.com with ESMTPS id ca4sm1085063eeb.15.2013.04.10.10.59.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 10:59:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220710>

Michael Campbell wrote:

> My company is moving from CVS to git in a few weeks (and we have a
> training class scheduled with the github folks).
>=20
> That said our CI/build guys have already got gitorious set up (we get
> to it through ssh with ssh keys and one "git" user on the server)

Note that gitorious is git hosting software / software forge, i.e.
combination of git hosting [configuration] software, web interface
to repositories, and web-based administration.

This is not the only solution.  Among other all-in-one solutions
are GitHUb:FI / GitHub Enterprise (proprietary and costly), InDefero,
GitLab, Girocco + gitweb (what repo.or.cz uses).  There are also pure
web interfaces, and there are pure repository management software
like gitosis (possibly unmaintained) and gitolite.

I see GitHub Enterprise and GitLab both recommended as alternatives
to Gitorious. But supposedly the most trouble is with installation,
and you write that you "have already got gitorious set up".

Unfortunately the Git Tools wiki page is not very actively maintained:
https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

> and
> we are in the process of migrating all new CVS checkins to a git repo=
=2E

What tool do you use for that?  Do you have tool selected to perform
a full migration from CVS to Git (to have full history in Git), or
will you cut off the history (perhaps stitching it later with historica=
l
repo with history imported from CVS, via grafts or git-replace), like
Linux kernel did when moving from BitKeeper to Git?

BTW. it might make sense if you have time to massage the history
imported from CVS to remove CVS-related crufts and mishaps, e.g. with
the reposurgeon tool (http://www.catb.org/esr/reposurgeon/)

> As a business decision we have decided to pull in some "staff
> augmentation".  We don't want the remote developers to have direct
> access.  Our plan is to have some sort of external repo on which they
> can push things, and locally we can pull those changes to our
> "official" repo and check it as we go.  So far so good.

Another possible workflow is to have each of remote developers to get
updates from central "blessed" official repository, but for each to hav=
e
their own publishing repository they push to (and send pull requests ab=
out).

Or maybe something hierarchical, with each group having their own
repository...

> Our product has several logically separate projects, which right now
> we have in the one big mega repo (in CVS, and migrating per checkin t=
o
> Gitorious).

Errr... didn't you use so called "modules" in CVS?  Those usually
translate to projects, which translate to git repositories.

> So... I was wondering what the best way to split up our new repo migh=
t
> be - or is it best to NOT split it?   One of the concerns we have is
> that in the one big repo we can't control access to the various
> projects.  So far we haven't needed to but this might be because we
> couldn't.

Split it, of course, into individual independent (more or less) project
repositories.  Note for example that you can tag (give name to a
release) only whole repository.

> So one plan is to have multiple repos, and then a mirror of those for
> the remote devs.  The other plan is to say "sod it" and have one loca=
l
> and one remote and just suffer through possible non-requirements of
> varying authorization profiles.

It would also lead to slower operations (git works well with large
number of files, but not necessarily with very large number of files),
and increased storage (you can clone only whole repository even if
nowadays you can check out only part of it; and you want for each
developer to have their own private clone to work in).

> Is there documentation I can refer to for this, or is there an obviou=
s
> way to do these things?  Any help or pointers appreciated.

--=20
Jakub Nar=C4=99bski
