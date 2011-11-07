From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A Python script to put CTAN into git (from DVDs)
Date: Mon, 07 Nov 2011 13:50:23 -0800 (PST)
Message-ID: <m3ipmv38o2.fsf@localhost.localdomain>
References: <4EB6A522.3020909@pytex.org>
	<mailman.2464.1320597747.27778.python-list@python.org>
	<4EB6CFBB.2090901@pytex.org> <m3zkg92dxq.fsf@localhost.localdomain>
	<4EB83DDD.1080103@pytex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: python-list@python.org, git@vger.kernel.org
To: Jonathan Fine <jfine@pytex.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNX5K-0001UJ-UQ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab1KGVu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 16:50:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50257 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1KGVuZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 16:50:25 -0500
Received: by faan17 with SMTP id n17so466092faa.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:newsgroups:to:cc:subject:references:from
         :date:message-id:lines:user-agent:in-reply-to:mime-version
         :content-type:content-transfer-encoding:posted-to;
        bh=r8iqTb2gKqf/f5FHcwzk+vKWbLiUBDEFRQH5w1ZGitc=;
        b=dZxi/9IZK3FWpB2WAf6X+bwX/yXSplUKkLcDRJOkOe1QGNDw/+w0udPhs/3YRRD9wr
         tjFe3gjiPFa7oe/X1k2T26/Q6gcAouWNOWajf5muUrMGCMusXmGu+i6uuRAmez8/W/lG
         z395wKR2SSvQjhftK4TRrsXNZs3j2TeW8Z9j0=
Received: by 10.223.91.82 with SMTP id l18mr47927197fam.30.1320702624112;
        Mon, 07 Nov 2011 13:50:24 -0800 (PST)
Received: from localhost.localdomain (abwr239.neoplus.adsl.tpnet.pl. [83.8.241.239])
        by mx.google.com with ESMTPS id d3sm20394822fad.2.2011.11.07.13.50.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 13:50:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pA7LnkOQ017775;
	Mon, 7 Nov 2011 22:49:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pA7LnOw1017769;
	Mon, 7 Nov 2011 22:49:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
Newsgroups: comp.text.tex
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
In-Reply-To: <4EB83DDD.1080103@pytex.org>
Posted-To: comp.text.tex
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185038>

The following message is a courtesy copy of an article
that has been posted to comp.text.tex as well.

Jonathan Fine <jfine@pytex.org> writes:
> On 06/11/11 20:28, Jakub Narebski wrote:
>=20
> > Note that for gitPAN each "distribution" (usually but not always
> > corresponding to single Perl module) is in separate repository.
> > The dependencies are handled by CPAN / CPANPLUS / cpanm client
> > (i.e. during install).
>=20
> Thank you for your interest, Jakub, and also for this information.
> With TeX there's a difficult which Perl, I think, does not have.  Wit=
h
> TeX we process documents, which may demand specific versions of
> packages. LaTeX users are concerned that move on to a later version
> will cause documents to break.

How you can demand specific version of package?

In the "\usepackage[options]{packages}[version]" LaTeX command the
<version> argument specifies _minimal_ (oldest) version.  The same
is true for Perl "use Module VERSION LIST".
=20
Nevertheless while with "use Module VERSION" / "use Module VERSION LIST=
"
you can request minimal version of Perl Module, the META build-time spe=
c=20
can include requirement of exact version of required package:

http://p3rl.org/CPAN::Meta::Spec

  Version Ranges
  ~~~~~~~~~~~~~~

  Some fields (prereq, optional_features) indicate the particular
  version(s) of some other module that may be required as a
  prerequisite. This section details the Version Range type used to
  provide this information.

  The simplest format for a Version Range is just the version number
  itself, e.g. 2.4. This means that *at least* version 2.4 must be
  present. To indicate that *any* version of a prerequisite is okay,
  even if the prerequisite doesn't define a version at all, use the
  version 0.

  Alternatively, a version range *may* use the operators < (less than),
  <=3D (less than or equal), > (greater than), >=3D (greater than or
  equal), =3D=3D (equal), and !=3D (not equal). For example, the
  specification < 2.0 means that any version of the prerequisite less
  than 2.0 is suitable.

  For more complicated situations, version specifications *may* be
  AND-ed together using commas. The specification >=3D 1.2, !=3D 1.5, <
  2.0 indicates a version that must be *at least* 1.2, *less than* 2.0,
  and *not equal to* 1.5.

> > Putting all DVD (is it "TeX Live" DVD by the way?) into single
> > repository would put quite a bit of stress to git; it was created f=
or
> > software development (although admittedly of large project like Lin=
ux
> > kernel), not 4GB+ trees.
>=20
> I'm impressed by how well git manages it.  It took about 15 minutes t=
o
> build the 4GB tree, and it was disk speed rather than CPU which was
> the bottleneck.

I still think that using modified contrib/fast-import/import-zips.py
(or import-tars.perl, or import-directories.perl) would be a better
solution here...
=20
[...]
> We may be at cross purposes.  My first task is get the DVD tree into
> git, performing necessary transformations such as expanding zip files
> along the way.  Breaking the content into submodules can, I believe,
> be done afterwards.

'reposurgeon' might help there... or might not.  Same with git-subtree
tool.

But now I understand that you are just building tree objects, and
creating references to them (with implicit ordering given by names,
I guess).  This is to be a start of further work, isn't it?

> With DVDs from several years it could take several hours to load
> everything into git.  For myself, I'd like to do that once, more or
> less as a batch process, and then move on to the more interesting
> topics. Getting the DVD contents into git is already a significant
> piece of work.
>=20
> Once done, I can them move on to what you're interested in, which is
> organising the material.  And I hope that others in the TeX community
> will get involved with that, because I'm not building this repository
> just for myself.

[...]

> > > In addition, many TeX users have a TeX DVD.  If they import it in=
to a
> > > git repository (using for example my script) then the update from=
 2011
> > > to 2012 would require much less bandwidth.
> >
> > ???
>=20
> A quick way to bring your TeX distribution up to date is to do a delt=
a
> with a later distribution, and download the difference.  That's what
> git does, and it does it well.  So I'm keen to convert a TeX DVD into
> a git repository, and then differences can be downloaded.

Here perhaps you should take a look at git-based 'bup' backup system.

Anyway I am not sure if for git to be able to generate deltas well you
have to have DAG of commits, so Git can notice what you have and what
you have not.  Trees might be not enough here. (!)
=20
> > Commit =3D tree + parent + metadata.
>=20
> Actually, any number of parents, including none.  What metadata do I
> have to provide?  At this time nothing, I think, beyond that provided
> by the name of a reference (to the root of a tree).

Metadata =3D commit message (here you can e.g. put the official name of
DVD), author and committer info (name, email, date and time, timezone;
date and time you can get from mtime / creation time of DVD).=20

[cut]
=20
--=20
Jakub Nar=EAbski
