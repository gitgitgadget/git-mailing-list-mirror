From: Christopher Faylor <me@cgf.cx>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 12:28:01 -0400
Message-ID: <20051005162801.GC30303@trixie.casa.cgf.cx>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <434299DB.7020805@zytor.com> <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx> <Pine.LNX.4.63.0510050902430.28854@localhost.localdomain> <20051005161546.GB30303@trixie.casa.cgf.cx> <4343FE08.2080607@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 18:32:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENC7l-00058T-QJ
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVJEQ2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVJEQ2F
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:28:05 -0400
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:10191 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1030221AbVJEQ2B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 12:28:01 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 1EA5313C23D; Wed,  5 Oct 2005 16:28:01 +0000 (UTC)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4343FE08.2080607@zytor.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9719>

On Wed, Oct 05, 2005 at 09:23:36AM -0700, H. Peter Anvin wrote:
>Christopher Faylor wrote:
>>Cygwin's rename is much more than just a simple wrapper around MoveFile
>>or MoveFileEx.  It tries hard to guarantee POSIX semantics within the
>>strictures imposed by Windows.
>
>Certainly, but presumably different versions of Win32 have different 
>limitations, no?

Yes, definitely.  That's why the Cygwin rename code (and unlink code for
that matter) is so headache-inducing.

FWIW, I just looked at the source and, AFAICT, if rename() is setting
EPERM on Windows NT/2000/XP, it should be the result of a failing
MoveFileEx (old, new, MOVEFILE_REPLACE_EXISTING).
--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
TimeSys, Inc.
