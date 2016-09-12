Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415D220984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757912AbcILLSI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:18:08 -0400
Received: from forward3m.cmail.yandex.net ([5.255.216.21]:35870 "EHLO
        forward3m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751955AbcILLSH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Sep 2016 07:18:07 -0400
X-Greylist: delayed 658 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Sep 2016 07:18:07 EDT
Received: from mxback10m.mail.yandex.net (mxback10m.mail.yandex.net [37.140.138.70])
        by forward3m.cmail.yandex.net (Yandex) with ESMTP id CC584210A0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 14:07:05 +0300 (MSK)
Received: from web17m.yandex.ru (web17m.yandex.ru [37.140.138.108])
        by mxback10m.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 0x5M2oDA6O-75wmLcP7;
        Mon, 12 Sep 2016 14:07:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=filippov.me; s=mail; t=1473678425;
        bh=kWPWN7XbWMX6wzd4vsuJgNIiDzeWhDead2480OeUClo=;
        h=From:To:In-Reply-To:References:Subject:Message-Id:Date;
        b=ZNCsf2aDvxOMJxnRJOtjRq5cPv8raH5GU5xUztQIF/EJbcumX/0ek0XR6tfdqd1Js
         zp9tWj6xGj1w5/j2YqJpFz2AI23s53TH9dhEuDJVSd3tySuaM8a3kN/OYRoeFmG3kF
         0VrLgFwCBeNxGRROgwhpC3QBttsLEjGVkw30P0Uo=
Authentication-Results: mxback10m.mail.yandex.net; dkim=pass header.i=@filippov.me
Received: by web17m.yandex.ru with HTTP;
        Mon, 12 Sep 2016 14:07:05 +0300
From:   Mikhail Filippov <mikhail@filippov.me>
To:     git <git@vger.kernel.org>
In-Reply-To: <xmqqeg4q6mw4.fsf@gitster.mtv.corp.google.com>
References: <1473625505-7641-1-git-send-email-mikhail@filippov.me> <xmqqeg4q6mw4.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] Do not record unstaged deleted file upon recursive merge if file was moved outside of working tree with enabled sparse-checkout.
MIME-Version: 1.0
Message-Id: <1843881473678425@web17m.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 12 Sep 2016 14:07:05 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>  +test_expect_success 'move file/sparse-checkout/merge should not delete moved file' '
>>  + git rm -rf . &&
>>  + git clean -fdqx &&
>>  + rm -rf .git &&
>>  + git init &&
>
> Yuck. This is inherited from existing tests but I think they need
> to be cleaned up. It is not your fault, and it is not in the scope
> of this change.
It's part need for cleanup repository from the previous case.
