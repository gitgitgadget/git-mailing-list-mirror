Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC8C001DC
	for <git@archiver.kernel.org>; Sun, 30 Jul 2023 21:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjG3VkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jul 2023 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjG3VkB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2023 17:40:01 -0400
X-Greylist: delayed 86 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 14:40:00 PDT
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303CE6C
        for <git@vger.kernel.org>; Sun, 30 Jul 2023 14:40:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=iojDa+74GOh++vgXuAqyzqu1R5gzrexTI5Zm5c+fiqDUqQUaTBxuJNqPG6VQxgzlLXrkC2MzHp6R7zCchKUEEybspwEBwVrRgKqMPZpj/zMiz1zexdBm4fs7u0v6WJ7lNIlYMQOJcvtzCuDSWnP3bDP1OF0t2tZP7s7xgAkhHuvD3YNiubIEGvFeA49iAHVZ/7k0rn2cetTwzTpQQhhkwsv6qUOnp69EMc/2t2w9qrA79cqL7VJh98e75AZBn1NWbCPqPu4mcDGatfAofGXU5vSM0lm1XeeLNguuyWbQH6pAu9AlsF0rha7PRhbCwuTUOr+bRVJTbwTeYFwhwn5d+A==; s=purelymail1; d=faughnan.net; v=1; bh=Sat0R/wyiTp/AoSREoHfipEZPIRzxHAcIX0BTxe6awg=; h=Received:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=akjb4dR5rbCdOw91HwjJjBTVKpYj+pOB7iVj1qiNgeWDC2ENb/6xHigsBlIb4qEb7BmfrZc9OqD76l+y8QdaELBD7KDx0Hs1vHjJOS43otKZJp0UPEemTtp++rLlxMansGJ2tX9kFPd67X28gaDGtbu27ATwBIs1iJwRkl5uBUViOo5lBy5fxZFzMECoCR6sdw4vOL3CE75M4Mombi7Njp4hzvesWUaOPE4wktKYcpY1eN111uzQxRSfpSv+5S7myRyTaUOUubD2Ii5aRn8cFWYeEYeUUWq5hXme/5UBGwh0yL6IWfbQx4h8STH4vR0EGjeVMXyGtBroKObsRZYO3w==; s=purelymail1; d=purelymail.com; v=1; bh=Sat0R/wyiTp/AoSREoHfipEZPIRzxHAcIX0BTxe6awg=; h=Feedback-ID:Received:Subject:From:To;
Feedback-ID: 3419:981:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2075316473;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 30 Jul 2023 21:38:13 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 30 Jul 2023 17:38:13 -0400
Message-Id: <CUFTY8BW9NHM.132KSE56BDE8Q@badwolf>
Subject: Re: Git is removing . from the last part of user.name
From:   "Thomas J. Faughnan Jr." <thomas@faughnan.net>
To:     "Jeff King" <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Daniel P." <danpltile@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2-108-g02eeed0b4898
References: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com> <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net> <YSKleNynVrWWyyML@coredump.intra.peff.net>
In-Reply-To: <YSKleNynVrWWyyML@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On a somewhat lesser note, I'm tempted to say that "." probably was
> never that useful (compared to say, comma, which is the gecos
> separator), and we could probably just drop it from the crud list.

Would this change still be considered? Or alternatively a git config
option to ignore "." when checking if a character is crud?
