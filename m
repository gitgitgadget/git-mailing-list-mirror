Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E36D1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeCWWMG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:12:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40844 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeCWWMF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:12:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id t6so6023095wmt.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6mV96dZpLH5j+oNi1JRU/hPogq3KPAUke/MTuzDUhuk=;
        b=j6Jqd3R60/KCNzNe4IalTKvETv5ln10vcwvswDX3lVfqYkjpWJp76I7KWm1UeGc35p
         Z9j9DikinfbLTyXw8pk3ZiW2yN8y14pjd79wG5CbfoDG94LjHuysuS0VkVSwGXKGGiaL
         8UqWkmViLH08gct21JIP3Mj6zEzzfa8ixtLCQUMfurXiM97dmDTaRK9vDELnPlKV+pwj
         1AgaanVdQPjM4Jn/GTC43wH/eTjpJvxEfC6BT0MeoOg5E7UJbw5wRnD4amWGKj+9WPmA
         5qnyRjnGA1kbibAUOlYUPvTh4hBGMBiEFWAbq/Wt9nXkRQWJ+sI02CfbBg+/vcO8pBAW
         kwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6mV96dZpLH5j+oNi1JRU/hPogq3KPAUke/MTuzDUhuk=;
        b=eLbK4hMFwLhqji3AUuvk5mJBv0YvAA57T3YfAMg2yfwz0bmBkJqFVOcJzLKr7PB5Y1
         Ayuv6n3g5QEjQnpmDY4yKevwbQQjpA6a4HKl76PsRGhwS+V+YK3t7MApGI2cQuvcNbGL
         UUecbYyBGh93WCwTa4egOvU908OwK7oNHEALIQ2ff9uEFdR5CMelmy08kFtmpl4wCDHH
         Gv8R36d7HhrnxX1ZaC84e6wV3m4Y2TEyCzdxQhrZAPUYoBSwM6mh5XHgJ3pBShn40rpo
         ODQOmTKrYNJQXVllkv5NimO5gczArMF8J/jtcx/qF1lq9XUfzXDnKMHzLq/lUSyT1UDf
         KvDg==
X-Gm-Message-State: AElRT7GGA5J0lXT+UvGPbSybWcU/+nlCQn1PItSLYC5ur5oGpRvDWX9K
        ndgeDS0gUyAzLan15WAvFhE=
X-Google-Smtp-Source: AIpwx48fBcf4pJrW7DQNff49WswV3VHJ+C/5HTJVNi8ljam/Cfwh/0ov8QIP9r+WToWfRNjdRmawHg==
X-Received: by 10.28.51.6 with SMTP id z6mr4871734wmz.63.1521843124036;
        Fri, 23 Mar 2018 15:12:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y30sm11416058wrd.83.2018.03.23.15.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 15:12:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, gister@pobox.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH v5 3/8] Indent function git_rebase__interactive
References: <cover.1521839546.git.wink@saville.com>
        <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <e893a9d550f4d09baf0d21adedca841b96feae0d.1521839546.git.wink@saville.com>
Date:   Fri, 23 Mar 2018 15:12:03 -0700
In-Reply-To: <e893a9d550f4d09baf0d21adedca841b96feae0d.1521839546.git.wink@saville.com>
        (Wink Saville's message of "Fri, 23 Mar 2018 14:25:24 -0700")
Message-ID: <xmqqpo3uh26k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Signed-off-by: Wink Saville <wink@saville.com>
> ---
>  git-rebase--interactive.sh | 432 ++++++++++++++++++++++-----------------------
>  1 file changed, 215 insertions(+), 217 deletions(-)

Thanks for separating this step out.  "git show -w --stat -p" tells
us that this is a pure re-indent patch pretty easily ;-).

Overlong lines might want to get rewrapped at some point, and it is
OK to do that either in this step or in a separate step.

