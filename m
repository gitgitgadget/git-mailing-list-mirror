From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 08/11] fetching submodules: respect `submodule.jobs`
 config option
Date: Fri, 13 Nov 2015 13:29:23 -0800
Message-ID: <CAGZ79kYjtpsVuTQt6Hg=GukFVyavLphH_i58v7ZNDF9ETh58Lw@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-9-git-send-email-sbeller@google.com>
	<56426DD1.6090904@web.de>
	<CAGZ79kbqedWRDADChorvWhcmyjO4iZqt4WO8KSo917pxWgr4Rg@mail.gmail.com>
	<56439D1E.8080102@web.de>
	<CAGZ79kYiPb-GJ37Zq-2ULpLD8Lh_3qAxa0W+u6+5fMrX6YzJdw@mail.gmail.com>
	<56464C44.6090902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 13 22:29:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxLuT-0005q4-J0
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 22:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbKMV3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 16:29:25 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34157 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbKMV3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 16:29:24 -0500
Received: by ykfs79 with SMTP id s79so170529791ykf.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 13:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RFB5i4XmT5e9k9WGSjlrDV7AnqUbftfWKPXXTBp55rc=;
        b=TAr0E3WWQIP0l71CERRG8MMgEVfGgqUiR0oMKWAD/8DjFCSssU5MCHQSM44s8PMfdE
         V4KpsN9dce1SSY3P0oXnZXTQj2g8KbFpRyLKd7WAZ8WpqnCUsrlQnmxY4oNJ8B7vR3b2
         CTmZZFVk+L6rZjp4b5UZ0/3ThKd7DVZXE2pAaCOURGiSIr4n8O4/gvch63n05Qd4NN34
         WfXc40aWUEq6aCcMk+Mf/55H4L+GPUS4qd+JqetgLpLZbMasbzikGRByXKP4WlZdjCsq
         vi0ufIDHinuomVBPwgobq7WBwglaiPMNhwxsVUCdqSpKgVn8eyvJTCxJlaQXwgbbCFgq
         ruyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RFB5i4XmT5e9k9WGSjlrDV7AnqUbftfWKPXXTBp55rc=;
        b=MQXfv+YJzAiaCTLDhHt01CHPTQdX7/Iz1vN/Gz1u5fF/15h9BTalhxg6g+Qm/8YU3c
         C0cbEzDlstn2tW/H+lcmUM4fhaWC3dEQDsags+0b2CausbVYWvXeGOm8XCWpwk5gQ/1N
         MtlVCmfVvhSmwiyKfMZFQBS7h1wCNydJaRfmwsqlcj9APZlUz8KSA5GXr7whHK5Q5tbM
         mZmy4GDMvim4mxQEnx9YXBNplGdcpiMMEx1/wQpqALHcDNBh3M926xo0+naF2kq/eesn
         c/moo4J9vx3dx7mJVIEiSwzX4s4xSroG5cgHk38nzWtZEuIHLZei2Jb4f1VWsQ0wQV7K
         G42A==
X-Gm-Message-State: ALoCoQlg6aeOQfi32YEZZBjC635LawynCWc9oXSgto0d+sLDTTsIbGbwrKicpens542vdVC03Lsi
X-Received: by 10.129.75.131 with SMTP id y125mr26486934ywa.48.1447450163994;
 Fri, 13 Nov 2015 13:29:23 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Fri, 13 Nov 2015 13:29:23 -0800 (PST)
In-Reply-To: <56464C44.6090902@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281263>

On Fri, Nov 13, 2015 at 12:47 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 12.11.2015 um 00:34 schrieb Stefan Beller:
>>
>> On Wed, Nov 11, 2015 at 11:55 AM, Jens Lehmann <Jens.Lehmann@web.de>
>> wrote:
>>>>
>>>>
>>>> TL;DR: checkout is serial, network-related stuff only will be using
>>>> submodule.jobs
>>>
>>>
>>>
>>> My point being: isn't "jobs" a bit too generic for a config option that
>>> is only relevant for network-related stuff? Maybe "submodule.fetchJobs"
>>> or similar would be better, as you are already thinking about adding
>>> other parallelisms with different constraints later?
>>
>>
>> Actually I don't think that far ahead.
>
>
> Maybe I've been bitten once too often by too generic names that became
> a problem later on ... ;-)
>
>> (I assume network to be the bottleneck for clone/fetch operations)
>> All I want is a saturated network all the time, and as the native git
>> protocol
>> doesn't provide that (tcp startup takes time until full band witdth is
>> reached,
>> local operations both on client and server) I added the parallel stuff
>> to 'smear' different submodule network traffics along the timeline,
>> such that we have a better approximation of an always fully saturated link
>> for the whole operation. So in the long term future, we maybe want to
>> reuse an http/ssh session for a different submodule, possibly interleaving
>> the different submodules on the wire to make it even faster. Though that
>> may not be helping much.
>>
>> So we're back at bike shedding about the name. submodule.fetchJobs
>> sounds like it only applies to fetching, do you think it's sufficient for
>> clone
>> as well?
>
>
> Hmm, to me fetching is a part of cloning, so I don't have a problem with
> that. And documenting it accordingly should make it clear to everyone.
>
>> Once upon a time, Junio used  'submodule.fetchParallel' or
>> 'submodule.paralle'
>> in a discussion[1] for the distinction of the local and networked things.
>> [1] Discussing "[PATCH] Add fetch.recurseSubmoduleParallelism config
>> option"
>>
>> How about submodules.parallelNetwork for the networking part and
>> submodules.parallelLocal for the local part? (I don't implement
>> parallelLocal in
>> the next few weeks I'd estimate).
>
>
> If 'submodules.parallelNetwork' will be used for submodule push too as
> soon as that learns parallel operation, I'm ok with that. But if we don't
> have good reason to believe the number of jobs for fetch can simply be
> reused for push, me thinks we should have one config option containing the
> term "fetch" now and another that contains "push" when we need it later,
> just to be on the safe side. Otherwise it might be hard to explain to
> users why 'submodules.parallelNetwork' is only used for fetch and clone
> and why they have to set 'submodules.parallelPush' for pushing ...
>
> So either 'submodule.fetchParallel' or 'submodule.fetchJobs' is fine for
> me, and 'submodules.parallelNetwork' is ok too as long as we have reason
> to believe this value can be used for push later too.

Ok, got it. So fetchJobs is fine with me.
Mind the difference in the first part, submodule[s] in singular/plural.
I thought submodule as a prefix for any individual submodule, but any
settings applying to all of the submodules, you'd take the plural submodules.*
settings.
