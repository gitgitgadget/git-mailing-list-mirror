Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD91220A40
	for <e@80x24.org>; Wed,  6 Dec 2017 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbdLFBGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 20:06:16 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:60500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbdLFBGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 20:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ktPLEaBw24aKQmRweQA9WlxFiFWsuGaIoe9gG1X5/Us=; b=HscVfw1grhoy9H9pCtoQBIZ4ZF
        CxDKLYnxS61JRWYSy7TsQmcWC+wlIaMPiCQZy9181YNXyRJuYC3xjwg+HmeOCdLPdWQklNqPtNghc
        ig4mn4a0kUiEq7hHZpnyzJU0flSwphrdlvAwEjS1yC4O2aJIL/zuANbZHMdyIYaEdhN0nkswPuhr8
        /FWcSM9WMWqt0T/87NXrLjgERcOWNQK/DiJCcvUuowEyA6IGMnf/854UZ8ru8OrafNSw0vahWKUUQ
        tvYwe+kxPDa1feg65wMXuGw9YN+U2cafR1gfKSyYL+QWEvaemMaVnzb0Sfm6oT+gMyNaN2Gu2dzbm
        IvCFUUYQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1eMOA9-0005nA-Ln
        for git@vger.kernel.org; Wed, 06 Dec 2017 01:06:13 +0000
Date:   Tue, 5 Dec 2017 17:06:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     git@vger.kernel.org
Subject: git send-email could check for no To: line
Message-ID: <20171206010613.GJ26021@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I keep coming up with new and innovative ways to send stupid-looking
emails with git send-email.  Please save me from myself.

My latest SNAFU is to spend so much time setting up the 'cc' list in
the git-format-patch step that I completely forgot to put anybody on the
'to' line, and even being prompted by git send-email that I might want
to add somebody to the 'To' line wasn't enough.

Could there be an extra confirmation, perhaps in send_message() that

        if ($cc ne '' && $to eq '')
		are_you_sure()

(you don't want me writing perl.  you really don't.)

