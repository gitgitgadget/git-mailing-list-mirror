Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F60BC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C79660F70
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhKDULq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:11:46 -0400
Received: from avasout-peh-001.plus.net ([212.159.14.17]:40173 "EHLO
        avasout-peh-001.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhKDULp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 16:11:45 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id ij2lm1K9VCV4Tij2mmFT9t; Thu, 04 Nov 2021 20:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1636056545; bh=3qehuz2oN/Dztr2QIvi0oE3a69Tkcm7cQXEcQFrOfsA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L0i8Bx8CDSad5JrrMZ8aYpDkFvvYXGro+vY/aBc/YhI4eCz/KrT5vZYOkrTE/DZvu
         Cg5VexJ56u2vawrT2SVL/NS1zbYfVeZCzP9e9i9pD6LVUkiHDU9v1UBMKRXGc8AnYs
         aFwFTWHljOZgeYzGfh6S+TuotL2fJbDGtBE/ueskq+QyWWlUlZPnNSKpNGSGzVt172
         AZ9tu4jnN9kEc+Cq9012/Qqv+ZwP1tqhUb+SP4dTxaFPClL2fx0If4D71HfTWeQmDR
         P6xgvKe48YTPHplpq0G/ABXy3pXdqOEFLxEDNJOpwky6xi5Y8rerNN3cDcF0x+bXax
         MIJVYzD7t47bQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Yrts+6UX c=1 sm=1 tr=0 ts=61843de1
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=hwfoqT4wVfvneG3jFG0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
To:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
References: <20211104192533.2520-1-adam@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6acb22bc-a90c-b8b6-2e7d-d7e17ba595ea@ramsayjones.plus.com>
Date:   Thu, 4 Nov 2021 20:09:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104192533.2520-1-adam@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfINy1KMCjYW2um4VAiEYeCtYcvlm1Eb70wphMJcpUar1gprUv/LZUZe+g93Vd2HsMj1lTX358KaVYB1VF7AG9YBNoh6n52ZDsOLMemv+Ss0CatUoWAcj
 Iecwm+fiVJvYLroijAv2j16NDApV7/sHrzk84CLHmEQE2VsJ9406qg55nRoQL5Kp+C1UZ0GnHhsXQOo/W/fXBwqysIGH1b87IQc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On 04/11/2021 19:25, Adam Dinwoodie wrote:
> SSH keys are expected to be created with very restrictive permissions,
> and SSH commands will fail if the permissions are not appropriate.  When
> creating a directory for SSH keys in test scripts, attempt to clear any
> ACLs that might otherwise cause the private key to inherit less
> restrictive permissions than it requires.

I was somewhat surprised to see your report, since all these tests
passed without issue for me on '-rc0'! :D (64-bit cygwin only).

So, the difference seems to be down to FS ACLs, Hmmm ...

(BTW, I am on windows 10 21H1)

ATB,
Ramsay Jones
