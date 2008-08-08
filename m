From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 3/3 v2] Enable parallel tests
Date: Fri, 8 Aug 2008 17:03:59 +0200
Message-ID: <20080808150359.GA25106@leksak.fem-net>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> <489BF95F.1070000@lsrfire.ath.cx> <alpine.DEB.1.00.0808081236010.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808081302180.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 17:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRTWe-0007PR-Lc
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 17:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYHHPEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 11:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYHHPEE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 11:04:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:44552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751967AbYHHPEC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 11:04:02 -0400
Received: (qmail invoked by alias); 08 Aug 2008 15:04:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp059) with SMTP; 08 Aug 2008 17:04:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+4b4U/dIi4Y64Cu+jAnIxnzzZQ0btFDF4oS3bFYP
	9ymgOloMg+us4X
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KRTVX-0006Xi-Of; Fri, 08 Aug 2008 17:03:59 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808081302180.9611@pacific.mpi-cbg.de.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91678>

Hi,

Johannes Schindelin wrote:
> @@ -485,7 +490,8 @@ fi
>  . ../GIT-BUILD-OPTIONS
>  
>  # Test repository
> -test="trash directory"
> +test="trash directory.$(basename "$0" .sh)"
> +remove_trash="$(pwd)/$test"
>  rm -fr "$test" || {
>  	trap - exit
>  	echo >&5 "FATAL: Cannot prepare test area"

Please also change t/README, there is a text like:

  [...]
   database and chdir(2) into it.  This directory is 't/trash directory'
   if you must know, but I do not think you care.

If the subdirectory variant is chosen ("trash directory/foo/" instead
of "trash directory.foo/"), then

   This directory is below 't/trash directory'."

could be sufficient.

Btw, Junio, about the passage: "I do not think you care" -- I cared :)
Sometimes it's nice to change to 'trash directory' and do git log, git diff,
git show or whatever.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
