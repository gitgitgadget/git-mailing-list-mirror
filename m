From: Dana How <danahow@gmail.com>
Subject: [PATCH 0/8] git-repack --max-pack-size
Date: Mon, 30 Apr 2007 16:16:07 -0700
Message-ID: <463678B7.70409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hif6P-0000bk-OS
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbXD3XQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbXD3XQM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:16:12 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:44831 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbXD3XQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:16:11 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2083712nzf
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:16:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=mcSXX0HUkrbLLjpfXyd7iZ8X220YBaP6c5YWB+8Q+T99HoWwjZNIBDjGh1F30+vCloff+WsqHu3XVoMfV+iSjYB01CJw2pF3o0AChGL0cdDbcVSZBLQhPvBbipUwSnH4u9+W2GztyYDZGen4Qw1FhWTD/XoONDyiy5rbBJW0VuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=dESnYuREVUOiTTys4IAP6o2fHFijvgJexC57qhBUK0TC9PP4mKO9BtBbNqD2/qaZ0evVrNOTAxTgqxo3KZcpuU1HffSkEj5rZLJXWGrXbc3Ob/0M2ws858zoiQCZ5bIaQ+URw3oamMaGzRCPadxpTQr2yZ5jvtBsnU7xlLUuA4Y=
Received: by 10.65.192.16 with SMTP id u16mr12903836qbp.1177974970385;
        Mon, 30 Apr 2007 16:16:10 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 18sm23006701nzo.2007.04.30.16.16.08;
        Mon, 30 Apr 2007 16:16:09 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45889>


The three most common ways of making large packfiles
are git-fast-import, the first git-repack, or git-repack -a.
The first already supports a "--max-pack-size=N" option,
which limits the resulting packfiles to N megabytes.
This patchset adds the same option, with the same
behavior, to git-repack to handle the other two cases.

This iteration fixes miscellaneous issues discussed on the list
and introduces no behavior not seen elsewhere in git.
It is based on "next" in order to incorporate Nicolas Pitre's work.
