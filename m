From: Andrey Hsiao <andreyhsiao@gmail.com>
Subject: Question about git log --merge option
Date: Thu, 14 Apr 2016 00:53:26 +0800
Message-ID: <CAArk4YMOkd3dEn-09-LMO7zf=X3iJqXUjCS0YNN5v4h=PjrTLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 18:53:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqO2n-00056r-6T
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 18:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbcDMQx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 12:53:29 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36794 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbcDMQx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 12:53:28 -0400
Received: by mail-ig0-f195.google.com with SMTP id kb1so7319543igb.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=wTIet26QDRHFCzOwwJe9cXAJYb7zLrx/oC9TFKI3Lz4=;
        b=hghuMt7StIBpLYoyXluqW75Ab2qHOUWcYDfSN6zb4VsKoOOCpY0Synnkq8gNFXBLBA
         r50+vSUXtgQYt2YIaC944hhuh9OpLj2t9ZbjbTXd8wX+X2ZrIo+ftwuKzx1+PY5Q6cAA
         ljsDknf0sBrDDYpeBUzBfoZyc/A+soAMOHuad1zI3uztBp+Va+UpIIUXG7/F0y5NJ5UA
         FnAeJ+2etdBQWAeopKCThfWvhXpqJ+tb0YcCFhKXAcOHOGZlFKi8cO78pjLLn+x/FLL8
         0l80/aPL909aIGA5fwEWUZXiKNv+jGS11oyNnliCMpzRw2y2v3bP1toJ4uffv6tCDD9C
         ZhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wTIet26QDRHFCzOwwJe9cXAJYb7zLrx/oC9TFKI3Lz4=;
        b=XCXb2v+vtYnL43TqLtG9bez1BNadzAJkM3gHDRfdJ1NAqLs3EIEMEzVwlesYukIK2K
         NefiqOnQJ/x/OO5LJXj2ISWHPW6VEpMS3WSUmOnipUGToPEAIDYLfSE6VyaOWtkPwjkW
         SDPrSdLlWSi19zjjH03WdPZVJypxcDkAChP7W7PbDIRK7j9c+1c3Bwp5WJ919CKJVLpC
         2CiXZB/YT3OR486nH1rO+nBj4TulzyzpTfX2zbtDFk4yemMdFQtoU2b97a9L0ZJZvIHi
         erphyomvwl/xZQ/1QQ6VUHdGYtah3+uWNT1nt0jA1gpe8Hy4KcSEWqikBd+vMvskpmmc
         wF1A==
X-Gm-Message-State: AOPr4FVa2/hHpMoPp/ii++giYChgt8ZKYhh0hLX16xq86Z4kDTGwoJBkVYv+WBEKOWLVeX0CGye1Qs2Tpeef7g==
X-Received: by 10.50.160.164 with SMTP id xl4mr7807767igb.3.1460566406499;
 Wed, 13 Apr 2016 09:53:26 -0700 (PDT)
Received: by 10.107.152.195 with HTTP; Wed, 13 Apr 2016 09:53:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291459>

Dear list:

Just encountered the --merge option for git log.

In the man page, it has the following explanation:
- After a failed merge, show refs that touch files having a conflict
and don't exist on all heads to merge.

I tried this option and get below results:

1. For a failed merge (with conflicts), if the conflicted file does
not exist on either side of the merge, the --merge option will return
the log from the other side.

2. If the conflicted file exists on both sides of the merge, the
--merge option will return the latest change on either side. (i.e: git
log -1 -- conflict_file / git log -1 --merge -- conflict_file may
return different results, whichever changed the latest)

I'm not sure whether above behavior is the unexpected result (cannot
find detailed explanation for --merge option online).

Thanks
