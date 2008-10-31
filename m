From: Alessandro Guido <ag@alessandroguido.name>
Subject: git archive problem with 1.6.0.3 (maybe regression?)
Date: Fri, 31 Oct 2008 22:13:31 +0100
Message-ID: <200810312213.32224.ag@alessandroguido.name>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 22:14:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1KJ-0000Yk-4D
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYJaVNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbYJaVNZ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:13:25 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:13965 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbYJaVNY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:13:24 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1303726fkq.5
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        bh=u8mDKpbJEAJbGrLWz149x4fnKrtP7/lYfGhaCIaXTIE=;
        b=HvOKv0Lz0deEUNJ/kJNhI3KZ0c+E4DwG99d05y0gY1uu0xmM1ugz4lLsuP/Kx6uGfo
         VzIJz/gSiYiF6BrlZx6yHK2/gjbmRgPXHomH0dutlUdc/puc3Lnnx9Ds0Q2cJ007xxRt
         6eiR7KysPQxcT/6dV8ODzY2T6xkQiFnEDVVgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=N/c5YDgr0/evEyjWB7vprcmhWTAD6CetyTAb0FSOagncrwTfUxgQzV7Q8PJ3LI7Lq0
         /9vec47Mb2IkEKBOe8fyMkgi/SkPHImFLhu26bzr6FXlqblGPkuD370YB/sUp6i0zzK+
         LVUQa5WgRqHKK69dtEyplWSC4S+L9XKQZT47U=
Received: by 10.181.134.12 with SMTP id l12mr3197693bkn.80.1225487601817;
        Fri, 31 Oct 2008 14:13:21 -0700 (PDT)
Received: from odino.localnet ([151.65.145.100])
        by mx.google.com with ESMTPS id 22sm3850790fkr.4.2008.10.31.14.13.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 14:13:20 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.28-rc2-185-ge946217; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99643>

[please CC: me on replies]

Hi everybody.

With git 1.6.0.3, I get the  following error when trying to "git archive" on a 
bare clone of the Linux kernel repo:

~ $ cd Kernel/
~/Kernel $ ls
branches  config  description  FETCH_HEAD  HEAD  hooks  info  logs  objects  
packed-refs  refs
~/Kernel $ git archive 721d5df > /dev/null
fatal: Not a valid object name

With git 1.6.0.2, on the same tree, it works fine.
