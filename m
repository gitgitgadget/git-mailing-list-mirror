Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EF241F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755835AbeEaRGH (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:06:07 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:46116 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755838AbeEaRGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:06:05 -0400
Received: by mail-oi0-f41.google.com with SMTP id h79-v6so13632438oig.13
        for <git@vger.kernel.org>; Thu, 31 May 2018 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iZW5GVYRZpvJkStXJlUbVfdrNtp4vpt0jWhWZ+oVT40=;
        b=b8T72o8GQQ6d4b6aCZHdGe1OTt0Cb4J082SY8dGlXyH4xk6UheAVA7uNpjmjjWq/Ro
         lHQ5udc7++miHRE/dlziphOKxxyOjSUoJXJHud7u9GSXSUVjrAaNwhRiiZQVdMo2l1sj
         kp4smFm73gyvKqOkjhFyDSp5psKOuwsyrsoqt5cVCkQX2k21uLchk8/+GZfAnXYnejvz
         iwmqJojyQ/rjwzUSiFHVJ/KhZokPHZoQ3OEiTZCrNW03a8CExUMBqompmuktCis5dPLv
         CDdhqmqa12/696B5y1OSOnyRQc4u3vZNK88xffMWWsdHnXWxa/3WtJ1IdkhkjgFKvt+N
         vxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iZW5GVYRZpvJkStXJlUbVfdrNtp4vpt0jWhWZ+oVT40=;
        b=DaeM6tVeOTa0t+m/pRlsnfbc+kdPW5MM4MnIzT43zHEWmWeTZ0LTPUXeGNg2llrBZ6
         Dmbe6ecRSEWTZhhMDVoyl8Geav2g9OM/QyjQr5zTcVNW0fSjYiUBkKyunsG7tXtEl2qD
         QuhJqZfJgu+y2qvZF/LDhvMBKE0AZjOpSErfP9WmBsikjfOEK8kMSG6quETAgNzDPUtU
         C3/bzpiOAXbBWvRBh8eUxWdp2idlfkiB7FyF24c14ZOV9u6Si2usbv/XwjhecJwGlC7z
         r1KSrFrNMvsFjv/d5QFPU5gC4IVRbELAZqgujxN+D11JY9xXbhDdYCkxfHjptHIEb9B6
         s1IQ==
X-Gm-Message-State: ALKqPwc+mAYBhg85DsOh9HoS4Ej11FqOThHaCaBvrZMSbcWfrJFv3EOg
        70GVlW/qnwQu17WbMqLEl/fgdUfHuW6Ga9kz8Ns=
X-Google-Smtp-Source: ADUXVKKza7qBMn/EiQH0U5g9U0Nz/eIVzofAqclbEHN3iWtQGEsF7TAz9B4gNFia16gbQnh+vP6yT+gb5n24E7fB/BM=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr4631907oir.56.1527786365365;
 Thu, 31 May 2018 10:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Thu, 31 May 2018 10:05:34
 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain>
References: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 May 2018 19:05:34 +0200
Message-ID: <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com>
Subject: Re: is there a reason pre-commit.sample uses "git diff-index"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 6:38 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   was going over some hooks and writing some tutorials for some of the
> commit-related, client-side hooks, and was wondering (perhaps
> stupidly) why the pre-commit.sample hook uses, as its last line:
>
>   exec git diff-index --check --cached $against --
>            ^^^^^^^^^^
>
> as in, could this not be done equivalently with just git diff, not git
> diff-index? i just did a quick test and it seems to do the same thing,
> but i've never taken a close look at git diff-index before so i may
> just be clueless about some important distinction.

git diff-index is "plumbing", designed for writing scripts. "git diff"
on the other hand is for users and its behavior may change even if it
breaks backward compatibility.
-- 
Duy
