Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88279C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 20:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjD1Urj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbjD1Urh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 16:47:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215ACE2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:47:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso366278b3a.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682714855; x=1685306855;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1STz0dRiofcj6Y+VaDWqkE6Yqax1cg+HMrW2u7Ntzho=;
        b=Empj1iv8wo2G/VMbLPvSR8w97mXtYzypTrgCKQCVS4i/6RWbwhiaDk+V0uftxvSCwD
         FFZ+jlcsPZFwdS1EVfPPojwzDVak54/A1suHT8Rppu/J61ZBBjWyr1HCUHMVTIPeaOSu
         4a2AJ7RCljjvYgeuNHUPWvyQqrlw57A7pfSi5LXCM8I+L6I+1B2+Be0VArJhrAigacMQ
         rRwpGmq22j+ygF2cVez2fOMjOes6a0RfXdfTz7s0ZiCZ9qBikj8A6oKW+3Btz67LLCz5
         K9eAXZ2kEQti6tdKcTv6qE4HQcZXovARmVOwsBeDDymkxrC85AmTY9PBpaZcNoJFueCQ
         J2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682714855; x=1685306855;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1STz0dRiofcj6Y+VaDWqkE6Yqax1cg+HMrW2u7Ntzho=;
        b=A4bL+a+ztxu5NT49JbJ9iR4ob95maJrWeX2RzR9o7ZrIQHy87b5jKgIpfWoUZp9WJs
         145dA8z/dIimWf4ab+nN8U5JHnsy7l9KtP7dVCwIzWBjCr91QTnpKK7T5pG2GPrjN8JN
         GTITn58WdsuuGsmHSBeKaBsFPX7EOHzhb8xW2SDaRDQ+oJcdjSxODzDTVef4p3+GZhd7
         wlw08lTbrF8m++wNMn/IqjFH7QOp3cy2xyjW/ClqUmYXyTSWdGdWzL1EKlyZAtijZTiv
         PWQuzuJ/rCf+bQhoSI2XVeHWZ9b/QGFfpi8MpHUDw/CzHjrKlx+qLIsM9KQwLutm+o0Q
         44Qw==
X-Gm-Message-State: AC+VfDy1lVmIb0o19TrE7DSzyA0vji8J5R/z5RQ33cVsFVDlsL7gq2Gr
        5YE/puLHTSmRvJVM8TqKDcM=
X-Google-Smtp-Source: ACHHUZ74T5048ica26tYHB5E9wtmsAvgTUdl5qT/cIRGv47DzVvnf8HAhy+8hi06/kZOz96yQS5yAw==
X-Received: by 2002:a05:6a00:16ca:b0:641:23df:e914 with SMTP id l10-20020a056a0016ca00b0064123dfe914mr8988025pfc.13.1682714855453;
        Fri, 28 Apr 2023 13:47:35 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id z21-20020a62d115000000b0063d24fcc2b7sm15537341pfg.1.2023.04.28.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 13:47:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jouke Witteveen <j.witteveen@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email docs: Remove mention of discontinued gmail
 feature
References: <20221001104609.18453-1-j.witteveen@gmail.com>
        <CAJ2ouawTq0b=1-+471u0c6XJZPVwM4f+dg0uNu4-B19332jSiA@mail.gmail.com>
Date:   Fri, 28 Apr 2023 13:47:34 -0700
In-Reply-To: <CAJ2ouawTq0b=1-+471u0c6XJZPVwM4f+dg0uNu4-B19332jSiA@mail.gmail.com>
        (Jouke Witteveen's message of "Fri, 28 Apr 2023 13:28:42 +0200")
Message-ID: <xmqqildfbuop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jouke Witteveen <j.witteveen@gmail.com> writes:

>> Support for "less secure apps" ended May 30, 2022.
>>
>> This effectively reverts 155067a (git-send-email.txt: mention less secure
>> app access with Gmail, 2021-01-08).
>>
>> Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>
>
> Half a year has passed and this patch is still relevant, yet (as far
> as I can tell) not applied.

Yeah, it does not seem to have been applied.  Thanks for pinging.
Will queue.
