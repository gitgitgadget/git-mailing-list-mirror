Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8DEC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9E822287
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLWSTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 13:19:33 -0500
Received: from mail-gateway-shared02.cyon.net ([194.126.200.224]:40866 "EHLO
        mail-gateway-shared02.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgLWSTd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Dec 2020 13:19:33 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2020 13:19:32 EST
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1ks8bs-0000al-9A
        for git@vger.kernel.org; Wed, 23 Dec 2020 19:11:42 +0100
Received: from [10.20.10.231] (port=10766 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <dev+git@drbeat.li>)
        id 1ks8br-002alj-3d; Wed, 23 Dec 2020 19:11:39 +0100
Subject: Re: [RFC PATCH gentoolkit] bin: Add merge-driver-ekeyword
To:     Matt Turner <mattst88@gentoo.org>,
        gentoo-portage-dev@lists.gentoo.org
Cc:     git@vger.kernel.org
References: <20201221034452.307153-1-mattst88@gentoo.org>
 <CAEdQ38E9Fepp9gmidcf_HvFMacwPZBr0XgPT5HFs8bHw-SJDZQ@mail.gmail.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <b2adb41b-b2d2-fecf-3a93-7eb3f1f2247d@drbeat.li>
Date:   Wed, 23 Dec 2020 19:11:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAEdQ38E9Fepp9gmidcf_HvFMacwPZBr0XgPT5HFs8bHw-SJDZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-3.5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.12.20 23:40, Matt Turner wrote:
> tl;dr:
> 
> I want to handle conflicts automatically on lines like
> 
>> KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
> 
> where conflicts frequently happen by adding/removing ~ before the
> architecture names or adding/removing whole architectures. I don't
> know if I should use a custom git merge driver or a custom git merge
> strategy.

You can probably put each of the keywords on a separate line:

KEYWORDS="
~alpha
~amd64
~arm
~arm64
~hppa
~ia64
~mips
~ppc
~ppc64
~riscv
~s390
~sparc~x86
"

The shell should handle both forms about the same.

(I'm not a Gentoo user, just talking about my general shell experience)

Regards
Beat
