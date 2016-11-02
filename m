Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3BD20193
	for <e@80x24.org>; Wed,  2 Nov 2016 15:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbcKBPci (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 11:32:38 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35658 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbcKBPch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 11:32:37 -0400
Received: by mail-wm0-f51.google.com with SMTP id a197so148315469wmd.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=known.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=oTARWDkrjl1kbEJTMzesj21ZdybFs6dYiOSE60cR7UI=;
        b=SAFc2L+iXgqOIYlwBxe2CeEZ8euKN5XNAV7LHiaWt1/0rTFGlpk0lMlfpzn1wPa13N
         LMowpZOE9oUMjjCCUPibcx6W6oliJzh9qdXDb/s98R1xJTA8J0uRlBzgbxfFDaWUeo8j
         xGwrg3bUgsuvCJmADpG01RGjH+oCnrLmID39c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=oTARWDkrjl1kbEJTMzesj21ZdybFs6dYiOSE60cR7UI=;
        b=e7EzGYf28B2xYwuJnhtiC1n79jBRkGMVrzwf7wvMo5nh37blyBQsW+S1eyOuWLwe2R
         MVd9SYVzrnFZIRxHHPwmG560WPkltM5pYQbaSE70ZHSvXGNBo3S8ZRGFGcyM4Cf6Iu8b
         3M5nfyxLl5L0es/H/o6RnChw2VwlVwnNmKfktT8KOfEDHo7ayafpih+F49HBm2a906Ko
         XG5CuZ4ax3bTepR5cL0h8gD71AWnvbqZWVEkGYn4SxNgAhckFGyeOCtNtgooVJXFXeV6
         PrSQOL08yb1rcDbIQx6Y+XYGb39IfZQSIkWSVp0Q3F7A5QEMOUQQ22sCriICdb6E4JaB
         OAcw==
X-Gm-Message-State: ABUngveSUDOfcP2kmKRdDOok73G51bcAKn2HflMXS+soSejy7IBD0Jw7uTGHXoAxwXRfqqnbzTHKcezSb0aE0xLn
X-Received: by 10.194.80.74 with SMTP id p10mr3381285wjx.121.1478100755531;
 Wed, 02 Nov 2016 08:32:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.195.11.200 with HTTP; Wed, 2 Nov 2016 08:32:34 -0700 (PDT)
In-Reply-To: <CAGSZTjKg1=tMYgFiwys=ePVT+3p6KTa1mQ0fP9pPns-Nvd+6fA@mail.gmail.com>
References: <CAGSZTjKg1=tMYgFiwys=ePVT+3p6KTa1mQ0fP9pPns-Nvd+6fA@mail.gmail.com>
From:   Kevin Layer <layer@known.net>
Date:   Wed, 2 Nov 2016 08:32:34 -0700
Message-ID: <CAGSZTjLreF1Uj5cARt6=1vMUDCrbSQ11ZbCin7YzYGZdEmR3fg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IEhvdyBjYW4gSSB0ZWxsLCBmcm9tIGEgc2NyaXB0LCBpZiDigJxnaXQgY2hlcnJ5LQ==?=
        =?UTF-8?B?cGlja+KAnSBmYWlscz8=?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nevermind.  It's working as it should.  The script that was doing the
cherry-pick was doing it in an if and I neglected to exit with a
non-zero status.  Sorry for the noise.

On Wed, Nov 2, 2016 at 8:14 AM, Kevin Layer <layer@known.net> wrote:
> If the cherry-pick fails due to a merge conflict, it just returns an
> exit status of 0.  I have a script that does a series of cherry-picks
> and I need to know if they succeed.
>
> I'm sure this has been covered before.
>
> Using git version 1.8.3.1.
>
> Thank you.
>
> Kevin
