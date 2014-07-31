From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/5] ref-transactions-req-strbuf-err
Date: Thu, 31 Jul 2014 14:25:05 -0700
Message-ID: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:25:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCxqn-0000Q8-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbaGaVZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:25:18 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:61869 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbaGaVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:25:17 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so957497ieb.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HReW2IYJ4rWSj0co9KlteFVuPhxwRLjKCLcvudCqSRM=;
        b=P3ijzA77BsPEBNdFnvSpxpmBBETWwFOWMyhfSp8SCmJR6OJ9aQzLLB4Hpd3Q9qe6Nw
         t0VG9jHctkVQwi5hQFZMl+5AfF2CG4l5Z477IAOHODxKeqFbhEpH0fmzGbZKpid2MM10
         GU5gsys4NYC7E3yiRu8BgtYuLm6hqqTFcaICS5JPtvlv352Ban7ue7XPT1A5lwcFD2qR
         SkJta7fxMBVL9WPeycCmTlias1NS+ijvpeBxSEW4DNZk+IIYcXaut1avl2T5k8Egmwm8
         rreMxTOxZhYTxggUvmb+knrdbdHAnTp87sA3voKJMdhOpT82jYPQ0l5IRiRGoE6nWf4f
         ObHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HReW2IYJ4rWSj0co9KlteFVuPhxwRLjKCLcvudCqSRM=;
        b=ExLQVjHz0bav9KkvVi6QswPx3DMxxWnXPtwAbyyr21fMvOER9Oc9z1rLMZ6SPan8Pp
         cVA7dhgGNh0IBVfYDI66Rew5bPEfolmwIkGuWBjQl4l7fcJeBIuJk4xlM22/wYGRy47p
         s6REF//YjQUG2RsCQX9uA1H4wZsroVvYICtw+UoOjYaDzSAebO1o+TBKabjEYnVWB0WO
         EylpRPQ3dglUjlyy18sTKkwPz1FtIF+CfIDNRmY+n7gK15TlThyk3HsCH7Q79Nc28mr+
         bILlptfNNTpPVQEY/vMCGssymVc7j7qgVk7eoeKmcREAEo1+oBNffjpitg6ZOBnYa/qi
         thUA==
X-Gm-Message-State: ALoCoQnSkltWSuRpXNdAj/73rFYQqRzaayBufxCktkKJwIbhbmZIoFqIR7uXfzJuS83NsPktKx7F
X-Received: by 10.42.90.68 with SMTP id j4mr970843icm.3.1406841916239;
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id 4si55594igj.0.2014.07.31.14.25.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C6BD831C602;
	Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 57AF8E06DA; Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g70700c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254603>

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
2.0.1.523.g70700c9
