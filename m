From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW binary installer available
Date: Thu, 08 Feb 2007 09:09:38 +0100
Organization: eudaptics software gmbh
Message-ID: <45CADAC2.938303B2@eudaptics.com>
References: <45C9E470.7030609@xs4all.nl>
	 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0702071559340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 09:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4Ng-0002fT-Fu
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422961AbXBHILh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 03:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161550AbXBHILe
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:11:34 -0500
Received: from main.gmane.org ([80.91.229.2]:34596 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161551AbXBHILb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 03:11:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HF4LV-0005ti-Rs
	for git@vger.kernel.org; Thu, 08 Feb 2007 09:09:33 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:09:33 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:09:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39041>

Johannes Schindelin wrote:
> Which makes me think if we should just disallow the "git-<builtin>" on
> Windows, since sooner or later, Git will no longer be used from the
> command line on Windows.

But all git scripts still use mostly git-foo instead of git foo :( They
must be changed, too!

> And another thing hit me there: Are you sure that all works well if you
> change the install path from "C:\Program Files\Git" to something else?
> Without explicitely setting GIT_EXEC_PATH?

I think it doesn't matter (mostly). The git wrapper sets the exec path
and augments PATH, so that the scripts work. It uses the directory of
argv[0] if --exec-path is not used. The only problematic cases are where
non-builtins (like git-send-pack) invoke other commands or hooks.

-- Hannes
