Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713861F6AC
	for <e@80x24.org>; Thu,  5 Jul 2018 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754509AbeGEQmu (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 12:42:50 -0400
Received: from outbound-ss-348.hostmonster.com ([74.220.202.212]:60680 "EHLO
        outbound-ss-348.hostmonster.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753715AbeGEQmt (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 12:42:49 -0400
X-Greylist: delayed 2391 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 12:42:49 EDT
Received: from cmgw13.unifiedlayer.com (unknown [10.9.0.13])
        by gproxy6.mail.unifiedlayer.com (Postfix) with ESMTP id 3A7DD1E14E6
        for <git@vger.kernel.org>; Thu,  5 Jul 2018 09:36:43 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id b6JFfPmrYlpkrb6JFfStZI; Thu, 05 Jul 2018 09:36:41 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LTJc8EtlCS7bmRxkZ6xK0d6UdLQDFUtTcsyM7Zkcwf0=; b=CDuAKiWPbCpXUGt5Ch+kyJpcG7
        BvQYx6l1SuqPnggFyuvQGusZ9ueZBcRrrRl/qHyRXE1GXIGNWLRAEHhT4pYeL14YBKqo+WNV5fhyd
        zkZ/HbeTVqLE9I1+VH8DbftSL;
Received: from [50.226.24.42] (port=43710 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fb6JG-003jYh-El; Thu, 05 Jul 2018 09:36:42 -0600
Message-ID: <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Dan Jacques <dnj@google.com>
Date:   Thu, 05 Jul 2018 11:36:38 -0400
In-Reply-To: <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
         <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
Organization: I may be mad, but I'm a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Source-L: No
X-Exim-ID: 1fb6JG-003jYh-El
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:43710
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-07-04 at 13:22 +0200, Johannes Schindelin wrote:
> > Basically what happens is that I run configure with
> > --prefix=/my/install/path --with-gitconfig=etc/gitconfig
> > --with-gitattributes=etc/gitattributes.
> > 
> > Then I run make with RUNTIME_PREFIX=YesPlease.
> 
> Ah. In Git for Windows, we do not use configure. I *think* this
> points to an incompatibility of the RUNTIME_PREFIX feature with our
> autoconf support, and this is a grand opportunity for you to step in
> and help.
> 
> Essentially, what you will want to do is to implement a new configure
> option --with-runtime-prefix that then prevents the autoconf script
> from munging the relative paths in the way it does.

FYI I was able to get this to work by overriding variables on the make
command line, like this:

  make ... RUNTIME_PREFIX=YesPlease \
      gitexecdir=libexec/git-core \
      template_dir=share/git-core/templates \
      sysconfdir=etc

I agree a new autoconf option would be much simpler to use.  I'll think
about it as I happen to have some some experience in these areas ;) ...
but time is limited of course :).
