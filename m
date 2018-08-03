Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16201F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeHDAej (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:34:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52610 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbeHDAej (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:34:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so7713527wmh.2
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4o2rONWgIm6yanaE5+9cpLB0tkiZdhK7kjCTTF3xztA=;
        b=a50D5ra7CSwfTHUuoWJjtE2uaCvdpg40Ga+IurcjWwV1uDEtUUmNLs/5WCQrJ2Q/0c
         /pLfpZRATxgmqcWWovms9a3ppTJwvg2z4xNtuIWgUBii27YwL1Iub9Xw8Ld3XFmzpOKz
         LMo6QbqvZKA7/z99Ot7SOisU7/KtEnzWj5UNlQv0a6nLLqg7v43U259Nd9bxu+Eg0uK0
         OxPHPnEwtHQn5URgZV8VRWgbEkGItjolfNbOt+d+63PnIkWOb/oU8XRs2RssTALTtZC0
         ZQigFuE8pYRLPNUaKCkUW7xFj5yIKIkD1rXwjMBbW2wCE8+sszkKfDCe/vAr+OYnRBW4
         1a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4o2rONWgIm6yanaE5+9cpLB0tkiZdhK7kjCTTF3xztA=;
        b=ttj+v3hElzQooEO+9RXU23gXVMflCTtDXkAvIIeDR1IS64nq7Rp7Ya3I9WUHLknYaz
         FoHCGhXZSIbhmdewmVUpimYT4qBqFemN1X3x9/aLZovDNqqsinAPvq56lYyXn7m4v9yy
         nOSyJfQlm1Rxzb3dAgvj3oOmNvf6TLQx2ItyTY39mT594QBRbWY5inlv6v8iNvGiDWDo
         qRfQWcrwNI6VyLYfST9I0AFx8jV/fNwOk1ln7yc+HmI7xXM07notRzEwGEIT8/vQ6WtX
         aiQpkdOE7K4bqabvaVHe2abRwBKo50YAplc3QL/MOOEadAxI9Ydl5Qt9k4Eyfij3YYSE
         lDAQ==
X-Gm-Message-State: AOUpUlHwDkWapqpv2MV/PUYqEiBMEQjDVV7fDQvJu1Fk548SyBYrATTz
        qyjbmrGiLl4OViUFqN0CqUqbzGx1
X-Google-Smtp-Source: AAOMgpfh4+4pWVCc73ZoOxblwvncx8POrbf0jng2wybSyoUKE1gcfXwcU93GiwmbAaqGl4KApcLUzw==
X-Received: by 2002:a1c:7d47:: with SMTP id y68-v6mr5745371wmc.62.1533335783424;
        Fri, 03 Aug 2018 15:36:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a20-v6sm365156wmg.23.2018.08.03.15.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 15:36:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] Resend of sb/submodule-update-in-c
References: <20180803222322.261813-1-sbeller@google.com>
Date:   Fri, 03 Aug 2018 15:36:22 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 3 Aug 2018 15:23:15 -0700")
Message-ID: <xmqqwot7ulg9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> * Introduce new patch
>   "submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree"
>   that resolves the conflict with earlier versions of this series with
>   sb/submodule-core-worktree
> * This series is based on master, which already contains 
>   sb/submodule-core-worktree

Thanks; as this is not a bugfix but a new way of implementing the
thing, it is good to base it on 'master'.

Will queue.
