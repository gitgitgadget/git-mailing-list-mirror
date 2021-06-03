Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24898C47098
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07191613B1
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFCSfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:35:08 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:38852 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhFCSfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 14:35:07 -0400
Received: by mail-qv1-f47.google.com with SMTP id d7so1436379qvo.5
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OoHANQlPdmdxUTdPgHLtvclQnRHhZiMdM5tloSF7Of0=;
        b=BhpZwR5/he4DsOuDkKfhwSGju+QlctluMTRt+NKJuCznGOIGJHtJCWKWC6QE9NCCGZ
         KR1gDhyKRB+UOxhBQlXoTXJ50YajnviHFGvb79N0Hv5TVnPO5vgvF2WdJSIXJc+uJgWD
         1SwCptqw5qfcKfY7tpA9R41vjfxQ8vzuci1+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OoHANQlPdmdxUTdPgHLtvclQnRHhZiMdM5tloSF7Of0=;
        b=lJSb5RZBFG85I2dGRsCOHB1nerQXB8I0H7ZK2fp4KISiLzGxf5rifRcwp+iUHQrpBU
         bOwyNQ/2gHp6jGf6yqDpM5QN30PlsNOF3oFidWOvyTKC8dR+PVG0P7z5kPc/nQ/9iIv9
         HKBXqoZEXreDo5pUzaYM5kBpNDKzrLqDfSApj9ah/Wl8sf75Zq6f5QBd5n1OjM025N6b
         MC3/HijFqBxI3s+MhXuwLBwXXm/ItK/kp/hlYp4fjYuaKUnQCNWf4XQrRLt0aE/Z44ah
         KRqDl0lZBhS/mzYWxLq75sCsztVaMXKB50E3yZhAfQVsHQYiPgK2ELLQK/0ewX5gYA5S
         Q5MQ==
X-Gm-Message-State: AOAM530g9IwzpYf1h5KSHNA3mxFL337DGwCXl6WhcMiy5lAe2KVdk2p0
        DPFN4Mw1gqnEQQUTISfR4RAqeEk5yGvC8oI6/Vw=
X-Google-Smtp-Source: ABdhPJz8z2b1eXFipq4PhXuhxudsEEX3ac9tnLdaqtH9jCMCnWdWgu4VEo90c3CwxVhlTxFktCNzJQ==
X-Received: by 2002:a0c:e185:: with SMTP id p5mr875684qvl.17.1622745142286;
        Thu, 03 Jun 2021 11:32:22 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id i14sm2545979qkn.99.2021.06.03.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 11:32:21 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:32:20 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <20210603183220.47nx7f2aazk6wy33@nitro.local>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 02:25:42PM -0400, Eric Sunshine wrote:
> > The fact that Gmail forces folks to enable 2fa for app passwords is an added
> > bonus in my book. :)
> 
> The 2fa requirement is a problem for those of us who don't have
> smartphones or SMS. (I see now that they also offer 8-digit backup
> codes to print out for 2fa; perhaps that might be a workable option,
> though I haven't tested it.)

I'm not going to argue too much, but I'd say that someone who's looking for
solution to use with git-send-email is *likely* going to have access to a
smartphone. :)

It's also possible to use TOTP without a smartphone (e.g. via a desktop app),
though this would largely defeat the purpose.

-K
