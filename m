From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: Missing pieces for 1.6.0 on MinGW?
Date: Sun,  3 Aug 2008 11:16:25 +0200
Message-ID: <1217754985.4895776973fda@webmail.nextra.at>
References: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 11:19:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPZkH-0004B7-4L
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 11:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYHCJQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 05:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYHCJQb
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 05:16:31 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:52951 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbYHCJQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 05:16:31 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp4.srv.eunet.at (Postfix) with ESMTPS id CF5D397209;
	Sun,  3 Aug 2008 11:16:28 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m739GPCo005257;
	Sun, 3 Aug 2008 11:16:27 +0200
Received: from 77.117.130.90 ([77.117.130.90]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sun,  3 Aug 2008 11:16:25 +0200
In-Reply-To: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.130.90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91219>

Zitat von Junio C Hamano <gitster@pobox.com>:
> Just a quick question before the weekend ends and -rc2 gets tagged.  (I
> lost track of that argv0 vs bin/git vs libexec/git-core/git-foo
> discussion).
>
> Are there any missing but necessary patches we need before 1.6.0 for
> MinGW?

Yes, there are some open issues:

(1) git-gui was fixed for the msysgit installer, but it broke for me; but I
think I know where to fix it.

(2) the non-builtins in $(bindir) don't set argv0_path, and consequently don't
find ETC_GITCONFIG.

(3) the 'mingw_main undefined' error is still a mystery. I'm about to send a
preprocessed file to Steffen (it's a bit large, even compressed, so I'll do
that in a private mail).

Item (1) I expect to work on later today, but needs some investigation by
Steffen and perhaps Shawn. (2) is probably a minor issue. (3) is, well, a
mystery, although Steffen's patch works for me, too. Nevertheless, I'd like to
know why my original approach does not always work.

-- Hannes
