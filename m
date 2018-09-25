Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E2A1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 06:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeIYMsZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 08:48:25 -0400
Received: from forward4j.cmail.yandex.net ([5.255.227.22]:59707 "EHLO
        forward4j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbeIYMsZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Sep 2018 08:48:25 -0400
Received: from mxback6j.mail.yandex.net (mxback6j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10f])
        by forward4j.cmail.yandex.net (Yandex) with ESMTP id D8E10218F7;
        Tue, 25 Sep 2018 09:42:20 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback6j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WRb9oNg9C8-gKv0Lc4R;
        Tue, 25 Sep 2018 09:42:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1537857740;
        bh=3PysmUHHRSwm6xrp1gRxUPRFF79eueCqbEgYBiEODs0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=ZYBV5FvODSgclsiFgHPL87xS5EHVgifo4tLTLSF2tnRb7nNRq+zUmbIz8IecLtf6t
         Hns0GhbOVU9FgvWeHpk/5RwGRK8SN4UroovG+jXP6c//LBks7UzV5x7iO4weB8kRmm
         YN+esZvb4dMtPwY+tl2gNQY4m7av2iii7LCD7BnE=
Authentication-Results: mxback6j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-857317bd6599.qloud-c.yandex.net with HTTP;
        Tue, 25 Sep 2018 09:42:20 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
In-Reply-To: <xmqq36u42pzw.fsf@gitster-ct.c.googlers.com>
References: <6160201537441514@iva5-cb9df376e345.qloud-c.yandex.net> <xmqq36u42pzw.fsf@gitster-ct.c.googlers.com>
Subject: Re: Work is not replayed on top while: git pull -v --rebase
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 25 Sep 2018 09:42:20 +0300
Message-Id: <21782811537857740@sas2-857317bd6599.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you can see I have lost some commits. Thus I wanna an option to be safe

20.09.2018, 17:38, "Junio C Hamano" <gitster@pobox.com>:
> KES <kes-kes@yandex.ru> writes:
>
>>  PS. for `git push --force` there is alternative: --force-with-lease
>>  Is there something similar to --force-with-lease but for `git pull -v --rebase`?
>
> Curious.
>
> For "push", you are competing with the other pushers who want to
> update the repository over there, and there is need for the
> force-with-lease=<it must be this verison> safety, but what is the
> reason why you need to take a lease on your local side while doing
> a "pull"?
