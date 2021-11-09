Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4470C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 05:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE1B610F7
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 05:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbhKIFvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 00:51:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40660 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230364AbhKIFvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 00:51:06 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A95m5D7004911
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Nov 2021 00:48:06 -0500
Message-ID: <503ee252-c733-ce8e-14ed-d4d1909682b8@mit.edu>
Date:   Mon, 8 Nov 2021 21:48:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 1/2] fetch: Protect branches checked out in all
 worktrees
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
References: <alpine.DEB.2.21.999.2111081514460.100671@scrubbing-bubbles.mit.edu>
 <a1acda2b-7cd0-0c1a-8c60-681d79418872@gmail.com>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <a1acda2b-7cd0-0c1a-8c60-681d79418872@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/8/21 21:19, Bagas Sanjaya wrote:
> On 09/11/21 03.15, Anders Kaseorg wrote:
>> As a side effect of using find_shared_symref, we’ll also refuse the
>> fetch when we’re on a detached HEAD because we’re rebasing or bisecting
>> on the branch in question. This seems like a sensible change.
> 
> We can say "we'll also refuse fetching when we're on a detached HEAD 
> (for example if we're rebasing on the branch in question or bisecting)."

No, I meant what I wrote.  We don’t refuse the fetch if we’re on a 
detached HEAD for some other reason.  That would be quite unhelpful.

Anders
