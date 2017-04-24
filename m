Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C9D207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 23:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979122AbdDXXF5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 19:05:57 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35871 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936408AbdDXXFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 19:05:55 -0400
Received: by mail-pf0-f172.google.com with SMTP id 194so18337158pfv.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zBk3utp675M9z0/FsJf7Pdq3UV/e4KN2yI+BDrONx00=;
        b=t+0Aw1jNZTNUjKzzdZT1qcty9Gf82lRTYTGXQb9/e0iXH4TsXSQ/wbZHBEdv/oYrP5
         E6i+gKIhleRGL/eneD4o5TVnDN7WicIYqQQ6h/AiIAxMygQFLDqqnMaRyCHz/rHHtGbv
         QdfDV007+zd31pjOQg8SQZo/6XXGmTwn7HIOb+NeNaV/LbaQP1Nz3ilp3kdaLj3HfEi1
         iV/zbdAHgsJdmz9ha7teUnESdqVN4NWSslnjbuasO4zPBCxzErDZ2WApcRRhPN2oHzF+
         wyShGDYLKlayddUt2w5WI1cA++acHMfVm5dPnnrrQqKXF+i8tvhHz+fedYInvNz6h0TZ
         Hmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zBk3utp675M9z0/FsJf7Pdq3UV/e4KN2yI+BDrONx00=;
        b=t8F+KzfnihNTvoOeK+3OaSLyd5i20a3hnN/rSyPSQP2mZYOZRv8ULo7GIY11Wv4CIE
         79Q+HJagWT1uX5my1uEtZ0hTS4pWh4ZAWYMopTg8ybookwXnyNuT041X3fnlMzW25rGv
         KMFN3QBrba1J1Wl7znd2tKbXsEYsd8BWZLLruwX0Ip0ppjx/L0sgjmtWszlDX7YMN5+b
         TPnZTCzuR0ad+t0TXbDWJctgNXGzTfhxV27eNQRjo0MQbiek8oml7ARQsncc/2sjrap7
         OhBGKb5rWnoEBXUk2uhMBN5M38e2UY/ZqLmdZejYOAwfJFW6ISk3ygLyUoSpNPDpCQRE
         5aaw==
X-Gm-Message-State: AN3rC/7eP2Qi6O66Q+7rXkPMhSHlEq2ih7n696R9K/RWWRjE/HL0NmqR
        b5Z69guOigK4nzJ31yud0k3a0Ko7p6zY
X-Received: by 10.98.2.213 with SMTP id 204mr26990701pfc.125.1493075154507;
 Mon, 24 Apr 2017 16:05:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 16:05:54 -0700 (PDT)
In-Reply-To: <20170423213453.253425-29-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net> <20170423213453.253425-29-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 16:05:54 -0700
Message-ID: <CAGZ79kZGVKT5Xg2AnS=DPa+xXRJq6w4HL9R+j+nu8QrW3eGPAA@mail.gmail.com>
Subject: Re: [PATCH 28/53] Convert remaining callers of lookup_blob to object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 2:34 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> All but a few callers of lookup_blob have been converted to struct
> object_id.  Introduce a temporary, which will be removed later, into
> parse_object to ease the transition, and convert the remaining callers
> so that we can update lookup_blob to take struct object_id *.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Reviewed up to here, looking good,

Thanks,
Stefan
