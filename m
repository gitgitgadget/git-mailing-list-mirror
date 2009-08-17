From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 19:09:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5in-0005gq-EN
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbZHQRJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbZHQRJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:09:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:37966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932337AbZHQRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:09:57 -0400
Received: (qmail invoked by alias); 17 Aug 2009 17:09:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 17 Aug 2009 19:09:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FKQ8gfRiFJX2+/JW4e0QaaYIt1gkPvkajzZtmCy
	d7BqWWQ9H9nkbG
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126236>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> Add unix head file, dirent.h, unistd.h  and time.h

These are copied from somewhere.  From where?  What is the license?

> Add MSVC special porting head file msvc.h and msvc.c.

This is added by you.  Logically, that should be a separate patch.

> diff --git a/compat/msvc.h b/compat/msvc.h
> new file mode 100644
> index 0000000..6071565
> --- /dev/null
> +++ b/compat/msvc.h
> @@ -0,0 +1,95 @@
> +#ifndef __MSVC__HEAD
> +#define __MSVC__HEAD
> +
> +#define WINVER 0x0500
> +#define _WIN32_WINNT 0x0500
> +#define _WIN32_WINDOWS 0x0410
> +#define _WIN32_IE 0x0700
> +#define NTDDI_VERSION NTDDI_WIN2KSP1
> +#include <winsock2.h>
> +
> +/*Configuration*/
> +
> +#define NO_PREAD
> +#define NO_OPENSSL
> +#define NO_LIBGEN_H
> +#define NO_SYMLINK_HEAD
> +#define NO_IPV6
> +#define NO_SETENV
> +#define NO_UNSETENV
> +#define NO_STRCASESTR
> +#define NO_STRLCPY
> +#define NO_MEMMEM
> +#define NO_C99_FORMAT
> +#define NO_STRTOUMAX
> +#define NO_MKDTEMP
> +#define NO_MKSTEMPS
> +
> +#define RUNTIME_PREFIX
> +#define NO_ST_BLOCKS_IN_STRUCT_STAT
> +#define NO_NSEC
> +#define USE_WIN32_MMAP
> +#define USE_NED_ALLOCATOR
> +
> +#define NO_REGEX
> +
> +#define NO_SYS_SELECT_H
> +#define NO_PTHEADS
> +#define HAVE_STRING_H 1
> +#define STDC_HEADERS
> +#define NO_ICONV

These would normally be defined in the Makefile.  You might want to state 
that in a comment.

Or maybe move the definitions (along with vsnprintf) to the .vcproj file, 
which is the logical pendant of the Makefile?

> +#define inline __inline
> +#define __inline__ __inline

These definitions are unrelated to the surrounding ones; please move them 
elsewhere.

> +
> +#define SNPRINTF_RETURNS_BOGUS
> +
> +#define SHA1_HEADER "mozilla-sha1\\sha1.h"
> +
> +#define ETC_GITCONFIG "%HOME%"
> +
> +#define NO_PTHREADS
> +#define NO_CURL
> +
> +
> +#define NO_STRTOUMAX
> +#define REGEX_MALLOC
> +
> +
> +#define GIT_EXEC_PATH "bin"
> +#define GIT_VERSION "1.6"
> +#define BINDIR "bin"
> +#define PREFIX "."
> +#define GIT_MAN_PATH "man"
> +#define GIT_INFO_PATH "info"
> +#define GIT_HTML_PATH "html"
> +#define DEFAULT_GIT_TEMPLATE_DIR "templates"
> +
> +#define NO_STRLCPY
> +#define NO_UNSETENV
> +#define NO_SETENV

Would these NO_ definitions not _love_ to be close to their siblings?

What is the reason for those empty lines?  Their placement and amount look 
rather arbitrary to me.

> +#define strdup _strdup
> +#define read _read
> +#define close _close
> +#define dup _dup
> +#define dup2 _dup2
> +#define strncasecmp _strnicmp
> +#define strtoull _strtoui64

vsnprintf could go right here.

> +#define __attribute__(x)

The two inline definitions could go right here.

> +static __inline int strcasecmp (const char *s1, const char *s2)
> +{
> +	int size1=strlen(s1);
> +	int sisz2=strlen(s2);
> +
> +	return _strnicmp(s1,s2,sisz2>size1?sisz2:size1);
> +}
> +
> +#include "compat/mingw.h"
> +#undef ERROR
> +#undef stat
> +#define stat(x,y) mingw_lstat
> +#define stat      _stat64
> +#endif

Looks much nicer now, thanks!

Ciao,
Dscho
