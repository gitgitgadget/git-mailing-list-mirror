Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6E61F428
	for <e@80x24.org>; Sat, 28 Apr 2018 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeD1TA4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 15:00:56 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:43583 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeD1TAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 15:00:55 -0400
Received: by mail-lf0-f45.google.com with SMTP id g12-v6so7168337lfb.10
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U9964JjhSQHGwCoFsqaXaY+znsp7qT3uiB6uTihrLb0=;
        b=P4wouXZD/sPrRY00O2CQDaH+BHf+vE0BgS20BaJb0wTFIPyiC7sHtRWfNtrRRDLlL1
         cZA0tcpjbk3QHMaetHuGeoL6lqODRJxK0+nNnd6Sfo2nqMnUN7vOzkhZgcykKLNFMgvF
         ndGMENqw6RZL2pqHXcOHLxoz22iXN0XXU1vRcqQ4gZSCyZP+1WsS0+4h7vlZiP532ckl
         7i4fE8AtgC7GsEmiIiQMvZk1CKefIqw0xfixgsAVt9BMXM/cBj8Ua8OQ5sQDdxryTXVl
         4HNfP7x0VXMe1Tghn0bJDlqjaX+ORe9sgGqBVE6bqaG3bkTccqWP8gdlsVu4dsMWMB3f
         LN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U9964JjhSQHGwCoFsqaXaY+znsp7qT3uiB6uTihrLb0=;
        b=XsjWWDRH5o6ytw4O1MP4H4k4EbHV28C2WrEDGwV4K/4slEAUhDLXESJHnXvNd+/87X
         cOln4+EVxH/kowe/ZQtdjV47XcMOCp+DzRAcENTDPcIr0PlT2Vo6CLs6ua4m+uPTjOIl
         h9wCRtUTMBlYYOHwaKtUXcTkkjoV+Wud0G6ozy8vzQOe0XYNawC1F94YmFgj/jKQ2+UT
         QwclQUedjeJkIVjH0h/NrlZ4T31/8PRl5wbghVldPhTEn7EvDPAqizMdhPQqhrpE3Gc6
         cT8HPc5S3GSaznAXBJTAV/qkNAmCjULlaSg8Z8ICECteS4EYNrcBDhYgAIXin9dMCkQM
         pFew==
X-Gm-Message-State: ALQs6tBH4RsQo229yoJ4BoNE5DZ9f3AC8ijjn2Twr8hBrTGKeqh+EcyH
        dBCzFBEIIV5Y5T8hqamshmwbaIiNxTQTI4aOafsAw1PGIRk=
X-Google-Smtp-Source: AB8JxZr2gzA8FCL+FvVKGVobrrlV2xf2Yf5bMRMv96BnHoEEO3O09CoRKBhEq6WvZ/bTdpwoQ557a5NxLQ7iiYeqW7U=
X-Received: by 2002:a2e:1082:: with SMTP id 2-v6mr4506856ljq.9.1524942053466;
 Sat, 28 Apr 2018 12:00:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9ecc:0:0:0:0:0 with HTTP; Sat, 28 Apr 2018 12:00:32
 -0700 (PDT)
In-Reply-To: <20180428182728.21696-1-wink@saville.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com> <20180428182728.21696-1-wink@saville.com>
From:   Wink Saville <wink@saville.com>
Date:   Sat, 28 Apr 2018 12:00:32 -0700
Message-ID: <CAKk8isq9wXLpMJxT4SHzAtj6abm6phH4G-XjfUY4=0V6g3XxdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] Teach remote add the --remote-tags option
To:     Git List <git@vger.kernel.org>
Cc:     Wink Saville <wink@saville.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this version I changed "+refs/tags/*:refs/remotes/tags/%s/*"
back to "+refs/tags/*:refs/remote-tags/%s/*" as Junio originally
suggested. This way don't have remotename collisions as Bryan
pointed out.

Since I don't like "--prefix-tags" I changed the option to
"--remote-tags" but obviously open to anything else.

I think jacob.keller (+ demerphq) suggestion is probably good,
but for the moment just using remote-tags as seems simplest.
