From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn fails to fetch repository
Date: Sat, 17 Jan 2009 02:45:58 -0800
Message-ID: <20090117104558.GC29598@dcvr.yhbt.net>
References: <loom.20090113T204616-845@post.gmane.org> <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com> <loom.20090113T211437-12@post.gmane.org> <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com> <loom.20090113T213400-985@post.gmane.org> <76718490901131658l108852f2y9a25eb9133d6e96d@mail.gmail.com> <loom.20090114T083207-942@post.gmane.org> <76718490901141006n6c70eb2cw67ad814b3739786e@mail.gmail.com> <20090117095147.GA29598@dcvr.yhbt.net> <E3BA9CAD-B3CD-4050-8493-7C4024AD4529@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Vladimir Pouzanov <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 11:47:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO8iE-0003dW-Rs
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 11:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbZAQKqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 05:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbZAQKp7
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 05:45:59 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60314 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbZAQKp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 05:45:58 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D231F44D;
	Sat, 17 Jan 2009 10:45:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E3BA9CAD-B3CD-4050-8493-7C4024AD4529@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106039>

Vladimir Pouzanov <farcaller@gmail.com> wrote:
> On 17 =D1=8F=D0=BD=D0=B2. 2009, at 11:51, Eric Wong wrote:
>> Does the following patch (a shot in the dark) work for you?
>> (it generates a lot of warnings for me)
>
> $ git svn clone http://qsb-mac.googlecode.com/svn/trunk qsbmac
> Initialized empty Git repository in /Users/farcaller/temp/qsbmac/.git=
/
> r1 =3D 810fe584c48b884460b5403a28bc61d872452b93 (git-svn)
> Attempt to release temp file 'GLOB(0x82b290)' that has not been locke=
d =20
> at /opt/local/libexec/git-core/git-svn line 3413
> 	A	externals/BSJSONAdditions/NSArray+BSJSONAdditions.m
> Attempt to release temp file 'GLOB(0xa0de34)' that has not been locke=
d =20
> at /opt/local/libexec/git-core/git-svn line 3413
> 	A	externals/BSJSONAdditions/BSJSON.h
> Attempt to release temp file 'GLOB(0x80ed84)' that has not been locke=
d =20
> at /opt/local/libexec/git-core/git-svn line 3413
> 	A	externals/BSJSONAdditions/NSDictionary+BSJSONAdditions.m
> Attempt to release temp file 'GLOB(0x9d3018)' that has not been locke=
d =20
> at /opt/local/libexec/git-core/git-svn line 3413
> 	A	externals/BSJSONAdditions/Example/Unit Tests/=20
> BSJSONScanner_UnitTests.h
> Attempt to release temp file 'GLOB(0xa0df48)' that has not been locke=
d =20
> at /opt/local/libexec/git-core/git-svn line 3413
> 	A	externals/BSJSONAdditions/Example/version.plist
> Attempt to release temp file 'GLOB(0x9d8114)' that has not been locke=
d =20
> at /opt/local/libexec/git-core/git-svn line 3413
> 	A	externals/BSJSONAdditions/NSDictionary+BSJSONAdditions.h
> Temp file with moniker 'svn_delta' already in use at /opt/local/lib/=20
> perl5/site_perl/5.8.8/Git.pm line 1011.

OK, and there are no symlinks in the repository which could trigger a
rare code path, either.  Very strange, does abort_edit() ever get calle=
d
in there?

> I've built git 1.6.1 based on OSX original perl an subversion, and it=
 =20
> handles the give repo without any problems, so the problem is kind of=
 =20
> solved. Strange thing is that macports git (the one that fails) handl=
es=20
> other svn repositories without any problems, I had cloned whole=20
> transmissionbt repo (>7000 revs) with all the tags and branches and=20
> several other simpler repositories.

At least you got a working combination working.  Does anybody know if
macports git have any patches/changes to it that could cause this?

--=20
Eric Wong
