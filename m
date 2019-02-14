Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30FB1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440019AbfBNUrJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:47:09 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45493 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437874AbfBNUrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:47:09 -0500
Received: by mail-wr1-f42.google.com with SMTP id w17so7973177wrn.12
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 12:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WgGREEDeuzt7ULPqxcPrhIijvrHHnY0VCnEww1vfMeM=;
        b=SgGNVIKSkzlxvrYjW3Y9+DsWhdyhJvzh1hhe8tc6WiwA3nozUW2cS+9iCjdWmY0FD1
         n3Inql9PdI9rEcAATZCSWg7sRt7pOoMSbjp4LieES72v729KJrjCxu97jau8jqKmwFuN
         6IokqPEGotCR5CIkfX6hgQQNRQ4sIp9vR5dxW8sqZEMWDCNHV0c3eNy2SFv0YuUBsCEJ
         SAOJUB5rpghYeYFYZHe9dOxz+dcxxJRli+ahn8L/AKFi2UOtab2G0mrvnSiKs57IPCu+
         FuSBDbJOb3GW5BQ/ihxRerK21r61avxspyj1tVcf73/4FnQAhs1zOoW0TTyVoB/SB1RD
         4hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WgGREEDeuzt7ULPqxcPrhIijvrHHnY0VCnEww1vfMeM=;
        b=ZY2mj7UE9Gho2Zr6x1MnvAeag2PdoLEBLZy5fJDN2k6o4RPQ7+1Kz1v8b7w4FGHVMm
         afl6iQu1oRdsqTlXNI3T4WH3H+hQlzr+BXMOzpltEOOLl+Hbo96qjp049y0O7j9O+s67
         4IhajkcrcaWLpbL5J0JzksUgtNWJvV7MTe5ugYjAfHdM9SfwjNP8zzEQRW/3W1jsQJ76
         qeT5Fm840A1sW6vQf1+J4aNiKGTjDKVQMnbZB1+CEnDtQfvn/upiH8rXtVhIjucr67w9
         kMmOn+9IWLSYXYvKwlMI1lHSTGBT1V+05EhJpsplLKCKDxw/6ZS+wZfnhiluV+OEs7vk
         RGxQ==
X-Gm-Message-State: AHQUAuaFQh9rmaW4JBas4aRIDk9u0+wDXoREkrZi/AToLQED+0RVXrCc
        zveS1chsyOAGbZmMdbV6rT8=
X-Google-Smtp-Source: AHgI3IZRvgCJ0Gkyc73kFlwdyq7Lyvt+MQBScIdQU516G5lHKr3Bz2Hec5GI2unualex0OGyhzCoRQ==
X-Received: by 2002:adf:f543:: with SMTP id j3mr4058810wrp.220.1550177227187;
        Thu, 14 Feb 2019 12:47:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c186sm5433703wmf.34.2019.02.14.12.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:47:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #03; Wed, 13)
References: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
        <20190214201006.127960-1-jonathantanmy@google.com>
Date:   Thu, 14 Feb 2019 12:47:06 -0800
In-Reply-To: <20190214201006.127960-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 14 Feb 2019 12:10:06 -0800")
Message-ID: <xmqqzhqy6qt1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/test-protocol-version (2019-02-06) 9 commits
>>  - remote-curl: in v2, fill credentials if needed
>>  - t5552: compensate for v2 filtering ref adv.
>>  - tests: fix protocol version for overspecifications
>>  - t5700: only run with protocol version 1
>>  - t5512: compensate for v0 only sending HEAD symrefs
>>  - t5503: fix overspecification of trace expectation
>>  - tests: always test fetch of unreachable with v0
>>  - tests: define GIT_TEST_PROTOCOL_VERSION
>>  - Merge branch 'js/protocol-advertise-multi' into jt/test-protocol-version
>>  (this branch uses js/protocol-advertise-multi.)
>> 
>>  Help developers by making it easier to run most of the tests under
>>  different versions of over-the-wire protocols.
>> 
>>  Blocked by js/protocol-advertise-multi
>
> If you don't mind, remove the last patch (remote-curl: in v2, fill
> credentials if needed) from this set. Peff noticed some issues with it,
> and I have sent out a separate set [1] that better fixes the issue.

I certainly do not mind ;-)  Thanks for a ping & an update.

> Peff also noticed [2] a minor issue with patch 1 - I used
> strlen(git_test_v) instead of *git_test_v to check that it is non-empty
> - but that might not be worth a reroll.
>
> Other than that, this set (with the exception of the last patch that I
> asked you to remove in the first paragraph) looks good to Peff [3] and
> me (besides being blocked by js/protocol-advertise-multi).

Let's see if we can straighten out the blocker first, then, so that
we can reboot both topics once the current cycle closes.

Thanks.
