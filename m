From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am,
 rebase and index-pack
Date: Sat, 12 May 2012 13:36:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205121326380.21030@xanadu.home>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_SA85pjSyCzdvHESNLg64pw)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 19:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STGF8-0000Mx-Td
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 19:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab2ELRga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 13:36:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24535 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab2ELRg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 13:36:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3X00KXF7KSMJ80@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 12 May 2012 13:36:29 -0400 (EDT)
In-reply-to: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197739>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_SA85pjSyCzdvHESNLg64pw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 12 May 2012, Nguyễn Thái Ngọc Duy wrote:

> A few attempts have been made in the past to change 'gc --auto' [1]
> [2]. This is another such attempt.
> 
> Commit d4bb43e (Invoke "git gc --auto" from commit, merge, am and
> rebase. - 2007-09-05) used the rule to put "gc --auto" is "where
> update-ref occurs". I would argue that this is not a good condition to
> run gc, because (at least current) gc is slow. We encourage commit
> often and rebase to make all patches in good shape and this workflow
> should not be interrupted/slowed down by random "gc --auto".
> 
> Instead, we could just inform users that "gc" should be run soon in
> commonly used commands (this patch also reinstates "gc" check in
> commit, which was lost at the sh->C conversion). [1] and [2] can annoy
> users constantly with warnings. This patch shows the warning at most
> once a day.

I agree with this.  However don't bother making this once a day.  There 
is no harm in warning every time.  Referring to the man page as git 
--auto does when it actually meets its treshold wouldn't be a bad thing 
either as incidentally that would contain the info to get rid of the 
warning.


Nicolas

--Boundary_(ID_SA85pjSyCzdvHESNLg64pw)--
