Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55712ECAA24
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbiHYQUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243017AbiHYQUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 12:20:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7BC4C61C
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:20:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p185so5797638pfb.13
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=lR71EPwkWVEx6YqhwtQ2GTvN/bV1mKgJwKIK3xqriEE=;
        b=MUX4IY4qMp6lVod5zzKnAJVqEgPwKdII2s9uN2VoA3nKQYxfX/YpS7RIn4tiOXLqKV
         eOPjgC+CM3Q2zz8ImHc6JFvcqG0iAB3Vzrxqf+2LuZQEDzZO24+ep1PnNGZiVcZGcrUI
         u0N4AtyZ98l1NP748MvbX+rB7VgUI8ehlGXgISo40SoxnTx7VTM4VmcJlQSa5eLz26eP
         POCH/faRoeYp6OT0ctNlrCMzL6f849HbGDuiR6f/JisMZv8/Vl4/vzFv8XYPSWCf0jtb
         dDBW6BLa8gSZy4/GNhy9emppAlN/dfAYuqYlujxKbCyByRt1hMMe/ScOd22p7Ot55+l/
         nLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=lR71EPwkWVEx6YqhwtQ2GTvN/bV1mKgJwKIK3xqriEE=;
        b=G7I86L0O+2VSjxpcDaXrTRJ5/uNvP9fucUTeVudRrGlf4Wq7qpJL8zapSo6394tAm9
         s7Ke/S1ILrDiB4p9L+ZaBz+Vnmc6nq/iVZLD+jcyKR2qpfQfk+2Qy7jBo1IhQH178xPZ
         HfH/+VswzRWS5vHGDHNPsCgStuiwLoihSAzOmWsfZOSMdPO6Zr6bls8x7D9hJPX20yqZ
         aInjUw7p5Wcp1HrnzAUeV9qlKb46vtMQ3OJGur7BopVs2V+QgECXMnl6GNWY87uc2RPs
         j2vzL+7jRAVgq4f2kdbOuzoQbi01NxQD50JAkkX2thVQAp9eFEuA3jlKH/qv+E5jIVpU
         pIIg==
X-Gm-Message-State: ACgBeo17G9pbcnSp7l6QMfW+sJREDzW55cR4vNXufiBVq1OJPsQOsq3e
        MO/sVwE8Zgc91iGV0+eoU74=
X-Google-Smtp-Source: AA6agR4PXlPbu87HTrnfXj+kmm6fjn9GpAMpXJx75QksP8YEYX/vDY90CLOYIURHNeM3SPYkplIjZg==
X-Received: by 2002:a65:6202:0:b0:41d:5906:2165 with SMTP id d2-20020a656202000000b0041d59062165mr3895176pgv.320.1661444406323;
        Thu, 25 Aug 2022 09:20:06 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m6-20020a1709026bc600b0016c9e5f290esm12836402plt.10.2022.08.25.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:20:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: clarify whitespace rules for trailers
References: <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
        <20220823140630.159718-1-christian.couder@gmail.com>
        <xmqq4jy18q7h.fsf@gitster.g>
        <CAP8UFD0EfhDo9ZMNSYp8YVHXJs6mYtSBs=hwoFZWWF3xZ0wjpg@mail.gmail.com>
Date:   Thu, 25 Aug 2022 09:20:05 -0700
In-Reply-To: <CAP8UFD0EfhDo9ZMNSYp8YVHXJs6mYtSBs=hwoFZWWF3xZ0wjpg@mail.gmail.com>
        (Christian Couder's message of "Thu, 25 Aug 2022 13:59:38 +0200")
Message-ID: <xmqqsflk2t3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> The code seems to be allowing zero or more space/tab before the
>> separator.
>
> Yeah, I agree. I misread the code. I will send a new version soon.

I recall I did suggest to tighten to "zero or one" some point in the
discussion, but we decided to correctly document what we do right
now, so let's do that first.

Thanks.
