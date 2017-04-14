Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD7B20970
	for <e@80x24.org>; Fri, 14 Apr 2017 17:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdDNRCY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 13:02:24 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35409 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdDNRCX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 13:02:23 -0400
Received: by mail-pg0-f42.google.com with SMTP id 72so37248175pge.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=80b4ZPoXAG5J3bSbuCa+Yx99l4gR9EFBchCMAqjpzms=;
        b=vynBRx916pZR3MuJICzsRVX/pMA+ZfhsGT90jn8B5w7AL9hrivSNjP+U1ObxE3Eo5o
         YEx6TeGG9dRKowKYnNFOd03oYncFjDEVbF/ZpspjNH+qRQT5pzyAss2qzOgMBH6YqdX2
         nYc/ZHY5Q1y6NuvA3xqe8wsZH5uQgDsMWVGPlgS571tvagChZSGqInPmQOs8O46xn5Nw
         rzRkMv9weat777eQtAgFXK6xt7f9jruaze4mUeqE0sw7ek1VgTMcEsctvo+hfQ2cSKHR
         NgIQVKAJLrL5vAHc2iHEqabemNdpBnYBV5TP2MZJsMAcrLog7XVAjKmicVDflUPE2csF
         QeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=80b4ZPoXAG5J3bSbuCa+Yx99l4gR9EFBchCMAqjpzms=;
        b=DMvtOhQKBwXW75UzuEBmn2NINh0bMZZ3e3D/M3TBvonPabMf9rSXpByaAicN24ktv1
         vK6QxTmzVzidN9mNN7ynoIFIXPR+rFTh2AqnQWfr6mSqGAXNBvxlP6Wt2ELgMrNShxJB
         501jdVExgJKNeMNHPZQ2HI31Vq5IiJ+VJdbnFXWfMdXW2my8D7MUGpBWFW39Dv61NM4d
         m/5aRtEGFguG9fzSz17GTj48URi4cpqv70PlxGDbdb2hPux6L0Z5B0bbbiehzCLaG9Uz
         loeLdARbBklZV6Pk30bA5ZqVrC2pVAOARYd0749AQ0THWKB4OH01+P/3X9w0LbLErDt9
         jnDw==
X-Gm-Message-State: AN3rC/6208nrkkJq559fT47Jpg912nw30ZtKrNIFGGgwClw271EBzmO3
        lc1dQKu8U9N654DPn7QRinH5LjXvREb3p4U=
X-Received: by 10.84.232.131 with SMTP id i3mr10017675plk.172.1492189342219;
 Fri, 14 Apr 2017 10:02:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 14 Apr 2017 10:02:21 -0700 (PDT)
In-Reply-To: <CA+P7+xoY-FFXEkPgQBA4=Twq+G5YZrHkBqiO+sKHcGJe7xt7vw@mail.gmail.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413185707.97746-1-bmwill@google.com> <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
 <CA+P7+xp=1PUsq1_or=J8ED+-1NMaF=BckC9bK4jqWbA+RFeszw@mail.gmail.com>
 <CAGZ79kaRTrgHMnP6mA3V2rDHzf8iOidqLTpp2aXmi6x+6YeZxw@mail.gmail.com> <CA+P7+xoY-FFXEkPgQBA4=Twq+G5YZrHkBqiO+sKHcGJe7xt7vw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 14 Apr 2017 10:02:21 -0700
Message-ID: <CAGZ79kY_Faantt9s3aBrWk6F9vDaKidjYpWt0be00w1vXu9PWg@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 9:33 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> Never mind. git ls-files doesn't support showing files for a specific
> ancient history. (I guess you'd use ls-tree for that?). I'm guessing
> we want to run in the actual work-tree for ls-files here.
>
> Does "is_submodule_initialized()" going to ensure that we only operate
> on a submodule that's currently checked out?

I think for that we rather want to use is_submodule_populated.
And I think it would make sense as well to check for that instead
of the initialized state.

Thanks,
Stefan
