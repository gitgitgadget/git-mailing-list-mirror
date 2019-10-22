Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B251F4C1
	for <e@80x24.org>; Tue, 22 Oct 2019 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfJVRqj (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 13:46:39 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39825 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJVRqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 13:46:39 -0400
Received: by mail-pg1-f201.google.com with SMTP id m20so13043066pgv.6
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4CC2Twcog+y/WEicn5O5yciitX90TT7RjSe0aZHFQgA=;
        b=vM2xqBmZPGqwCB6kYP9zN4DU4IxhU/XZz/LrVMa5XQCK16iQIUHRfKa3UiG+e8qU2C
         JnPwSvPmSUkdEsgU1a2r1FppnDWOrd0wt/yVTScvz0X6yPgYEOuEX6Eg5pe84jy0YgXS
         TRK2QyucfY+u0d0pyV+9W9tKcBSg8h7pKLbEKsbyXLJCRcn5yIIOxcX/aRjMf0AZ9T21
         lQGzh4Y1yhO0ukXzu1c25/Wp0VeYlXbiZhJZuNEXqJjE+XEfCOrNWNEIZKF4ZKz7rxKk
         3UJ5ZPriyEKliS85dx4f+mmHVhsax2Uuuk1Jn0Jnm0n+bMyK9Y6h/vMyaeL7n14eeOGN
         +naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4CC2Twcog+y/WEicn5O5yciitX90TT7RjSe0aZHFQgA=;
        b=fWv4vz+5OVrxdPT6PMh7iH3XG6QEjQULef+YhcZbtR6/X75KiNWJaswpcI6GBeSxgV
         m0cn0ZnEDBhV6mjiHN+aeagWbhDk5tGwc8iiT89mSNJjmqa5AABhaG5P3PtrJwh9HO8r
         RsadpR24UvW+PnZLMyvGFQ5hwJWLFdwi+0iT14lx/rBzJWIiG5EK92+WnY2RXRMUr7zL
         vjp96J3K0XeUjo1CpNtc/h/nDqLv++Sx1G7Jk5//10Kae7dYesekVgVk3tcIxaOJmBlI
         elVrFti0jdt3rO6c2n0gzjS+wePFlW8eq9nhSTTmT8/0BpWyMXYjaBYI5n5qhw0Nc/B5
         o5XQ==
X-Gm-Message-State: APjAAAUpmylF7A/cakOOggBuASEt/9+lozkoM8YfFjJJfJqbTN+n3NQ3
        UVuVB4uMHBCWw1ZlE/8WQdpBMl59tILloxjjonxb
X-Google-Smtp-Source: APXvYqzE9AW7QvJEUR975QewKNe7gbfQ0KS2aBwFtphT8fkOHevz+FkpZHqYWICetCKMchxjMG/sZL9mWBCysVJmEdQs
X-Received: by 2002:a63:1209:: with SMTP id h9mr1758179pgl.394.1571766398113;
 Tue, 22 Oct 2019 10:46:38 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:46:28 -0700
In-Reply-To: <20191019103531.23274-4-chriscool@tuxfamily.org>
Message-Id: <20191022174628.115505-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191019103531.23274-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: Re: [PATCH v2 3/9] ewah/bitmap: introduce bitmap_word_alloc()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Jeff King <peff@peff.net>
> 
> In a following commit we will need to allocate a variable
> number of bitmap words, instead of always 32, so let's add
> bitmap_word_alloc() for this purpose.
> 
> We will also always access at least one word for each bitmap,
> so we want to make sure that at least one is always
> allocated.

The last paragraph is not true - we still can allocate 0. (We just ensure
that when we grow, we grow to at least 1.) I think we should just
delete the last paragraph - the first paragraph is sufficient.

Other than that, all patches up to but not including the last one look
good, except the ones that just add a new function because I'll have to
review the last patch to see how they are used.
