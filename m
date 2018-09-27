Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B32C1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeI1ED0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:03:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI1EDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:03:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id z14-v6so4174835wrs.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hmfo1yI0rzefaUy50nCAifDqTQ9E80lN6PZ1VkEyKeE=;
        b=BmG3lQ9i8fN24wYkQsFbUI5uTSxZCFOKf4dtZAVSpfl17uLx6MrwH3Nmr+VcEbxNOU
         vVYGOXBTNdkXV7fi8HW9BQ5xqwtS0OYrl60B5e6oMC/EBLUbcLZgBf1sGXKzifpdpS/s
         +jtKwm+lLVaR0amEblSpmBcoZiQXh/BRNzTsixcMtm802zQOt8rMtOFfjmyWTjXZW7a7
         30mNfUP5KQDLAtGdhYfocqDpa7zrGOBemMgY0cVbxmA5sS5yv4w40le2tWs0N7SSLnT9
         wx1HbnyOX88AYhe9tRfdWOdY5f7n92V7zZAyDaiLTfPDUiRTEHPMyrOprRrTBge5MfbH
         fQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hmfo1yI0rzefaUy50nCAifDqTQ9E80lN6PZ1VkEyKeE=;
        b=qq+h+mW008SBE68XWpiuDoSGVvc0j9sjXRt9UbWQlRoWrRGaS3SJtD8FTZF9TzEGDc
         LTVCqZWxAx1chpTNQ3knTKHrNdBbqaONkSvN0vGENci5ApZoFFyWrYiyp7gOeL2GD9fc
         P3aWmo3cs33GOWN9YQF8q+jy7zaRG3ZIPO/boY1yoCWu5FQkEkwj7BchozCg0IZtKbZu
         zvWgSvJfTA3WL6YpMod2XPtkmRnqlLRt5/N6DA4QTGYhbJ/332P+0ErJaxBZTuX+NYjn
         HOH5tJX341Ajg2gtXVtCG0dh9I+7gbjo/S5P/lknQwz9wMNbMDkRjwZPAxLYidTMBmy9
         9I1w==
X-Gm-Message-State: ABuFfojAYab7HYABZZ0vROPPq+nO6S182TJLTcZ4l7E8Jbj7wobEapvo
        0NCYfX3jT17m+kbi9s1dTp4=
X-Google-Smtp-Source: ACcGV60peNmDf6Q8m3YRns4mCLRBwMnVpPxyxMCJJ7o8ppKWg6RfJMFCBPyQByJDUa8RCK3emPNdjQ==
X-Received: by 2002:adf:a969:: with SMTP id u96-v6mr10085692wrc.222.1538084583299;
        Thu, 27 Sep 2018 14:43:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 94-v6sm3793314wrc.10.2018.09.27.14.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 14:43:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
        <20180927212727.128214-1-sbeller@google.com>
Date:   Thu, 27 Sep 2018 14:43:02 -0700
In-Reply-To: <20180927212727.128214-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 27 Sep 2018 14:27:27 -0700")
Message-ID: <xmqqftxufwgp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There are different opinions on how to document an API properly.
> Discussion turns out nobody disagrees with documenting new APIs on the
> function level in the header file and high level concepts in

Looks conditionally good ;-) Thanks for keeping the ball rolling.

I didn't get an impression that "next to implementation" vs "in
header to force people write clearly" was totally settled.  I'd wait
until Ævar says something on this ;-)


> Documentation/technical, so let's state that in the guidelines.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  This is how I would approach the documentation patch.
>  
>  Thanks,
>  Stefan
>  
>  Documentation/CodingGuidelines | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>  
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 48aa4edfbd..15bfb8bbb8 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -358,7 +358,10 @@ For C programs:
>     string_list for sorted string lists, a hash map (mapping struct
>     objects) named "struct decorate", amongst other things.
>  
> - - When you come up with an API, document it.
> + - When you come up with an API, document the functions in the header
> +   and highlevel concepts in Documentation/technical/. Note that this
> +   directory still contains function level documentation as historically
> +   everything was documented there.
>  
>   - The first #include in C files, except in platform specific compat/
>     implementations, must be either "git-compat-util.h", "cache.h" or
