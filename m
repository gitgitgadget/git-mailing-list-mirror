From: Dan Zwell <dzwell@zwell.net>
Subject: git-gui is slow to display a large number of changed/new files
Date: Mon, 29 Jun 2009 16:19:54 -0500
Message-ID: <4A492FFA.5030703@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOO2-0001GK-CG
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbZF2V13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbZF2V12
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:27:28 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:56954 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZF2V11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:27:27 -0400
Received: by pxi28 with SMTP id 28so3644203pxi.33
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=mHOXECT2udO+wxYj373EwIVAqDp9TdZvNL4BPNPl/Bg=;
        b=m8/zgKaJuBZtj5sT+3cwk2Q9TwVzSCnFyLypu3kU92H2go0Xu9k9TqDcFjVB6GVd4C
         7bYD8dNd2hC+gabG6Th4WnqeoQhKCvhb+0OWizS2L919d6RKPgYnEFXB94DuXikiCj9V
         cL0Va+svQiYI6imbZUdfKzaZyAudWHqcSsWtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=N2to26dNFsnmS8RQcs6QT5Uhg8297yBd9YbMo8L3Gs/1CxSM+0uEttgWFsefKFzT7D
         8k4UByHVcAFQFtJje4TEDuQrk+7IxsnYPsqac+2ux/bpSGV49NrVNpDPvGUvfCPo3f4o
         o7du1wePQ1iC+6HqVUcMEZKMvIgOdWt5sHqy0=
Received: by 10.114.95.1 with SMTP id s1mr12542602wab.160.1246310405332;
        Mon, 29 Jun 2009 14:20:05 -0700 (PDT)
Received: from ?192.168.1.103? (c-76-21-120-57.hsd1.ca.comcast.net [76.21.120.57])
        by mx.google.com with ESMTPS id n33sm3874540wag.56.2009.06.29.14.20.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 14:20:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090319)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122460>

Hello,

I was recently working on a project with tens of thousands of generated 
files. The generated directory was not intended to be tracked by git, 
but I had forgotten to add it to .gitignore. When I tried to use 
git-gui, it seemed to hang for about a minute. The problem is that 
creating the icons in the "staged changes" and "unstaged changes" 
windows is very slow. This data is redisplayed after several operations, 
and the lag makes git-gui unusable.

Is this behavior worth changing? I doubt the scenario I encountered is a 
common one. However, I have written a patch to display at most 5000 
changed/new files, warning the user that the list has been truncated. If 
this is a worthy change, I can submit the patch--I can also change it so 
that the maximum number of displayed files is taken from git's 
configuration.

Thanks
-Daniel
