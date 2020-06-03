Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28488C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21AA20772
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 15:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="XYy+k2U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCPUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:20:13 -0400
Received: from gateway20.websitewelcome.com ([192.185.48.38]:38942 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgFCPUN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2020 11:20:13 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 11:20:13 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id D3573400CC7A7
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 08:14:44 -0500 (CDT)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id gUT1jmp8iAGTXgUT1jy4JL; Wed, 03 Jun 2020 09:34:07 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0pYawS9qNIAh/dHIlLoAa+g955LkR5yxRniCpUgHaQg=; b=XYy+k2U/TA2StSGaxv251aod6b
        w4JzQZbeHdaO+mJrZcCED2U1U7cgjGUte7iir+pzmpAmPBFK2yGAvjMlS8wfamQUo1VocZ2Pu8dZg
        wlHhJQqWWsOE771iONE/8WEDr;
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:58238 helo=pdslaptop.home)
        by box5922.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@mad-scientist.net>)
        id 1jgUT1-0046CD-05; Wed, 03 Jun 2020 08:34:07 -0600
Message-ID: <c931a1a5bf041057fa75febf6c05b7435ce27881.camel@mad-scientist.net>
Subject: Re: Questions about Git-Gui Makefile and GNU File Name and Text
 Functions
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Edua Vioz <eltipejoloco@gmail.com>, git@vger.kernel.org
Date:   Wed, 03 Jun 2020 10:34:06 -0400
In-Reply-To: <CAGiZ90kHSZEjw2ApU4kyGqCCH0KJS2Fe1mbvkJy4W2YKXs_-=w@mail.gmail.com>
References: <CAGiZ90kHSZEjw2ApU4kyGqCCH0KJS2Fe1mbvkJy4W2YKXs_-=w@mail.gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 98.118.0.140
X-Source-L: No
X-Exim-ID: 1jgUT1-0046CD-05
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-98-118-0-140.bstnma.fios.verizon.net (pdslaptop.home) [98.118.0.140]:58238
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020-06-03 at 02:56 -0500, Edua Vioz wrote:
> Would the outcome of $(dir C:/Program
> Files/Git/mingw64/libexec/git-core) be "C:/Program
> Files/Git/mingw64/libexec/" or "C:/ Files/Git/mingw64/libexec/"?

I'm not super-familiar with the Git build system so maybe there are
mitigations for this there but: GNU make always treats whitespace as a
word separator so it will apply the "dir" function to each word.  So:

  $(dir C:/Program Files/Git/mingw64/libexec/git-core)

is equivalent to writing:

  $(dir C:/Program) $(dir Files/Git/mingw64/libexec/git-core)

and the expected result is:

  C:/ Files/Git/mingw64/libexec

> If the latter, is there no way for the $(dir) File Name function to
> be told to respect white-spaces in files' directories?

No.  Make in general, and GNU make in particular, doesn't expect to be
given paths with whitespace in them.

Again I'm not an expert in the Git build system but my understanding is
that the install can be relocatable: in that case I recommend you build
it into a location where there is no whitespace in the path, then move
it wherever you like after building.

> Additionally, would $(notdir C:/Program
> Files/Git/mingw64/libexec/git-core) result in "Program git-core"?

Yes.  All GNU make functions work the same way.

