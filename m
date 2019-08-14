Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D3A1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 21:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfHNVkx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 17:40:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40002 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHNVkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 17:40:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so469367wrd.7
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aq5CwFJpP9Wbko4vauOXf5E+b7VQZyvGI35leCzM3G0=;
        b=BS0W0xThoDvR3NY13I2zT3uNaBYDbSRJ0xgS+Hytc03p5jAK5eRs0aZ4kWODgs+0gY
         Dee6T9whF7I8OMzRWDAfqLOLW6PEEXOqzHm51jqLHQCoGYQ0lEqsP9RMyGok8ytnDJLn
         VY66KfRRyuTc8QglCo1+/quwFALphiU6HVv7w6Cza8DOPVsLrxFmC/spuH6OGtVXdhN0
         FRt4ErxmCmL6AeiqgRsO23AJGRKCEB+f46qIf71fOub5SGCLWV4ddULB9hFrt+W6apJI
         ez43kQ0Mj0QQRuJMYq9F2vaGHeXasZb2L/WO3r61AAvlUlPAvKWEtzE8YrkbZptOpbu6
         9ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aq5CwFJpP9Wbko4vauOXf5E+b7VQZyvGI35leCzM3G0=;
        b=UNC5pS6pLOa/Vlcw0EZC+UA6XhqJavND/H5SuJDmNPqn5V/Y2yziFa9kWlKzhQCKlY
         EDu3ALd4Rr1RDAhMSocKg2jO7R+cVAnhvIC/giwq9udzmflZ+GgPQ7YRu19Tl+YpP1b9
         dO+NAx2UlsJqEHFqmz267uWpqugaxHwffuGyRn2jg0gWgWN8r8I4S9A8O/ZRrcKd+Lp6
         czBVxzmuv4SZ9uVvVPg5VsfRfP5W7xUFoyK3ncXPjCqKETUYrEoNQEwU7QSMG8olJbAC
         nHbTefwc+l0WWWpV5Yv0ItqLapviTb1JltbRkLIYqq3L42NzT+zxjwQicS1msruxxrSA
         Qgvw==
X-Gm-Message-State: APjAAAUOPOBI43Q+AqdI+sMoK/r48WzYUlACZ47MTIib241aSKosTyrj
        LyQeTT6YQrQkCo2QxPURZq2bsEN6
X-Google-Smtp-Source: APXvYqyScEZQSOz4sUZUqg+N4Z43XFpYgUD0vaBOjzZMNNxVF+1B+fxUE3GRI/xph8jdqMAycqBr6A==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr1596672wrg.325.1565818851128;
        Wed, 14 Aug 2019 14:40:51 -0700 (PDT)
Received: from szeder.dev (x4db5324e.dyn.telefonica.de. [77.181.50.78])
        by smtp.gmail.com with ESMTPSA id q124sm692358wma.33.2019.08.14.14.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 14:40:50 -0700 (PDT)
Date:   Wed, 14 Aug 2019 23:40:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit
 while rewording
Message-ID: <20190814214047.GR20404@szeder.dev>
References: <20190812175046.GM20404@szeder.dev>
 <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
 <nycvar.QRO.7.76.6.1908142241080.656@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908142241080.656@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 14, 2019 at 10:45:22PM +0200, Johannes Schindelin wrote:
> However, I am reluctant to accept the performance impact: in the long
> run, I would love to have an interactive rebase that actually only
> updates `HEAD` (and the worktree) when interrupting the rebase (via
> `break` or `edit`), and `reword` does not qualify for "interrupting" in
> my mind.

It's crucial that users can look at the files in the currently
reworded commit while it is being reworded.

