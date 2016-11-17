Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643581FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 19:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933105AbcKQTG0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 14:06:26 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34280 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932641AbcKQTGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 14:06:25 -0500
Received: by mail-pg0-f53.google.com with SMTP id x23so91358094pgx.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nl4DKhFQSE1JfNRsY/O5Ob2xl/ay1aKU8qvT1EeW7iM=;
        b=NS0fhd6boh+eBVLyV0X3M9vXrpXGH9Wol1kheG/LpeqeDz6v4m2YjeLNsalVbQhxFP
         D1wnGanRZPD7FycQ4aZ86txzq98NufEc5zj3nLsCzEVMX03CpNZuA5PClttt5Za8nDYa
         y4idhRtjx1yev5/UB+3fcAndLLJsvzV6/Iz4pIkSBfXo/qZUF39bfZ1r4jH2K+uBXHSC
         tiZgH/7x+fMzl4s99YWIk283MOo3+MmJf2nKsAQXU/iJB0t25UsJr11l8zHDSxsVDusz
         24bdiOmknyUtLl+36jyPVKq+5GeqH1vmJI+QfBX49ZsbiXgffpxS7022XguezQTAu/mC
         a50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nl4DKhFQSE1JfNRsY/O5Ob2xl/ay1aKU8qvT1EeW7iM=;
        b=CHvz9ufxz6ODiRO50FqqYWrJjvy34fZI3q8QWsRy/1SvbriIMU8OwAa+19+zy1ZAdQ
         ppHUimYs1Znp6RtP3KZ4LSRl7fBrU6MxPAuDHsk9hIj0XXCx+/ZWLM7WZ9X4nvGsq7b8
         y/PRexR7tYazrnrjJ98ZYT8F/D6W289iVnaEl+IHfQEEB2Jua1AcOwNx7J6yZ3uQQG+M
         2Ozo0+Irg+Ezj3i5xjY39uRI26qOcDBBRF88lrEwlszsl3eSrGn+7zuaFrOmzrmfVHBq
         GJHPcpiZB3gyWeUh0FxXaAkbXlWLCyV9/RSvG5qOD0vFA9hi//09aklt5JnhRJZGKtkx
         tfRQ==
X-Gm-Message-State: ABUngvc+jpP42S61vkklOtT5fZRWu88N2VX7jhTUyV7da0sHdiS0nrC74mEALrKKcN3JDpWc
X-Received: by 10.98.97.7 with SMTP id v7mr3626472pfb.39.1479409584688;
        Thu, 17 Nov 2016 11:06:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:718b:9d6c:8235:ef51])
        by smtp.gmail.com with ESMTPSA id y89sm9960849pfk.83.2016.11.17.11.06.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 11:06:23 -0800 (PST)
Date:   Thu, 17 Nov 2016 11:06:22 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/2] bug fix with push --dry-run and submodules
Message-ID: <20161117190622.GL66382@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479408364-150268-1-git-send-email-bmwill@google.com>
 <CAGZ79kYC51zC4nF3crtuJXK7uwK=Lh9X8LnRke5C87Vo46Gb+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYC51zC4nF3crtuJXK7uwK=Lh9X8LnRke5C87Vo46Gb+A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17, Stefan Beller wrote:
> On Thu, Nov 17, 2016 at 10:46 AM, Brandon Williams <bmwill@google.com> wrote:
> > v2 of this series is just a small cleanup of removing a nested sub-shell from a
> > test and rebasing on the latest version of
> > 'origin/hv/submodule-not-yet-pushed-fix'
> >
> > As stated above this series is based on 'origin/hv/submodule-not-yet-pushed-fix'
> 
> an interdiff to v1 would be nice :)
> 
> Now t5531 is inconsistent in style,
> how much time would you estimate to add a commit to refactor
> that test to follow the style with excessive use of -C for
> all the other tests and avoiding subshells there, too?

I didn't change to an excessive use of the -C option, but rather
eliminated the nested-subshell and instead cd'ed to the required
directories in the subshell.  Excessive use of -C seemed to greatly
reduce the readability of the test (at least it did to me).

-- 
Brandon Williams
