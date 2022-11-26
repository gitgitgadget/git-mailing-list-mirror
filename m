Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8BFC43217
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKZWom (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 17:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZWol (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 17:44:41 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781414010
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 14:44:39 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oz3uW-0002dP-Fk;
        Sat, 26 Nov 2022 22:44:37 +0000
Message-ID: <18530e26-3b36-9bc4-924c-f90084aabc9c@iee.email>
Date:   Sat, 26 Nov 2022 22:44:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without ellipsis,
 options
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221102120853.2013-1-philipoakley@iee.email>
 <20221112143616.1429-1-philipoakley@iee.email> <xmqqfsedywli.fsf@gitster.g>
 <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email> <xmqqedtvu7py.fsf@gitster.g>
 <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email> <xmqq7czjecfr.fsf@gitster.g>
 <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email>
In-Reply-To: <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/11/2022 14:32, Philip Oakley wrote:
> A careful read (and testing) of the existing 'mtrunc' does show a
> rounding error bug though. Its a confusion between the computed start
> and end points of the cut that loses one display column (the string
> displayed is short by one when the count is odd, IIUC).

I had confused myself.

My test case `git log --graph --format="%<(19,mtrunc)%d=2" -6` had a
2-char step in the graph that I confused with the effects between
repeated runs with the 'N' value adjusted by +1 and -1.

I then jumped to conclusions about the integer division in the mid
string position of the mtrunc case win the code.

Sorry for that.
