Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C441FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 10:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762349AbdDSKxJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 06:53:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36595 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762345AbdDSKxH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 06:53:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id b187so3809787oif.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B/O850RA/SwZv+qZMWk3MV+qzKqj3DTJtxiqDl0Wpxk=;
        b=UKJYFcy+bCyGufmhZZviXFal5tocbDUgAV/Dvbjy7Q+oQ71YVnJbnd2xyBj6nzE1kH
         H768z2utPK4zUe2qmnw84u9FRTUQJmGboR8unQ5rcjFEkCgCf63ShYwcZRlQhTnl/cXw
         psoK0sWMbWkypGLX7baMZgU7750scu81XkyDWGqd2uCSoSsGv3/W6GMGVR1XFZLZI0Wq
         N44sll2AKsOOcLFufWxjSW2EDdbQLsML80NcUBv4B9LSTnqG5iTDsfBnAf1W+ZFVKD3n
         5e/ZzVIvbr5iG7NtxUxwIp0/r0Ra5dmm9XSxsi+95zJi3FfDUUvEs8/hBSDXx+zbDl/r
         NQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B/O850RA/SwZv+qZMWk3MV+qzKqj3DTJtxiqDl0Wpxk=;
        b=cuCvBH+GT+yH1ifowt9TIDpTyAYt7rxRXV7hctp/zFPHllcJv8I1uaACoN5lArRfpA
         IVzvBbv8XMLkNPbfOgWzxTp9tmoHmx629VLjWksSPC9gP0nHxuO/MSCPW1ZvBKXB+zVi
         WbFKbDoNNzAbn9NLOqyltbJIjYkIHHZt6QhhOqfhAXlXYd/E/E1n/VEV8sTAszZQaMvF
         jECt8fPoE1+EMf6doxhEXvPqPbFK+XYT8MRzkmi7bjVZO1hQzESH6Ao44J84tcWbLdbh
         GQ7zWebpk5u6uFhJKhniTolkSG3FmTDmC3P8xu38kck+Cj3EZent4uPLeQ6Fh6Y8XeAi
         hAoQ==
X-Gm-Message-State: AN3rC/5MIBbjTalhQwHiZhejZDlw7GdYpgfoyOZMtLa1FAx3JSJ1+OIF
        AmhEXtd/d7eYhDMWnOttofF5+kaY/A==
X-Received: by 10.157.68.146 with SMTP id v18mr988276ote.128.1492599186790;
 Wed, 19 Apr 2017 03:53:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 19 Apr 2017 03:52:36 -0700 (PDT)
In-Reply-To: <xmqq4lyq4g92.fsf@gitster.mtv.corp.google.com>
References: <20170217141908.18012-1-pclouds@gmail.com> <20170318101153.6901-1-pclouds@gmail.com>
 <20170318101153.6901-13-pclouds@gmail.com> <xmqq4lyq4g92.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Apr 2017 17:52:36 +0700
Message-ID: <CACsJy8B5r9qPd9iNZnX4KG_-1WdL+LF+bSOy-zZnwiryQqRWKQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] rev-list: expose and document --single-worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index a02f7324c0..c71e94b2d0 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -179,6 +179,14 @@ explicitly.
>>       Pretend as if all objects mentioned by reflogs are listed on the
>>       command line as `<commit>`.
>>
>> +--single-worktree::
>> +     By default, all working trees will be examined by the
>
> s/working tree/worktree/?

Nope. It's the "working tree" that we consistently use throughout
git-worktree.txt
-- 
Duy
