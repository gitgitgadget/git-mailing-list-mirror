From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: Re: [PATCH 1/2 (v2)] submodule: no [--merge|--rebase] when newly cloned
Date: Thu, 17 Feb 2011 15:17:15 -0700
Message-ID: <201102171517.15906.olsonse@umich.edu>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu> <4D5D7A06.6050700@web.de> <7vzkpu9zo0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 23:17:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqCAE-00050C-30
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 23:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab1BQWRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 17:17:25 -0500
Received: from smtp.mail.umich.edu ([141.211.14.81]:54827 "EHLO
	hackers.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1BQWRY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 17:17:24 -0500
X-Greylist: delayed 78937 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Feb 2011 17:17:23 EST
Received: FROM localhost (cadash.gpcc.itd.umich.edu [141.211.2.218])
	By hackers.mr.itd.umich.edu ID 4D5D9E70.2EFC8.16223 ;
	Authuser olsonse;
	17 Feb 2011 17:17:20 EST
User-Agent: KMail/1.9.4
In-Reply-To: <7vzkpu9zo0.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167129>

This looks fine by me.

What about the testing patch?  It'll be a few hours before I can resubmit 
with "git submodule status submodule" changed to "git status -s submodule".



On Thursday 17 February 2011 13:25, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> > Am 17.02.2011 17:18, schrieb Spencer E. Olson:
> >> Previously, when a new submodule is cloned by running "git submodule
> >> update [--merge|--rebase]", the newly cloned submodule does not get
> >> checked out and a rebase or merge is incorrectly attempted against an
> >> empty working directory. This patch ignores --rebase or --merge for new
> >> submodules and instead simply checks out the appropriate revision.
> >
> > Nice work, thanks!
> >
> > Just a small thing: This problem also happens when the configuration
> > "submodule.<name>.update" is set to either "rebase" or "merge", not only
> > when using the command line options. So perhaps you could reword the
> > topic to something like "submodule: don't merge or rebase when newly
> > cloned" and adjust both commit messages a bit?
>
> I tentatively queued with this rewrite (the patch text is the same as the
> one I sent previously).
>
>     From: Spencer E. Olson <olsonse@umich.edu>
>     Date: Thu, 17 Feb 2011 09:18:45 -0700
>     Subject: [PATCH] submodule: no [--merge|--rebase] when newly cloned
>
>     "git submodule update" can be run with either the "--merge" or
> "--rebase" option, or submodule.<name>.update configuration variable can be
> set to "merge" or "rebase, to cause local work to get integrated when
> updating the submodule.
>
>     When a submodule is newly cloned, however, it does not have a check out
>     when a rebase or merge is attempted, leading to a failure.  For newly
>     cloned submodules, simply check out the appropriate revision.  There is
> no local work to integrate with for them.
>
>     Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
>     Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
