From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv3 08/11] fetching submodules: respect `submodule.jobs`
 config option
Date: Fri, 13 Nov 2015 21:47:00 +0100
Message-ID: <56464C44.6090902@web.de>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
 <1446597434-1740-9-git-send-email-sbeller@google.com>
 <56426DD1.6090904@web.de>
 <CAGZ79kbqedWRDADChorvWhcmyjO4iZqt4WO8KSo917pxWgr4Rg@mail.gmail.com>
 <56439D1E.8080102@web.de>
 <CAGZ79kYiPb-GJ37Zq-2ULpLD8Lh_3qAxa0W+u6+5fMrX6YzJdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 21:47:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxLFv-0007QR-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 21:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbbKMUra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 15:47:30 -0500
Received: from mout.web.de ([212.227.15.4]:56513 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933099AbbKMUr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 15:47:28 -0500
Received: from [192.168.178.41] ([79.211.114.124]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MDPI5-1aBxJi3WWL-00Gtca; Fri, 13 Nov 2015 21:47:04
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kYiPb-GJ37Zq-2ULpLD8Lh_3qAxa0W+u6+5fMrX6YzJdw@mail.gmail.com>
X-Provags-ID: V03:K0:uHymiT5iUcpuO1+a6RJexVmEROS8XhFu0c19TIFIP8U38C6UwHd
 h+wnR9jJBD03gN5u3U/s3kXxRXpHFmdAzXyVkZ2Wr0YyozFoE+3BMCltIBhiYzov/C43lza
 PHXmw5vI/vZ/JO0IOqtcmxpI/gyx6VoJj1TIkAc5QfG+Xwg0vPj73MwK06mptcRQeZMx64w
 jNZeBHPzPHPwqh1G2Y2Lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LfUznC4y+Ow=:EEtTlEqfGdowulw2YMki1n
 VynUZoLeCHcTCPfnN9jCia0sGwi7Sg8yXFmHE8SQkO1Tjy8yibFsenfkC/OU8vnnxFkix0EtS
 G6WhXnPKtHOuStWvlYdtG9svEftob+htl4gdumsEuZsV16KkcfwzmPntxxPyesCW6vP0yr1Aq
 OC77ElgYXUXcz682PNPShSjILpQtaFGzzlM4rD+eojuQsCCqzVY+4WeUm9DJAH0DQoipaLpi1
 2VoD6ZUaafVwmA9o/CuWdgh3ScuWKM9UZO4GkADR0kfWBhy+N8PGwnpk9Dgx2GebFuFMTF/rl
 aMMKRudaI4I71kz3Mt6lmZg59UeMMoy6s0eOFDa8OAniIMV5hVtAxHOeQM1XM2qC3DsmIntBQ
 NNRJbb3RwUq5A0dn4mkp/1GP7FeBke3Vvge4W1GIAiLZ0S84pk1isUN2RT+CniDZuQ9RloG+I
 0lC90GGgZsIXNWnmmiM4xnG2vgruIs3hvL5XKIXdDddBtB8DPt0shZLNHfFniFV+OqwP9psM8
 Uu546FvsxTMt4eV+Dk9VKt6feVS39g9XA9LFzJdZKjyM/f0BmWqN3VQ9WAxKzgPPLWNhLiqMo
 Gg2XW1tiJa0ck+WUm25Si4rbTRjs/1mIC9Xoud0bXvnDlAwVJVDE9Wf90jumHAHHCNRk9sVrr
 3Aw4SXn8KArsJpuIz/kvy5NVMONupzQUhxM9ivM1RFW5TRmIojtu1BCt0SgjLxDrgaSAiN7s/
 KPJlBn7O4QgrJiLoY8gZHp+HSe4UKYP4gdgtvJQLx5aFeb1lJdfgdkn7k/Qpf9iNzftMk/Ry 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281262>

Am 12.11.2015 um 00:34 schrieb Stefan Beller:
> On Wed, Nov 11, 2015 at 11:55 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>
>>> TL;DR: checkout is serial, network-related stuff only will be using
>>> submodule.jobs
>>
>>
>> My point being: isn't "jobs" a bit too generic for a config option that
>> is only relevant for network-related stuff? Maybe "submodule.fetchJobs"
>> or similar would be better, as you are already thinking about adding
>> other parallelisms with different constraints later?
>
> Actually I don't think that far ahead.

Maybe I've been bitten once too often by too generic names that became
a problem later on ... ;-)

> (I assume network to be the bottleneck for clone/fetch operations)
> All I want is a saturated network all the time, and as the native git protocol
> doesn't provide that (tcp startup takes time until full band witdth is reached,
> local operations both on client and server) I added the parallel stuff
> to 'smear' different submodule network traffics along the timeline,
> such that we have a better approximation of an always fully saturated link
> for the whole operation. So in the long term future, we maybe want to
> reuse an http/ssh session for a different submodule, possibly interleaving
> the different submodules on the wire to make it even faster. Though that
> may not be helping much.
>
> So we're back at bike shedding about the name. submodule.fetchJobs
> sounds like it only applies to fetching, do you think it's sufficient for clone
> as well?

Hmm, to me fetching is a part of cloning, so I don't have a problem with
that. And documenting it accordingly should make it clear to everyone.

> Once upon a time, Junio used  'submodule.fetchParallel' or  'submodule.paralle'
> in a discussion[1] for the distinction of the local and networked things.
> [1] Discussing "[PATCH] Add fetch.recurseSubmoduleParallelism config option"
>
> How about submodules.parallelNetwork for the networking part and
> submodules.parallelLocal for the local part? (I don't implement parallelLocal in
> the next few weeks I'd estimate).

If 'submodules.parallelNetwork' will be used for submodule push too as
soon as that learns parallel operation, I'm ok with that. But if we don't
have good reason to believe the number of jobs for fetch can simply be
reused for push, me thinks we should have one config option containing the
term "fetch" now and another that contains "push" when we need it later,
just to be on the safe side. Otherwise it might be hard to explain to
users why 'submodules.parallelNetwork' is only used for fetch and clone
and why they have to set 'submodules.parallelPush' for pushing ...

So either 'submodule.fetchParallel' or 'submodule.fetchJobs' is fine for
me, and 'submodules.parallelNetwork' is ok too as long as we have reason
to believe this value can be used for push later too.
