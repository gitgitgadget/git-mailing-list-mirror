Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23570209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 06:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbdIMGoi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 02:44:38 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37763 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdIMGog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 02:44:36 -0400
Received: by mail-it0-f45.google.com with SMTP id o200so5026148itg.0
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yASdqEpAXaa2Ux4cs2yORglW0IPobJdzRnx3lB8UkBs=;
        b=b2QEg2g+ytMxM0D4W50QfOjysn011H8SskeRS3rGnCW4vI45vFf0uxlg0qUX/HnfbC
         ZYQDNSkofOmhuGC/Jn6paZHg1/+XrDzrkvgA9DuNUCBtslHJxWyMiL0a7HgndXxPXbPQ
         NljF+2eCSb02EmCFuk4xH/T4xelwfNncrvi3oH68FdEXd3OeyswqRiWCylcmuBRrOnHc
         vYL2ca6V35P6L69w3AWUc/DNd6mjboxRnedhpiI3jMM/8uZyaZlqYrno6Et65d/B22JE
         ftfSmjYJYHu3bvXwEra6eVH9w9Wp7whgvv+xNb3TTmqCOZ03/F2O/gsVSHW+bN9Q6JWe
         TUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yASdqEpAXaa2Ux4cs2yORglW0IPobJdzRnx3lB8UkBs=;
        b=Cr/iiy6KXQHOjKWtCVNTxTaYNix8MZIi3Szo1m9AbKq7EBiubMivi4RESOJ0nczFXQ
         imViKVm+ALxsCM6yxnAHPz5UxUgGZrK3d/1x5/pFKVXMRUUwXotIuY6DL1pK5er9iilk
         wtU9usxE/khI80QwhieedGEsJzMztYToUF2osFgzZ52SgnrIFdP6NU0OBaoANUwhbjfk
         1HQ2ZW/MMe+KDrPM9SRLJQzPruDRrCrFJcL9qiLPkReR6cQQ/psEbAiXOvIjlS0qCFeD
         eYFB4SmcBgs0//B7QYz464FnP40rsfiDqKA4r+7DflU0X4tdd6huGCyj5OctgC8qfGDI
         6M8Q==
X-Gm-Message-State: AHPjjUieOcbew2U1tcDO16lt7D7iH4tn6zdhsFiCsVKHvzRK/cklT3NG
        7duIM2yTvp/x4yMYISabMiYpfbg8
X-Google-Smtp-Source: AOwi7QCb8x2LPYh+AukCewwBoPw3JNddHyZUzCDY6UDN+dIE2DXRHvh/ZXaZ++j8gVx/w7teUlGMIA==
X-Received: by 10.36.29.199 with SMTP id 190mr3150059itj.78.1505285075582;
        Tue, 12 Sep 2017 23:44:35 -0700 (PDT)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id f68sm7053118iod.40.2017.09.12.23.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 23:44:35 -0700 (PDT)
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
 <1505223698.27800.30.camel@gmail.com>
 <20170912152935.iqmj6jpkvgifaju2@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <26c0badc-0443-fca0-a12b-033a87dcffb1@gmail.com>
Date:   Wed, 13 Sep 2017 12:14:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170912152935.iqmj6jpkvgifaju2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 12 September 2017 08:59 PM, Jeff King wrote:
> Like all good writing rules, I think it's important to know when to
> break them. :)

That's right. "Have guidelines but 'Be bold' enough to break them when
they seem to be inducing counter productivity."

> Writing in the imperative is _most_ important in the subject. You're
> likely to see a lot of subjects in a list, and it makes the list easier
> to read if they all match. It also tends to be shorter, which is good
> for subjects.
>
> For short commit messages, I think the imperative also keeps things
> tight and to the point: describe the problem and then say how to fix it.
> The recent 0db3dc75f is a good example (which I picked by skimming
> recent "git log" output). But saying "this patch" is IMHO not that big a
> problem there, as long as it isn't done excessively.
>
> When you the explanation is longer or more complicated, the imperative
> can actually be a bit _too_ terse. In longer text it helps to guide
> readers in the direction you want their thoughts to take. Having a
> three-paragraph explanation of the problem or current state of things
> and then jumping right into "Do this. Do that." lacks context. A marker
> like "this patch" helps the reader know that you're switching gears to
> talking about the solution.
>
> I also think that "I" is useful in avoiding the passive voice.  It can
> certainly be used gratuitously and make things less clear, but in most
> cases I'd rather see something like "I tested performance under these
> conditions" than "Performance was tested under these conditions". I also
> often use the "academic we" here even when I worked on something myself.

Thanks for taking the time to give the detailed and clear explanation.

---
Kaartic
