Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B93820954
	for <e@80x24.org>; Wed, 22 Nov 2017 20:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdKVU1Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 15:27:25 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:42687 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdKVU1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 15:27:24 -0500
Received: by mail-it0-f50.google.com with SMTP id n134so7726833itg.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cMxmkjI5l35zQJC99ZCq4wVmWaj7y2U9Ycwkw8n2J68=;
        b=PFjTESHI9xSUAjFN2dXRBVhSsymU6urfwH55qFNhnDItpLqb0O63af4lOTmPcIdySY
         tZ9FDkl5xhQvGoFny8QUAkUXx9x2yx/nviNWFOB4osBbVmZIs2/5fpfTegGYt2hu/5nm
         gREIsIwWQl923eHTijTi5S7VcQYW9eA7B+pB1r0FaWmNu5rNv970IyszzhTONr9hZcQD
         xCTcshwY7OpRAdqymAq0swqtg/RFa2NTet5nPpG0cv2jn/+IN0QlgvnT0nzoir9nUOLM
         3/8jBSj3K9POZYNKsx6NtLcb20nM+hEXiLC1yKoGOOwNdZ3vLafqEgfilqpvo2VRYUJb
         wSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cMxmkjI5l35zQJC99ZCq4wVmWaj7y2U9Ycwkw8n2J68=;
        b=f/qbxhrIf59QyTa7EOlDu1wNIa+3w3W7owthParotEAtolR3HmFuggqBfQxtnlwDyQ
         dcOTwQpltqgbL+w8V+DUCy5z0D5KJDT9gnbLqRT/RYBVCPLkkixa+uDJyqhTVTdr9m74
         KodGzlVUAc/As0V13MhmrWLGN+RMY+FZHp8JxHdZbxs8kRh7rb5MLZySnrakLVhF35Ts
         CkbdDdbxTbjMxJUhKZMeRArRgnJzdWP1sZp1XUaf1o4z1rkD/B/rSfg4MbsZuJ04Rwwr
         k1tzVLJ6cxz9Dkg+mFthm1GTsrfO1/7xaAyY/qZrwkgf/3SQw2SnnSsscmN2qfETugzx
         hvtg==
X-Gm-Message-State: AJaThX7zrF45OxQqJVNGABCMokWb1tc3n/lr6yw6/1EFpDpsQJNP7kp+
        49jhHgJ6BESmn0rw2LahhPE=
X-Google-Smtp-Source: AGs4zMayvB1aFMAlpQ8fObB1BiUWNRW8iOu+8aId26ZWy36oaHk/uO4ADZBOu6GHKK81gjOfo6NRoQ==
X-Received: by 10.36.8.136 with SMTP id 130mr8768026itc.18.1511382443339;
        Wed, 22 Nov 2017 12:27:23 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 194sm2689041ito.20.2017.11.22.12.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 12:27:22 -0800 (PST)
Date:   Wed, 22 Nov 2017 12:27:20 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nathan Neulinger <nneul@neulinger.org>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171122202720.GD11671@aiede.mtv.corp.google.com>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Nathan Neulinger wrote[1]:

> I just got an answer to my stackoverflow question on this,
> apparently it's already implemented:
>
> https://stackoverflow.com/questions/47436939/how-to-run-git-status-without-modifying-git-index-such-as-in-a-prompt-command
>
> There is a "--no-optional-locks" command in 2.15 that looks like it
> does exactly what I need.

I was about to point to
https://public-inbox.org/git/20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net/
about exactly this thing. :)

That said, I wonder if this use case is an illustration that a name
like --no-lock-index (as was used in Git for Windows when this feature
first appeared) or --no-refresh-on-disk-index (sorry, I am terrible at
coming up with option names) would make the feature easier to
discover.

Thanks,
Jonathan

[1] https://public-inbox.org/git/dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org/
