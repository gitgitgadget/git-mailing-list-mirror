From: Dana How <danahow@gmail.com>
Subject: [PATCH 0/8] git-repack --max-pack-size
Date: Sun, 08 Apr 2007 16:17:40 -0700
Message-ID: <46197814.5010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hagdw-0006OO-Al
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbXDHXRo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbXDHXRo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:17:44 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:61856 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXDHXRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:17:43 -0400
Received: by py-out-1112.google.com with SMTP id a29so896335pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:17:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=EhA2Oxo5djGoysMR0Ir8rhXjb8wjSo+0dbRPo5z1ZWDPUSFYWtyNX/27QKcJJPDyb68EGHcbzYIGMiPKScLKakmSAZLUuBwiNOUUbzVFq/SOWHB0Kb2tdL+MkeXfentiR2YWmKvbAGgd/ZxzJbKyVTY+rNGnFejB2x0Kii6ds4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ExkLy5gC8WTERX3w78yR7U2taSgLhMz9P8+ykShlcvyIAms+5emVSk+SBrziEePPB243AgYjYVS8Z/dqRmdl16zKXU7kCaAZKplX5Zl+eddEWNnPywkIZ/hYDwxcgdAhKaQUNLUfdp1f3KCpmCXh0sxwF4/1o1LgOd8x56u0o3Y=
Received: by 10.35.106.1 with SMTP id i1mr10089335pym.1176074263084;
        Sun, 08 Apr 2007 16:17:43 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id j7sm8814345nzd.2007.04.08.16.17.41;
        Sun, 08 Apr 2007 16:17:42 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44009>


The three most common ways of making large packfiles
are git-fast-import, the first git-repack, or git-repack -a.
The first already supports a "--max-pack-size=N" option,
which limits the resulting packfiles to N megabytes.
This patchset adds the same option, with the same
behavior, to git-repack to handle the other two cases.

After reviewing others' comments,  this latest patchset
touches 2/3 fewer files and 1/6 fewer lines,  and
introduces no behavior not seen elsewhere in git.
