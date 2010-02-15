From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v2 0/4] Refactoring: remove duplicated code
Date: Mon, 15 Feb 2010 23:26:46 +0000
Message-ID: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 00:34:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhASk-0001Sk-5J
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 00:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234Ab0BOXel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 18:34:41 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:33225 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab0BOXek (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 18:34:40 -0500
Received: by mail-bw0-f213.google.com with SMTP id 5so1503719bwz.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 15:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=G0c0AcKmqT1iI10e7dEmCgYD3GqJC9ZoIEpBT2oB2bY=;
        b=PT7FNe3JihLflfnFzz6rS+KRXZO+dCvIUMI+8CfNj1roam5bhkzgSGp4zKxVB/5xbZ
         BHF1wrV2DyEWIs20qg2Ac4hAQyCjM++WHCJqyj6CkKDBOHtpPXGEsRsEPlhRTKivVq5x
         xgpAV7iLZ0MIb6d65oSV9NdVRMFrVEJ+9Nv30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uUjtdUPcPtiQG1zLoosJNEP6TtrwEZpjWLyPOBan3mI3cxBe3nQ2mA7uObWUMwKOCL
         kpnC68MB5nerCTiYGpcVx3K2YjjoXkgrw6nmS9PHmuavw+wJ5KdPAo/IdZ56cUF9SFuQ
         5nPSilo8MzOL6NzwBACj2OqZo4gouACq739fo=
Received: by 10.204.33.131 with SMTP id h3mr3646419bkd.53.1266276425253;
        Mon, 15 Feb 2010 15:27:05 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 13sm2900172bwz.2.2010.02.15.15.27.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 15:27:04 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140048>

Hi,

Here is the 2nd iteration of my refactoring patches. 

Michael Lukashov (4):
  Refactoring: remove duplicated code from builtin-send-pack.c and
    transport.c
  Refactoring: connect.c: move duplicated code to get_host_and_port
  Refactoring: move duplicated code from builtin-pack-objects.c and
    fast-import.c to object.c
  Refactoring: remove duplicated code from builtin-checkout.c and
    merge-recursive.c

 builtin-checkout.c     |   18 -----
 builtin-fetch.c        |   20 +++---
 builtin-pack-objects.c |   27 -------
 builtin-send-pack.c    |  190 +----------------------------------------------
 connect.c              |   83 +++++++--------------
 fast-import.c          |   23 ------
 merge-recursive.c      |    2 +-
 merge-recursive.h      |    3 +
 object.c               |   20 +++++
 object.h               |    9 ++
 transport.c            |   27 +++----
 transport.h            |   11 +++
 12 files changed, 101 insertions(+), 332 deletions(-)
