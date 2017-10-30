Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15491FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbdJ3RVM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:21:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45239 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbdJ3RVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:21:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id p1so17350419qtg.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fgw0/b93Q+RNlhIKe8wqYr4S5gJe4t44QiDLNeq6nZU=;
        b=gXJOwL357r9hgmZDSmxwDdIu9BRaY9/QFiu/CCnSY00BHy/1J8ZNiUhF8Y0hfnKAyo
         epWy/fYIFH9QRmpKrkIsmOXRG6QhrMjn0Ta0Fi49q7E2prur+7xuySa23pxLrrTA0cz3
         oVq5Ve1Qt/Sb1ojpT87uQhaTv3U3TjLHn+ax5F946kTmuyVMgJrU5RHaIRakM8m5XgfR
         YFWtDXmoYw2XefHNfh+huFNS68ZDUoDo/uNxtMD5WMTyJkLjFuk9Ytt7WKCR1SqofIwJ
         Yv1h+v8fm0i/zUxTYsT5jdS9ZULEkA1gj4qJ+fPA6iw+qzT+tZvzaI9W3F+RO/KKo72i
         FP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fgw0/b93Q+RNlhIKe8wqYr4S5gJe4t44QiDLNeq6nZU=;
        b=Gl45TPR81iSJg3IdSb2/bX3oIn/1egRmRIoKX8VsZdCtI+lqgYHpikc64/ggRJm6YE
         IgqAW8mfF6j77DygwH/5/0dWeikymx3UCr8pQCgf6TJW4k11L6oLiJQOyJCBrbWvkXbH
         BA7Spzquqby/cAK03J3+EinH+uL0WtWwUYoTKXVOQkXD0uPuM3XTLOjHF3smWmBGDMTF
         Ko6pth+f0R9N47KLDcYKeNVQ5mJkqj7KuEuDmOp/Oo7bbDYyreP73g2htZ3uT17edtz4
         pEebmp0gjpiIpTdsONTVHSzShOmgbkPVMSDqmY3e9upPd4/EstV/W0UgIkkwo0gchkDe
         SATg==
X-Gm-Message-State: AMCzsaXkTf8g/2+9oN7YyDL5ggTY0keF46TBKvPbB9VnFYvMLNdII6kO
        XnG8JWQXI4y3eGQFy1c0IUHJkOYF0hMI527fMPYulw==
X-Google-Smtp-Source: ABhQp+RGJ9FXH1fpqLxE+ZMso2tA2njHoZJOqWiYXTBK4yMUgLr8GqKJLIXLbkBlyXfJsGkV2AigFfxnN2YWg16DeAk=
X-Received: by 10.237.34.201 with SMTP id q9mr15148400qtc.198.1509384059939;
 Mon, 30 Oct 2017 10:20:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 10:20:59 -0700 (PDT)
In-Reply-To: <20171027170745.2125-1-sbeller@google.com>
References: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com> <20171027170745.2125-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 10:20:59 -0700
Message-ID: <CAGZ79kbNMWqPkk9PGDH44YYPC=Mgqk4+sTmRwQUGKF_JCmbpLA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Re* Consequences of CRLF in index?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 27, 2017 at 10:07 AM, Stefan Beller <sbeller@google.com> wrote:
>> Let's do this bit-shuffling as a preliminary clean-up.
>
> These 2 patches can go on top of that as well.

Actually these textually do not conflict with your patch,
and they can be picked independently, e.g. they could
go on top of sb/diff-color-moved-use-xdl-recmatch
as a diff cleanup.

(I note this as you regard your patches as a lunch time hack
in the cooking email; I am serious about these patches though.)

Thanks,
Stefan
