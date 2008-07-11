From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/2] help.c: Add support for htmldir relative to git_exec_path()
Date: Fri, 11 Jul 2008 11:02:04 +0200
Message-ID: <1215766924.4877218c5716b@webmail.eunet.at>
References: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de> <1215162566-16062-1-git-send-email-prohaska@zib.de> <7vk5g2uhi9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807041334010.9925@racer> <4668B2FF-2B2B-4221-8151-F0AEA681983C@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHEX0-0008BM-SP
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 11:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYGKJCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 05:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbYGKJCL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 05:02:11 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:51460 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbYGKJCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 05:02:09 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp3.srv.eunet.at (Postfix) with ESMTPS id C851210AD35;
	Fri, 11 Jul 2008 11:02:06 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6B924g6012212;
	Fri, 11 Jul 2008 11:02:04 +0200
Received: from cm56-163-160.liwest.at (cm56-163-160.liwest.at [86.56.163.160]) 
	by webmail.eunet.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Fri, 11 Jul 2008 11:02:04 +0200
In-Reply-To: <4668B2FF-2B2B-4221-8151-F0AEA681983C@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 86.56.163.160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88100>

Zitat von Steffen Prohaska <prohaska@zib.de>:
>
> On Jul 4, 2008, at 2:35 PM, Johannes Schindelin wrote:
>
> > On Fri, 4 Jul 2008, Junio C Hamano wrote:
> >
> >> Could you check if there are copy-and-pasted duplicated code you can
> >> factor out before continuing this direction?
> >
> > Note also that Hannes tried very hard to get rid of those ugly "#ifdef
> > __MINGW32__"s by declaring/overriding functions in git-compat-util.h.
> >
> > I think that is such a good practice that we should not stop here.
>
> I'll send three patches that address Junio's and Dscho's comments:
>
>   [PATCH 1/3] Move code interpreting path relative to exec-dir to new
> function system_path()
>   [PATCH 2/3] help.c: Add support for htmldir relative to
> git_exec_path()
>   [PATCH 3/3] help (Windows): Display HTML in default browser using
> Windows' shell API
>
>
> Hannes,
> the patches I'll send probably conflict with your planned work on
> GIT_EXEC_PATH that has been discussed on the msysgit list.  I think
> you could built on my series and modify system_path().

Thanks. I haven't done a lot in that direction, yet, so your patches will be
helpful.

But according to the conclusion of our recent discussion

http://thread.gmane.org/gmane.comp.version-control.msysgit/2633/focus=2669

I shall modify system_path() to construct paths relative to the git executable,
which is essentially Makefile's $(bindir), not git_exec_path().

-- Hannes
