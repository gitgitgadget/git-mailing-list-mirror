From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Sun, 3 Aug 2008 22:12:11 +0200
Message-ID: <20080803201211.GA11121@steel.home>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <4891B872.3040707@panasas.com> <20080731183732.GA7598@steel.home> <32541b130807311155v50ee6ddaha1bba2f56e9bd61d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boaz Harrosh <bharrosh@panasas.com>, cte <cestreich@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPjxJ-0001iO-T0
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbYHCUMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755831AbYHCUMV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:12:21 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:50461 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070AbYHCUMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:12:20 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf4ErWSQ==
Received: from tigra.home (Fabb4.f.strato-dslnet.de [195.4.171.180])
	by post.webmailer.de (mrclete mo13) (RZmta 16.47)
	with ESMTP id y064edk73FInN8 ; Sun, 3 Aug 2008 22:12:15 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0AF89277BD;
	Sun,  3 Aug 2008 22:12:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DA39856D2A; Sun,  3 Aug 2008 22:12:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130807311155v50ee6ddaha1bba2f56e9bd61d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91263>

Avery Pennarun, Thu, Jul 31, 2008 20:55:26 +0200:
> On 7/31/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Boaz Harrosh, Thu, Jul 31, 2008 15:04:50 +0200:
> > > Produce a C file and header that defines some stable API to your
> >  > GUI application, that does not expose any git internal headers.
> >  > Then compile that, say git_api.c, with C compiler in Makefile
> >  > and extern "C" link that file to your C++ application. This will
> >  > completely insulate you from any git code.
> >
> > no, it wont. He still have to resolve name conflicts at the link time.
> 
> Language keywords (as opposed to function names) like 'new' and
> 'typename' are definitely not exported to the object files.  Moreover,
> function parameter names aren't either.
> 

Didn't mean them. Meant the globally visible names. libgit does not
use a prefix for its exported symbols. They will clash with the
symbols of the programs it is linked to.
