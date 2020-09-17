Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F6BC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11FC206D4
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIQITK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:19:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57617 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIQITK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 04:19:10 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgzWP-1kzYnq44yb-00hRf6; Thu, 17 Sep 2020 10:18:55 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 4FC081E01E7;
        Thu, 17 Sep 2020 08:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3entOaL-YvtG; Thu, 17 Sep 2020 10:18:55 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 1D8EE1E01E6;
        Thu, 17 Sep 2020 10:18:55 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id EEEDA8051A; Thu, 17 Sep 2020 10:18:54 +0200 (CEST)
Date:   Thu, 17 Sep 2020 10:18:54 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200917081854.GC8079@pflmari>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:D0xuwjRbgs5Ss8cM74LUL0kmygKzQFd2e++q6/DolZrPa3gLvZ+
 AAvYsqKenJI0PXVgYbF60mYkjDpPos/1DsW2hlBL6VyoksJqhdbt5cyNWA/UDLZt1kkCwaX
 G2f30OM4p2fSsksd1VXhycbGAOX7swhnbRrwlLa707rsINw2yeWMAzT28b32c6xlE7Qje1d
 619OhTcNeneGDlMGebq3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5B17jaxhWc4=:wrIiNr6ljpmE5f4ZYMKrhB
 YweUCPin9KdxUiP1iY0o6EnfXr11CYFdj1NI5O9cITDBcxLLYsOLB3iYyc3FdqXfAtlOXp5G4
 IjPYJkRgru7B7R+zc+1AbuVLTYuHeheH7AZkGr7Uxl7nUGoK/IeKb2wTkXneUD9vw8ohqaoT3
 PfvQRNan4zWiCtF5Z5X7+JD2u0tAnrOvz35z3Fr8273nCW5ZK9IB2lb+Oh+hizvJ5lukS5TgB
 aHHeuHwxJo6LvefsdqtKs2j9sOvlm4ZLTTu0XghRy4CfGDwSFEXHfD2QhtJ6YMrvtlz7jhC85
 ZUd1LUEIpAqx92AVlpNelwsFnqwr4ibPbQlpfVvBCOQY6SQwR6ssfdnBpZ/j1hueDJSIb5m5X
 klL7dtfTeawOcM7WyGRexqyPlA0fCwjllMde4mvuuxqn9bPs8XmaefIr+9Q/3Un2jLQqhZrpN
 pDZY/joaVBRYdHi99KZ7M1t9AxDclfV9Z9kdsstspks99iyAuMF403eSr1j6HTBlZiyfP71eE
 Tp36gvfidMCZVgP1/0Tf49eh5BMrfmOpAK2G2K/itRAf2A/+jZttr6jywDMgEq0U5z8FjnejR
 9f7dfVayiEIOLe+NqD+3vSqSs8JvvRU5OoSPEzTudhPD3txOmxO1GBgPUBeaJNoc3D9ElGQPl
 7I1MH1d7pty8a88HUtbWccf9hFPSC3JFGPBELKAM+Huy9IM6qhzzh/BUb4yOln+BsYzRli9LO
 OQ4YEevSBX0xw0ZEG8wLVCAxifvMMuTNLHEnqDwtv93/AQ68kn7M/fBeJ/ikn29nc/YpFLkGO
 cdXFRjleWmjndEhNQiupxMYsNgnOYp5ZiVw2C/1NIGR+Pw/U6S60W89oj86AICYSKkrS8UpIC
 opc8Q4UJtd0R/wSlsYKQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Wed, Sep 16, 2020 22:14:08 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > Affecting the transfers caused by git-fetch, the
> > option allows to control network operations similar
> > to --ipv4 and --ipv6 options.
> > ...
> > Something like this?
> 
> Also, we should follow the usual "the last one wins" for a
> configuration variable like this, which is *not* a multi-valued
> variable. ...
...
> [Footnote]
> 
> *1* But leave a room to extend it in the future to a comma-separated
>     list of them to allow something like "ipv6,ipv7,ipv8" (i.e. "not
>     just 'any'---we want to say that 'ipv4' is not welcomed").

I think this footnote is the best description of this option. From what
I gathered, it looks like really a list of protocols the networking code
is allowed to try to reach the remote.

The above is orthogonal to how it given on the command-line: there it can be
"unset". It is just not "unset" for the networking code, rather reset to the
default list of protocols.
