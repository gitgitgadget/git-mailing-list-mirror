Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEDA1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeCPVFp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:05:45 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36330 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeCPVFo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:05:44 -0400
Received: by mail-wm0-f52.google.com with SMTP id n3so5431260wmd.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jp+8PmzxsK+GAYgE0aOoJv50tvPulZuGhnCnxqf7Lh8=;
        b=lm2/2LjiCa5ZyT+WcPfc7Vx5pjQM3tNkR+vLhKJzNQAEpztByh+tH6Q+j6LnXrAz54
         wQ1jkjAexBJzb1oWwet4RjUAK/5MQl4snTvV27sin2h6L+kjiFkK/jahidnPFfMmL+lX
         PnHXfQJQLD+kGQo5+N/OwJ8fcjgjKCsNuIDAKNtvbSJw/hrb/MphJpAIp4SQjza95REk
         ou3L/bimdxAUuAEaYDQl0HvqvOqvWPwFrMZIKbbJEYHfJ1FG3ER3VaNNdvba6AOY2pFw
         c9xlm/I9tBSlDf+sI+HEkNxr9P0IrZNE/eFyeBT8E4AYdPP6Z4oCzEbd/OavPurITpsI
         JU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jp+8PmzxsK+GAYgE0aOoJv50tvPulZuGhnCnxqf7Lh8=;
        b=QUUAGSsHGySnb7CwvpaEK/9P96EB8P2blnNaF9ZOCKQebUkSp6pMstjpd9XlHdSuMY
         NVvGG+FKX/WoVUdEz/4abmTdZhedLEB9GsECDY+ZMEdb3r41+b5vgm3hU5n5ifXFFLh4
         IQ0udbX5nvZyJKmrqOEZIWtBVrbWcEhhwS1F3cX3H14ShNKTGTBY/01byWLhAxG5b9B4
         H/tl8koew3QM26LTvs3lWCg1uflCScM7Cj+HANB/UIhpnvTlGiawPKwIfyFrc4nN+AGx
         GxdAfyYDjzgjYzAsVDIu8TclN/2y7JQeKkBm3eCIN9iiouPOjLT3XWwFQ1f04LAweUfv
         ALEw==
X-Gm-Message-State: AElRT7G0juQ/GiHhIvfakriCikMKL+PuOnrPFWIZOmXB0Aj9VofcwBoj
        EoU6+cnEp7p7+5hHQA0dmGo=
X-Google-Smtp-Source: AG47ELveXWT4A76JlcNRFtGclJ3PGNmuHTQMz+0TTvJrQvXg/mTSq7AqBm1CagfVXNH1Bm6jBZwYsQ==
X-Received: by 10.28.116.14 with SMTP id p14mr3027249wmc.117.1521234343542;
        Fri, 16 Mar 2018 14:05:43 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id u127sm9308591wmd.30.2018.03.16.14.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:05:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v3 2/7] gc: add --keep-base-pack
References: <20180306104158.6541-1-pclouds@gmail.com> <20180316192745.19557-1-pclouds@gmail.com> <20180316192745.19557-3-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180316192745.19557-3-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 22:05:39 +0100
Message-ID: <87zi37d93w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Nguyễn Thái Ngọc Duy jotted:

> +--keep-base-pack::
> +	All packs except the base pack and those marked with a `.keep`
> +	files are consolidated into a single pack. The largest pack is
> +	considered the base pack.
> +

I wonder if all of this would be less confusing as:

> +--keep-biggest-pack::
> +	All packs except the largest pack and those marked with a `.keep`
> +	files are consolidated into a single pack.

I.e. just skimming these docs I'd expect "base" to somehow be the thing
that we initially cloned, of course in almost all cases that *is* the
largest pack, but not necessarily. So rather than communicate that
expectation let's just say largest/biggest?

Maybe I'm the only one who finds this confusing...
