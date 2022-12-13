Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC50AC4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 21:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiLMVCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 16:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiLMVCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 16:02:53 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719935F59
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 13:02:50 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 8452 invoked from network); 13 Dec 2022 22:02:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1670965366; bh=WCTLTcy4okJdHdi4KpGrnlwnkGotr4pgBQjFKMrBIdo=;
          h=Subject:To:Cc:From;
          b=Ur2pZsAwb+OdgBZOCurY20esLsUqCnmvj5fXAhWF13/DLLbuz4841eTX7Xg0AdtoU
           zlt2pzUsIvXEDXjqXnzWMiIAXfSPDdLjq17q0dTt8+CRMthh7ljuE45U/E0bdgTIGm
           Gn1emqaTS7biVozeczNuCje7YYV7adVj0EGELRn4=
Received: from mail.dtcasino.pl (HELO [192.168.1.5]) (piotrekkr@o2.pl@[212.180.138.13])
          (envelope-sender <piotrekkr@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <l.s.r@web.de>; 13 Dec 2022 22:02:46 +0100
Message-ID: <c07a5ac4-3da6-6fb4-4586-a83373bc05d4@o2.pl>
Date:   Tue, 13 Dec 2022 22:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Issue with git > 2.36.1 and pre-commit hook on macOS M1
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <51d5993f-a1e0-519e-ffa9-ec5205c5e96d@o2.pl>
 <30f80aa4-d5c1-4fce-f1c9-710eabeaa022@web.de>
Content-Language: en-GB-large
From:   Piotrek <piotrekkr@o2.pl>
In-Reply-To: <30f80aa4-d5c1-4fce-f1c9-710eabeaa022@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 8edf3adc2f91ca212115ccef80bc89c3
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [EaLV]                               
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.12.2022 14:29, René Scharfe wrote:

> While "docker compose" is right in that stdin is not a TTY, it never
> was.  Redirecting the output its seems to help.  So I guess it checks if
> stdout is connected to a terminal and then expects stdin to be a TTY as
> well.  Try appending " | cat" to the command in the pre-commit hook,
> which breaks the connection for stdout.
> 
> René

Just to be sure if I understand this correctly. It is probably a bug in 
docker compose expecting stdin to be a TTY, right? I'll write some bug 
report to them, maybe they will take care of this since it is only on 
MacOS and all works fine with Linux.

Thank you for checking this René.
