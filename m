Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBCF20966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933262AbdDENFk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:40 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41185 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932971AbdDENE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:28 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id EA18A6000509
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=Zg4lSf0exmqP9ba4Enbt7ZlLXUI=; b=b6YJb/p+D9uZ
        FOM9t8vw+/IUF+Kn8slkptXaHOicVCwR3AiF/4nkAGzoDpkMQwgHTjPquekVVezo
        3jsYIFYmfJ1TxE2PpLpV57nlOMuU7JkDVJPtKZxz/H6+NHo7db0gRDXK/bzHzE79
        1ooicUpX9BhAw651ctKnpYTvhyTEUx0=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 9416E600050D
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 16B2E612D5
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 054E476C82; Wed,  5 Apr 2017 15:04:24 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] Patches to support older RHEL releases
Date:   Wed,  5 Apr 2017 15:04:17 +0200
Message-Id: <20170405130424.13803-1-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are patches currently needed to support building and running git
on RHEL/CentOS 3 and 4.

Tom G. Christensen (7):
  Make NO_PERL_MAKEMAKER behave more like ExtUtils::MakeMaker
  Install man pages when NO_PERL_MAKEMAKER is used
  Allow svnrdump_sim.py to be used with Python 2.2
  Handle missing HTTP_CONNECTCODE in curl < 7.10.7
  Add support for gnupg < 1.4
  Handle missing CURLINFO_SSL_DATA_{IN,OUT}
  Do not use curl_easy_strerror with curl < 7.12.0

 Makefile                       |  6 ++++++
 contrib/svn-fe/svnrdump_sim.py |  4 ++--
 gpg-interface.c                |  2 ++
 http.c                         | 12 ++++++++++++
 perl/Makefile                  | 20 +++++++++++++++++++-
 5 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.12.2

