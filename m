From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git.exe diff-index --cached --raw HEAD can not show unmerged
 file at    delete conflict case.
Date: Fri, 27 Feb 2009 16:28:46 +0100
Message-ID: <49A806AE.7010402@viscovery.net>
References: <1976ea660902270653p3b144231h86b98244173d09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 16:30:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld4fM-00071r-Qu
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 16:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbZB0P2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 10:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbZB0P2u
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 10:28:50 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58069 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928AbZB0P2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 10:28:50 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ld4dq-00065H-K5; Fri, 27 Feb 2009 16:28:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 505786C4; Fri, 27 Feb 2009 16:28:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1976ea660902270653p3b144231h86b98244173d09@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111677>

Frank Li schrieb:
> $ git ls-files -u
> 100644 658b87c67a68f0b17a835c66ab735e4bbcc5b3ab 1       rb1.txt
> 100644 e776c70dbc6ea929021515cf4d45a207a2f56517  3       rb1.txt
> 
> 
> but use git.exe diff-index  --cached --raw HEAD
> show nothing.

That's correct, AFAICS. You have a delete/modify conflict. You deleted
rb1.txt locally, yet the branch that you merged in modified it.

HEAD does not have the file, nor is it in the index in stage 0 nor stage 2
("ours"). There is nothing to compare.

-- Hannes
