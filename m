Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA5D2047F
	for <e@80x24.org>; Fri, 29 Sep 2017 11:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbdI2Lwk (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 07:52:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:57322 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdI2Luj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 07:50:39 -0400
Received: by mail-it0-f68.google.com with SMTP id g18so1748493itg.5
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xY0uPjr6SpXK4MY6u6r1+vITil+9LT+ViYbyryHa2Uo=;
        b=i/CsUEdLr3Th1FBQEYMzkCNQu/4A6tfd4wfpwFHGejNR3mS6RGaRCsuv0c8ZrcPf6Z
         eD/06UwCvTlFzH/KNEqKHLGmSpfaMTbrqkM7530vDyECJ2tWL1fTiO9HQTmroDtoc9My
         DMu/3S5RiwXCC4GXrP4ywdG4VGeFnqZ7SgB/Grzc0W6lIdiXSu0Y8uXL00bjpGw5QQ7r
         T/1jDbaXQXXybsC/ifmETgTs84zLZvMfKH20t/rX7UIwVHxfOagfI85QaTTYLHYmsqyj
         uzkFuDJrvSz31BQOYD/kbMtUGMNnkCowZ5Txc2DmN94keQgw4GnM1jBJjvlt1GtnX1og
         tmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xY0uPjr6SpXK4MY6u6r1+vITil+9LT+ViYbyryHa2Uo=;
        b=eNqW9pwazD4HB+ce+U9i5VgLIW+HceBm67O8d3tpZAldQgsKz4TxhHNNEBnjUR3JBh
         DADiuQArTTm+D84bRRBEi/URlxlZIwB6CmREnjyagXQhWJE87x55MRB5Q+JLtemMCACi
         S5XCEwqqZqB03RtnFEEX4W+jdYe5jZCtUWotmhiqpYFdoGEJ97X1VtV1rnx1UMrH/7nX
         4HMVxvqtuWlg0qPipa8nboUuw+2zRP8SD/7r4zqtsOL8upwUIpbv5oVOl1SAoiUlyEh8
         eSCJG8gNXV+ad3ahmf6MUoxEhxqAwVapVhb0hw1wohdGFD0v69myTn3nNinm+//Lf5//
         vqrw==
X-Gm-Message-State: AMCzsaX47/99zNiRA/awBW09MjQcIdPR9tb7Xy7rItKszVc9vWyGhI6L
        A6zd6DFc2nPEJNw10913oW9ugvmQ61L3BkUYX/8=
X-Google-Smtp-Source: AOwi7QB0Vcx+/XAx0FjripmoujcRt0HzLZVRYDPODdcT9eLcj+ucTUeMlWHQZwEnlB3KY/yUReXQMIK48lMlPuAUgUo=
X-Received: by 10.36.73.216 with SMTP id e85mr6666922itd.116.1506685839081;
 Fri, 29 Sep 2017 04:50:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.125.142 with HTTP; Fri, 29 Sep 2017 04:50:38 -0700 (PDT)
In-Reply-To: <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net> <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
 <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Sep 2017 13:50:38 +0200
Message-ID: <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 9:23 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 29, 2017 at 09:18:11AM +0200, Christian Couder wrote:
>
>> As we use the "prepare_packed_git_run_once" static, this function will
>> only be called only once when packed_git_mru has not yet been
>> initialized, so there will be no leak.
>
> Check reprepare_packed_git(). It unsets the run_once flag, and then
> calls prepare_packed_git() again.

Ah ok.
