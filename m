From: Peter Colberg <peter@colberg.org>
Subject: Git Perl module not installed to --prefix
Date: Thu, 13 Sep 2012 14:30:19 -0400
Message-ID: <20120913183019.GA15312@pignolo.chem.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 20:36:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEHI-0005al-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab2IMSgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Sep 2012 14:36:32 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:35060 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab2IMSgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:36:31 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2012 14:36:31 EDT
Received: from [176.9.47.72] (helo=pleione.colberg.org)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <peter@colberg.org>)
	id 1TCEBB-0006Yf-BV
	for git@vger.kernel.org; Thu, 13 Sep 2012 20:30:21 +0200
Received: by pleione.colberg.org (Postfix, from userid 2000)
	id 2CBE11D45; Thu, 13 Sep 2012 14:30:21 -0400 (EDT)
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: MTAwMjE5OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205407>

Hi,

I have trouble installing the Git Perl module to the correct
installation prefix, which is required for git send-email.

The problem is reproducible with the following commands:

    ./configure --prefix=3D/home/peter/usr/rhel6-x86_64/git-1.7.12
    make
    make install

While git is installed to --prefix, the Git Perl module is not:

    =E2=80=A6
    make -C templates DESTDIR=3D'' install
    make[2]: Entering directory `/tmp/git/git-1.7.12/templates'
    install -d -m 755 '/home/peter/usr/rhel6-x86_64/git-1.7.12/share/gi=
t-core/templates'
    (cd blt && gtar cf - .) | \
            (cd '/home/peter/usr/rhel6-x86_64/git-1.7.12/share/git-core=
/templates' && umask 022 && gtar xof -)
    make[2]: Leaving directory `/tmp/git/git-1.7.12/templates'
    install -d -m 755 '/home/peter/usr/rhel6-x86_64/git-1.7.12/libexec/=
git-core/mergetools'
    install -m 644 mergetools/* '/home/peter/usr/rhel6-x86_64/git-1.7.1=
2/libexec/git-core/mergetools'
    install -d -m 755 '/home/peter/usr/rhel6-x86_64/git-1.7.12/share/lo=
cale'
    (cd po/build/locale && gtar cf - .) | \
            (cd '/home/peter/usr/rhel6-x86_64/git-1.7.12/share/locale' =
&& umask 022 && gtar xof -)
    make -C perl prefix=3D'/home/peter/usr/rhel6-x86_64/git-1.7.12' DES=
TDIR=3D'' install
    make[2]: Entering directory `/tmp/git/git-1.7.12/perl'
    make[3]: Entering directory `/tmp/git/git-1.7.12/perl'
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git.pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN.pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/I18N.pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/IndexInfo.p=
m
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Log.pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Fetcher=
=2Epm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Ra.pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Prompt.=
pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Migrati=
on.pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Utils.p=
m
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Editor.=
pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/GlobSpe=
c.pm
    Installing /home/peter/usr/rhel6-x86_64/share/perl5/Git/SVN/Memoize=
/YAML.pm
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git::SVN::Pr=
ompt.3pm
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git::SVN::Fe=
tcher.3pm
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git::SVN::Ed=
itor.3pm
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git::I18N.3p=
m
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git::SVN::Me=
moize::YAML.3pm
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git::SVN::Ra=
=2E3pm
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git.3pm
    Installing /home/peter/usr/rhel6-x86_64/share/man/man3/Git::SVN::Ut=
ils.3pm
    Appending installation info to /home/peter/usr/rhel6-x86_64/lib64/p=
erl5/perllocal.pod
    make[3]: Leaving directory `/tmp/git/git-1.7.12/perl'
    make[2]: Leaving directory `/tmp/git/git-1.7.12/perl'
    =E2=80=A6

As seen above, the perl module is installed to the parent directory.

Strangely, if perl/Makefile is invoked manually, it works:

    make -C perl prefix=3D'/home/peter/usr/rhel6-x86_64/git-1.7.12' DES=
TDIR=3D'' install

    make: Entering directory `/tmp/git/git-1.7.12/perl'
    make[1]: Entering directory `/tmp/git/git-1.7.12/perl'
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git.=
pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
I18N.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
IndexInfo.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Log.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Fetcher.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Ra.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Prompt.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Migration.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Utils.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Editor.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/GlobSpec.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/perl5/Git/=
SVN/Memoize/YAML.pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it::SVN::Prompt.3pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it::SVN::Fetcher.3pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it::SVN::Editor.3pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it::I18N.3pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it::SVN::Memoize::YAML.3pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it::SVN::Ra.3pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it.3pm
    Installing /home/peter/usr/rhel6-x86_64/git-1.7.12/share/man/man3/G=
it::SVN::Utils.3pm
    Appending installation info to /home/peter/usr/rhel6-x86_64/git-1.7=
=2E12/lib64/perl5/perllocal.pod
    make[1]: Leaving directory `/tmp/git/git-1.7.12/perl'
    make: Leaving directory `/tmp/git/git-1.7.12/perl'

Thanks,
Peter
