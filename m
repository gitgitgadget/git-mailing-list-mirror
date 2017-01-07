Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F8E1FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162076AbdAGBBS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:01:18 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33624 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034256AbdAGBBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:01:17 -0500
Received: by mail-qk0-f182.google.com with SMTP id s140so68640173qke.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 17:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+3OzZCoDnFD/RfQ+YalSq+yU1XilMX4OBW+bGLL30c=;
        b=eJG2FNLm/vCXnkPcrdlN0bLWWEnk2OYH0HGSyOyCSYy6RhK88L34xVjQIPugQKrMYH
         Gsb5nOgfRWpgtbIcvG3LplkdPtp4KeXU2BWTgVbsRfhsMex4nD+B4OvXjXuHhV4Xd84n
         lhPi2HM6WOOrDZV8Wf6vxMnVJFHcNNlnXvdeUNk0nYdy99oeut9vIZhvWR4+qW8eBH8M
         zLRxGgPnaGLNy++zgfhKkEAg21SPuR+zDjIo0+m+OgNIHlhdZ3TO4Uqa+3B3a8KeE2nC
         Xg6CbFHBEtGdSWvz6X5KeaEnM2N05JeOuHY2gSW1nXdY6/heQmKrFmXBORvn5tBD3i5I
         42fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+3OzZCoDnFD/RfQ+YalSq+yU1XilMX4OBW+bGLL30c=;
        b=jOXFOFcDuXdG2F5UJfM33Kc7fRTYr+J0pajDgyjoXshFvfQ4cGaSqUj6+S1AY7eeO9
         90i9njqNXW1ABiyh5uuE59U0QB8eurnWwqB+rS3584XwYZ7Uzec0LtwfZbeziMiiB27v
         mAYsb+x6Eu87lnwVi8Z7emrOiePsqsyGna/wKKrP9zOmolRZLbBRsOzr6rFL5/MM7wmD
         lWp5VKfT4vA8JIeq/IFV5vUbdsYqMgzcZlIcKv/B04okw3nYYNSWpRQT5No+VxpYjUBB
         0i5LraciE83qwuQUCcNTF3hNxx2Cnn2+bZGwzHS3GLOmTgyabsYcBdjXs/v7gy/iPDDD
         /Jpg==
X-Gm-Message-State: AIkVDXITvSCsMrmpJvCA9W9BGI0N5vvgJ91Nyfvpa8gdhmGtFdAhik+W8QzOB709qDF7GPCxgbiK7qbNV90kbzPe
X-Received: by 10.55.105.129 with SMTP id e123mr82602342qkc.173.1483750876291;
 Fri, 06 Jan 2017 17:01:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Fri, 6 Jan 2017 17:01:15 -0800 (PST)
In-Reply-To: <1483750501.31165.9.camel@frank>
References: <20170107001953.3196-1-sbeller@google.com> <1483750501.31165.9.camel@frank>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Jan 2017 17:01:15 -0800
Message-ID: <CAGZ79kZDebuqV7q-bcqG-g7E8hBq3RMa0jSDgD1Ho5BN0sByog@mail.gmail.com>
Subject: Re: [PATCH] submodule update --init: displays correct path from submodule
To:     David Turner <novalis@novalis.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 4:55 PM, David Turner <novalis@novalis.org> wrote:
> (for the test)
> Signed-off-by: David Turner <dturner@twosigma.com>
>
> TIL: super-prefix!

yeah that was introduced recently for prefixes from "outside the repository"
e.g. a superproject, its first user is grep --recurse-submodules.

Also I realize I have set diff.context to 15 as I was experimenting
with it earlier,
and forgot to turn it off. So a lot of context in the diff for the patch.

Thanks for the bug report,
Stefan
