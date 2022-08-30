Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7CECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 04:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH3EDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 00:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiH3EDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 00:03:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AFAAA4E0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:03:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w28so7690125qtc.7
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=9D5Z167+h9eYInPkffo6m0ufVd7eVn3MHvy4h0Yw/98=;
        b=bBdactww+0vSJoQFvkNkl6rnFoQN0ncPc8iz4y/uzZ+WxYziLUVmC6LDDBwKb+vTnw
         1v98IrfLA2QBoDLGLKvIuEsPFrMw9hzWTXTgyv1yLtD7s7uSZTJJagHtKZh1+AcWL2+A
         b33NvoYt7Z5mVxeXPH28hueOKGMo6Dnu1KdeRFqr/P6MV5RFoUeHsWxO18yBW7bk7Wsh
         zc3JAT9R8DEOpdDbl9q6AFP4d6HmbU1coWZ0JLYg60ZNyvsyQeKoloKMxHliJ6wpualy
         KK0nGM3QikYkQ0CrdNM0HIhSthDPL8XdK94Vbd0NzU10rpj2g5XoyCj9pBw32x2hIRAu
         3ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=9D5Z167+h9eYInPkffo6m0ufVd7eVn3MHvy4h0Yw/98=;
        b=yEbX9KZBlrZyipO28VeVX5FufE4xFUcTX5JFdWiEqI7hzonBESaC6pIy6HaWK7/ivg
         pOR8t0rajkn5nIzl+BWNLptsxeXKgxeGI9HslQc0XrFuRiJEll1M8kJ0Q7m/k2Mu4nzU
         RRAvbIka/nQOr+xhib5RPc4LSbjFr5LCxhI+xhUxuo5i8ZTQ3wyCgsGK1bdd5+9sDrJr
         kkyRFCJ4S+Cp3Kp+MThyFjf+F4kswln+ZnGyL03sey83Cw5SsfiG58sjRM9MDDp+hzav
         mZgZPQbxJPXRrrp/dRkGq11PYXD2vR3qNkp3vzu3LQvlT8qfP/K0uV5JdtNezwV0TJAH
         2V3A==
X-Gm-Message-State: ACgBeo13kmekagsqFesoyY3QaE1N7WcyzujAXivg7hxJJ7Vrei30Gwc9
        uvBbYPXT9mGBYwsx0ugMDbWHnrf6zoE=
X-Google-Smtp-Source: AA6agR5eQiauUDs5TsY2l7YuN+8nfeAylbcgF17JHNoOWJxPqtPHqay7uSr1taEF3C5Od6vI6qheKQ==
X-Received: by 2002:a05:622a:3cc:b0:343:7396:4824 with SMTP id k12-20020a05622a03cc00b0034373964824mr13030901qtx.680.1661832185005;
        Mon, 29 Aug 2022 21:03:05 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id v10-20020ac873ca000000b00342f960d26esm6215902qtp.15.2022.08.29.21.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 21:03:04 -0700 (PDT)
Subject: Re: [PATCH 3/6] t5617: drop references to remote-tracking branches
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
 <d8a2faf9ce7de2562424181109120a6d84b0e470.1661806456.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <2a887485-a335-cc73-493a-5b835171db8a@gmail.com>
Date:   Tue, 30 Aug 2022 00:03:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d8a2faf9ce7de2562424181109120a6d84b0e470.1661806456.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-08-29 à 16:54, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>
> 
> It has included submodule cloning tests without remote-tracking branches
> tests since f05da2b48b (clone, submodule: pass partial clone filters to
> submodules, 2022-02-04) at least. Rename it accordingly so that we can
> put future submodule cloning tests there.

I think it was named "*-remote" because it was introduced when 
'git clone --remote-submodules' was added in 4c6910163a 
(clone: add `--remote-submodules` flag, 2019-05-19).

In any case, nice clean-up!
