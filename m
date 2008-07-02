From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [msysGit] Re: [PATCH 12/12] [TODO] setup: bring changes from 4msysgit/next to next
Date: Wed, 2 Jul 2008 21:32:27 +0200
Message-ID: <200807022132.27751.johannes.sixt@telecom.at>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <alpine.DEB.1.00.0807021716030.9925@racer> <D35A2542-3943-4BDB-AEDA-0F8B7052EF7D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Wed Jul 02 21:33:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE853-00084l-I9
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYGBTca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbYGBTca
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:32:30 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:60834 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYGBTc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:32:29 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 0D57113A311;
	Wed,  2 Jul 2008 21:32:28 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CD41A1221E;
	Wed,  2 Jul 2008 21:32:27 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <D35A2542-3943-4BDB-AEDA-0F8B7052EF7D@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87184>

On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> On Jul 2, 2008, at 6:17 PM, Johannes Schindelin wrote:
> > On Wed, 2 Jul 2008, Steffen Prohaska wrote:
> >> From: Johannes Sixt <johannes.sixt@telecom.at>
> >>
> >> Hannes,
> >> You introduced "minoffset" in 861429a7c37c7.
> >
> > AFAICT it was redone differently in 'next', because 'next' has this
> > ceiling dir thingie, which allows a different (much smaller) patch.
> >
> > It might be more sensible to base your patch series on 'next'...
>
> Hmm.. it is based on next.  But obviously I needed to merge
> mingw's master to 4msysgit's master and resolve conflicts.
> Maybe I made the wrong decisions then.
>
> Hannes,
> If you believe that your setup.c is good, then I'll copy your version
> to 4msysgit's master.

The setup.c in mingw.git (and soon Junio's master) and Junio's next are 
_different_, but both are correct. If you reverse-apply the patch you 
presented here, then you get the version from Junio's next, which is a good 
state.

[ Of course, the result will work only as long as you do not set 
GIT_CEILING_DIRECTORIES, because we haven't taken care of the helper 
functions that this feature uses, longest_ancestor_length() and 
normalize_path(). ]

We have debated about set_git_dir(".") in the past. mingw.git doesn't have it, 
and it works (for me). I don't know what it is needed for.

-- Hannes
