Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35598C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 13:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiHBNyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiHBNyN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 09:54:13 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0832D95
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 06:53:51 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4926F3F413E;
        Tue,  2 Aug 2022 09:53:33 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:100e:b128:335c:f82b:cadb:1962:25e8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DC1B63F4129;
        Tue,  2 Aug 2022 09:53:27 -0400 (EDT)
Subject: Re: fsmonitor: perpetual trivial response
To:     Eric D <eric.decosta@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <CAMxJVdH6=dP7vwruSnKFVTT4ZgygLK_2fu5TKoRia+WyMzATXA@mail.gmail.com>
 <840r6312-3r19-n087-68s1-rpo1n9869osn@tzk.qr>
 <CAMxJVdEPd3h3WyXC+MjN9dmKyQOTMb9+Nsp=Vm-bt7J+kL202g@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5fb7ff38-dfa1-909a-1448-dfb779e1b5fd@jeffhostetler.com>
Date:   Tue, 2 Aug 2022 09:51:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMxJVdEPd3h3WyXC+MjN9dmKyQOTMb9+Nsp=Vm-bt7J+kL202g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/1/22 2:19 PM, Eric D wrote:
> On Thu, Jul 28, 2022 at 9:48 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Eric,
>>
>> On Wed, 27 Jul 2022, Eric D wrote:
>>
>>> fsmonitor daemon was started in the background (i.e. git
>>> fsmonitor--daemon start) so I could enable trace2 logging.
>>>
>>> 15:36:37.860862 ...n/fsmonitor--daemon.c:969 | d1 | th01:ipc-server
>>>        | region_enter | r1  | 124.965540 |           | fsmonitor    |
>>> label:handle_client
>>> 15:36:37.860862 ...n/fsmonitor--daemon.c:970 | d1 | th01:ipc-server
>>>        | data         | r1  | 124.965809 |  0.000269 | fsmonitor    |
>>> ..request:1658950597810367000
>>> 15:36:37.860862 ...n/fsmonitor--daemon.c:786 | d1 | th01:ipc-server
>>>        | data         | r1  | 124.965892 |  0.000352 | fsmonitor    |
>>> ..response/token:builtin:0.12336.20220727T193432.938608Z:0
>>> 15:36:37.860862 ...n/fsmonitor--daemon.c:822 | d1 | th01:ipc-server
>>>        | data         | r1  | 124.965969 |  0.000429 | fsmonitor    |
>>> ..response/trivial:1
>>> 15:36:37.860862 ...n/fsmonitor--daemon.c:974 | d1 | th01:ipc-server
>>>        | region_leave | r1  | 124.966000 |  0.000460 | fsmonitor    |
>>> label:handle_client
>>> 15:38:40.079662 ...n/fsmonitor--daemon.c:969 | d1 | th02:ipc-server
>>>        | region_enter | r1  | 247.186960 |           | fsmonitor    |
>>> label:handle_client
>>> 15:38:40.079662 ...n/fsmonitor--daemon.c:970 | d1 | th02:ipc-server
>>>        | data         | r1  | 247.187067 |  0.000107 | fsmonitor    |
>>> ..request:1658950720017776200
>>> 15:38:40.079662 ...n/fsmonitor--daemon.c:786 | d1 | th02:ipc-server
>>>        | data         | r1  | 247.187328 |  0.000368 | fsmonitor    |
>>> ..response/token:builtin:0.12336.20220727T193432.938608Z:0
>>> 15:38:40.079662 ...n/fsmonitor--daemon.c:822 | d1 | th02:ipc-server
>>>        | data         | r1  | 247.187448 |  0.000488 | fsmonitor    |
>>> ..response/trivial:1
>>> 15:38:40.079662 ...n/fsmonitor--daemon.c:974 | d1 | th02:ipc-server
>>>        | region_leave | r1  | 247.187491 |  0.000531 | fsmonitor    |
>>> label:handle_client
>>> 15:42:14.719673 ...n/fsmonitor--daemon.c:969 | d1 | th03:ipc-server
>>>        | region_enter | r1  | 461.821373 |           | fsmonitor    |
>>> label:handle_client
>>> 15:42:14.719673 ...n/fsmonitor--daemon.c:970 | d1 | th03:ipc-server
>>>        | data         | r1  | 461.821429 |  0.000056 | fsmonitor    |
>>> ..request:1658950934652816400
>>> 15:42:14.719673 ...n/fsmonitor--daemon.c:786 | d1 | th03:ipc-server
>>>        | data         | r1  | 461.821467 |  0.000094 | fsmonitor    |
>>> ..response/token:builtin:0.12336.20220727T193432.938608Z:0
>>> 15:42:14.719673 ...n/fsmonitor--daemon.c:822 | d1 | th03:ipc-server
>>>        | data         | r1  | 461.821486 |  0.000113 | fsmonitor    |
>>> ..response/trivial:1
>>> 15:42:14.719673 ...n/fsmonitor--daemon.c:974 | d1 | th03:ipc-server
>>>        | region_leave | r1  | 461.821497 |  0.000124 | fsmonitor    |
>>> label:handle_client
>>>
>>> Note that this is a slightly hacked build of mine where I disabled the
>>> check for network filesystems. I also added some additional logging
>>> that tells me that the query is successful, it's just that the
>>> response is trivial. The sandbox I am using is on the network and
>>> being accessed from my Windows VM.
>>
>> Since you already "hacked" it, why not instrument it a bit more, e.g.
>> offering some trace2 message for all the places where `do_trivial` is set
>> to 1 in builtin/fsmonitor--daemon.c?
>>
>> Or maybe you need to use `GIT_TRACE2_EVENT` instead of `GIT_TRACE2_PERF`
>> (I vaguely remember that `error()` messages are only logged in one of
>> these two modes).
>>
>> Ciao,
>> Johannes
> 
> My sandbox is sparse, but it is not "cone compliant"; temporarily
> disabling sparse checkout seems to have (temporarily) resolved this
> issue - at least for my purposes of testing fsmonitor out on network
> filesystems.
> 
> -Eric
> 

The first time status runs and it starts the daemon, you'll get
a trivial response (because the daemon doesn't have a sync point
established with client commands yet).

Subsequent client commands (like status) will continue to receive
a trivial response *UNTIL* one of them updates the index and records
the sync point (token) into the index.  That is, until the index
is updated with a valid token, they will continue to send not-sync'd
timestamp in the request header and get a trivial response.

 > ..request:1658950934652816400
 >
 > ..response/token:builtin:0.12336.20220727T193432.938608Z:0
 > ..response/trivial:1

When/if any of these client commands update the the index, they will
write the response token to the FSM index extension, and subsequent
requests will send it to the daemon.  The daemon will then start sending
non-trivial responses (possibly with an updated token).

 > ..request:builtin:0.12336.20220727T193432.938608Z:0
 >
 > ..response/token:builtin:0.12336.20220727T193432.938608Z:1


Commands like `git status` may be read-only or may update the `lstat`
times in cache-entries and rewrite the index.  It is not always clear
when a status command will and will not rewrite the index -- it just
depends on what kind of changes it sees and how many.  My point is
that it will not update the token unless it updates the index, so you
need to watch for that on the client side rather than looking at the
daemon log.

Hope this helps,
Jeff
