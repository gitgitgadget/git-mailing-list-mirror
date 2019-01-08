Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03981F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfAHSb0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:31:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38869 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAHSb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:31:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so5481353wml.3
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I4O734f6xsIdllveufhB5PGyvxW4GwY4g0cXghldPLo=;
        b=a+HgddmB6yPVJX8x15AiFwCkv5aiNplOvRCwUMNpYfTHG4riUsGa2kkeuAzNmxClVr
         03C1+fE7VM9hD0AdES3TKcon0wd8xCqdpA3HF7h/2+H0IPvqxo3MabAJZ2dqeN2pFNqi
         2n179TktZh8wQ643Myz4tLs3P30cjnUVac5AQruLpwFmEpV7SyqHIo5zI+VJ79zHyNJH
         woOj9Wv0HOsuqD0CLlV1x1Du2DtyXNcijrRVTxkQyr+DgcnTVeBe/Y/sU5cee8bc2jn2
         7Jdd4ihUJRYBdyoujkNhQ2qGLtzXH1l7eTZqgBSlqmx49h4b141s0CmANQR1Piz82AjM
         vYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I4O734f6xsIdllveufhB5PGyvxW4GwY4g0cXghldPLo=;
        b=b+YkNDZrXyLCOnfwAbiKnsD3BwkgARJYRqbuqwWXyFmBEXltTAq+2QQW375VP+RvSh
         KUlwvBbpKvVfn78peBzI90UjLzsT1kMl8xlvJJI2QCCiqnbGKRgKh8FMK3uz0vWuoMFO
         Nk7+VM1adZaukxVn/Ylqd8urOutz0KWtI9qA5YzgoNgEJHqHakmZJZ/WPdV94EOTzkKF
         L58DOY+fzALJNX0dODjm204n44C4iIwuYlqtcyVIcPvj6XXPyStYiWscY+IAutewO/RX
         sdLID/8apFlWQnT3G4giPhYpPMV704N55AjgkXTVXPARAQl8aCQOFgZj6Xu83fI5feBr
         R9Wg==
X-Gm-Message-State: AJcUukelYy6UmJ+4Cwq9IGGyJTo3sNvSdOGPVCV+UNeejEobUTQY6lJr
        u6F8KLPNW/wsseOCG6n/Du4=
X-Google-Smtp-Source: ALg8bN6w9bhmVzX0FDuIBg7oYgCgtozmo04IxKy0L6ATPbLuCbGpYYy4AoEMx/5X+D2B7PK7GokCrA==
X-Received: by 2002:a1c:bc82:: with SMTP id m124mr2547723wmf.77.1546972284423;
        Tue, 08 Jan 2019 10:31:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s66sm9060987wmf.34.2019.01.08.10.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:31:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/9] diff --color-moved-ws fixes and enhancment
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
        <20181123111658.30342-1-phillip.wood@talktalk.net>
        <402b9c01-cd7c-79f3-9fde-55907f03c406@talktalk.net>
Date:   Tue, 08 Jan 2019 10:31:22 -0800
In-Reply-To: <402b9c01-cd7c-79f3-9fde-55907f03c406@talktalk.net> (Phillip
        Wood's message of "Tue, 8 Jan 2019 16:22:20 +0000")
Message-ID: <xmqqh8ej57d1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> I just wanted to check that these patches are on your radar as they
> haven't made it into pu yet.

Sorry, but they were not on my radar.  I was waiting for comments to
come in on them before doing anything, and now it is more than a
month ago X-<.
