Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1B9FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 15:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiJ0PPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiJ0POk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 11:14:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D719ABFB
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 08:11:23 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oo4Wv-0009L9-Aa;
        Thu, 27 Oct 2022 16:10:49 +0100
Message-ID: <b0008377-2cb5-72ff-e94b-8182065b3436@iee.email>
Date:   Thu, 27 Oct 2022 16:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Git add documentation error
Content-Language: en-GB
To:     Angelo Borsotti <angelo.borsotti@gmail.com>,
        git <git@vger.kernel.org>
References: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
On 27/10/2022 12:53, Angelo Borsotti wrote:
> Hello,
>
> the reference manual for the "git add" command does not
> specify what that command does when applied to an
> unmodified file.

I presume that this file is already tracked..
> By testing this, I have seen that it does not add the file
> to the index, 

How was this tested?

If you have no changes, thaen the status diff will have no mention of
that file.
Perhaps change the tracked mode bits to see if that is noticed (note
though, not all mode bits are tracked..)
> and consequently it does not add it when a
> subsequent commit is done.

I suspect this is a subtle mental model misunderstanding about the
distinction between a commit as a snapshot, and a commit being reported
as the diff relative to its parent (and here, there is none, if the file
is unmodified)
> I think that this should be documented.

A test script with sample output would help here.
--
Philip


