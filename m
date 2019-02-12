Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DAC61F453
	for <e@80x24.org>; Tue, 12 Feb 2019 10:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfBLKAG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 05:00:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBLKAF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 05:00:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so1072788pfb.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 02:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZR+RQEQhGdJA0RIluQUk1d9oGzAS4+U6l314IwGT2Y=;
        b=Zz6MZ6i1fQm569ZLkfeNxxNbDAZpvnwlFR0q+cGplGeE3ojuyCn9wSIMdpHbFs7Q7o
         9cdzrFy7Rp+fQhrertlwrLMHQ0Rbk+efZQui/zCif47hifOL/hczeiGT8KbFxBUMBU4Y
         zDHN8v1KT0arxx4TwRXkWqlvxJOkHnXnw41UECr0v7CxsffcZx4yiBoNn0lpV+bSUh6b
         taB7kcsB66m3cNkBA/XuQ7IbFpXAwSurCiXgQv2hMtJZN2Zk2WJY2rDI6hhzRIK1iaxD
         zM5Xi4dG27oSbx4WPlsonAlIEZLM8eVocd5F9ygbIewGDnNESL+C2muxUhNvRaksI6DQ
         M19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZR+RQEQhGdJA0RIluQUk1d9oGzAS4+U6l314IwGT2Y=;
        b=Hnwl8VuV7KU2MpFgZv2gEGljug0UySYxcjIxC6GNFb5AyAYv9twqAFC3XMRq0qfSTx
         /Knd1KeO2syKZZlfjiaYuCrw8O17AHNMEkTCFDjc1QaqI2Yc0lvi9nuBQXipQDcizG4w
         X6WUm/DBgx2cO0TVOFyKWhX2advC/qjTQXOzztGIJ8nfeIPN121etGUFUHsO5dgh7ubj
         I5E/zlVcqYXFZwcKYSahuKpxRKgubI9yNdVYmzqYcfFZOnxyCqCagsaHBEJs5sNWRT8c
         pEK92fIK7vqm8QpZih7S1OMFRjhQPQTXayY0LHa+X38/5TRuW8Nr6BhZUsN48H/rGhX6
         9nBw==
X-Gm-Message-State: AHQUAuZlKYBXeP4Ge27xvZ4Xolxb5su+8RgFM8EDVETb0H7u29+fWq8j
        tBxmSBnlePE00e1FKxpFuJE=
X-Google-Smtp-Source: AHgI3IazLzpKPYQHa0kcN0GCnyHD56mhEoDz/bquDqM+i3sA3MDoIzdJO6+BJ95ukpVNSSzw7cyttQ==
X-Received: by 2002:a63:ea56:: with SMTP id l22mr2873381pgk.391.1549965605155;
        Tue, 12 Feb 2019 02:00:05 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id y19sm13918604pfm.181.2019.02.12.02.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 02:00:04 -0800 (PST)
Date:   Tue, 12 Feb 2019 02:00:02 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     gitster@pobox.com
Cc:     apenwarr@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/subtree: ensure only one rev is provided
Message-ID: <20190212100002.GA28167@archbookpro.localdomain>
References: <cfd86853cce8a2cd5fae9e6fb9a84f1e3d6daaf4.1549538392.git.liu.denton@gmail.com>
 <xmqqftszpgy1.fsf@gitster-ct.c.googlers.com>
 <CAHqTa-3bDnAm=49uBDLWxLrpOMd6sh1ve1fmmnf5kCbVxHsawg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHqTa-3bDnAm=49uBDLWxLrpOMd6sh1ve1fmmnf5kCbVxHsawg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 05:34:38PM -0500, Avery Pennarun wrote:
> But I don't see any major problems with the patch in this thread.
> 
> Thanks!
> 
> Avery

Hi Junio,

If there are no other comments, I think that this patch is ready to be
queued.

Thanks,

Denton
