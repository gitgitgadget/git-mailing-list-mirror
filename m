From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 11/11] mingw: compile git-daemon
Date: Fri, 27 Nov 2009 22:17:22 +0100
Message-ID: <200911272217.22271.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-11-git-send-email-kusmabite@gmail.com> <1259196260-3064-12-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	dotzenlabs@gmail.com, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Nov 27 22:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE8CK-0001Oi-RL
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 22:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbZK0VRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbZK0VR3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 16:17:29 -0500
Received: from [93.83.142.38] ([93.83.142.38]:63894 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750883AbZK0VR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 16:17:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5B0CE19F60D;
	Fri, 27 Nov 2009 22:17:22 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1259196260-3064-12-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133940>

On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -352,6 +352,7 @@ EXTRA_PROGRAMS =
>
>  # ... and all the rest that could be moved out of bindir to gitexecdir
>  PROGRAMS += $(EXTRA_PROGRAMS)
> +PROGRAMS += git-daemon$X
>  PROGRAMS += git-fast-import$X
>  PROGRAMS += git-hash-object$X
>  PROGRAMS += git-imap-send$X
> @@ -981,6 +982,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
>  	NO_REGEX = YesPlease
>  	BLK_SHA1 = YesPlease
> +	NO_INET_PTON = YesPlease
> +	NO_INET_NTOP = YesPlease
>  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>  	# We have GCC, so let's make use of those nice options
> @@ -1079,9 +1082,6 @@ ifdef ZLIB_PATH
>  endif
>  EXTLIBS += -lz
>
> -ifndef NO_POSIX_ONLY_PROGRAMS
> -	PROGRAMS += git-daemon$X
> -endif
>  ifndef NO_OPENSSL
>  	OPENSSL_LIBSSL = -lssl
>  	ifdef OPENSSLDIR

You should remove NO_POSIX_ONLY_PROGRAMS from MSVC and MinGW sections.

-- Hannes
