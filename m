From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 2/2] Port to QNX
Date: Sun, 16 Dec 2012 09:27:05 +0100
Message-ID: <kak0kr$cf6$1@ger.gmane.org>
References: <1355510300-31541-1-git-send-email-kraai@ftbfs.org> <1355510300-31541-3-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 09:28:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk9ak-00006Q-Dn
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 09:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab2LPI1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 03:27:21 -0500
Received: from plane.gmane.org ([80.91.229.3]:57959 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab2LPI1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 03:27:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Tk9ZL-0007al-Gm
	for git@vger.kernel.org; Sun, 16 Dec 2012 09:27:31 +0100
Received: from dsdf-4db5c45f.pool.mediaways.net ([77.181.196.95])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 09:27:31 +0100
Received: from jojo by dsdf-4db5c45f.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 09:27:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db5c45f.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211584>

Matt Kraai wrote:
> From: Matt Kraai <matt.kraai@amo.abbott.com>
>
> Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
> ---
> Makefile          | 19 +++++++++++++++++++
> git-compat-util.h |  8 ++++++--
> 2 files changed, 25 insertions(+), 2 deletions(-)
>

snip

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 2e79b8a..6c588ca 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -75,7 +75,7 @@
> # endif
> #elif !defined(__APPLE__) && !defined(__FreeBSD__) &&
>       !defined(__USLC__) && \ !defined(_M_UNIX) && !defined(__sgi) &&
> !defined(__DragonFly__) && \ -      !defined(__TANDEM)
> +      !defined(__TANDEM) && !defined(__QNX__)
> #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
> needs 600 for S_ISLNK() */ #define _XOPEN_SOURCE_EXTENDED 1 /* AIX
> 5.3L needs this */ #endif
> @@ -99,7 +99,7 @@
> #include <stdlib.h>
> #include <stdarg.h>
> #include <string.h>
> -#ifdef __TANDEM /* or HAVE_STRINGS_H or !NO_STRINGS_H? */
> +#if defined(__TANDEM) || defined(__QNX__) /* or HAVE_STRINGS_H or
> !NO_STRINGS_H? */ #include <strings.h> /* for strcasecmp() */

There's another recent thread, discussing to change this to "#ifdef 
HAVE_STRING_H" plus the infrastructure in Makefile and configure.ac.

Bye, Jojo 
