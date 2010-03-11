From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] General configuration portability (Resend)
Date: Thu, 11 Mar 2010 17:51:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003111750130.3748@intel-tinevez-2-302>
References: <20100311162750.GA7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 17:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NplbS-0000Ez-Nw
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 17:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295Ab0CKQvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 11:51:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:51733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933291Ab0CKQvM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 11:51:12 -0500
Received: (qmail invoked by alias); 11 Mar 2010 16:51:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 11 Mar 2010 17:51:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19w1YZ3QDdwbaYdvIRl/4aCdTEKVd2KED2Qj/smqk
	oZF/lXdcoTZS9z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100311162750.GA7877@thor.il.thewrittenword.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141987>

Hi,

On Thu, 11 Mar 2010, Gary V. Vaughan wrote:

> Resending some patches that didn't make it, in the correct format
> and taking into account the feedback I already had on one of the
> later patches...
> 
> This patch is in part to deal with peculiarities of our build
> environment (software packages are installed in their own directory
> tree, for example, and oftentimes we need to set additional -I options
> in CPPFLAGS, or -L options in LDFLAGS, among others).
> 
> However this is also where we put configuration changes to add
> additional tests, or fix Makefile problems so that everything builds
> on all of our supported architectures.  Probably, much of this patch
> is useful upstream.
> ---
>  Makefile             |   50 +++++++++++++++++++++++++++++++++++++++---------
>  aclocal.m4           |   41 ++++++++++++++++++++++++++++++++++++++++
>  config.mak.in        |   10 ++++++++-
>  configure.ac         |   51 ++++++++++++++++++++++++++++++++++++++++++-------
>  git-compat-util.h    |    8 +++++-
>  perl/Makefile        |    3 +-
>  perl/Makefile.PL     |    2 +-
>  t/t7610-mergetool.sh |   25 +++++++++++++----------
>  8 files changed, 156 insertions(+), 34 deletions(-)
>  create mode 100644 aclocal.m4

Whoa.

Pretty large patch, no? And looking at things like this:

> diff --git a/Makefile b/Makefile
> index 8fdc421..6058805 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -243,7 +243,7 @@ endif
>  
>  CFLAGS = -g -O2 -Wall
>  LDFLAGS =
> -ALL_CFLAGS = $(CFLAGS)
> +ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)

It seems to me that this wants to be a relatively large patch series of 
well-contained, easy-to-review, tiny patches.

Am I correct?
Dscho
