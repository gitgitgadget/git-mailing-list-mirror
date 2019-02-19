Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08DA1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 11:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBSLNs (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 06:13:48 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:48286 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSLNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 06:13:48 -0500
X-Greylist: delayed 1537 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2019 06:13:47 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IC+PqmBBbODFN2i7ZToiYbrePteEXq0qpgdK68W4APg=; b=EJItsisKYt5OP1y4uiIQ8uwzqX
        3Mw6T6jmM7nsLci5XUEOt8131TA4inpvPNryT3ASpN3eoElPuBznuay2kMIxKwRTw9IWy8MNJUTR7
        9MdS6ZZuI5mtuTH/hLa5hB1VvZCv0uyVR+Hn7XGvhGcT9GkVAakjwA/kTXv5j95YFobH53Q5bgl0H
        RcvsDzNJJ0Bf+ENh7RqfcZCIY8f8NJppGNmt8dKrbP6GkfgRgs97mZ2EYNJ64oiBCEslizX6tkIuk
        vx+hkkI4pDEn/nWqzUGGo5Dwy/CKg5GBpTM/PVte13Wwzu7Dcvt2gi7+tX04+URQPBowxnmTxxp3p
        jsPi89dA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:46318 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gw2wa-00DmbE-FJ
        for git@vger.kernel.org; Tue, 19 Feb 2019 05:48:09 -0500
Date:   Tue, 19 Feb 2019 05:48:07 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: why no mention of "hooks.allownonascii" in any man page?
Message-ID: <alpine.LFD.2.21.1902190544470.23739@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  was just perusing the sample hook scripts, and the sample pre-commit
script provided with git does the following check:

# If you want to allow non-ASCII filenames set this variable to true.
allownonascii=$(git config --bool hooks.allownonascii)

  but that config variable (hooks.allownonascii) is not mentioned in
any man page. its entire existence in the git code base consists of:

$ grep -r allownonascii *
templates/hooks--pre-commit.sample:allownonascii=$(git config --bool hooks.allownonascii)
templates/hooks--pre-commit.sample:if [ "$allownonascii" != "true" ] &&
templates/hooks--pre-commit.sample:  git config hooks.allownonascii true

  technically, there's nothing wrong with that, i just thought it was
a bit weird that a sample hook script refers to a config variable that
is not referred to in any way elsewhere.

  should i care?

rday
