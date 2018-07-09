Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D00D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeGIVpt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:45:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54810 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGIVps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:45:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so22430863wmf.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JwTvtEL33q8Lq8AELQ0y+MaCAVngJMOXEfhvhYfpo0s=;
        b=BLiQI8eHV/8qYWTecTa9FSJUUd7t6Y2L6NzWDzEQSIUT3A8Dk0FTy3r9BvGZqcR1HS
         pOblduVc6hpKO8z5m2DwRd6IxOcuthrUzRlUUIlyqGFmLL98BuldTFQkF+uqkhlZ+u69
         a6RZkiR/GDERVBP/ZP8iR4o5QCHBLQEpuPqqTwXAkAmxio0aC3Jf3jHpfIsBe2+FSFXM
         PDjeQq/EL+ZfULVbIB8CHM1vKZDVoeBT02d/8snSZUIlAgkW8mc22GZ/NIw8fe6E4Xjd
         LIhVL90LCiZcDYD7+svKHgYCQpuUIWgaS70PuMvI+VtPKBNcnndVDJWvoWh90c2IXuym
         +upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JwTvtEL33q8Lq8AELQ0y+MaCAVngJMOXEfhvhYfpo0s=;
        b=dC/z5wnvpOZ6KnvOMrJ3Jw67AnDMNs/aQU3Q9FGqW8SSWwh+VOP5DHmW6fUDMLtFVd
         9iWJW17GVJl2gz/LzXgAWWaRbtJHI0/T+zO20pS9xbsz2pwzATTuAJ3K68ZUPuVkZm/f
         PDQPpuvwuVgGUlm5vLn4ZdNw49oBljaD+WuExPY4DWU3FTyO96MJH/Ez+7b7HQ6YzluC
         Ucs7Kv35fY02T+aaCthC9fThmfbS1loDAz4NNnC+ZkS8ETlqDoyEkSp3lgcERIgntEfz
         H3Db67S9rykVat8/b+zodffcpBBwNNTrjH8kosiwdH1V9bOUbmIOka0FAjqmTmOmLp4S
         tdkA==
X-Gm-Message-State: AOUpUlEcvU3wXrRTZFyFnRrElALsHdLyRmvpMT8WMuagnzbRIu0wFRzA
        cYh7i4hgO0LpH75hERJQYmk=
X-Google-Smtp-Source: AAOMgpdfeaVigUNeRvU6Kf7pRTDrlO2hX/5RLUo+dXKc6WZS/MKMMv3dxl5uZBFdvqZi2j1aIBAr1A==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74-v6mr3044143wmd.85.1531172747250;
        Mon, 09 Jul 2018 14:45:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f18-v6sm12068202wrt.64.2018.07.09.14.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:45:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Compile cleanly in pedantic mode
References: <20180708144342.11922-1-dev+git@drbeat.li>
        <20180709192537.18564-1-dev+git@drbeat.li>
Date:   Mon, 09 Jul 2018 14:45:45 -0700
In-Reply-To: <20180709192537.18564-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Mon, 9 Jul 2018 21:25:31 +0200")
Message-ID: <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> While developing 6aaded550 ("builtin/config: work around an unsized
> array forward declaration", 2018-07-05), I have compiled Git with
> CFLAGS="-std=c99 -pedantic".

Nicely done.  

With these 6 patches and the USE_PARENCE_AROUND_GETTEXT_N hack, the
forward decl of the unsized static array you dealt with separately
becomes the only remaining violation in the codebase, which is good.

Will queue.  Thanks.
