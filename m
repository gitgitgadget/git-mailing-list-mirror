Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE0FC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 06:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjB1Gfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 01:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjB1Gfr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 01:35:47 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB91AD27
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 22:35:45 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4PQngK5qShz5tlB;
        Tue, 28 Feb 2023 07:35:41 +0100 (CET)
Message-ID: <75afffcd-65f8-e8e2-1cd9-51806194e4b3@kdbg.org>
Date:   Tue, 28 Feb 2023 07:35:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Gitk : When the number of commits is small, you can roll up
 excessively
To:     Philip Oakley <philipoakley@iee.email>
References: <BY5PR14MB3560879E6CBDD493C873DB18B1A29@BY5PR14MB3560.namprd14.prod.outlook.com>
 <3f11a4d5-6774-ddd9-060e-3e95acb84c69@iee.email>
 <CH2PR14MB35637B8C5593D5F17076E7EEB1AF9@CH2PR14MB3563.namprd14.prod.outlook.com>
 <15d5c6c5-091a-63b1-979a-5aaa64c9e717@iee.email>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     "L2750558108@outlook.com" <L2750558108@outlook.com>,
        git <git@vger.kernel.org>
In-Reply-To: <15d5c6c5-091a-63b1-979a-5aaa64c9e717@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.23 um 11:00 schrieb Philip Oakley:
> On 27/02/2023 05:01, L2750558108@outlook.com wrote:
>> You can scroll up via the scroll wheel or the right column button and
>> see the white space in front of the first row, and in this case, the
>> collision box for each row is misaligned, which prevents me from
>> selecting the commit by clicking. If you stll not understand, I can
>> send a picture or video to show the situation I am experiencing,
> 
> I see the space above (which I guess is for 'uncommitted changes',
> should they exist) and a small space below when scrolling.
> I'm unsure what the 'collision box' refers to as I don't see any
> 'misalignment'. But I maybe just too familiar with gitk's quirks.

The issue is this: When there is vertical space for a list of, say, 10
commits, but there are only 3 commits, then you can scroll the display
such that the 3 commit lines are at the bottom of the list and there is
blank space above the lines. Now, when you click on one of the lines,
nothing happens; but when you click into the void near the top, one of
the lines is selected as if the lines were displayed at the top.
Clearly, the click hitbox for the lines is not aligned with how the
lines are displayed.

IMHO, this is a case of "if it hurts, don't do it".

-- Hannes

