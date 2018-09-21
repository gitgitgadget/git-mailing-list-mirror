Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56381F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390248AbeIUWzM (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:55:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43512 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWzM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:55:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so13526972wre.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GLmzw9ozZK9ZwADT9RnGtF+U1/ZEBZsUxg4sTyqw1ak=;
        b=XV7yMWTJK9nuVLHkwFwLe77tZ0Vg3TjYiu2iUMyCOIB8Ks6/7cgpeICzH1lJv/xc8T
         JqZeuwEMZFgp4IffmhZqhKSzUEboWPr8O5RBbZTRS7U/GEbSoflyHdaEt3ck/bCS4ozE
         HDVBU1Nh7uryU5Bj0s/hdzSXwPpXHQ8CGVCJS/z1d8YLWUpgXd1S3CGh1cOVhkDwihN5
         96KZLA2Z/lSUqglWMUrE2c1gZzkGLLFdtPNmPIgJhFs8dUUrC0X/HZGXunMmX57d5mfF
         wjhqGDKRFpRwtdxlEAuzMc52/lmUmCU93z/3HLeDQuck+FS0DTMd2GZP5Qy7fQZyphqN
         yIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GLmzw9ozZK9ZwADT9RnGtF+U1/ZEBZsUxg4sTyqw1ak=;
        b=ZIW9nsoLz8kT7pUmS4yBW+UkQr0q6rYsk5MoOSUvE+0EBALMAyw4icP6oV5nvcyk/V
         S/xnv4GF/11c7dzq8JJ+tA6PxqLkEJ52WgBLx+tLycHlALNQNyw2L6yxHyPCiTY+wg7X
         DsGfwo2B9G12dPwbaPM43DvdN/MKgHhyIcL0A/DK+yMWLHhDRa/7E8y/cBGxG8IiqMZp
         HKuyzhXiSrUWVpkrXHgmVVe8eh6GQnDf4e0sSe2NLoA0dL1L6b16nv7b7lU5WOKOvQo7
         OIuYWkM+NFmmOjeCrOOuGFOI845U3V/CCuPNl1tH3XRNVjeWvra9KnZ+Y0dxDuNsrZmy
         H0Dw==
X-Gm-Message-State: APzg51CvzWS96zB/YNae1xeRBdPCW4pXYKkhMUVYX4946lm45pIJ0VhU
        PGiDeZxyZsyZIObKobiD4mE=
X-Google-Smtp-Source: ANB0VdZT5i2O58taDOgVzkOU2Gq54BswWEZEzkXK0XzlQMI5x7lXep4Tf0FHn8lmhnraVTBiMeG2VA==
X-Received: by 2002:adf:b2b5:: with SMTP id g50-v6mr36648002wrd.218.1537549523393;
        Fri, 21 Sep 2018 10:05:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z3-v6sm4631088wmf.12.2018.09.21.10.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 10:05:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-object.h: add missing declaration (hdr-check)
References: <12cd9928-d04d-d208-a1b4-ceecbdf79432@ramsayjones.plus.com>
        <xmqq1s9myg67.fsf@gitster-ct.c.googlers.com>
        <f6663e27-cfe6-c927-746c-dfbeed5bb3a2@ramsayjones.plus.com>
Date:   Fri, 21 Sep 2018 10:05:22 -0700
In-Reply-To: <f6663e27-cfe6-c927-746c-dfbeed5bb3a2@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 21 Sep 2018 17:47:03 +0100")
Message-ID: <xmqq7ejewzl9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> BTW, I notice that patch #9 (commit-reach.h: add missing declarations
>  (hdr-check)) didn't make it onto 'pu' - was there something else I
> needed to do? (I am still in two minds about sending an RFC patch
> on-top of patch #9).

I refrained from queuing it as I did not sense a clear resolution of
the discussion.

I found it a sign that you may want to update the log message to
explain "instead of adding a few forward decls, include the whole
commit.h because..." that you had to explain why the patch did what
it did to Derrick in a follow-up message.
