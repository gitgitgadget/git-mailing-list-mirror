Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F7620248
	for <e@80x24.org>; Sun,  3 Mar 2019 14:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfCCOOa (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:14:30 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:45998 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCCOOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:14:30 -0500
Received: by mail-pl1-f173.google.com with SMTP id r14so1235388pls.12
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 06:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=li3nSCea9LQ/pOqOXPFzGgNLmPsNu8HtjfLy/MXo82A=;
        b=hTDetrUl4qbCyUWiIFgKYt4uzreyBqZq1W+GoKoinvJ5pKyHHd/pyRTI1Ugr3TUqKv
         nxwJKiN1w+yAqq+sU4KX5A60kUWczMe4aetYal1pjFZFsrMIyC3hTA5LMqImRJemIgWm
         wQ5Xsqr63s7XLhq4KGY6hXvntPRk7zh9xZ593MocqZKHq+tz+A8zcjuAodm2XButO7oG
         7OgkUrVliwcQqaGuqPXVHu3DPZ1VltapAF0tM5lr0PYUs65miI87g3j3HCCv0KyJuz5d
         4H5MEgeuvzlINl9ZKJOMizqjCuoK1G7S9oAclIrSrS4r0r94hb3j9L9ACpSSWNTJGsYq
         t05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=li3nSCea9LQ/pOqOXPFzGgNLmPsNu8HtjfLy/MXo82A=;
        b=esM0MkIq41YlPE70gbwKA7bvlOFAVoil2dRPmJWFDaUjfRqpvpIiNLNMLNHgS4nOgA
         pepZBh+P60+TKvPQCADJm0ypZeHgDAsCB3M9bS+Js/YfvpE+sI2R+87AQgtvEe4zBCdH
         1RSrrbbpGFBsIvkMVb8OvP+b8Ik4ZtrDeRdYVdjR/IUiWWX7pMCKmPYyKwK2//5NmjwS
         G6bNzh4GLopbkmk93N/NqWUhxWrGBVA+b78pJ3yypM1F11wcC+ErMCFD/7Qo82brKhym
         AQx3ZGKv19knO8CDozvPXgj1wb9INMrsrui1MKxtXiFIeBR2AWGBZRpzgYB8XwegNCOX
         j47w==
X-Gm-Message-State: APjAAAV0jv4KEnju4PRoRTmZeh4pIsHouQgr2gB/ZEcEhKmO+1jIoWeG
        hW1XP2pDABr3JCNITIIapxo=
X-Google-Smtp-Source: APXvYqzQ1e68P1J0s5vhgsewowvZWS7bxEwGJGW+0J8TJR1OHTvJ7dhScewMQQK/4/ryTqOGCXYmaw==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr15421751pld.238.1551622469706;
        Sun, 03 Mar 2019 06:14:29 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id g6sm4664898pgq.54.2019.03.03.06.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 06:14:28 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: t3600: refactor code according to comtemporary guidelines
Date:   Sun,  3 Mar 2019 19:43:58 +0530
Message-Id: <20190303141358.6479-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqqwolgytk5.fsf@gitster-ct.c.googlers.com>
References: <xmqqwolgytk5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree to all the points that you mentioned.

On 2019-03-03 13:30 UTC Junio C Hamano <gitster@pobox.com> wrote:

> We prefer "test ..." over "[ ... ]" (Documentation/CodingGuidelines).

At first I thought this should go in [PATCH 3/3] but now I think this is
its real place.

Thanks
Rohit

