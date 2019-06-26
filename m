Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1A41F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFZXKx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:10:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34697 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfFZXKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:10:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so5265045edb.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQZ/exasp8VhQAvasCdrsUx3b1qBkXy3hovRKvQIVQc=;
        b=niaNhiKgvxMFqqWjEh5V+4WBG18vqgvSMPLEDM65F0iM+uHqAyo4w1824rckRCsX2Q
         i04JRfYYyUA4RNav+yjhA/q2pF8peRJ/hHanOiJgjp5M/gY7+d98wKR1vBQzMy7aQ8Bv
         jfXY8O8zhMVeTABEzt1xRFHKTGuvpu6HrzmINzPTXiSkCd+bLN2jJiJFN/rLmtsbSCZ5
         3OQsC2bf/w7CvMkYWpqFk3rRP4lpmR4PCfg7mxqZYFp8S/UnklNC62B0d3QWB2GJWvFs
         Q6Mnw1et8xk8MNIgulAyHmlreuVE14mMFkP25Nq4ebdd/1Jd4TKIAfF15Cmvt2VBvWwl
         Q8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQZ/exasp8VhQAvasCdrsUx3b1qBkXy3hovRKvQIVQc=;
        b=BJ2SPjgLLXC7FKMfPJaevK4z/biGyOCRpTmXmZe3XYGKUk6JWzV4DMe0Lqmn3ThGKP
         U0AkCqqdKqVviDB+LO0Pzmj+LETsuzdDfulhve3nyb0erC1amkPMddicqwmtJDvAZ6eo
         9RGZ09xokNNM+4ZSjZ2KhZ6Wg8XVt1Y5wTbYtF90xMjoIg+LBRe0Y5hobwzi89ML1rPs
         eLewMr69NlAfp3pYFJj/xQQiRxl9pI566SyMeOvvE0vLlzYnN5i1hVbsUCM/knYH3DuB
         rM7999so8JLYMVcNPpFFl6Amjc/lWjhUO2TLi3ZxVqJNnssoKqIZePUcXDPb2LDoyEmd
         7Y1Q==
X-Gm-Message-State: APjAAAUeafbG4m0v6AJ4f80d9rlBvakA4WQhDR/PQ6wd6sgpiFpZsbIt
        wtF4WbVlMiu5vALVyNncd9WLDnys3P+6ZnTDqlwLMMxp
X-Google-Smtp-Source: APXvYqyKNbjdADhcpvWB16/v/V3MeZEgcVoppTEkQRA4VYXDz1jTgIITDMjUnidS1dX/05IK/IDsQAEreMtxa7Sh508=
X-Received: by 2002:a17:907:20ed:: with SMTP id rh13mr294163ejb.34.1561590651403;
 Wed, 26 Jun 2019 16:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <204ceee5-9a79-150c-df62-e2f522cf15e0@ramsayjones.plus.com>
In-Reply-To: <204ceee5-9a79-150c-df62-e2f522cf15e0@ramsayjones.plus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Jun 2019 01:10:40 +0200
Message-ID: <CAP8UFD1+cs3LB9w4331oqkwABHe2ufV+gXixVrT2pJ8sts44hA@mail.gmail.com>
Subject: Re: [PATCH] promisor-remote.h: fix an 'hdr-check' warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Thu, Jun 27, 2019 at 12:14 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> If you need to re-roll your 'cc/multi-promisor' branch, could you please
> squash this into the relevant patch (commit 9e27beaa23, "promisor-remote:
> implement promisor_remote_get_direct()", 2019-06-25).

Sure, I have integrated it into my current development branch.

> [No, this is not the same as the April patch! :-D ]

Glad to hear that :-D

Thanks,
Christian.
