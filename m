From: Henning Moll <newsScott@gmx.de>
Subject: protect branches against deletion from remote
Date: Sat, 14 Mar 2015 19:28:40 +0100
Message-ID: <55047DD8.703@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 14 19:28:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWqnq-0000FC-AQ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 19:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbbCNS2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 14:28:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:60426 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbbCNS2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 14:28:43 -0400
Received: from [192.168.178.22] ([88.217.113.107]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LhTjQ-1ZJKht2A2S-00mXdS for <git@vger.kernel.org>;
 Sat, 14 Mar 2015 19:28:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Provags-ID: V03:K0:qrag4R24G8lA6expRXYAnWTzIZx4oZIa+o9Pt5Co+lCbXmheKaN
 LGp6kCGAlJUmm/rvKaA42wHZfoikmzKn1cbRXp05hkL3NsZ2SIcCm0pzfMNpR/QWTwftiXw
 Of9afvvxD7JwECb2K1b3SVgAPv2Z3RU+TABziyHtXl16Y++VkB95gXOF2N91ckKZXWQ/UkX
 Bewwm27WoPahHIk1aTL6w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265456>

Hi,

If you try to delete a local branch "feature" which is not merged into 
another branch, you will get the following warning:

. error: The branch 'feature' is not fully merged.
. If you are sure you want to delete it, run 'git branch -D feature'.

If a local branch is worth to be protected in such a way, why not the 
remote tracking one:

$ git push origin :feature

no warning, just deleted.

Well i can set "receive.denyDeletes" on the remote repository, but this 
completely removes the ability to delete remote branches.

How to achieve a similar behavior as with local branches?

(BTW. with "git push . :feature" it is also possible to force deletion 
of local, unmerged branches)

Best regards
Henning
