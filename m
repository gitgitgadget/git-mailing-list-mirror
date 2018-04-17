Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F521F404
	for <e@80x24.org>; Tue, 17 Apr 2018 15:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDQPek (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 11:34:40 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:33840 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeDQPej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 11:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C7h3BY2HBlRZgHDeLPOUWUly4ZGMvMbPwSPlnCsGYRI=; b=0Cfl5i2Jg8AJlznZoHUy0OGAh
        5gPLyiDS/pcRO956aTpTAbWq3oP28luZ33RCEssZHSBG+HxjmEr+37YovuJ2n3cuTCSHD/VPxzjoj
        3CVd67QcxyeTM/MHH/gtPMxFO963hzf7qKkkTpunH4N9xAkfRgR7MUH9kFdRdEk3c+nHQhE9/BRKq
        MC2PHW0/mSVK4bYrGU02EMATsOqUCz7ma7FwGcm0NWKu0w2IEOa8IOEFnrTr4Iz/1K2EvjU0eMhGT
        AYi0ZLNoH6FhsISXEBpWnnGh6rJ6VhS8g2kwwbmWd26STtM2YNFc/68Tds2IRzwPpTqNI0c7EbQAD
        dZlvfZmFQ==;
Received: from [128.107.241.175] (port=40384 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1f8Sck-0002wA-J1; Tue, 17 Apr 2018 11:34:37 -0400
Date:   Tue, 17 Apr 2018 08:34:20 -0700 (PDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: man page for "git remote set-url" seems
 confusing/contradictory
In-Reply-To: <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1804170831190.6019@localhost.localdomain>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain> <87y3hn5drx.fsf@linux-m68k.org> <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain> <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
 <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
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

On Tue, 17 Apr 2018, Junio C Hamano wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > Things won't work so well if you set the push url and fetch url to
> > different repositories. Git assumes that refs updated by "push"
> > will also be reflected via "fetch".
> >
> > I don't know offhand what will break, but likely something will.
> > For one, when you fetch again it will rewind your remotes after
> > the push.
>
> Exactly.  I still haven't fully embraced it myself, but for a long
> time, "git push" pretends as if it fetched from that remote and
> updates the corresponding remote tracking branches (if you have
> any), so you'll be inviting inconsistent behaviour if you set your
> fetch and push URLs pointing at two logically separate places.

  ... snip ...

  oh, i totally buy all that now, i'm just suggesting that the man
page might be tweaked to make that more obvious. in "man git-remote",
under "set-url", remember that it reads:

"Note that the push URL and the fetch URL, even though they can be set
differently, must still refer to the same place."

  i think it would be useful to be more specific about what "can be
set differently" means, since a lot of readers might not immediately
appreciate that it means just, say, the transport protocols. it never
hurts to add that little bit of detail.

rday


