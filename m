Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8001F404
	for <e@80x24.org>; Mon, 13 Aug 2018 05:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeHMHnZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 03:43:25 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:48962 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbeHMHnY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Aug 2018 03:43:24 -0400
Received: from mxback15g.mail.yandex.net (mxback15g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:94])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 39CE8444524B;
        Mon, 13 Aug 2018 08:02:49 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback15g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mGdEZXPfkE-2mK8xaOq;
        Mon, 13 Aug 2018 08:02:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1534136569;
        bh=6iAlTJr8NyXQVURnSCdi3QJHJ3mLMik/bACIRFMOPGU=;
        h=From:Subject:To:Cc:References:Message-ID:Date:In-Reply-To;
        b=YldhcUcURqSEF885VmswUeKl+oqNd6GNyS8jBTveWtFU6Of94Eym5JIxYsiX3I7KO
         UtsE9oDWfglIS3VTM/y3qmN6DmT/IqIuZZcDZ6uX3PiqXMJICL1y2qWJHjY87IcNeT
         DNwjnUOoRO+x+2VqDaMPD9jkE4e/dz9V5jhmuCIE=
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id bk4wvrJeZp-2lfeCswC;
        Mon, 13 Aug 2018 08:02:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1534136567;
        bh=6iAlTJr8NyXQVURnSCdi3QJHJ3mLMik/bACIRFMOPGU=;
        h=From:Subject:To:Cc:References:Message-ID:Date:In-Reply-To;
        b=GvhQc8ghN/GR880DnDjsv5clgcJe6neDzeVtXQKLJyJtCVZaGp1MBDd6G+3wKt41j
         B5YhQ6xC68S+/7Bn//IVszw4fEoysBeriEIlniB37okneWtoxk/SmJ0tGKFlwUHUJQ
         9Q/wLT3KbOnK0bKVji4kiWmtfr2JAXZ7nf1cWOp0=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@ya.ru
From:   =?UTF-8?B?0JrQvtC70Y8g0JPRg9GA0YzQtdCy?= <guriev-ns@ya.ru>
Subject: [PATCH v2] status: -i shorthand for --ignored command line option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <CAPig+cTD7XYbaPBzj36Eudrud80r-cz1CPLDsLA9CHJC6Yc-Qw@mail.gmail.com>
 <20180809062142.15638-1-guriev-ns@ya.ru>
 <xmqqpnyrczo8.fsf@gitster-ct.c.googlers.com>
Openpgp: preference=signencrypt
Message-ID: <a178d91c-74dd-e04a-8db3-70cd75ad6793@ya.ru>
Date:   Mon, 13 Aug 2018 08:02:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqpnyrczo8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

09.08.2018 18:44, Junio C Hamano пишет:
> Unlike "-u', "-i" is supported by "git commit" which shares the
> underlying implementation, and that is the historical reason why we
> never had "-i" shorthand, I think.  

git-commit supports the -u flag, its meaning is the same as for
git-status. Although the -i flag might be confused with the --include
option of git-commit, I suggest this shortening based on first letter of
the --ignored option because git-status and git-commit are different
commands and it's more obvious shortening.

> While I do understand why sometimes "-u" is useful, especially
> "-uno", to help those whose .gitignore is not managed as well as it
> should be, I am not sure why a "typical git-status" invocation would
> ask for "--ignored" that often to require such a short-hand.

The --ignored option is often used for opposing purposes, to show all
changes in working directory regardless of .gitignore files which may be
written sloppy. I've discovered that I type this option quite
frequently, and I hope my case may help others.



