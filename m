Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41A0C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 12:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFAA60C4B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJNMtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 08:49:45 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.44]:57858 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNMto (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 08:49:44 -0400
Received: from [94.228.207.246] (helo=[192.168.2.206])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1mb08v-0005a6-11; Thu, 14 Oct 2021 14:47:29 +0200
Subject: Re: Suggestion: "verify/repair" option for 'git gc'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <e288dbe1-b7c7-5a2e-5271-404a14de836a@syntevo.com>
 <87h7dkh04o.fsf@evledraar.gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <96bf2eff-f4c8-cae8-76cb-6eeb233cd1d3@syntevo.com>
Date:   Thu, 14 Oct 2021 15:47:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87h7dkh04o.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.10.2021 4:19, Ævar Arnfjörð Bjarmason wrote:
> I'd be interested in a copy of it, I've been slowly trying to improve
> these sorts of corruption cases.

Sent.

> I wonder if this and other issues you encountered wouldn't need a full
> "fsck", but merely gc triggering a complete repack.

That sounds slow :( For example, it's going to be a lot of disk write 
bandwidth. Just doing the verification along with regular gc sounds faster.

> Yes, we still definitely have cases where dealing with this sort of
> thing can be very painful.

With the new remote promisor code, I think that auto-fixing corrupted 
blobs is easy enough (provided they can be found on any remote) ?
