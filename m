From: Oliver Hoffmann <oliverhoffmann32@googlemail.com>
Subject: git init --bare versus git --bare init
Date: Sat, 8 May 2010 12:38:13 +0200
Message-ID: <201005081238.14156.oliverhoffmann32@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 12:38:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAhQP-0003R2-1o
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 12:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0EHKiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 06:38:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:42205 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab0EHKiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 06:38:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1019962fga.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=DK390AQd0zi+0NRxoliyBtQzXEGHF7mUSOogtLBdiLM=;
        b=pI5es3SSxnXCayWzEZ87bmWvt2yYMkULY0vCDOROKmNGAa9lCte46GUMFsQzvD27Ta
         5r20ZK0egFHHFvH0HB8qxuNVnesgxTzzDr4Nt3c89oBzH+irkg0O3W9whv0vLEGHwJuz
         SnY2SqH28nN2NuhmYcG5t1Oqg/Hk+VjbPimOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=Pg8TrjCEtkJWrFRwEzd8d4Ib1sA8Pr/tQzJa8oBSmsgi4ykQ97hqeP1qQYUJLldcwY
         MKFuvMxMYmdlTFsDjc39plpquu49sAGEcUQZ4xilIjqqjRaAgB9xqAO+s4m3BPc7DXhM
         22Hy8ryUwEYE4RJa7kBrZrArPnBR/MwLWFs8I=
Received: by 10.87.15.35 with SMTP id s35mr5661513fgi.12.1273315097361;
        Sat, 08 May 2010 03:38:17 -0700 (PDT)
Received: from dnserver.localnet (dslb-088-067-130-044.pools.arcor-ip.net [88.67.130.44])
        by mx.google.com with ESMTPS id 12sm5804599fks.50.2010.05.08.03.38.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 03:38:16 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.33-gentoo-r1; KDE/4.4.3; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146655>

Hi Git Folk,

If one accidentally writes "git --bare init <dir>" instead of "git init --bare 
<dir>" an appended directory argument is ignored and $CUR_DIR or the working 
directory will be used:

> pwd
/tmp/foo
> git --bare init /tmp/bar
Initialized empty Git repository in /tmp/foo/
> git init --bare /tmp/bar
Initialized empty Git repository in /tmp/bar/

... but both should probably be initialized in /tmp/bar/

Greetings,
Oliver Hoffmann
