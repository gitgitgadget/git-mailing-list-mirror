Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B74C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369552073A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="fZ80FqrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGRRaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:30:06 -0400
Received: from gateway30.websitewelcome.com ([50.116.125.1]:17267 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgGRRaG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Jul 2020 13:30:06 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 443333F56C
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 12:30:04 -0500 (CDT)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id wqexjoSszSxZVwqexjXOiX; Sat, 18 Jul 2020 12:30:03 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+X15mf3aezegXxdlUuPwCmA296Rx00uOZDev5q9EBf0=; b=fZ80FqrH+EUF2Z+Lipp1MiLEVV
        pNv9YwomqasWedzoe3SDGvHuVydp/AilLV1G3W8j96GOU1eHaqKQma36+m2EZel1DsTpLtnRuMz4J
        +eBaY9jMwuecYqbgCnP2ZpFYC;
Received: from pool-96-233-64-159.bstnma.fios.verizon.net ([96.233.64.159]:41246 helo=pdslaptop.home)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <paul@mad-scientist.net>)
        id 1jwqex-00096I-1j; Sat, 18 Jul 2020 11:30:03 -0600
Message-ID: <edc9f4ca70bfcb7a94f4c9d44f03e71efbab12ee.camel@mad-scientist.net>
Subject: Re: [off topic] Git hook and integration for JIRA
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Date:   Sat, 18 Jul 2020 13:30:01 -0400
In-Reply-To: <015101d65d27$dee4e9a0$9caebce0$@pdinc.us>
References: <015101d65d27$dee4e9a0$9caebce0$@pdinc.us>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 96.233.64.159
X-Source-L: No
X-Exim-ID: 1jwqex-00096I-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-96-233-64-159.bstnma.fios.verizon.net (pdslaptop.home) [96.233.64.159]:41246
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2020-07-18 at 13:21 -0400, Jason Pyeron wrote:
> An non-ideal implementation [2] looks like a comment. While the
> native implementation [4] shows up in a nicely organized section of
> the issue page.

Indeed this is off-topic but AIUI, there is no magic needed to get your
commits to show up in the *Development* sidebar of a JIRA issue.  All
you have to do is mention the JIRA in your commit message; if JIRA is
configured to be able to scan your Git repository it will create those
links on its own.  I'm not sure if it only hooks up commits which show
the JIRA issue ID in the first line, or anywhere in the commit message.

In any event at $DAYJOB this is how it works (we do have an on-prem
install of JIRA though, we don't use the hosted version... maybe that
has fewer features).

