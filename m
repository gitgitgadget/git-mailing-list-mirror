From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as
 well.
Date: Thu, 4 Aug 2005 22:19:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:24:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0mFH-0008NN-Ca
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVHDUWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVHDUTx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:19:53 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30686 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262667AbVHDUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 16:19:15 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C3E31E23EA; Thu,  4 Aug 2005 22:19:14 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A8C25B347E; Thu,  4 Aug 2005 22:19:14 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 90134AAC04; Thu,  4 Aug 2005 22:19:14 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3D611E23EA; Thu,  4 Aug 2005 22:19:14 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 4 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> This may be controversial from the robustness standpoint, so I
>>> am placing it in the proposed update queue first.  Discussions
>>> on the list very welcomed.
>>
>> I'd vote against it: As of now, I can perfectly do
>>
>> export PATH=$PATH:/whereever/my/git/is
>> git-init-db
>>
>> which would not work with this patch.
>
> I take it to mean that you do not mind building but would want
> to try it out before installing.

I'd like to not being forced to install git. Scenario: I have an SSH 
account on a remote machine. I am not root there, but I'd like to 
synchronize my work with git. I can not install git.

> * Make git-init-db create an absolute minimum $GIT_DIR
>   structure itself, if the template directory is not available,
>   possibly with a warning.

This would be exactly what I'd like. Let git-init-db create 
.git/objects/[0-9a-f]{2}/, .git/refs/heads/, .git/refs/tags and .git/HEAD. 
Everything else is taken from the templates directory, if that exists. I 
would not warn if it does not.

Ciao,
Dscho
