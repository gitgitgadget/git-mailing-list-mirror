Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70DC20248
	for <e@80x24.org>; Wed, 10 Apr 2019 03:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDJDJX (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 23:09:23 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34969 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDJDJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 23:09:22 -0400
Received: by mail-wm1-f43.google.com with SMTP id y197so867211wmd.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 20:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WlxW7rjFvneO3T6pJJDyEeBBSKhxhQjBrT5Bj7HvWwU=;
        b=Qdg1snPhXsvG0BQZMTLtVlIn+rEz46rcWrMEw5B+iwJm4BQgMXjdLYvR/AN5TcK8Y8
         62mdoLoylsN3/2uxPQU91RtCofiKBqofQ+/iNKNcQ39xgiLL9pRiB+raM4LMTZ5Hnce6
         WFhSMaAeisSyS8z1YLMOrIRas1GEPnOX/BwppQYUv8dDmh8l94f45LrdXCZbgACso5+W
         P1goOWGNIIODz0bgy8vlmPnMjegkmigs35GVycSsroUqtpFdTM9F93Nr5apVAe9CXlqC
         RlWsJxyHCKYUiy1+ov1g70e227cp9Li0BT0I7ojfqNCtKVG5u1ktDD06l4ihAVutgZ0D
         2hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WlxW7rjFvneO3T6pJJDyEeBBSKhxhQjBrT5Bj7HvWwU=;
        b=Iri6sKHqOFHbbQY5QuoiuzeHM5TJGDkSoYmtgb0mCoCC1Xlra2OaeEFXcbCnX9Py4u
         W3uZaqA5B8X82D+qt8Ncw7TEtu486Wz87rPZIOAMPt3nIvtMGmhpAqoxTN/YjbRVvSdV
         ZhszLZ5QJpI0VZg13p2pefLoku7T5lDI0+BGhAokEvlUek8E3im8vg8coSgk0DBAx0HZ
         4OWUpJQanVdI21HgsM1BTiCF4P8spWqdtqh+4K8jcQWgicMuJdJGs9xwyKKxqcHtdpFt
         MADJeOC5zVIuJHIP8qMSekOdTdXw3Q6tZ/dXOX2vr52jXSiX0ba1byyNlukAFuHR+LzR
         Spkg==
X-Gm-Message-State: APjAAAVDhZAUephHJfy+iU8DYf9MTIcn2vFcrHMpd0Nki7PWsTrfNzVH
        C/n0bV/IgOvSk6A26e9up/M=
X-Google-Smtp-Source: APXvYqz6ZfftPIn/lT/Jk0rtK0Uhsv7WqWH/kBudq11Mayo6KM+MFmK6T5OqAXydOQ0msT5zAbXFxA==
X-Received: by 2002:a1c:9691:: with SMTP id y139mr968458wmd.64.1554865760958;
        Tue, 09 Apr 2019 20:09:20 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c16sm858166wme.31.2019.04.09.20.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 20:09:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
        <20190409182247.GA7317@dev-l>
Date:   Wed, 10 Apr 2019 12:09:19 +0900
In-Reply-To: <20190409182247.GA7317@dev-l> (Denton Liu's message of "Tue, 9
        Apr 2019 11:22:47 -0700")
Message-ID: <xmqqimvm36ao.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> * dl/submodule-set-branch (2019-02-08) 3 commits
>>  ...
>>  Needs sign-off on the tip commit; other than that it seems OK to be in 'next'.
>
> This has been here for a while. Did you need my explicit sign-off for
> this? If that's the case, here you go:
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>

Absolutely.  Thanks.

>> * dl/merge-cleanup-scissors-fix (2019-03-21) 11 commits
>>  ...
>>  Needs review.
>>  cf. <cover.1553150827.git.liu.denton@gmail.com> (v9)
>
> Phillip Wood left some comments for me here[1] and off-list. I haven't
> had time to address his concerns yet but whenever I do, I'll probably be
> sending another re-roll.

Thanks for an update.

