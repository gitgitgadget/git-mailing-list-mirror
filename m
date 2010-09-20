From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 12:56:10 -0400
Message-ID: <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 18:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxjgZ-0001Jg-1L
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 18:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903Ab0ITQ5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 12:57:41 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:45892 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753691Ab0ITQ5l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 12:57:41 -0400
Received: from host-211-194.meilvil.clients.pavlovmedia.com ([96.63.211.194])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OxjgL-0000g3-8D
	for git@vger.kernel.org; Mon, 20 Sep 2010 12:57:34 -0400
In-Reply-To: <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156639>

On Sep 20, 2010, at 10:53 AM, Brandon Casey wrote:
> On 09/19/2010 06:50 PM, Andrew Keller wrote:
>=20
>> Hello, all.  Quick question:
>>=20
>> I'm trying to build and install git 1.7.2.3 from source on a server =
at school used for my class.
>> 'uname -a' is 'SunOS bloch 5.9 Generic_122300-54 sun4u sparc SUNW,Ul=
traAX-i2'.
>>=20
>> There were a few hiccups at first =96 things like CC not being defin=
ed, tclsh not existing, the path to python being wrong, etc, but they w=
ere all relatively easy to work around.  This last error, however, not =
so much luck.
>>=20
>> Because I do not own the server and my account has restricted privil=
eges, I attempted to augment my PATH to include a directory in my home =
folder, and then install git in there by specifying a prefix at the con=
figure stage.  The configure and the make work, but the make install fa=
ils.  Here's the last section of the log:
>>=20
>>=20
>> $ make install
>>=20
>> ...
>>=20
>> make -C templates DESTDIR=3D'' install
>> make[1]: Entering directory `/usr/users/students/ak4390/Downloads/gi=
t-1.7.2.3/templates'
>> /usr/ucb/install -d -m 755 '/usr/users/students/ak4390/.local/share/=
git-core/templates'
>> (cd blt && gtar cf - .) | \
>>        (cd '/usr/users/students/ak4390/.local/share/git-core/templat=
es' && umask 022 && gtar xof -)
>> make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/git=
-1.7.2.3/templates'
>> make -C perl prefix=3D'/usr/users/students/ak4390/.local' DESTDIR=3D=
'' install
>> make[1]: Entering directory `/usr/users/students/ak4390/Downloads/gi=
t-1.7.2.3/perl'
>> make[2]: Entering directory `/usr/users/students/ak4390/Downloads/gi=
t-1.7.2.3/perl'
>> Warning: You do not have permissions to install into /usr/perl5/site=
_perl/5.6.1/sun4-solaris-64int at /usr/perl5/5.6.1/lib/ExtUtils/Install=
=2Epm line 85.
>> Installing /usr/perl5/site_perl/5.6.1/Error.pm
>> Installing /usr/perl5/site_perl/5.6.1/Git.pm
>> mkdir /usr/perl5/site_perl/5.6.1/sun4-solaris-64int/auto: Permission=
 denied at /usr/perl5/5.6.1/lib/ExtUtils/Install.pm line 165
>> make[2]: *** [pure_site_install] Error 255
>> make[2]: Leaving directory `/usr/users/students/ak4390/Downloads/git=
-1.7.2.3/perl'
>> make[1]: *** [install] Error 2
>> make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/git=
-1.7.2.3/perl'
>> make: *** [install] Error 2
>>=20
>>=20
>> So anyways, it appears that it is trying to install into a directory=
 in which I do not have write permissions.  But why?  I thought that se=
tting the prefix to a folder in my home directory would change that.  I=
s there another parameter I'm forgetting about at the configure stage?
>>=20
>> Thanks,
>> Andrew Keller
>>=20
>> PS: not sure if it matters, but just in case...
>> path to perl: /bin/perl
>> version of perl: 5.6.1
>=20
> By chance could INSTALL_BASE be set in your environment?
>=20
>   $ echo $INSTALL_BASE

env says that INSTALL_BASE is not currently set.

> A patch was recently made to unset that variable so that it
> could not influence perl's makemaker.  Though the commit message
> indicates that makemaker complains loudly when both INSTALL_BASE
> and PREFIX are set, so perhaps this is not the problem.
>=20
> If INSTALL_BASE is set, then unset it, and try again.
>=20
> Alternatively, you could avoid makemaker altogether by setting
> NO_PERL_MAKEMAKER on the make command line and git will build
> its own make file:
>=20
>   make NO_PERL_MAKEMAKER=3D1 install

Setting NO_PERL_MAKEMAKER at the build stage seems to make the install =
stage work.  Yay!

This is what it took to compile Git on this server without root privile=
ges (Solaris 8 / Sparc):

# create a location for apps in my home folder:
mkdir ~/.local
export PATH=3D$PATH:/usr/users/students/ak4390/.local/bin
export MANPATH=3D$MANPATH:/usr/users/students/ak4390/.local/share/man

# compile and install git
$ ln -s /usr/local/bin/tclsh8.4 /usr/users/students/ak4390/.local/bin/t=
clsh
$ export CC=3D/usr/local/bin/gcc
$ cd <path-to-git-src>
$ ./configure --prefix=3D/usr/users/students/ak4390/.local --with-pytho=
n=3D/usr/local/bin/python --enable-pthreads=3Dno
$ make NO_PERL_MAKEMAKER=3D1 all install

Letting the configure figure out the threading did not seem to work.  T=
he compile and install worked, with lots of warnings from gcc about not=
 recognizing -pthreads, but when you try to do a clone, git complained =
about not being able to fork off the demultiplexer.  So I just turned o=
ff threading and it works.

The quick-install-man target still failed, but it's not really a big de=
al since I can just install it myself.

Thanks,
~ Andrew Keller
