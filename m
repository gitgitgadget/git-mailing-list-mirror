Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16CC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9975A20739
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgI3VeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:34:19 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46851 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgI3VeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:34:14 -0400
Received: by mail-ed1-f45.google.com with SMTP id 33so3101201edq.13
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 14:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWcmrMNG1AcNTRKXN3wH3gdeAi4lOk6FgLQsGjOUgs0=;
        b=YFbMdtIlVv/K4VfAyFlCrFVnSSExOKwZuUZ+UUVITZdPB6VuL7A5QDPZy50Xjdsfms
         fGa2hA+aPDY09gGUXZfPVnWNFO3iWMw+ByAjn/pkxlF1IIv3CeBsvt26tUrxF9xgT876
         7aKKZKG97MzNpLgxNnARC9ffFrj9UmIuGercjvH4Zmn16OrFpQPqpifbTcLK9UT8FUa6
         DS8EpD0wRpN+kculjJkGVN6ageYqc89al9BQFaQvQHhq9tefegVhYPCYEaG3c0k3JN/p
         iUH9nKTVc6sJftFTj4wF7jRysxFQwfm//Y417p57QY1ohNgv0XeMhiNOSXItzBCVNCNW
         4WBQ==
X-Gm-Message-State: AOAM530Mz/mwig1H3YqtioeXBqMRdpjsxiAS84xV/CF7c29+pVEDWfsj
        oD+X1gHT/GsaajqgotOLti3pAOv5jhuXPIn1iio=
X-Google-Smtp-Source: ABdhPJyKB3zsq3/Ja0+pjJ8h7R7wsk1571/c0Z4h8U0Cm9pAixYWONtNmD6YPLisa0PPbOqvXxdfdwJOAL9wzWvaXT8=
X-Received: by 2002:a05:6402:14d4:: with SMTP id f20mr4816225edx.291.1601501653473;
 Wed, 30 Sep 2020 14:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200930212529.100458-1-jacob.e.keller@intel.com>
In-Reply-To: <20200930212529.100458-1-jacob.e.keller@intel.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Sep 2020 17:34:02 -0400
Message-ID: <CAPig+cQUeQV0=LDQ_tY43k6z7km4X6Fm9JJVPUBoG=wY3gxDfw@mail.gmail.com>
Subject: Re: [v4] refspec: add support for negative refspecs
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 5:26 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> Changes since v3
> * removed the ?: usage (for real this time)
>
> +               /* Note the reversal of src and dst */
> +               if (refspec->pattern) {
> +                       const char *key = refspec->dst ?: refspec->src;

Blorp.
