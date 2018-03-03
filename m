Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FCD1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 23:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeCCX6w (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 18:58:52 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:40149 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeCCX6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 18:58:48 -0500
Received: by mail-wr0-f170.google.com with SMTP id o76so13649458wrb.7
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=kwDZZyWSpFO5a9b5PNotThfRQayW9X/2tihB0OXq2yw=;
        b=UI4cpHeKllxtXg9kUMj4X1qnpZVU3W9JrM6bw5xK+wZ5yTqj4NDjDu4lCFjdqlZ+MK
         +JhGFWyqq5ceLPchTUFHmC+/ve03cpFIsNJmvojMkGbnKpYHWzbrnebe6cLrvAIKG2GQ
         ru52VVpz/Pae/5hRB6TQxuphV+uKP5owguIBZfJ/XTzSDbI9l7lgcwZ76VHjDHlUFq8z
         IkJXxpwuJBQA+mZcJNpdTh0U/XZUWc+/2s9ooIjrCmgDHpKgKq4vtswnA+oeWSX4uNxD
         bXWLHkef+55ja1XP/2EVTsjCf3+VEjkc9DuSm4gnODPklXDhHiRgAUf23kNdFuJSbK6L
         uy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=kwDZZyWSpFO5a9b5PNotThfRQayW9X/2tihB0OXq2yw=;
        b=Eul6FzdQxtSU0k1S4PY0boytnoARqM7tRI+PrhXZMG/BwLU9HQxUjWf2EZoMxs94Yz
         MvuGwIitnnGFnAZ+vi9L+RCRu6ZNNAEIrWhMfPXBL+jeDuVZhSFw+UjellMO7/vOfK9a
         LLmM6jZHpN2rfCr9cDJ4WZkDULAAh1zbfCr4mB2HFtLhrrkLA1T7scJ+dh9RFIDkrW40
         iQTkBZu6ZpfRUrWcupxtAHJj/EGYbHIyBAWJbhoBfCuydp4QUDGrUw6vMvlrmGWwvGjJ
         bXJef2Ly/YtOMRWbLj0BbxpjUBK2SvAK35StyyclJvyApA7Ovv9wiJw9EzfptD9MGRq1
         q4oA==
X-Gm-Message-State: APf1xPDEkDfvuwQSJE4i7RMt6y6KG1QTUtkoaYWy5oONJ3CJUmajbWjd
        LH6okH4u9QU+LwTgPg3kUV8BVBRP
X-Google-Smtp-Source: AG47ELuH5qXyUVYDMyAz8/SMuwUxhydCaTH7VXBTIZ7KKweIS/KWXZoZN3yq7mvRd2bXFs9xPo4Gjw==
X-Received: by 10.223.152.141 with SMTP id w13mr8859172wrb.12.1520121527367;
        Sat, 03 Mar 2018 15:58:47 -0800 (PST)
Received: from greyhound.Speedport_W_724V_Typ_A_05011603_05_028 (p200300CA5BEF8278E01D0E043582A547.dip0.t-ipconnect.de. [2003:ca:5bef:8278:e01d:e04:3582:a547])
        by smtp.gmail.com with ESMTPSA id v63sm27586496wrc.69.2018.03.03.15.58.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Mar 2018 15:58:46 -0800 (PST)
Received: from cc by greyhound.Speedport_W_724V_Typ_A_05011603_05_028 with local (Exim 4.89)
        (envelope-from <cc@localhost>)
        id 1esH37-000239-LK
        for git@vger.kernel.org; Sun, 04 Mar 2018 00:58:45 +0100
From:   Christian Ludwig <chrissicool@gmail.com>
To:     git@vger.kernel.org
Subject: git-send-email: Support for Reply-To
Date:   Sun,  4 Mar 2018 00:58:12 +0100
Message-Id: <20180303235814.7241-1-chrissicool@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is the third iteration of this series. There was a request to
rebase the changes on the refactoring patch b6049542 ("send-email:
extract email-parsing code into a subroutine", 2017-12-15). This is
the result.

The diffstat is the same compared to the last revision. It could be
made smaller by sacrificing readibility and breaking the scheme
introduced by the refactoring patch. But I do agree that send-email's
readability could benefit from slicing it into handy functions. And the
refactoring patch reduces the nesting of loops/conditionals.

But it's your code, you decide. I can re-send a fixed-up v2 without the
rebasing.


So long,


 - Christian
