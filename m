Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E1C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13DA208C3
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgEAO0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 10:26:30 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:2988 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgEAO03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 10:26:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49DF1B52Fmz5tlH;
        Fri,  1 May 2020 16:26:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4FD65735B;
        Fri,  1 May 2020 16:26:20 +0200 (CEST)
Subject: Re: [PATCH v2] userdiff: support Markdown
To:     Ash Holland <ash@sorrel.sh>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
References: <xmqq4kt0ubgu.fsf@gitster.c.googlers.com>
 <C2FDC85CN8B8.8IVFPUOV0BHA@what>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ec6239c6-b619-e11d-9166-d968bf5601db@kdbg.org>
Date:   Fri, 1 May 2020 16:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <C2FDC85CN8B8.8IVFPUOV0BHA@what>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.20 um 13:49 schrieb Ash Holland:
> On Thu Apr 30, 2020 at 11:31 AM BST, Junio C Hamano wrote:
>> Taking all that together, my suspicion is
>>
>> "^ {0,3}#{1,6}[ \t]"
>>
>> i.e. "possibly slightly indented run of 6 hashes, with a whitespace
>> to catch the headers with real contents and nothing else" might be
>> more practically useful. I dunno.
> 
> Sure, that looks plausible. I don't have a strong opinion on whether
> it's more useful to be consistent (and show the last heading, even if it
> doesn't contain any text) or to try as hard as possible to just show
> "some text", even if it's not the last heading, but two people have now
> suggested changing it, so I'll submit a v3 with your suggested pattern.

The pattern above captures only the hashmarks, but not the text of the
header. I suggest to append ".*".

-- Hannes
