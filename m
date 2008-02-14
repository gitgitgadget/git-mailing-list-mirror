From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: another git rebase -i problem
Date: Thu, 14 Feb 2008 15:39:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141537000.30505@racer.site>
References: <20080214093730.GA20408@digi.com> <alpine.LSU.1.00.0802141232070.30505@racer.site> <20080214130228.GB28472@digi.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1894166973-1203003576=:30505"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 16:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPgD7-0002SB-6q
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 16:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbYBNPjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 10:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756292AbYBNPjk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 10:39:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:45060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753250AbYBNPji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 10:39:38 -0500
Received: (qmail invoked by alias); 14 Feb 2008 15:39:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 14 Feb 2008 16:39:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r2l0596lrCpNw4+IFti46PWzXbk+v2QlPFN/IIm
	xPy66Rc6X0G4Xh
X-X-Sender: gene099@racer.site
In-Reply-To: <20080214130228.GB28472@digi.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73882>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1894166973-1203003576=:30505
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 14 Feb 2008, Uwe Kleine-König wrote:

> Ah, OK this disqualifies my test case, but the problem is real:
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index e5ed745..f0499e6 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -362,4 +362,11 @@ test_expect_success 'rebase with a file named HEAD in worktree' '
>  
>  '
>  
> +test_expect_success 'rebase patch already merged' '
> +
> +	git checkout -b branch4 twerp &&
> +	FAKE_LINES="1 2 4 3" git rebase -i branch3
> +
> +'
> +
>  test_done

Since the patches were already applied, but git (as well as you!) failed 
to remove them from the patch list, the user has to be asked to skip the 
patch.

Unfortunately, I have no time to look into this, and I do not even think 
that cherry-pick tells me if a patch was already applied (as opposed to a 
failed patch application), so I doubt that the message can be made more 
meaningful.

Anyway, your "problem" is that you have to say "git rebase --skip", 
because the patch has been applied to upstream already (but looked 
differently enough that the patch id was different).

Ciao,
Dscho

---1463811741-1894166973-1203003576=:30505--
