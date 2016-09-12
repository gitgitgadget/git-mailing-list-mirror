Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1281FCA9
	for <e@80x24.org>; Mon, 12 Sep 2016 04:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbcILE4q (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 00:56:46 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:36847 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbcILE4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 00:56:45 -0400
Received: by mail-yb0-f170.google.com with SMTP id u125so46038668ybg.3
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 21:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JiUvqcMyOTOXLEy0bk0zpIbjVF6Zz7o9fxrPh1ffVz0=;
        b=0v/VE0d57maBlz7gd6EpijsGWChHEa7vSiVY/9AVDsmwIU0T6IVsaKXAkH28eTw9UA
         q7OBXmDsaSxy6+pEIE+SWhsY1HKqdgNEwDcId6qYgdJaM/51pG6yTurmURwwqkVq7zyg
         ckkh5lzL77oBmGBF+LPjx87Gy2PsudTfq5RayF9S0UMfZeqA5/gHY0icDqVqOp5k9jsR
         fs+bsKtnQcT9+75w7emKf7sR/7PKiinf/7AJknxLd1WT28ojyafMvfM20yDntNWveivs
         LV0praA9wQg79zw/RgdLEq/7TsnSuBeI3iXFsiSkSYWldEg9Lequkx/KJTOok3BIBdQF
         UfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JiUvqcMyOTOXLEy0bk0zpIbjVF6Zz7o9fxrPh1ffVz0=;
        b=IAzqjPPGtRSAity4KPf+eTEuEWX+/VypgEgHtewmZcTyQuU6vp58YdTt+kg57ypQgY
         adUNTF8e7qyLNE+sFQwvf/h918/ZHhrfsyMhh1ZV1br2dVKU31PWXON6u/6uwXYwjKtr
         PAW3+knmJrap8q4U4uhsYAl3K8up/KolhE5w3PHA/UO6Gket3D2JEH1xSnptOp1V5IB/
         ExiExXhX1CqKHg8HSIk518w309VqyQ6+lY2F8S8vU7ZhRk86W3nNpBlNcQThuyi73hgn
         6DT+OHHBTSV6htNPOukCFk1bRkLoF16BZpkPoN0kDDkwfhyxG1U3YaI4rMOgDEZO2dXX
         YCgA==
X-Gm-Message-State: AE9vXwN+O7r0EyORHhNkzbcnILNWhCkppjGgmEjWgrVi0m7Pha1QReunEr+QTgOmAQW0w4IcQr/80gk4zlCqYA==
X-Received: by 10.37.214.75 with SMTP id n72mr16036502ybg.118.1473656204985;
 Sun, 11 Sep 2016 21:56:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Sun, 11 Sep 2016 21:56:24 -0700 (PDT)
In-Reply-To: <xmqqa8fd6fs7.fsf@gitster.mtv.corp.google.com>
References: <87zinmhx68.fsf@juno.home.vuxu.org> <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
 <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com> <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
 <87inu4bxt7.fsf@juno.home.vuxu.org> <b9d63103-011a-9486-2fa1-dcf3a82cbe64@gmail.com>
 <xmqqvay26r8u.fsf@gitster.mtv.corp.google.com> <CA+P7+xqdWbERVQenZJTLyirBy2VFrKV2-uBOxB1CwcWs+gy43A@mail.gmail.com>
 <xmqqa8fd6fs7.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 11 Sep 2016 21:56:24 -0700
Message-ID: <CA+P7+xo8QWRjON9Wp9vS0ymnSYTjnq=Qh4iR_EWYiULk86hBOg@mail.gmail.com>
Subject: Re: git commit -p with file arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Christian Neukirchen <chneukirchen@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> You are excused ;-)
>
> In ancient days, "git commit <pathspec>" was to add the contents
> from working tree files that match <pathspec> to what is already in
> the index and create a commit from that state.  This ran against the
> intuition of many users who knew older systems (e.g. cvs) and we had
> to migrate it to the current behaviour by breaking backward
> compatibility.

I see.

Thanks,
Jake
