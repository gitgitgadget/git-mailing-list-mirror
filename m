Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D66C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 09:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhKWJHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:07:22 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:20612 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhKWJHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 04:07:19 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Nov 2021 04:07:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637657528;
    s=strato-dkim-0002; d=nezwerg.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jpwFQzrqn7hQUBq2aBcJvKaJmA4flshg/1WH7oGhKFQ=;
    b=TI2BKfv/5EAIrweu/ViGhGJcLhHg6LQZKDYXxHjRbgJMbyf1jkI8ZG9MLnegpkPJfO
    QBnUx6TbuiPmjCd/GQBmwhc+PIGO+PtQurzR/K75WUa01cbAZJJJ51yhNLYhB9/xWexe
    VIXAwc2y1gbptSwO1q9llJDPK2eCyUGbl6vXwx8TrmKuA123GgZF5r5dM+cp6moXpybt
    vOf9T7/tt4fjEMxXG0xVpbsHPe7NoeLRRhzL3agiedCdtMFmP2XCQlMdhjDRlCmlrMWU
    XXUzd2Fv5x73abdnhN5FeNzhQKprsnKRhl2qsa7YPhrEolGvITxh32pE3h1YRKHvtHjZ
    akLg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IGUXYWCmfuWscPL1D1JO6dFpyf1vPb4ynTLEQ3AnwxYpaMfYGx6jswzFFT4lHLOpNiP/"
X-RZG-CLASS-ID: mo00
Received: from mail
    by smtp.strato.de (RZmta 47.34.6 DYNA|AUTH)
    with ESMTPSA id Y0a096xAN8q8413
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 23 Nov 2021 09:52:08 +0100 (CET)
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
 <xmqq5ysjbxfm.fsf@gitster.g>
From:   Alexander Veit <list@nezwerg.de>
Message-ID: <37d7c35e-54a3-04f5-b03c-b8197a8070a3@nezwerg.de>
Date:   Tue, 23 Nov 2021 09:52:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq5ysjbxfm.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.11.21 um 00:08 schrieb Junio C Hamano:
> So, here is that first step, to be hopefully mergeable to 'master'
> and also to 'maint' for 2.34.1

I've applied the patch to 'maint' and it worked. The application does not freeze anymore.

-Alex
