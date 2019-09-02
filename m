Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C20B1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 14:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfIBOI7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 10:08:59 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39774 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfIBOI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 10:08:59 -0400
Received: by mail-ed1-f46.google.com with SMTP id u6so9887530edq.6
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=lhB32muwGFx3P4e+Db3h+k//8B9NM1+LFS4jD937tKQ=;
        b=kyZmLb0v0Bc3Dtuuu0PCZh5SySMxoMSLckKO3ROLpOpJ0Rna14pwVIMkvu7Lc8FMKy
         pdX0tDBWjjdxXmZPCLEC7fnv1V+lkdwp2RXdjJkon/LchbOnyR/cvgnlphvAWilEwwEL
         16BYnbnxVvmr+N1Tklh0Z/YWJ9kFV+eBRDhH7JgqQ3yrYN357alB5Uj3isilvhs8P/Zg
         4pVLqesgMIAGz2OhoeB/Xm7ifalQ6RtnGdcg0zL+G4rvzQNZ0y9o+WDvkB637Ela5JCj
         T/EEvp5yRjEXpmQwzkpla/vcrFrMjZxnAmAlmRBPp587hdltT9k0LfOQnIW6RPRJcuHh
         kI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=lhB32muwGFx3P4e+Db3h+k//8B9NM1+LFS4jD937tKQ=;
        b=f8h5SqFbnroU5ceNv9nLe6qhMcEH/sOTao3vw8EsgH33fg9zO3udq1CXpW4kUX34ik
         4kkFsiF1lJNPb7w11d5COyvGY1vPLgTbBnZaBkBA26f4pqvvZWgYCvU0LMxxG7caZlDT
         VDRko70+3DC/SMkj7JeNizX2Gur1VjbLw+mLxCzhJffTwdSyGwEjgxWPumz3YMy1L37Y
         R61Uzcw4zsay1ik0JxEGvPJaQ4V5E/nzwquZGfrSCmVSEu14V6KiTrJtfrx9C81kXOQe
         FrBwIr6m4V4pKwsR3naTwGGZ3WxHQM480W2ODjfJNIj2GYloZD0n41WWFlR0YSW3CoDm
         I6cQ==
X-Gm-Message-State: APjAAAVnOieguRymbJ3ISTaBC37ySsgthEl5B86cviMO1JSpLpHdU4Wn
        u0QBEzAFRKOAkGKD3uYUDlMkCe0L+nI=
X-Google-Smtp-Source: APXvYqx2l/fP7DwgzaW9bMTlKwr8vqW4+AWx9QW8D7hdc28K3HOjUO/WJC2/iZMswtFaytO56V29PQ==
X-Received: by 2002:a17:906:5393:: with SMTP id g19mr1623157ejo.256.1567433337131;
        Mon, 02 Sep 2019 07:08:57 -0700 (PDT)
Received: from instance-1.europe-west6-a.c.vaulted-journal-250706.internal (169.120.65.34.bc.googleusercontent.com. [34.65.120.169])
        by smtp.gmail.com with ESMTPSA id 9sm1961777ejw.63.2019.09.02.07.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 07:08:56 -0700 (PDT)
Date:   Mon, 2 Sep 2019 14:08:54 +0000
From:   Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
To:     Reino Wijnsma <rwijnsma@xs4all.nl>
Cc:     git@vger.kernel.org
Subject: Re: Retrieve version-string on shallow clone
Message-ID: <20190902140854.GA3806@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
Reply-To: 26d7f32e-2df5-ce39-cd20-8cd82dc8587c@xs4all.nl
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'd figure one of these options would be to clone everything from tag
> v2.0.0 onward, but if so how would I do that?
> As another option I was thinking; maybe it's possible to do git describe
> --tags on the remote repo?


To my understanding both questions are solved by

* https://stackoverflow.com/a/47720414/2219670
* https://stackoverflow.com/a/12704727/2219670

It seems to me that's the expected behaviour of git

-Giuseppe
