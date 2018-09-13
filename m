Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876411F404
	for <e@80x24.org>; Thu, 13 Sep 2018 15:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeIMUN0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 16:13:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36859 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeIMUN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 16:13:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so6198656wrt.3
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6KkgY2ek1LUYb4HV30Sz9jIJPDl49ufsjXuFeJTB8m8=;
        b=UQQecGpo48cVXEszEB1vgGDWtJRFIV5PeFzWDMRwqCI5DcCLXjKJDpcNNtEKGB5TLh
         KgOhJTvzSJHQvq4+TWrd4yMADAJ5mogEcPsIAFvSZ2jEa+47sH6WV/DI7M6hs65yZZI4
         Xj7xv1z041/mj4DvLLAEMC/r5wKD/4i9ENstEB0peWy0dnWCFdIBwWoi8JUUROyBE4rS
         ixu1jUjx7AK0h5NYc9W1PUbS5ukdYo9hI6qjVdO7nZHHVOlvCP6Nakqa2veRfn151vS4
         w2BgmFgkMrtsLcXy4MzlPmjRxS/bKmnnqSvBPJVJEiUj5BoUqakpYje0Acj0gYvg2TCY
         xwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6KkgY2ek1LUYb4HV30Sz9jIJPDl49ufsjXuFeJTB8m8=;
        b=pvg8q84W+L8pBWIGZ1LIQFRJBTHGqzjcBDeG1vWyy3ax8tajc6xZ/bwHfaIhFvOBTp
         2Lr3+bAu6hkvGFkKgu3zH/Yl1szOvbTUpYzp4iWt4qSZq7vbm6KJ5Ac42zvX5LQt6/n9
         NEEsmigYZ2Xr8hZxsuVfCaU1BnMvHlGnt8Y5OQlJw7oppz1oXnQfY0uRfWAqcODdpCc2
         JmZxDMwdQG/0X/7MWIa0W7ilPXB+BRmfBhXIQbw66XWfvjc9ID8c+YIkGRpQNcuC/qZy
         ybwp4AuulPZl//jGCPXTg7rizobNr+kPi/4UYutaZFN1yEP1+Zo6s3fH7w3k0Bi15KCf
         2kVA==
X-Gm-Message-State: APzg51BniaRZ7dWULMd0zx6NRMfQfYLqpq8sapw1IpYT/C3KK5phgOir
        VbYIK0ptaxRBQoMeXs3xAOU=
X-Google-Smtp-Source: ANB0Vdao8x4FPFg48n221lLB8L8qnr5ZO0pf5N390bmZGgr5pxrRt7E9RC3QTBZM6OSgHIoLLusFQw==
X-Received: by 2002:a7b:c248:: with SMTP id b8-v6mr6177369wmj.21.1536851010356;
        Thu, 13 Sep 2018 08:03:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h206-v6sm3966726wmf.25.2018.09.13.08.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 08:03:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
Subject: Re: [Question] Signature calculation ignoring parts of binary files
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>
        <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org>
        <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com>
        <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com>
        <xmqq1s9yjp9j.fsf@gitster-ct.c.googlers.com>
        <001101d44b5b$fa337350$ee9a59f0$@nexbridge.com>
Date:   Thu, 13 Sep 2018 08:03:29 -0700
In-Reply-To: <001101d44b5b$fa337350$ee9a59f0$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 13 Sep 2018 08:19:04 -0400")
Message-ID: <xmqqefdxign2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> The scenario is slightly different.
> 1. Person A gives me a new binary file-1 with fingerprint A1. This goes into
> git unchanged.
> 2. Person B gives me binary file-2 with fingerprint B2. This does not go
> into git yet.
> 3. We attempt a git diff between the committed file-1 and uncommitted file-2
> using a textconv implementation that strips what we don't need to compare.
> 4. If file-1 and file-2 have no difference when textconv is used, file-2 is
> not added and not committed. It is discarded with impunity, never to be seen
> again, although we might whine a lot at the user for attempting to put
> file-2 in - but that's not git's issue.

You are forgetting that Git is a distributed version control system,
aren't you?  Person A and B can introduce their "moral equivalent
but bytewise different" copies to their repository under the same
object name, and you can pull from them--what happens?

It is fundamental that one object name given to Git identifies one
specific byte sequence contained in an object uniquely.  Once you
broke that, you no longer have Git.

