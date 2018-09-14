Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009001F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeINXdz (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 19:33:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33746 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeINXdz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 19:33:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so11513040wrc.0
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BG9WiDmkmJK5p64B9+M2jMrNjRkyfBhSj47FrIXRwaQ=;
        b=f2MbsznJSCy1UCySxVrbCPPI4XzA4GsVZF9orHWqSn6sX+y1Q2TKVOkzfF5tzmL8Au
         D6JnucrJq1lVId4gKTKSVwkLw23ib58a61ONbGPBD17p6MSMiwXUzjWEelrZfz/RtsLe
         uNu7X9T+/LXc93RAcd5ZmttQ/6JBKXQ+b1kFQhRlM8hZvGdtshG+N2bPVL1CbjR2RiBk
         8O8jBxNcZKb/lhtKjfwWgPWQTcXq2Otje61WW7bqG2At06lC9wsHVk/IJ+sQvgCtOdKF
         EMNDhDyiYJyDI730SG4T8KOPPWxd0ZfQ7QDunDdABiQg9i8yk0NiAJcfSYks48dAMdD9
         kIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BG9WiDmkmJK5p64B9+M2jMrNjRkyfBhSj47FrIXRwaQ=;
        b=nqzI3FDytQQ1diAa4kVb5HfSP8xzhARRNlelWPbym5zQTgZTVOx6K8+c5r7pb3AVhM
         qdYMai2K/7qn2sMgrRXJC+nN6F8txSxbldhVBnxHvHfKqeVwBOesTZSrItlrw6igNv2+
         GD7wXKBWP0JDo1HsA4Ma6S+bypWmfhV1NRz5HlBMmGmDPivWjIO7+MDR1mwkEj97Kaq1
         r7pNvLDi1ZorlCUn9NMMSpB3yWOqZO4W2tbyzJ76IHPUhWnmBS3paBGGmMTHao26Kul0
         LjG4IJ5jVazaV5Ib48tBIBG4cp4xsTtBdtSoc44Y/rc7SaE0lGOHtSTaaaWMy2P5aAaw
         U3IA==
X-Gm-Message-State: APzg51CiDQZ8tP0RsIm2SssRR5sLHOKFrSkp4WiP8MyYw6n/xDhUnq6u
        9PfJNnCtuOk+3Q79FAkna6Y=
X-Google-Smtp-Source: ANB0Vda+03K0W/ItX8Mq3yxawNHJXSPj9hFQiME/l7IvJ7/qUjUruQMW0AG/jra4PsdjjceA7J2Z4A==
X-Received: by 2002:adf:8504:: with SMTP id 4-v6mr10409072wrh.72.1536949094599;
        Fri, 14 Sep 2018 11:18:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f13-v6sm4853510wrt.9.2018.09.14.11.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 11:18:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer\@gmail.com" <t.gummerer@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1 2/4] fsmonitor: update GIT_TEST_FSMONITOR support
References: <20180914143708.63024-1-benpeart@microsoft.com>
        <20180914143708.63024-3-benpeart@microsoft.com>
        <xmqq5zz8c84y.fsf@gitster-ct.c.googlers.com>
        <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
Date:   Fri, 14 Sep 2018 11:18:13 -0700
In-Reply-To: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com> (Ben Peart's
        message of "Fri, 14 Sep 2018 14:05:46 -0400")
Message-ID: <xmqqin38aqoq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> The difference here is that core.fsmonitor isn't a boolean value.  It
> is a string to a command that is executed so it can't be moved over to
> get_env_bool().

Ah, of course ;-)

Then please take the following as a review comment for 4/4; checking
if each getenv(VAR) should or should not become git_env_bool() and
updating them should be done as a separate change for variables
whether they are being renamed or not in this series.

>> I _think_ the renaming should be done without getting mixed with
>> other changes like the git_env_bool() done in 4/4.  The idea to use
>> git_env_bool() in stead of getenv() may be a good one, but then we
>> should consistently do so when appropriate, and that would make a
>> fine theme for another topic.
>>
