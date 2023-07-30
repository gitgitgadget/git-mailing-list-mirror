Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9987C001DC
	for <git@archiver.kernel.org>; Sun, 30 Jul 2023 01:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjG3Bfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jul 2023 21:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG3Bfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2023 21:35:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F641700
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 18:35:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bc0a20b54so527932966b.1
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 18:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690680935; x=1691285735;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74QvVnyQU+3Ow/mvA5b4gjB09B1n/JvXWRYyFs7Sj24=;
        b=jwLyy9QA4alHq2U5TYcNBSsiG8duwIGWyd3R3UOmUfhbJJaQjduxgv0IYMDs7g98Ce
         pG0YCX7rQ/CIV9I0augZYe5iIQPDrvr+8VBhi61IU9VM6dTMJZ5iNERwut4nbY71QyTS
         IJbQlQDoGSOEHf6MGwQxNNuKOjS19A0AY4FPUwdFengslZebMs1h/vSBkfknk3rHWVzX
         zPUqy3QjBsCThbxZ6vVOz8cI/AuEFlmQ0tg5SDcqmaAMtBUdIp7DzNdHN5VJj2izV/l+
         t2EeybycrAj0Xsp14LSU1ohOFCV1PjNiFjmoMNzwkb1BuUEHki5LONDQgWBwtF+3bl7a
         lzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690680935; x=1691285735;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74QvVnyQU+3Ow/mvA5b4gjB09B1n/JvXWRYyFs7Sj24=;
        b=V5SSTRNUYEKnBKYIuFJaiASa0/XwQRZdegH++HKFQqIsyGt9gLokdpV9ZKtNjGZEIM
         OUtIvSI49G5UrDeZpeYGYHuyYlWvFFv8OylTsJ/hIv/fRzeYrkcreBrEQVJsrHGa6i9O
         V3vKk+MI0c2kPm+8PrPwAKl/insZU2pa63WIE2PNM7kpK0gxXsytM85RCWlByhToUKWU
         sA7CwrX9QTZ/zyIe9kz69t5rQezbaaSTThH1ryV7fCsGIhWjqERN+3Vh7P6MnzJZreky
         t4qpi4V8W7Vmoom9fc6OlL0GiPpI4bARJzR8BTKqHcspAQ7hpLP0WyYAdM47mm8EnTu6
         E12Q==
X-Gm-Message-State: ABy/qLb0hgYMtLVasY4mEUcdlMQk0dixsoqdX9t5KhVJe4h4L/uiX1Db
        iiBdrZxymqFaZ157TRVCxJzvy8qqihc=
X-Google-Smtp-Source: APBJJlFbLHcyYXQ3JCakd+oGYsdscyOTH756TqZ4E6uc88uFo+v2n8PEEGxKC2aIsGk8dl3/kzkEag==
X-Received: by 2002:a17:906:2216:b0:993:f4cd:34b5 with SMTP id s22-20020a170906221600b00993f4cd34b5mr3788207ejs.29.1690680935163;
        Sat, 29 Jul 2023 18:35:35 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm8848843wrm.3.2023.07.29.18.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 18:35:34 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2023, #06; Thu, 27)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh6po95a5.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <3267d00f-d7b7-1288-108c-21823265d854@gmail.com>
Date:   Sun, 30 Jul 2023 03:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqh6po95a5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jc/branch-in-use-error-message (2023-07-21) 1 commit
>  - branch: update the message to refuse touching a branch in-use
> 
>  "git branch -f X" to repoint the branch X seid that X was "checked
>  out" in another worktree, even when branch X was not and instead
>  being bisected or rebased.  The message was reworded to say the
>  branch was "in use".
> 
>  Will merge to 'next'?
>  source: <xmqqr0p1szhz.fsf_-_@gitster.g>

I think, this is a good refinement of the message to describe an
implicitly checked out branch.  Therefore, no objection to merge it to
next.
