Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53461C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbjDEPLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjDEPLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:11:14 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6158A58
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:09:03 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r187so42892336ybr.6
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680707277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM+279i7WsjACFordyvp85i2eOOsPySMwcKVrkkc3ZY=;
        b=ShCxOV3PXIMRkTM+yv42OHmCtHfZIz0w5k+vRNmXR+f+h/dZl+mCLgZu3ZXtrQyuHM
         OHREPnVs2OOJl7PEnu3otn4bqSw2BqBkY1XET/aJa7w4MviVgFhljiQ1YnjQz9pcrnNY
         U9WGRWORkZuDC4FwEaV/W376IqlgKnT0nQ2fdDgI3Leoaeg8AOpr4kinznZ68F650rdu
         SA+xj0vgzdzWk5cbqbKuFOfEDxQL9sx3ao4o1/iLIrDJxTbGLsAibjfTx1D+ZC2H76mC
         ATtZjrAPjB6uuuyF64y90CJfhHJAF0PEKzxPgGzg6j31KlYzbPyDOSAAtswYYv5o9Ipa
         B8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM+279i7WsjACFordyvp85i2eOOsPySMwcKVrkkc3ZY=;
        b=XpfQjO15Sgj6eSE1ehmVMjRlK1xuW2z66ggpIlpQRM/yG95ajqOqTcXbpxYCj4Cn85
         4Xdk1VkefaIwz04pZLvyKn+qLZiwFMBB95gCVZqT3r9vJAir71UbS9JM9ULawy5quzQM
         jgzCVyMj7kFUMKw2eBCC43ZOqsmXqvdm+hjBwgHx+dMpJeatk3Xua/R7qIQ19dn3+0hz
         fSbDgIrVaqvISJgspjXP+7JQs1ronBVBRAi9TCnHZ0k2NVer6deQcL6xXJxcEk781b+A
         tHpUKH11AqZolu4rMx7CSU/2UVZmd72ClCGWYSaYtbr8zcVY1iU7lPYF0LAfqdcUiDtK
         rIvg==
X-Gm-Message-State: AAQBX9fbJPCp5Dyw+smxYxpqOEkbxRfDTPx+4XYlk9fHaOOaSz+m9OTL
        jrwLgPy3rVs+0TbY+rfQG7pIjolFSmsW8SSZFZY=
X-Google-Smtp-Source: AKy350ZJuTgIXr5+7H4weRFDesqPF/LQ86Q6hPgNaS65m6cVpcDVxR9rl3uyDlwc6i/BqNAgqL81mMIsKZZ9L3TXJ7M=
X-Received: by 2002:a25:c6d3:0:b0:b6d:fc53:c5c0 with SMTP id
 k202-20020a25c6d3000000b00b6dfc53c5c0mr2224663ybf.1.1680707277588; Wed, 05
 Apr 2023 08:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzg7nw5gq.fsf@gitster.g>
In-Reply-To: <xmqqzg7nw5gq.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 10:07:46 -0500
Message-ID: <CAMP44s1ePrbxQc3KzU8A2Z-ZMXTaJHyt5hh9JsY337kd=OvOCw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2023, #01; Tue, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 7:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Here are the topics that have been cooking in my tree.

Any reason why this patch to remove a workaround only needed for ~2005
software wasn't picked?

https://lore.kernel.org/git/20230322000815.132128-1-felipe.contreras@gmail.=
com/


--=20
Felipe Contreras
