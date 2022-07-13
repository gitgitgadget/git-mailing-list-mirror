Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D1AC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiGMUfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiGMUfK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:35:10 -0400
Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8CF29808
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:35:08 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id Bj4ZohzkjCVxYBj4aofZ3K; Wed, 13 Jul 2022 21:35:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657744506; bh=U57oRgKhA1jGCGTbCBqKfOkoSQps7axlIH0AwiklU2Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HGk9tDgBXVsSM4wTRc+/GL6MJNGXbc4BofSkPYg8xGpFnweeVtXw1Yt6fXhksFv9C
         ochwTRVsb0oybIjL4jSLGb4Va1gE/2WRns03Op47YBk9ACam88geeixU0VakBTJHui
         VSmpVTTNTRkXly6oef7+6EFzv21hp+wiYqIYypLrPoDfG9ufPhcR9G428x/gso+gzc
         96k4txqpSR8Hn/9u49ve35sfhavGf/Qk7dMAt3HRfzS3dF9iJbwO9YzK3fAnN82AN/
         SZ2LNtDNZKyzBMrgL5/wuwqoHMt/EYWbGq3y0zPUsS89YmcNI0inueEtDOy9SenEw9
         0EFonWU5HV4hw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ENUVbnVC c=1 sm=1 tr=0 ts=62cf2c7a
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=r_1U0MD7EQCXj5CXXHoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <6e9b21ff-a716-b202-e8c8-f83116b9a171@ramsayjones.plus.com>
Date:   Wed, 13 Jul 2022 21:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: t0301-credential-cache test failure on cygwin
Content-Language: en-GB
To:     Jeff King <peff@peff.net>, Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
 <CA+kUOakjnOxs_FGojdZXaiaY4+68pvyBHsbue+AQHp7PLXqNJw@mail.gmail.com>
 <CA+kUOak29RkU-ooMgOz8yCg9-q6vb1VfdP8_VLay_V650ttwjA@mail.gmail.com>
 <51972253-c1a1-8be7-39f5-3093ac83ffb1@ramsayjones.plus.com>
 <CA+kUOam-_3qR7YguPyUmyC2dWi2M1cy6Hg4Pveak+f40qtYBvA@mail.gmail.com>
 <Ys8aJ1HSLnWFT5qB@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Ys8aJ1HSLnWFT5qB@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIZ3r/HYDL8wFk8j/TBe/li/EuWQJUhSGmv/JyB6Dzz2ViZFc02BgCrAFGNReKjUI4aB2DI4W3PYMJCOQ+vhbj1DUrpEylN8XtjHHmu2mo9Zt5Dcg4AR
 ePEQzUGgfj8Z90O7LPiPg3mvoo9ztCcg2JXiQsjy8Iq/OicpVLFj5CcqBcAIKM0tSht+6JGhWYWvDkVZdaEFulbVVYgIRixHes8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/07/2022 20:16, Jeff King wrote:
> On Wed, Jul 13, 2022 at 03:42:38PM +0100, Adam Dinwoodie wrote:
> 
> Hmm. So I had assumed that the problem was unlink()ing the socket path
> while the client was still trying to read(). If that's the case, then I
> _think_ the minimal reproduction below should also trigger the problem.
> That might give you something more useful to show to Cygwin folks.

Hmm, good find - I looked at this commit while searching the gitweb pages the
other night, but didn't think it was relevant! :( Oh, well ...

I don't have too much time tonight, but I gave your program a quick try:

  $ gcc -o test-unix-sock test-unix-sock.c
  $ ./test-unix-sock
  $ ls -l my*
  ls: cannot access 'my*': No such file or directory
  $ ./test-unix-sock
  $ echo $?
  0
  $ 

HTH.

ATB,
Ramsay Jones


