From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [msysGit] git rev-parse broken on Git for Windows
Date: Fri, 30 Jul 2010 11:02:15 +0200
Message-ID: <201007301102.15274.trast@student.ethz.ch>
References: <4C526260.6000104@workspacewhiz.com> <alpine.DEB.1.00.1007301022310.2983@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Scrivano <gscrivano@gnu.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	<msysgit@googlegroups.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 11:02:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OelU0-0000WX-BD
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 11:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab0G3JCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 05:02:18 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:2578 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab0G3JCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 05:02:18 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 11:02:16 +0200
Received: from thomas.site (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul
 2010 11:02:16 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.1007301022310.2983@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152234>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 29 Jul 2010, Joshua Jensen wrote:
> 
> >  9c7304e3e39ed397b3cc6566573333e2698a52b4 (print the usage string on stdout
> > instead of stderr) and then 47e9cd28f8a404a0d6293935252ddca5fc243931
> > (parseopt: wrap rev-parse --parseopt usage for eval consumption) break the
> > following line from the manual and 'git subtree' on msysGit:
> > 
> > eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)
> 
> Both commits are from Junio's 'next' branch. I Cc:ed the authors of both 
> commits.

Can you elaborate on "break"?

Because as you can see in git-sh-setup.sh, the "official" user of
parseopt does

	eval "$(
		echo "$OPTIONS_SPEC" |
			git rev-parse --parseopt $parseopt_extra -- "$@" ||
		echo exit $?
	)"

So AFAICS they only differ in the quoting.  And the latter works.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
