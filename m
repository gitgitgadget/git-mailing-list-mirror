From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to pull remote branch with specified commit id?
Date: Tue, 13 Jan 2009 10:43:16 +0100
Message-ID: <496C6234.9040903@viscovery.net>
References: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 10:44:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMfpE-0003rd-46
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 10:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbZAMJnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 04:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZAMJnU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 04:43:20 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59077 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbZAMJnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 04:43:19 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LMfno-00086e-UI; Tue, 13 Jan 2009 10:43:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A9FC36D9; Tue, 13 Jan 2009 10:43:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105481>

Emily Ren schrieb:
> Git experts,
> 
> I want to pull remote branch with specified commit id, how to do it?
> 
> Below command can get remote branch
> $git pull remote refs/heads/$branch_name
> 
> Below command doesn't work
> $git pull remote objects/$commit_id

You can't, and that is so by design.

Consider this: You accidentally push a branch with confidential data to a
public repository. You notice it early, and quickly delete the branch
using 'git push the-repo :refs/heads/that-branch'. At this time the
objects with the confidential data are still lingering in the public
repository. But with the current behavior noone can access them even if
the SHA1 happens to be known.

-- Hannes
