Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F981F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750740AbeFABcQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:32:16 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33025 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFABcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:32:15 -0400
Received: by mail-wr0-f170.google.com with SMTP id k16-v6so7486454wro.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5LCpBg5d05AZvpzSRXVGLQMJKA1MGPVEH9LBI3JO6JI=;
        b=Emo28xJwdqVTdBUAA8OCLUA3sJiqb274216vwtG+rAkDkfHSYSW1cTMUXzELZb0Mo8
         /lZc+ETFd/wQ6LZHCqTtZ3Hir+/ZrFk4FuygrgHnRHNkWta3OkTR93gerUMgOuemNA1U
         r7cZRbl/indfCFbG/GCt+RT+CseifnAkFd6EYrd0TxmwdxYaE6g7Ty1JXUv6XLPDaxpY
         Zw8M+k52o+DwgxMVVp4GsHkL9N2AOKZusGvWsvi3ybl1m0RiGzR92BEdc/nl3bSr4c1U
         YvOyOqneVt087+7YNauaUId5z7EG5Zw530DhadkxortEc34idXOpxIP0exqY12XwyT5i
         x2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5LCpBg5d05AZvpzSRXVGLQMJKA1MGPVEH9LBI3JO6JI=;
        b=mIRwbejgTo9iw1I1jMQQqvcyoLJl4ekIaarPGgO7rfum7dpMylJ4mNbH5gjfzQ1goC
         ZAQr6UI122B3eU5Cj0Lnc28rHSFIuyzycvm77fHPDdv+khLnNf95BV5mtq9Yfcq5J+Sy
         khPvX1ZFtF9Nbt5FGRYu5RzZTeyviDsxvxW5r7LRnVASCnBha/rAr4AbUJVNIii40znk
         XDshRqcc95+xZu2AY1oWivkb/bOLDYKMvznI/DRemrZfeFM/D0fOpS6u6xyuDxTJagQP
         MKQjeN0HtGwQROAlHqVDTuHGHwo2YkPMSrLAto3T3519Oz5Yj9E3qkHg6WWOUdqcx1yh
         3UXw==
X-Gm-Message-State: ALKqPwc7ctNZ5KXw9i4jCQ5NZjvTmJkdkAuZ7N+QGldHz4ITj9NlyOJ+
        2haqLXPE8/bWmck/6UEiW8g=
X-Google-Smtp-Source: ADUXVKLo2Y430nXa8HctK9vpsKdmnBnj0KTFNcuL8yYooeI3i3t/pO9zngw8aPaTLjhwSGtV7xWPWw==
X-Received: by 2002:adf:ac37:: with SMTP id v52-v6mr7170269wrc.56.1527816733889;
        Thu, 31 May 2018 18:32:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f18-v6sm6839130wro.1.2018.05.31.18.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 18:32:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is origin/HEAD only being created on clone a bug? #leftoverbits
References: <87bmcyfh67.fsf@evledraar.gmail.com>
        <xmqqo9gyey13.fsf@gitster-ct.c.googlers.com>
        <87bmcw9sqc.fsf@evledraar.gmail.com>
Date:   Fri, 01 Jun 2018 10:32:12 +0900
In-Reply-To: <87bmcw9sqc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 31 May 2018 09:42:03 +0200")
Message-ID: <xmqqd0xbb8bn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> We already have to deal with this special case of origin/HEAD
> being re-pointed in a repository that we "clone", so we would just
> do whatever happens to a repository that's cloned.

OK.  Not visiting that issue while we discuss this "origin/HEAD is
useful, so create it even for non-initial-clone case" topic makes it
simpler to discuss.
