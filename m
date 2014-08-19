From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/5] ref-transactions-req-strbuf-err
Date: Tue, 19 Aug 2014 09:16:59 -0700
Message-ID: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:17:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJm6Q-0003Fk-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbaHSQRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:17:09 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:52375 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbaHSQRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:17:07 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so796270qap.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Szq4Fmji09VPMAcv8rg9csTXyZfi0IuomQ2+9CDpZLc=;
        b=Ttvc4lBJQ4kb+5U+IuH+VJSwDFC+AVUNA4Xmgj+FwATyDQs7Pu12q8/9zIIZXorv26
         Xns37kipxCNrRe8R9TZ2NWDL+WSbySJo7TJt/XtFGjD5Q72Oz9kJv2kX0yTjeK++fgIo
         McssUdj8cXnIsoSPNpYqGwNvt83jOiYFKKhphIUT/cyGdrq0x1EAkXR5tGqo8LxwfgM5
         EYbw5F8bLq7F2C53cRSC1occ1jo6+ebRLusYWF91WB8Q+FDXYqCYJsLulitZeXilPJsZ
         Gn9Mf6P0VBFea90Tvq4ztaqmO5NCeTcDMrHVDbWJ7iu04c3eAWp99ia6gK8+HFv+iC/Q
         8uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Szq4Fmji09VPMAcv8rg9csTXyZfi0IuomQ2+9CDpZLc=;
        b=MOXNIhYIt8VaPr04dpkInN+dcwDnd6Zfv/sCYbJW50SaT/o1Kpo8aaiHq30Q2XV6dR
         z2Oa6nfq1TNv6SAmxbjACBlE1rVyogti9u86FnocykFinJbPpl8c2iXJKRi9nSAUT0ZF
         +VxTxVhlvB6pFQvJUGj1pExt/PgljucPQKCBJFvMSZZOxO3EYf6Pc0Pu0IfmM5hY9/x6
         JDNqEpK0kDOqJNp0NOp+AxUczQTdnMyD0FOz8tJTrKdl7Bi8Yk5EovD7fJTpEu4OfRYv
         s0VzAhehnrthpAOgACWGlucxVST0gK30I4EENIQIGPS3Qyp9j7x2+A8I2MGzMVnm4WUo
         J2Vg==
X-Gm-Message-State: ALoCoQkkLLqPCK1igibg71B1ob6UdtnN9W2CPDWmPXeIAcO43zgW2TRV32x5Bc/3rEsW15AA/5tt
X-Received: by 10.236.14.99 with SMTP id c63mr18936482yhc.40.1408465027071;
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si326076yhe.2.2014.08.19.09.17.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DCAE931C528;
	Tue, 19 Aug 2014 09:17:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7DC13E0F40; Tue, 19 Aug 2014 09:17:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255468>

List,

This is the next patch series in the ref transaction work.
This patch series is called ref-transactions-req-strbuf-err and builds ontop
of the series called ref-transactions-req-packed-refs which is origin/pu


This patch series mainly adds some nice strbuf arguments to some functions to
pass errors back to callers.
The only thing noteworthy is that we finally get to remove
-enum action_on_err {
-       UPDATE_REFS_MSG_ON_ERR,
-       UPDATE_REFS_DIE_ON_ERR,
-       UPDATE_REFS_QUIET_ON_ERR
-};

aside from that there is little/nothing much interesting in there.


Ronnie Sahlberg (5):
  refs.c: replace the onerr argument in update_ref with a strbuf err
  refs.c: make add_packed_ref return an error instead of calling die
  refs.c: make lock_packed_refs take an err argument
  refs.c: add an err argument to commit_packed_refs
  refs.c: add an err argument to pack_refs

 builtin/checkout.c   |   7 ++-
 builtin/clone.c      |  23 +++++---
 builtin/merge.c      |  20 ++++---
 builtin/notes.c      |  24 +++++----
 builtin/pack-refs.c  |   8 ++-
 builtin/reset.c      |  12 +++--
 builtin/update-ref.c |   7 ++-
 notes-cache.c        |   2 +-
 notes-utils.c        |   5 +-
 refs.c               | 148 +++++++++++++++++++++++++++++----------------------
 refs.h               |  13 ++---
 transport-helper.c   |   7 ++-
 transport.c          |   9 ++--
 13 files changed, 170 insertions(+), 115 deletions(-)

-- 
2.0.1.556.ge8f7cba.dirty
