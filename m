Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A441F404
	for <e@80x24.org>; Fri,  2 Feb 2018 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeBBQsd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 11:48:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:55402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751718AbeBBQsc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 11:48:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B916AD4A;
        Fri,  2 Feb 2018 16:48:31 +0000 (UTC)
Subject: Re: [PATCHv2] tag: add --edit option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com>
 <CAPig+cT8vKyhq6DvFMz-0CPRO-Y7R4EE_JhN6yuiSUNXW8-Yww@mail.gmail.com>
 <fa3f512a-bd77-80c7-4fec-071639f62d26@suse.com>
 <CAPig+cTDHsBSPZ+o+jh9bDvJ7NcZ3DGe+penppPwyupCJzmhAA@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Message-ID: <52737deb-a5dc-27d6-3c0c-0d8b8de991c5@suse.com>
Date:   Fri, 2 Feb 2018 17:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTDHsBSPZ+o+jh9bDvJ7NcZ3DGe+penppPwyupCJzmhAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 02/02/2018 à 10:57, Eric Sunshine a écrit :
> On Fri, Feb 2, 2018 at 2:15 AM, Nicolas Morey-Chaisemartin
> <nmoreychaisemartin@suse.com> wrote:
>> Le 02/02/2018 à 02:29, Eric Sunshine a écrit :
>>> On Thu, Feb 1, 2018 at 12:21 PM, Nicolas Morey-Chaisemartin
>>> <nmoreychaisemartin@suse.com> wrote:
>>>> - I'll post another series to fix the misleading messages in both commit.c and tag.c when launch_editor fails
>>> Typically, it's easier on Junio, from a patch management standpoint,
>>> if you submit all these related patches as a single series.
>>> Alternately, if you do want to submit those changes separately, before
>>> the current patch lands in "master", be sure to mention atop which
>>> patch (this one) the additional patch(es) should live. Thanks.
>> Well this patch does not touch any of the line concerned by fixing the error message. So both should be able to land in any order.
> Yup, that's a reasonable way to look at it. I see them as related
> (thus a potential patch series) simply because the existing error
> message in tag.c is fine, as is, until the --edit option is
> introduced, after which it becomes a bit iffy. Not a big deal, though.

OK ok I'll do it :)
What message do you suggest ?
As I said in a previous mail, a simple "Editor failure, cancelling {commit, tag}" should be enough as launch_editor already outputs error messages describing what issue the editor had.

I don't think suggesting moving to --no-edit || -m || -F is that helpful.
It's basically saying your setup is broken, but you can workaround by setting those options (and not saying that you're going to have some more issues later one).

>> Plus I've never had to look into localization yet so I'm going to screw up on the first few submissions (not counting on people that disagree or would prefer another message),
> As long as you just change the content of double-quoted string, you
> shouldn't have to worry about localization. The localization folks
> will handle the .po files and whatnot.

Sounds easy enough :)

Nicolas
