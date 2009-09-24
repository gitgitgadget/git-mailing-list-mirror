From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Thu, 24 Sep 2009 01:24:37 -0700 (PDT)
Message-ID: <430881.64091.qm@web27803.mail.ukl.yahoo.com>
References: <34819.77.61.241.211.1253779041.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>, git@vger.kernel.org,
	spearce@spearce.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Thu Sep 24 10:24:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqjd7-0004hX-PR
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 10:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZIXIYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 04:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbZIXIYf
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 04:24:35 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:26581 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751890AbZIXIYe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 04:24:34 -0400
Received: (qmail 65206 invoked by uid 60001); 24 Sep 2009 08:24:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1253780677; bh=uixjtgvE3piJEC4rIz4BDko67zgSz5fwc0jetM/Tq+Q=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KaDVE9HzyRKUCvLYRrzlwyzkVN8EKgIEod8j4t+Mee4AOmEeAvbA3fvkZEQo/WWBq8cIaJat4dDBEunoP2tZlO/MYfvKHlsjoS1vkQc8krGUuMjLNIsJUlA20fHbL9GVdo3L9VoxBq92a3DA8171exQ7EShZ6cxvNoNTjp7L26c=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CrOSFaz/DrJewNG92VF/yPspeHsxK37EJ0YRpLGRLLjeqIF4nIyQVjW5VVc2ufiO5U9oQYx0v30SI5tlCPO4aA6xgOUIEx3JRsGNo8/UigUY9smmva+wqc0Xcc/wxkI5tzoc7UQEFeYAJwNYzpl6FPl/6zG3H0jqB4EGNUIM4As=;
X-YMail-OSG: CxtA77cVM1noMNBjc3YlezxW6EYVYDfv6ZTrQJrYZdB9CYkwUTQJHH.DH1iFsQ6DUyUk5d4j9NGKUhIM53RLj1R3vtsmOAJi2zuN4WVuq6UVwS9vIASXbdaQuHaaQv8WsfRZbhgg4mlIYtALR8t8Xsxygnv4m3kICcD8EHilhxd5YV_ZH.8wHzsLVw2k6fcgQcN0WvrZ.vGaBbwuQ7zK52pWc0oKbb.f8DUwXi_lftLn5.W.eJ5ea24JQJXVVj2Hg_7ctrcQU6QhyX2r6wjjyvuOBsuZZQdR88u2rVAABA7l7uM4m.N9dmlm
Received: from [81.16.153.112] by web27803.mail.ukl.yahoo.com via HTTP; Thu, 24 Sep 2009 01:24:37 PDT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.2
In-Reply-To: <34819.77.61.241.211.1253779041.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129030>

Hi again and txs 4 your comments!

There are a few problems with dirty files:

a) one cannot automated make sure that all builds well and the build is=
 reproducable if there are dirty files lying around. A build script can=
not judge which changes doesn't affect the build in a bad way and thus =
may be ignored.

b) therefore the maven-release-plugin will refuse to build a release if=
 you have something dirty or not up2date.

c) if people get used to have dirty files, they will simply refuse to m=
erge them because they don't like to apply their local settings every t=
ime

d) there are a lot of people working with Idea, NetBeans, vi, emacs, et=
c. All those people would not be forced by the settings in the eclipse =
config files.

e) having all the rules in the underlying build system will allow us to=
 easily enable continuous integration tools like e.g. Hudson.


ad the JVM settings: I have up to 4 different JVMs installed on my boxe=
s: 1.4.2, 1.5.x, 1.6.x stable and 1.6.x previews
So I have to tell eclipse what exact JVM to use.=20
Please note that the jdk1.5++ rule is already forced in the pom.xml mav=
en-compiler-plugin settings.=20

ad different plugin versions config: having only the settings for a new=
 plugin doesn't do anything (beside crashing/breaking eclipse) if you d=
on't have the right versions of the plugins itself installed actually ;=
) This is imho only enforcable in a company and not in an OSS project.


LieGrue,
strub

--- On Thu, 9/24/09, Ferry Huberts <ferry.huberts@pelagic.nl> wrote:

> From: Ferry Huberts <ferry.huberts@pelagic.nl>
> Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>, git@vger.kernel.org, =
spearce@spearce.org
> Date: Thursday, September 24, 2009, 9:57 AM
>=20
> > I work on a lot of projects and having eclipse (or any
> other IDEs) project files in the SCM is
> > almost ever causing a problem. In praxis those files
> are always dirty. There are so many settings
> > which may be different from user to user
>=20
> true. however, those problems can easily be avoided by the
> policy of not ever checking in those eclipse files unless
> coordinated within the project.
>=20
> we have many big java projects here internally and _do_
> have
> the eclipse settings in git. it makes life so much easier
> for
> everyone to start work and we have many more settings in
> there that we actually want enforced.
>=20
> for example: we enforce a coding standard through eclipse
> by automatically formatting the source code and organising
> imports on file save. also, we want everybody to use the
> same
> settings when cleaning up the code. we want them to use
> the
> same findbugs settings, the same settings for xxx/yyy/....
>=20
> > * different JVM settings
>=20
> if specified correctly this is actually an advantage: you
> can
> standardise your projects on a (minimum) JVM platform, like
> 1.5
>=20
> > * using different version of various plugins
>=20
> we see that as an advantage so that we can standardise the
> development setup, or at least define some sort of minimum
> setup
>=20
>=20
> > You can easily create the project files for a few IDEs
> with maven e.g.:
> > $> mvn eclipse:eclipse=A0=A0=A0for
> creating the eclipse project files
> > $> mvn idea:idea=A0 =A0 =A0
> =A0=A0=A0for creating the idea project files
>=20
> I know, quite handy :-)
>=20
> Think I have more questions now than before by discussing
> it :-)
>=20
>=20


     =20
