Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A2DC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 23:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjHJXlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 19:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHJXlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 19:41:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A153271E
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:41:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d62858b0914so3440016276.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691710909; x=1692315709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WNcp8xU64urMARKbc5YtRj4N3Om/1Gb6nw5zu43gEc=;
        b=C/w9JYNuxN0bJI2NkBOUsAuDlnMkh3niOyq0kRCdlVnIeoVOUpZquy7D9M9eqfJ8tq
         9IB0LRv7QflFFmZi8+p5wKuIj+24adz8xN5XF5/LDOBSPx6joJsg2krJf0EMC1z2S33A
         tVMuFhxF+EaoeqpXDjJJIYrRIe7PvLdIk1bmIgewpO7gDSUEya1bXpFkEcWD5IKGis52
         hoBpoZQZ2mYBJGYzqtJ51QJN4ugW1SQTUYdUigYR0i3zD1trE4YDW3bsArHqEbLhVSC1
         HUXZA9uHoQKDHydB1AF6Ninyx6fCzOboYc4RKT3QKa/ATtmXKbIIk0NQh7EXSqJLu8pz
         G2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691710909; x=1692315709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WNcp8xU64urMARKbc5YtRj4N3Om/1Gb6nw5zu43gEc=;
        b=HT/1M1vaM9Ec6lgwbZZSyqelY1RlxIEBw2zVx3en5fYUuAEZ39n9OpfNMkhdrFF37X
         XcoyYB7nfh9Vw2Fgy3NxR68FVse84utsDzZdlYCGzKSX4f4exIb57WEVlVxq2wX0FYC0
         T/Y7zy1yMKdjxdlHPVZzZIlSNXUEx4rpm3Pk8sPJkAhouHmMTl2lxmoYJunFHyZsec1I
         Q5FTTIfoYp29GPR+f+VGe3RMu/7kBPUMSdGY8tuIyMiUPApseyMtwIqKt3AhhtSkvtAp
         cpJT3IeL4giBlKX1t8XxpD8zR3qOviWP8c3w42tSzT3o/o5eHZMXTCcfUR9lc/Pq19EN
         fcPg==
X-Gm-Message-State: AOJu0YyaxzbRjgzdMk7wCBSBqzbzv1qQ0LP2CXuGJRAFFrRqWF476XUA
        kjd65Yxrf9dGyPpKTUR2ksPmR0nscbz7Rg==
X-Google-Smtp-Source: AGHT+IFhGZkQ6bgUEUrQysL3hutVyQar1EG6IqDpKY0J73AZBhl5PhWw+rthxmGTGj1iJPeZnfh0ji1bHgJ0ZA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:91b:b0:d15:53b5:509f with SMTP
 id bu27-20020a056902091b00b00d1553b5509fmr71115ybb.2.1691710909782; Thu, 10
 Aug 2023 16:41:49 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:41:48 -0700
In-Reply-To: <20230810163654.275023-5-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com> <20230810163654.275023-5-calvinwan@google.com>
Message-ID: <kl6lbkfe8nyb.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v2 5/7] date: push pager.h dependency up
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> In order for date.c to be included in git-std-lib, the dependency to
> pager.h must be removed since it has dependencies on many other files
> not in git-std-lib.

Dependencies aside, I doubt callers of Git libraries want Git's
pager-handling logic bundled in git-std-lib ;)

> @@ -1003,13 +1002,13 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
>  	die("unknown date format %s", format);
>  }
>  
> -void parse_date_format(const char *format, struct date_mode *mode)
> +void parse_date_format(const char *format, struct date_mode *mode, int pager_in_use)
>  {
>  	const char *p;
>  
>  	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
>  	if (skip_prefix(format, "auto:", &p)) {
> -		if (isatty(1) || pager_in_use())
> +		if (isatty(1) || pager_in_use)
>  			format = p;
>  		else
>  			format = "default";

Hm, it feels odd to ship a parsing option that changes based on whether
the caller isatty or not. Ideally we would stub this "switch the value
of auto" logic too.

Without reading ahead, I'm not sure if there are other sorts of "library
influencing process-wide" oddities like the one here and in the previous
patch. I think it would be okay for us to merge this series with these,
as long as we advertise to callers that the library boundary isn't very
clean yet, and we eventually clean it up.
