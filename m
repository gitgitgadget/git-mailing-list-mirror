Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4D71F404
	for <e@80x24.org>; Fri,  2 Feb 2018 05:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750714AbeBBFAn (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 00:00:43 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36670 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeBBFAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 00:00:41 -0500
Received: by mail-it0-f67.google.com with SMTP id n206so6513028itg.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 21:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yFi/byzNTSfZu2XOkbNpzVF9AwviqPnYCHnhKKArvQ4=;
        b=HvcxGCCLJO9d2A3tYWimTscwUmmFqwbrsUtTL4f5ltw/xkX5Iy9Ia8G1JWRcXtyzd5
         QKBv6BNHsuIVjIb1gmehIPrLvxfyYvmt2Fmw0ttitLX/FOVbTROh2JY85vBHAWf5F9Ch
         +VJ5CcoDFKedbifB/47cdg+OoHIPZ5/knayizuYstmcHgp0l0Y5EEI6gfwI0efPSP520
         DFGuHsTC01k7W3e698VvjVx9ee5RbzA/YLY46r2oC37P7VDhbZTvVDIOGGI+R43NJqEX
         Hk5USc+qdlLg7YDcJYzg8Qbko4B3+ilpvm6NHXEYBuAbv/it0X0TWGjsOSCgiPEDH1yP
         3/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yFi/byzNTSfZu2XOkbNpzVF9AwviqPnYCHnhKKArvQ4=;
        b=aCjIKSm9YTgGo6oQjiVK3o7cJMz69sDLVKLs7JC6YSslG0Chw5EnM+zCbdYy3zfKRw
         yUpyyIr67prTJ6J4ADMPO4VDHLRNUlmIjfdl0Je/9qmpICtSOu82P8UTMsLihVZkN0BT
         tfiOBCVyhKvxxOvWG+IAIrfs6QQN3Yk4ioB72mkUS1d9LDuF7aIdryxpKf1rxy/Ywg53
         dbxdjo2/8lnI0VFN6ViOrDuFUlWrsCo4h4gJgXGvcUfwax0hSFIxuuWRyNUdGHTE91bG
         K9P2GCwd42eqhtrNW7MIpkkVS2MdpWVAvLCzXAbR4ZALepozZM8UOsKXIQ/65vnj6sc/
         huXQ==
X-Gm-Message-State: AKwxytfqVRc30rdoR/d81eQyTkH7xuhQT5PBdYpSBvD+ONLg5cejnD/0
        L8bkNqlsiFVIKX4mGyVyAzZBGog8Q8FlNzGn8J8=
X-Google-Smtp-Source: AH8x2258V/lJNqK53hV4/y1ERAzoe+uvWXj4Wr+CQ79sfGShWaCipKlKpKM0FJQnmhqs4vn/iM7/W76pz6Vky6wPY70=
X-Received: by 10.36.33.210 with SMTP id e201mr13596748ita.144.1517547640688;
 Thu, 01 Feb 2018 21:00:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.84 with HTTP; Thu, 1 Feb 2018 21:00:40 -0800 (PST)
In-Reply-To: <CAGZ79kbVbUQGx84ynhG6DnOMNy4Qv1Og3ykRGqCNbNAswwnBfw@mail.gmail.com>
References: <20180129193453.3438-1-pc44800@gmail.com> <CAGZ79kbVbUQGx84ynhG6DnOMNy4Qv1Og3ykRGqCNbNAswwnBfw@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Fri, 2 Feb 2018 10:30:40 +0530
Message-ID: <CAME+mvXPKO6f1j9htMCj32GCf5aeTkMLEzM83stwLVEHXc4yFg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Incremental rewrite of git-submodules: git-foreach
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since due to some reason, the previous patch-series list was
unavailable on the mailing list, I have re-posted the series.
It is available at:
https://public-inbox.org/git/20180202045745.5076-1-pc44800@gmail.com/

Thanks,
Prathamesh Chavan
