From: Matthias-Christian Ott <ott@mirix.org>
Subject: Re: git send-email doesn't work with IPv6 and STARTTLS
Date: Thu, 01 May 2014 22:44:22 +0200
Message-ID: <5362B226.4080500@mirix.org>
References: <53615259.90200@mirix.org> <20140501180546.GA9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen_Ullrich@genua.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 22:43:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxpX-0007Tn-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbaEAUnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:43:40 -0400
Received: from a.mirix.org ([78.46.130.147]:49787 "EHLO a.mirix.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbaEAUnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:43:39 -0400
Received: from [2003:5c:ad3d:2e00:4dd3:c93f:ccdd:1f38]
	by a.mirix.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <ott@mirix.org>)
	id 1WfxpR-0002Ll-J8; Thu, 01 May 2014 22:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140501180546.GA9218@google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247880>

On 05/01/14 20:05, Jonathan Nieder wrote:
> Hi,

Hi,

> Matthias-Christian Ott wrote[1]:
> 
>> git send-email uses Net::SMTP connections that use STARTTLS. Net::SMTP
>> does not support IPv6. I patched Net:SMTP to use IO::Socket::INET6 and
>> it worked.
> 
> Thanks for reporting.
> 
>  1. What version of Net::SMTP do you use?

Included in Perl:

Summary of my perl5 (revision 5 version 16 subversion 3) configuration:

  Platform:
    [...]
    hint=recommended, useposix=true, d_sigaction=define
    useithreads=undef, usemultiplicity=undef
    useperlio=define, d_sfio=undef, uselargefiles=define, usesocks=undef
    use64bitint=undef, use64bitall=undef, uselongdouble=undef
    usemymalloc=n, bincompat5005=undef
  Compiler:
    [...]
    intsize=4, longsize=4, ptrsize=4, doublesize=8, byteorder=1234
    d_longlong=define, longlongsize=8, d_longdbl=define, longdblsize=12
    ivtype='long', ivsize=4, nvtype='double', nvsize=8, Off_t='off_t',
lseeksize=8
    alignbytes=4, prototype=define
  Linker and Libraries:
    [...]
    libs=-lnsl -lgdbm -ldb -ldl -lm -lcrypt -lutil -lc -lgdbm_compat
    perllibs=-lnsl -ldl -lm -lcrypt -lutil -lc
    [...]
  Dynamic Linking:
    [...]


Characteristics of this binary (from libperl):
  Compile-time options: HAS_TIMES PERLIO_LAYERS PERL_DONT_CREATE_GVSV
                        PERL_MALLOC_WRAP PERL_PRESERVE_IVUV USE_LARGE_FILES
                        USE_LOCALE USE_LOCALE_COLLATE USE_LOCALE_CTYPE
                        USE_LOCALE_NUMERIC USE_PERLIO USE_PERL_ATOF
  Locally applied patches:
	gentoo/EUMM-RUNPATH - https://bugs.gentoo.org/105054
cpan/ExtUtils-MakeMaker: drop $PORTAGE_TMPDIR from LD_RUN_PATH
	gentoo/EUMM_delete_packlist - Don't install .packlist or perllocal.pod
for perl or vendor
	gentoo/config_over - Remove -rpath and append LDFLAGS to lddlflags
	gentoo/cpan_definstalldirs - Provide a sensible INSTALLDIRS default for
modules installed from CPAN.
	gentoo/cpanplus_definstalldirs - Configure CPANPLUS to use the site
directories by default.
	gentoo/create_libperl_soname - https://bugs.gentoo.org/286840 Set
libperl soname
	gentoo/drop_fstack_protector - https://bugs.gentoo.org/348557 Don't
force -fstack-protector on everyone.
	gentoo/enc2xs - https://bugs.gentoo.org/338802 Tweak enc2xs to ignore
missing @INC directories
	gentoo/mod_paths - Add /etc/perl to @INC
	gentoo/patchlevel - List packaged patches for perl-5.16.3(#1) in
patchlevel.h
	gentoo/aix_soname - aix gcc detection and shared library soname support
	gentoo/solaris-relocation - Fix lddlflags for solaris
	gentoo/opensolars_headers - Add headers for opensolaris
	gentoo/cleanup-paths - Cleanup PATH and shrpenv
	gentoo/usr_local - Remove /usr/local paths
	gentoo/hints_hpux - Fix hpux hints
	gentoo/darwin-cc-ld - https://bugs.gentoo.org/297751 darwin: Use $CC to
link
	gentoo/mint - [perl #89502] Mint fixes
	gentoo/interix - Fix interix hints
	fixes/maketext-code-execution - [1735f6f] http://bugs.gentoo.org/448632
Fix misparsing of maketext strings.
	fixes/cgi-cr-escaping - https://bugs.gentoo.org/443446 CR escaping for
P3P and Set-Cookie headers
	debian/cpan-missing-site-dirs - https://bugs.gentoo.org/422981 Fix
CPAN::FirstTime defaults with nonexisting site dirs if a parent is writable

[...]

>  2. Would you be willing to contribute your patch to Net::SMTP upstream,
>     for example by mailing it to bug-libnet@rt.cpan.org with
>     the string "[rt.cpan.org #93823]" somewhere in the subject line[2]?

I just did s/INET/INET6/g. I don't know Perl, so I guess Seffen Ullrich
could help here more than I can.

Regards
Matthias-Christian
