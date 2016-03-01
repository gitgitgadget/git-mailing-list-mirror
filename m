From: greg0ire <postmaster@greg0ire.fr>
Subject: Bypassing hooks while cherry-picking
Date: Tue, 1 Mar 2016 12:01:53 +0100
Message-ID: <56D576A1.3020202@greg0ire.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 12:10:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaiC7-0002mO-5h
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 12:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbcCALKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 06:10:12 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:46463 "EHLO
	19.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbcCALKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 06:10:11 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Mar 2016 06:10:11 EST
Received: from mail179.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id 26BD21004577
	for <git@vger.kernel.org>; Tue,  1 Mar 2016 12:01:56 +0100 (CET)
Received: from localhost (HELO queueout) (127.0.0.1)
	by localhost with SMTP; 1 Mar 2016 13:01:56 +0200
Received: from str75-1-78-192-188-179.fbxo.proxad.net (HELO ?10.0.1.245?) (postmaster@greg0ire.fr@78.192.188.179)
  by ns0.ovh.net with SMTP; 1 Mar 2016 13:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
X-Ovh-Tracer-Id: 8548395044352331230
X-Ovh-Remote: 78.192.188.179 (str75-1-78-192-188-179.fbxo.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekjedrjedtucetufdoteggodftvfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekjedrjedtgddvtdcutefuodetggdotffvucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288009>

Hello,

using git 2.1.4 here, and it seems there is no option to bypass 
pre-commit hooks while cherry-picking, while git commit provides a 
--no-verify option. I ended up doing this to disable hooks while cherry 
picking :

     test -f "$GIT_DIR"/CHERRY_PICK_HEAD && exit 0

Wouldn't it be best to add the --no-verify option to cherry-pick too?
I had a conflict when cherry-picking the commit, maybe this does not 
happen otherwise?

Steps to reproduce :

1. create a pre-commit hook
2. create a commit that fails the hook, and bypass the hook
3. checkout another branch
4. might be optional : create a conflicting change with the previously 
created commit
5. cherry-pick the commit
6. might be optional : solve the conflick and use git cherry-pick --continue

Regards,

--
greg0ire
