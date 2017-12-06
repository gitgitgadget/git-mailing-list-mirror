Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D62C20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 22:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbdLFWHX (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 17:07:23 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:45439 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdLFWHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 17:07:22 -0500
Received: by mail-qt0-f180.google.com with SMTP id g10so12793762qtj.12
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DoRPMB4Jwd1nVQk3LjyTiJ83Qe9Vs4f3HC9UD91Q4wc=;
        b=stj9QmOFTZ9aJLB4whMG33xD80eYQqGKySXVjAL6/WKJi++2Xv+EL3+JTrXb0zZtBF
         Rt3Zhqis2QhbKq7tjtlFLb7u78d77KxT8jCFgzCuA5WekzYP+8Z7eFnGKSVhv/xjLMqR
         2tJfufYQkpThWH1AvkYGN7V95LXG+s8KAtaxYxybUyaoL8X3N1zLZQDwy+URcozZsEbZ
         va/AqVqYxnp2xkXfktiaJu+HL31aejjz7Fy2C62aMNHzr9DQod+GZCcbqJTiKHeoZ764
         6alwNgmXPLSP7qqRHAPy1WknmMdQz5i0zbfVYIJk0xmh82kg2JjCaGEP23sN5N4pY9sZ
         aNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DoRPMB4Jwd1nVQk3LjyTiJ83Qe9Vs4f3HC9UD91Q4wc=;
        b=M8sZOwzQQUD39iA02e/kTnH7or7FdB2IskqGbnwWkuSJX1AaMVc3UXIn/VjTShZcft
         oTOWgdqvpOeFZjqhVnTRdekBq7gAe0HRhp2cA8k09cZ1BrNWW7x/fLKSEfkw8HPHJwiw
         iUibO/C5LCKAQyJQMezreR+uHE9PgPzQEbxmfJ7PomVWu3X1jFQfOloi9qbzZE3Doku+
         w6+GvjjbvzNgYMauXEcbJv83UN4c2/ANlj8pFHQXFis3e19lrb7kZg+FNKDQ3L7d6cLy
         XqdmaUR03wLmxP4t/+2MVWGRxYGM9tXoXSy2GL6oPxvvordCUYcQHKrFQ1UCv572LM02
         s6OQ==
X-Gm-Message-State: AKGB3mKfB5ZgxA7c1Bc6czw3FvTpbqn7SuJO2ra9rHayoq0SMML82iGc
        1NamGzZtyxIZcH1qFlCciDhdMJCIorsvY0nvpTE=
X-Google-Smtp-Source: AGs4zMbg6o0PSY0knvKSLwHPE0cyD1EFF0NBxw9CjSNFdDvboEfQvNPPnOJA+rnxqVVbFuh+potp4mj1Ro259nzc8qU=
X-Received: by 10.200.39.104 with SMTP id h37mr6621449qth.114.1512598041875;
 Wed, 06 Dec 2017 14:07:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Wed, 6 Dec 2017 14:07:21 -0800 (PST)
In-Reply-To: <20171206220055.GB118027@google.com>
References: <20171205194801.GA31721@megas.kitware.com> <20171205221337.140548-1-bmwill@google.com>
 <CAPig+cS6zf3AvQVi7PZf=ignL-7JZKzYUyN9RoJSPZzL=Dj7FA@mail.gmail.com> <20171206220055.GB118027@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Dec 2017 17:07:21 -0500
X-Google-Sender-Auth: 1XJdRB4Vq2HYbptzkZjFrGUIV4E
Message-ID: <CAPig+cSNwPJkVNNbnp-rh-jXgwrEXhvzVHZoQM6wQMQNjn5n5Q@mail.gmail.com>
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in
 bare repositories
To:     Brandon Williams <bmwill@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Ben Boeckel <ben.boeckel@kitware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 5:00 PM, Brandon Williams <bmwill@google.com> wrote:
> On 12/05, Eric Sunshine wrote:
>> 557a5998d (submodule: remove gitmodules_config, 2017-08-03) touched a
>> fair number of built-in commands. It's not clear from the current
>> patch's commit message if diff-tree is the only command which
>> regressed. Is it? Or are other commands also likely to have regressed?
>> Perhaps the commit message could say something about this. For
>> instance: "All other commands touched by 557a5998d have been audited
>> and were found to be regression-free" or "Other commands may regress
>> in the same way, but we will take a wait-and-see attitude and fix them
>> as needed because <fill-in-reason>".
>
> I don't know if any other commands have regressed.  This was such an odd
> regression that I think it would be difficult to say for certain that
> there couldn't be others.  I did go through the affected builtins to see
> if I could find anything.  I came up empty handed so I think we should
> be ok.

Thanks for the response. It would be nice to have this explained in
the commit message so that future readers don't have to wonder about
it.
