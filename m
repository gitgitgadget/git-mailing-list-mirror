Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8644020756
	for <e@80x24.org>; Fri, 20 Jan 2017 13:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdATNlJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 08:41:09 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34734 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdATNlI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 08:41:08 -0500
Received: by mail-it0-f66.google.com with SMTP id o185so2967301itb.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 05:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NmCVzTvwBS6bsYmqNhgs2oZNSSrTSQNsqA2QHV3+Om8=;
        b=Wyy3545piLT+AcSKWnSZnAkhOl9b0AOXs1M4mebjzRUQiIxKLx+uSV9P6LPxYUiCrm
         BqpjAz4xvy1kdyPBEFiiIBA1lEq1XJNthKBpeNi/6jygU3Ow++83VREEcu+NVt2jYDOM
         JU76UNNuBJxLK2Bo2vXZIzXt8UfXETr6wrRj6Fkm3QOWeLSXqrn0h9nzIaJ2lTdiM465
         eqZU/g278wbP/KILcMS8+o0/o1YWppeCkIBrwU2OIgDV2dicW2YBTvCqKt0srxsygFv1
         Nxy7MRpC0IQEkvg4IGx2Ny4XI03ynU/njq9Fehi0G3Ef3EzYYDMG6MsRPQYLb9ZQWPlD
         UvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NmCVzTvwBS6bsYmqNhgs2oZNSSrTSQNsqA2QHV3+Om8=;
        b=dOsvPirQd16qF6Ful7pULYLYo1gE15o/dzz0VyONFmSwdJqmOJgU+4scjajTOsCA10
         m7JOYN0kMA9WykbNEt6shk1aK5rNmY4VqP397gd+XX00DhlOnjXqeFhztPnHUcpxS4P3
         FdFfHr6BtNUQEBDlqzvu549JkEokEh3nlO6bPBSLyTK04Si4lsFAcn5lwQncmIYllor3
         58xvJi6VBaY1tEviM64RSrDYaoYDjxrn18yWnj9/bGNxH+1nURiNTSXDCQYgwv//Yr5u
         W9LWBhI3L9rMtREv+Yo4qINwa2tQ2Ibv11uH4hHg5Q6PqtV0NXJ6JCcVTUey+j9cyTlw
         ES+A==
X-Gm-Message-State: AIkVDXK0vurO/kr/noEPhRX3wngnPn83HUyUL73Xtpv3AqMNSh3j0lkVyFTRufzDPpCUx6aSB9k5mYJ3G4+7UA==
X-Received: by 10.36.118.133 with SMTP id z127mr3576962itb.74.1484919122385;
 Fri, 20 Jan 2017 05:32:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 20 Jan 2017 05:31:31 -0800 (PST)
In-Reply-To: <20170120132322.GA23030@ash>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net> <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net> <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net> <20170120132322.GA23030@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jan 2017 20:31:31 +0700
Message-ID: <CACsJy8BacMqxfN=LO-LV+tJy39or8U0w_trwLOnZy+hZpkya-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Localise error headers
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 8:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> I've tested it a bit. Seems to work ok.

Oops. Didn't notice that the "fatal:" bit is still untranslated but
Micheal's patch can handle that.
-- 
Duy
