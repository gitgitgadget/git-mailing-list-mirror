Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CA420248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfCENne (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:43:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46550 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfCENne (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:43:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id 196so5667720pgf.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 05:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TbxFpQmt5CdeY/VftYW4jrA4PoINcX4385lYskZyhBk=;
        b=Ko/EJPIKtT+9YMw80OR6RbgPGrHhZlZMltbeSKa9qR70o4PGBBV1Q9bIm5AI6wMoSB
         Vcg3DeAM5TqqcsG4iCIYU+m2IIK7b6KD/CJhUl9KkcA9UvQ6nZl/UeRumCCHc6c//MVq
         KDqSyEYw5xEUQEsgUT0L+oAmxk+ngdh0yK60vZlLoU7SDj/1yGzvYmiXu5lXpMSKS4W3
         G6+009NO3DuMyVSCEqx8WEXes0azrhwKDC8QDQ8041QyNIy/FOV6s1SuTbIEGMPjNDTy
         41MH9mZdVrvmf6IbbApohOTn501uXGtCGXhlPkR3c1edfixXHYvAMxL0yX1lAHoCLjA+
         /xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TbxFpQmt5CdeY/VftYW4jrA4PoINcX4385lYskZyhBk=;
        b=aNlW/y/kVc5fidXBwKQ2oXvasVR/2vxIY1BY1njGJ6fUPM1/ba4hNY3DV1BGymFaSe
         mrPk5K4XEj/DZZYN1EuEKkTEkWBCIUFHK/mjtE+jH7tBGQjlGqKozf9+mKOmaPHjk5iw
         IiVduRBES1H2f7B1TFdQb5u7K4A5QBVa553URXNqB2q/xXWbD6uvrGIwQjfVeKUoIS3r
         uyFYxog6sFrCZHXsI6MrMlCYLogG/VLgg7dbHmmPXMAUeVEUkVEdHYtIf2Sc21J4JSQd
         ZMNn1PxQyMFl8gshkQ3Ci5amjYCffDOYXznW3RmLcmDVP1nUg1gtWDeMfX1gSu/xb+PM
         6dBg==
X-Gm-Message-State: APjAAAWIQBCIhJHzaU+tMB+twr3HqMvBM/j6jGxBnoZd6a8Hfmyd6jsd
        P+MI5RVx8WaYEbSp4Ua5fq4=
X-Google-Smtp-Source: APXvYqxrHJ7pWGtPdSrFwl3IZsDYww3sl+thCTFJDFov8RZUbeDRjUAlMPdbrXoqas9dhRKqr4mClg==
X-Received: by 2002:a63:8948:: with SMTP id v69mr1509905pgd.140.1551793413417;
        Tue, 05 Mar 2019 05:43:33 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id h63sm22927399pfd.148.2019.03.05.05.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 05:43:32 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     sunshine@sunshineco.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v3 3/3] t3600: use helpers to replace test -d/f/e/s <path>
Date:   Tue,  5 Mar 2019 19:12:59 +0530
Message-Id: <20190305134259.10962-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPig+cSKOSC+CckNbjr7HahT5jXkp47WuOxbDov_KQi4XNnbQQ@mail.gmail.com>
References: <CAPig+cSKOSC+CckNbjr7HahT5jXkp47WuOxbDov_KQi4XNnbQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Eric

On 2019-03-05 0:42 Eric Sunshine <sunshine@sunshineco.com> wrote:
> As with the commit message of 2/3, many of the words in this message
> are separated by multiple spaced. Please fold out the excess so there
> is only a single space between words.
>
> Also, no need to say "previously" since readers know that the patch is
> changing something. Rewrite in imperative mood:

Okay, I'll keep that in mind from next time onwards. The spaces were
provided to make the commit message look aesthetically pleasing.

These changes aside, is there anything you would like to add to the review?
or is it good to go for a merge?

Thanks for advice
Rohit

