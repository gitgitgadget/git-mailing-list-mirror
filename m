From: Volker Braun <vbraun.name@gmail.com>
Subject: Compile fails on OSX 10.9 with FSF GCC in common crypto
Date: Fri, 3 Oct 2014 10:41:08 +0000 (UTC)
Message-ID: <loom.20141003T123307-243@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 12:45:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa0MN-00073Y-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 12:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbaJCKpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 06:45:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:42476 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaJCKpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 06:45:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Xa0MB-0006zn-Dd
	for git@vger.kernel.org; Fri, 03 Oct 2014 12:45:03 +0200
Received: from dhcp-163-1-81-56.maths.ox.ac.uk ([163.1.81.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 12:45:03 +0200
Received: from vbraun.name by dhcp-163-1-81-56.maths.ox.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 12:45:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 163.1.81.56 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257836>

* Works with Apple clang
* Works with FSF GCC and NO_APPLE_COMMON_CRYPTO=yes.
* Fails with FSF GCC, see below
* FWIW, git-1.8.4.4 can be compiled with FSF GCC

$ gcc --version
gcc (GCC) 4.7.3
Copyright (C) 2012 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ ./configure 
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking how to run the C preprocessor... cpp
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for size_t... yes
checking for working alloca.h... yes
checking for alloca... yes
configure: CHECKS for programs
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking for inline... inline
checking if linker supports -R... no
checking if linker supports -Wl,-rpath,... yes
checking for gtar... no
checking for tar... tar
checking for gnudiff... no
checking for gdiff... no
checking for diff... diff
checking for asciidoc... no
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... yes
checking for curl_global_init in -lcurl... yes
checking for XML_ParserCreate in -lexpat... yes
checking for iconv in -lc... no
checking for iconv in -liconv... yes
checking for deflateBound in -lz... yes
checking for socket in -lc... yes
checking for inet_ntop... yes
checking for inet_pton... yes
checking for hstrerror... yes
checking for basename in -lc... yes
checking for gettext in -lc... no
checking libintl.h usability... no
checking libintl.h presence... no
checking for libintl.h... no
configure: CHECKS for header files
checking sys/select.h usability... yes
checking sys/select.h presence... yes
checking for sys/select.h... yes
checking sys/poll.h usability... yes
checking sys/poll.h presence... yes
checking for sys/poll.h... yes
checking for inttypes.h... (cached) yes
checking for old iconv()... no
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for socklen_t... yes
checking for struct dirent.d_ino... yes
checking for struct dirent.d_type... yes
checking for struct passwd.pw_gecos... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking whether the platform regex can handle null bytes... yes
checking whether system succeeds to read fopen'ed directory... no
checking whether snprintf() and/or vsnprintf() return bogus value... no
configure: CHECKS for library functions
checking libgen.h usability... yes
checking libgen.h presence... yes
checking for libgen.h... yes
checking paths.h usability... yes
checking paths.h presence... yes
checking for paths.h... yes
checking libcharset.h usability... yes
checking libcharset.h presence... yes
checking for libcharset.h... yes
checking for strings.h... (cached) yes
checking for locale_charset in -liconv... yes
checking for strcasestr... yes
checking for library containing strcasestr... none required
checking for memmem... yes
checking for library containing memmem... none required
checking for strlcpy... yes
checking for library containing strlcpy... none required
checking for uintmax_t... yes
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for mkstemps... yes
checking for library containing mkstemps... none required
checking for initgroups... yes
checking for library containing initgroups... none required
checking for POSIX Threads with ''... yes
configure: creating ./config.status
config.status: creating config.mak.autogen
config.status: executing config.mak.autogen commands

$ make
GIT_VERSION = 2.1.2
    * new build flags
    CC credential-store.o
In file included from git-compat-util.h:324:0,
                 from cache.h:4,
                 from credential-store.c:1:
compat/apple-common-crypto.h: In function 'git_CC_EVP_EncodeBlock':
compat/apple-common-crypto.h:32:2: error: unknown type name 
'SecTransformRef'
compat/apple-common-crypto.h:36:37: error: 'kSecBase64Encoding' undeclared 
(first use in this 
function)
compat/apple-common-crypto.h:36:37: note: each undeclared identifier is 
reported only once for each 
function it appears in
compat/apple-common-crypto.h:40:36: error: 'kSecTransformInputAttributeName' 
undeclared (first use in 
this function)
compat/apple-common-crypto.h:44:9: warning: assignment makes pointer from 
integer without a cast 
[enabled by default]
compat/apple-common-crypto.h:52:2: warning: passing argument 1 of 
'CFRelease' makes pointer from 
integer without a cast [enabled by default]
In file included from 
/System/Library/Frameworks/Security.framework/Headers/SecAsn1Types.h:42:0,
                 from 
/System/Library/Frameworks/Security.framework/Headers/oidsalg.h:29,
                 from 
/System/Library/Frameworks/Security.framework/Headers/Security.h:44,
                 from compat/apple-common-crypto.h:14,
                 from git-compat-util.h:324,
                 from cache.h:4,
                 from credential-store.c:1:
/System/Library/Frameworks/CoreFoundation.framework/Headers/CFBase.h:535:6: 
note: expected 'CFTypeRef' 
but argument is of type 'int'
In file included from git-compat-util.h:324:0,
                 from cache.h:4,
                 from credential-store.c:1:
compat/apple-common-crypto.h: In function 'git_CC_EVP_DecodeBlock':
compat/apple-common-crypto.h:62:2: error: unknown type name 
'SecTransformRef'
compat/apple-common-crypto.h:66:37: error: 'kSecBase64Encoding' undeclared 
(first use in this 
function)
compat/apple-common-crypto.h:70:36: error: 'kSecTransformInputAttributeName' 
undeclared (first use in 
this function)
compat/apple-common-crypto.h:74:9: warning: assignment makes pointer from 
integer without a cast 
[enabled by default]
compat/apple-common-crypto.h:82:2: warning: passing argument 1 of 
'CFRelease' makes pointer from 
integer without a cast [enabled by default]
In file included from 
/System/Library/Frameworks/Security.framework/Headers/SecAsn1Types.h:42:0,
                 from 
/System/Library/Frameworks/Security.framework/Headers/oidsalg.h:29,
                 from 
/System/Library/Frameworks/Security.framework/Headers/Security.h:44,
                 from compat/apple-common-crypto.h:14,
                 from git-compat-util.h:324,
                 from cache.h:4,
                 from credential-store.c:1:
/System/Library/Frameworks/CoreFoundation.framework/Headers/CFBase.h:535:6: 
note: expected 'CFTypeRef' 
but argument is of type 'int'
make: *** [credential-store.o] Error 1
