Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1552020D11
	for <e@80x24.org>; Mon, 29 May 2017 08:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbdE2IuC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 04:50:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdE2IuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 04:50:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C14480F75
        for <git@vger.kernel.org>; Mon, 29 May 2017 08:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 4C14480F75
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=lersek@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 4C14480F75
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-94.phx2.redhat.com [10.3.116.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9D1560BE2
        for <git@vger.kernel.org>; Mon, 29 May 2017 08:50:00 +0000 (UTC)
To:     git@vger.kernel.org
From:   Laszlo Ersek <lersek@redhat.com>
Subject: FORMAT_PATCH_NAME_MAX increase
Message-ID: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
Date:   Mon, 29 May 2017 10:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 29 May 2017 08:50:01 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

would it be possible to

- increase the FORMAT_PATCH_NAME_MAX macro from 64 to, say, 128?

- Or else to introduce a new git-config knob for it?

I have a small review-helper / interdiff script that matches patches
from adjacent versions of a series against each other, based on subject
line. (Using the formatted file name with the patch number stripped.)
The project in question uses long common prefixes in subjects, and the
current limit of 64 does not always ensure unicity (again, with the
number stripped).

Thank you,
Laszlo
