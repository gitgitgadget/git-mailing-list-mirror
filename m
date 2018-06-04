Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31171F403
	for <e@80x24.org>; Mon,  4 Jun 2018 10:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeFDKNP (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 06:13:15 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:38384 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeFDKNO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 06:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gaW/5DlxAMFesSiVCe6FlG8zMAs5z2nr+7lXoT1nDUM=; b=OamqZKrvDnD3MaNWjI4d3SlaM
        /1MPeqecUrB5hCTEoIVOr/PQ2lmbRct2gFJt8bzEaHPyHfCjj9n3NQ97f0V71HsdRXnOwLf8p3vOc
        NcwNrayXXnSc7Qzg7GtiGqgSBfAOO11TsfSBpr8YS/aF6l16PxYqZmQ1cPdgb8KR+aNewVdRvBkFR
        tFRXrLbbK0CaGVKI7Zjnc56ZaI1yeBZf8AR6iTlaw/fT4/pKFXEuRm4o3NKk/eACOphl9gWXU9lit
        j1ynKkhWnB7gZrRVWFuBWAWaMQNTWFqScOvj3ayCLJt2f2+0lOuLtdhWK3qh/HV7cAMfvjzA5gvEK
        C01sNebAg==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:42480 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPmUB-00AOBm-0J; Mon, 04 Jun 2018 06:13:12 -0400
Date:   Mon, 4 Jun 2018 06:11:00 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: does a stash *need* any reference to the branch on which it was
 created?
In-Reply-To: <xmqq4lij6ym4.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1806040609290.7584@localhost.localdomain>
References: <alpine.LFD.2.21.1806021525120.19865@localhost.localdomain> <xmqq4lij6ym4.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
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

On Mon, 4 Jun 2018, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >   i realize that, when you "git stash push", stash graciously
> > saves the branch you were on as part of the commit message, but
> > does any subsequent stash operation technically *need* that branch
> > name?
>
> It is not "saves", but "the message it automatically generates
> includes <branch> and <commit title> as a human readable reminder".

  sorry, poor choice of words (particularly embarrassing as i'm such a
stickler for wording :-P)

> "git stash" does not have to read that message, as it is not
> prepared to read and understand what you wrote after you ran your
> own "git stash push -m 'my random message'" anyway.  It is merely
> for your consumption, especially when it appears in "git stash
> list".

  right, that's what i wanted to confirm, thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
