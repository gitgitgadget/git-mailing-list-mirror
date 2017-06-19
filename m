Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134B81FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdFSRrq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:47:46 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35974 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdFSRrp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:47:45 -0400
Received: by mail-pg0-f47.google.com with SMTP id u62so31946763pgb.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QQHiV8zam+447KhWdPVTsboxv92pPPVix0ZHQLEAj7o=;
        b=FybcDc1y4juzUWeF6O2I4yeQv44gA7LD+Qlg6GCnYp0CXOTLZpw7BoC8aE7PgeRvd4
         KvUE5M2rWDMCTUa5h9/mRRnDq5HP+Im8AvF4yQTGbuGVna7fdH8+1Rwrbc2Ug36SwoxW
         RFze1K7KkNTox4dn91UlXvUn6RIQ1oW0C6gtH8AIdufWCq91yXFssWt0bGz7naKAu4y9
         ZtGSb5Df2wGH7m4uCT6q2Jaz7gaPGzk7EeuIiNTjEHYzLcX3u7tNfrkMTlWQFdWOsJ3T
         ZVISdnLxrWGOtss5mPFG2JNXQndoKPZOThaDyoINzPSEhYmmr+649zr9rnDs5O1p7rpa
         PrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QQHiV8zam+447KhWdPVTsboxv92pPPVix0ZHQLEAj7o=;
        b=a79lxP8/80xqHBHWf7Qua2TqTAuS8xgSXnXH2p7GOS34PacjhpNTMguB9SHHbULts1
         XFo6PAFThnceWQeNQXZ1ySWMAFLrN2izHZaK3S5bV4dJiBIQvprTWMrOPgnJZef5Ag40
         t0PZeOtDPogV/zXhNBjUXstGcQHn9mil9WJMcafHxdRQ+7EwBd5wA8Q1YN+8UdfEQPwg
         +DPAigeBQVi0gnwKJI2gWuimlx3vOGWuEhf2ppiYr0rr+Sxr01yatr5IESGzA3h2pwsq
         up3Jim9sc62nW69h4IOdE9XQNFVUWjVvYbIBEOdOVQdxRRU2hplN92ZkA516TSmZu4Zt
         cNVQ==
X-Gm-Message-State: AKS2vOyDQIvnnL6U79q44zMDNt+mUQrSB1snSYQlJMk0v4IonrnZMSGF
        y8SEw5sHZu2QErCffyJmtdhfIH8Vlpkz
X-Received: by 10.98.63.10 with SMTP id m10mr26117200pfa.19.1497894464694;
 Mon, 19 Jun 2017 10:47:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 10:47:44 -0700 (PDT)
In-Reply-To: <0092CDD27C5F9D418B0F3E9B5D05BE0801028A86@SBS2011.opfingen.plc2.de>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
 <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com> <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
 <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com> <0092CDD27C5F9D418B0F3E9B5D05BE0801028A86@SBS2011.opfingen.plc2.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 10:47:44 -0700
Message-ID: <CAGZ79kbMOdkKiVsvxk4UeKKPicyi958LpomeY=ypXT0_=5d8BQ@mail.gmail.com>
Subject: Re: Restoring detached HEADs after Git operations
To:     Patrick Lehmann <Patrick.Lehmann@plc2.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 10:34 AM, Patrick Lehmann
<Patrick.Lehmann@plc2.de> wrote:
> Hello,
>
> I'm just an advanced Git user, not a Git developer. So I might find some time to improve the suggested script, which I provided with the hints given on the mailing list, but I have no time to do a complete feature release in your patch based Git flow.

ok, thanks for letting us know. I may re-prioritize the "reattach
HEAD" patches that I referenced earlier.
I would have hoped that additionally to the shell lines you'd have
given a good use case/summary.

> I have no experience with other shells then Bash. So if you rely on a Bash with less features, please port the syntax to such a shell system. (I personally do not support legacy programs or out-date programs).
>
> ------
> We are talking about circa 50 submodules in total with a maximum depth of 4. The platforms are:
> - Mint OS with Git in Bash
> - Windows 7 with Git-Bash
> - Windows 10 with Git-Bash
> - Windows 10 with Posh-Git

Thanks,
Stefan
