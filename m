Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725FF2022D
	for <e@80x24.org>; Tue, 28 Feb 2017 07:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdB1HfI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 02:35:08 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:34793 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdB1HfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 02:35:07 -0500
Received: by mail-io0-f169.google.com with SMTP id 90so4248376ios.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 23:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc;
        bh=g/EN10fDnRvE/e2U3djKf4vwCbTbKzZ0QdJG9S2XUws=;
        b=mQ6mlVpIALM6xjwWwplB2WWT8Z0m/Opii9T2jVVNXLrV+GyoHJX5Qy+ECp2sL1v7i/
         SUlEWyn4hTdu493UL8o0DsK+ApoIqiCojE+rsbXvzRyDcrrm9RfW4BjBzJSGp6XcukwI
         nvwC6CVIsg15aZ4Hh3t4lt9IM28dwSYRN9Z6qAmGFFlry9nldSnu4Blpp2ZPmyJVTbFp
         S5KcK5bCvpCbLJO6re+6eK5aXFhqHcKYf4lCWUk9qMapNpdbO/SXb2UJduUQe9+kmQhr
         GQh6WNPsm9/lpPv/o5BDEU6L8aDVagdnCu5rjUHcCb3+bxCAiOLjnHGNM+s3NagriyDD
         Cneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc;
        bh=g/EN10fDnRvE/e2U3djKf4vwCbTbKzZ0QdJG9S2XUws=;
        b=lvqTrCJX2k9+fyMfa8+1SJ1aHNkwdQUihMdZWfPWFwKEdhfYcJ0JPRAdfcJQhaI31N
         kk+W5wY4Z5Eq4v9v8NuHw4/+/aAKMvbhqZHYA/1wnAEK0wfdbvumjirG3lmnAosKsAM9
         x63TJGvEDywLckgnTaugVXfBXA0zdJWGZsdYMZrTq7jzcxyPK6GZaHWosFrtSWM+WAGw
         9fXanHIm8BsEVjnU5ZE/FAULq1rC5tgoyXcefnuIj7sDmYje8gfU9/yue5r3pMZC/zTi
         oZkJeTIWDMvzBaQB+Kx2d/AwUDZ0Pli1ZLN4fjSfKovL+brX1lcG6b/0G5RreLsEHWG9
         ZQbQ==
X-Gm-Message-State: AMke39lvxqFoiOhmr6uj+Z6PzStET1ZylA97/ST4XAbPd5TrW9YoH6WGCMtYPufuOQgQvWD8btKl3F2weHDjHhIg
X-Received: by 10.107.181.2 with SMTP id e2mr1008513iof.20.1488263404834; Mon,
 27 Feb 2017 22:30:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.101.129 with HTTP; Mon, 27 Feb 2017 22:30:04 -0800 (PST)
In-Reply-To: <CAAj3zPzwWr4u1qSMp5CwVMzExW2eg9LQ7t7RX-5m6fRRGh9pcA@mail.gmail.com>
References: <CAAj3zPzwWr4u1qSMp5CwVMzExW2eg9LQ7t7RX-5m6fRRGh9pcA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 27 Feb 2017 22:30:04 -0800
Message-ID: <CAGyf7-Hp5b5r-NROVehnpwS2cSdwMz_kSUgzaQJ03Ba+K8g9wA@mail.gmail.com>
Subject: Re: [RFC] - url-safe base64 commit-id's
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 6:27 PM, G. Sylvie Davies
<sylvie@bit-booster.com> wrote:
> Is there any appetite for base64'd commit-id's, using the url-safe
> variant (e.g. RFC 4648 [1] with padding removed)?
>
> And so this:
> 712bad335dfa9c410a83f9873614a19726acb3a8
>
> Becomes this:
> cSutM136nEEKg_mHNhShlyass6g
>
>
> Under the hood things cannot change (e.g., ".git/objects/71/") because
> file systems are not always case sensitive.
>
> But for "git log" and "git show" output it would be nice. And helps
> with ambiguous commit id's too if you only want to specify a 7
> character commit-id, since that encodes 42 bits instead of 28 bits.
> I've run into problems with maximum command length on windows (32767
> chars) because I was specifying so many commit-ids on the command-line
> that I blew past that limit. This would help there, too.

Depending on the command, have you considered using stdin instead? git log,
for example, is perfectly happy to read commit IDs from stdin instead of
the command line.

In general, I think the pattern of getting away from command line arguments
is better than trying to shoehorn more data into the same character limit.
Base64 encoding might help get a few more arguments into the available
limit, but in the end it's not going to solve the underlying problem.

>
> Might be particularly helpful with the transition to a new hash.
> e.g., a 43 character Base64 id instead of a 64 character hex id.
>
>
> - Sylvie
>
> [1] - https://tools.ietf.org/html/rfc4648#page-7
