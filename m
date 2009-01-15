From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 08:27:21 +0100
Message-ID: <496EE559.3060901@viscovery.net>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <1231978322-21228-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 08:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNMep-0005QI-Mk
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 08:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbZAOH13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 02:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbZAOH11
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 02:27:27 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38044 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbZAOH10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 02:27:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LNMdO-0006XH-6q; Thu, 15 Jan 2009 08:27:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CFF7E4FB; Thu, 15 Jan 2009 08:27:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1231978322-21228-1-git-send-email-trast@student.ethz.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105769>

Thomas Rast schrieb:
> Let git-checkout save the old branch as a symref in LAST_HEAD, and
> make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
> the shell.

/me likes this feature.

git rebase (-i or not) calls checkout behind the scenes if the
two-argument form is used:

   git rebase [-i] master topic

and 'topic' is not the current branch. You may want to add a test that
ensures that rebase sets LAST_HEAD in this case.

You must make sure that commits referenced by LAST_HEAD are not
garbage-collected. (I don't know if this happens anyway for symrefs in .git.)

-- Hannes
