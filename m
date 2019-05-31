Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADA91F462
	for <e@80x24.org>; Fri, 31 May 2019 00:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEaAaT (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 20:30:19 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40946 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEaAaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 20:30:19 -0400
Received: by mail-it1-f193.google.com with SMTP id h11so12467029itf.5
        for <git@vger.kernel.org>; Thu, 30 May 2019 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pYQj5vgvKh8RD6IcuXzDuD7vGKlVqIk5IraOeKu/fwI=;
        b=T8Qb/LcmzTKkI+GNfr8DuuufIiSp0QN8PfFpFTHqNQiyzKOmByJAlosgyt8vqwPc6w
         iMlQeVAvHU5xQjeW+p7o1RcLOaRhOQsrVfRtLIhA0ZvI5xgz/S9N+v27Km2rxcN2FhLW
         TEziaosVZeMlPxRw2wHdQ/MwD0Db8ov4iG4RHU2c7NxyJM/MplMjrYlO3vyCtTJi6gKW
         WvQZtjqR4WxFkJbL66K1ZVyCf8lCczu+3uzNMX9OJe34RiUaWh8/OheZSHSe8nzw8HUA
         GTP2HPLpbj+2ooYII99oY0vD86jZUJc3+cLOxHG4bp3KRBXAj+24yQQ2vHh1kZxWuwfE
         /jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pYQj5vgvKh8RD6IcuXzDuD7vGKlVqIk5IraOeKu/fwI=;
        b=hUnEb5Zcu8qcveRtGDNlEWhKwclGeht/Swf7e2km5586pJcaqzOdcYBMoMBanhgl0g
         dRyNP4EkZ8UKCScRF1V+Qgy/p84ZCwJTT03RkhshE2IeLzxYiGCasN05DKho8x1xHU8b
         6y+crcymgvJGoXQItuLIKNbML0iwH2k2duMFaYXmshE6m42Kj6kDu8flhN9YxlYkqiBR
         gPlgTeclpbguc38Yyj12vPHhQhbvJhBi2lJsQ/S2FDYwOPdyK5j844pHNV669V0pFyA4
         +g9zJ1W5uuzznSafOPjjMwyHPvI1qal7LumzHMQYdJC7hUQGoPD40rVMsKm5JZRMQfrb
         hkAA==
X-Gm-Message-State: APjAAAXJdAlDOm53/1J5I/TpvMWsnjAOkG2h7Uc9/orRGYy+f5DogFzf
        Wjh+BkOvaEBjVbwI39Y7ioOXADR1
X-Google-Smtp-Source: APXvYqxyla8yTtyeafgExl5E+jR60cfuTBWQ7bZ2YAkBN8oIrG1tfk5UTs+oyX8P8I4vrsqsnjg7gg==
X-Received: by 2002:a24:4794:: with SMTP id t142mr5062096itb.121.1559262618166;
        Thu, 30 May 2019 17:30:18 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id m189sm1809211itm.21.2019.05.30.17.30.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 17:30:17 -0700 (PDT)
Date:   Thu, 30 May 2019 20:30:15 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] teach branch-specific options for format-patch
Message-ID: <20190531003015.GA9976@archbookpro.localdomain>
References: <cover.1558052674.git.liu.denton@gmail.com>
 <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 10:44:23PM -0400, Denton Liu wrote:
> Hi Junio,
> 
> I've gotten rid of all the `format.*.coverSubject` stuff and replaced it
> with a generic `format.inferCoverSubject` that will read the subject
> from the branch description. I've also made `git branch -d` stop
> deleting the `format.<branch>.*` variables.
> 
> A new addition in this patchset is that format-patch is now taught to
> understand the `format.<branch-name>.outputDirectory` configuration.

[...]

Quick ping for this topic.

Thanks,

Denton
