Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F4C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501236124C
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhEQOKH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 17 May 2021 10:10:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62835 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbhEQOIG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 10:08:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14HE6i14052495
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 10:06:45 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
Subject: [Broken] RE: [ANNOUNCE] Git v2.32.0-rc0
Date:   Mon, 17 May 2021 10:06:38 -0400
Message-ID: <007201d74b25$de5f2710$9b1d7530$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AddLJVIzUwm4TVJaQsaMsWz47AhTyg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 17, 2021 3:06 AM, Junio C Hamano wrote:
>To: git@vger.kernel.org
>Cc: Linux Kernel <linux-kernel@vger.kernel.org>; git-
>packagers@googlegroups.com
>Subject: [ANNOUNCE] Git v2.32.0-rc0
>
>An early preview release Git v2.32.0-rc0 is now available for
>testing at the usual places.  It is comprised of 545 non-merge
>commits since v2.31.0, contributed by 76 people, 29 of which are
>new faces [*].

Git 2.23.0 no longer builds on NonStop x86. Reference to pthreads is not permitted in s non-pthread build.

**** ERROR **** [1210]:
   libgit.a(ipc-unix-socket.o): In function `thread_block_sigpipe':
   ipc-unix-socket.o(.text+0xb87): unresolved reference to pthread_sigmask.

We are not building with pthreads. This is net-new for 2.32.0-rc0, not seen in 2.31.0.

I'm unsure as to why this file is even being included in a non-thread build.

Randall


