From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [msysGit] How to reduce remaining differences to 4msysgit? (was What's cooking in git.git (topics))
Date: Mon, 30 Jun 2008 20:47:56 +0200
Message-ID: <200806302047.56935.johannes.sixt@telecom.at>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <4CE52307-A2DE-488B-998B-76D60B66E804@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Mon Jun 30 20:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDOQt-0001Cu-EV
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 20:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYF3SsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 14:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbYF3SsA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 14:48:00 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:35581 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbYF3SsA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 14:48:00 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 2C31F33B4F;
	Mon, 30 Jun 2008 20:47:58 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E398F11195;
	Mon, 30 Jun 2008 20:47:57 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4CE52307-A2DE-488B-998B-76D60B66E804@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86928>

On Montag, 30. Juni 2008, Steffen Prohaska wrote:
> On Jun 30, 2008, at 11:08 AM, Junio C Hamano wrote:
> > * MinGW will be in.
>
> If this is done, we should be able to create the msysgit release
> directly
> from Junio's master.  Hannes changes alone, however, are not sufficient,
> because some commits have been parked in 4msysgit.  Now that MinGW is
> on Junio's next and Junio's next is also on 4msysgit's next, it it easy
> to see how much is left to do by running:
>
>     git diff --stat junio/next..4msysgit/next
>
> junio is a remote pointing to git://git.kernel.org/pub/scm/git/git.git.
> 4msysgit is a remote pointing to git://repo.or.cz/git/mingw/
> 4msysgit.git.
> I attached the output below.
>
> How should we proceed to get rid of the differences?
>
> Should we prepare and send patches directly to the official git list
> now?
> Should we wait until the first MinGW branch is on master?
> Should we prepare a whole patch series?  Maybe Hannes would maintain
> this
> patch series.

Until 1.6.0 is released, a number of _required_ patches will have to be 
included. There are two sorts of them:

* Patches that touch generic code, like replacing c == '/' by is_dir_sep(c).

* Patches that are purly Windows specific.

The former I intend to submit to the mailing list directly and as soon as 
possible (but if I can intervene on newly submitted patches early so that a 
fixup is not even necessary, then even better). The latter I intend to 
collect in a branch and submit as a batch. Let's see how this works out.

Then there are the extra patches in 4msysgit. From my POV, they are not 
_required_ because I can appearently work with git on Windows without them. I 
think some of them are not necessary. Can we go through them again?

And then there are the patches to the t/ directory. I do not target them for 
1.6.0, but I do want to prepare another series with them.

-- Hannes
