From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCHv2 0/2] am: bug fix and new patch format support
Date: Thu,  4 Sep 2014 10:21:56 +1200
Message-ID: <1409782918-26133-1-git-send-email-judge.packham@gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 00:22:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIwb-0000KH-MF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 00:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934081AbaICWWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 18:22:20 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54977 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933916AbaICWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 18:22:17 -0400
Received: by mail-pd0-f178.google.com with SMTP id y13so12163362pdi.9
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=kF9qsNnrfxPPXI9m9EuYRuN4mr5znpewd8xErC1no7M=;
        b=H2RCD4U+Gr6s8AOnN3UzFTLuZLd6f+IRYRh0dQ4j2VFM7AwUNIZ1S24dDM0K4t33Kw
         8KEj8T9TH+FKefWnW2MuXyblXLzhpfuhXnkhY0Q01gp8FWfLtB/DKMI0/k0aX0WyIOpL
         bG23mucsfQrnI3UlxOyaosvIBwGa9/Z6RnX8BwEtpkVEA4eMazlS7KpJVFPXwPsDTQGy
         6Ri13sA1NWLtxbrUJwTeTA9d/Nbf7kk5HUM5jz461E1oFU3dBR+wHVLR4czKMDpi1/8o
         ylVg8oV2lHxIG0dDfrfk7XefbCy2xzRHqucpjOVlfm06CXhf2Xtlqo5cPk6eGhs3rer7
         wuog==
X-Received: by 10.66.66.163 with SMTP id g3mr629923pat.150.1409782935793;
        Wed, 03 Sep 2014 15:22:15 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id we5sm20099548pab.28.2014.09.03.15.22.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Sep 2014 15:22:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
In-Reply-To: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256424>

I've done some digging into the tr error message. I think the extra
re-direction of stdin is unnecessary. I've removed it and the tests
still pass. The error message I was seeing is no longer seen but I've
found it hard to actually reproduce (even with different sized patches).

I've also updated 'am: avoid re-directing stdin twice' to add some tests
and only strip the description part of the patch.

Chris Packham (2):
  am: add gitk patch format
  am: avoid re-directing stdin twice

 Documentation/git-am.txt |  3 ++-
 git-am.sh                | 38 +++++++++++++++++++++++++++++++++++++-
 t/t4150-am.sh            | 13 +++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.0.4.2.gadd452d
