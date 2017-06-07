Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A971FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 21:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdFGVqv (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 17:46:51 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36242 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdFGVqu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 17:46:50 -0400
Received: by mail-io0-f175.google.com with SMTP id y77so12800299ioe.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6/neasSKir85EoWllGXrmMrmBRxEiPKUvRiW9KbZxY=;
        b=Ssdu+K6Xkc03dhcL0tf5pQdOsq6Nys+sNvv0fV1TaRvGpsqO6ijqbhP6CB/zHkShYz
         JfZHbS+A9ErkZT/hXuc86pKuKWvOefnORvHCnp0JVjTo/I2QjHduWxXs2z3Cqu3pQGm8
         t3vZe98dKRFl/8Wi2rhFZ23xtdKRUszLUpjbwLekHfGiz8QzGJ4f6i+D2uSStc6Ahu1U
         OVlBMJO4oxzyMpW3vcJuu0EhhyCxjmtnXrcZcFzRO8JCc4upUTFTnhQinb+xK0vSE7Pn
         VcnG3eUuXnHdw+7pfhInZf8pWcoAgjoUuG3o0mkLarZQAgh3MyByfDOMhGhhvHBG85K2
         JN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6/neasSKir85EoWllGXrmMrmBRxEiPKUvRiW9KbZxY=;
        b=ePEG+qef+VDOSaSKNzsCfNS00VABXC0sQCjncmoIj1HRQc0VZFs9aXXlNjHYUuqNmK
         xkX0AkNQseo4PzThJjvlEYJWNlQMEn49orWc0+AUqhojC1TZMfy4IR935A0t9LBBacfR
         oF93OEwqkZGypV6rW7Q0XMYVLgN8QEOzLyZFg/fMBJg47ZwnlO4BJDQWccFtJXrRbFAx
         DeugKLVrtuczsCdlUR/q2aCCUzwFvQbRr4eO00nKS/OfJIsCO98uSc0zKUIohpD9CP+x
         jrtI4dHE9M3EAsCNkEdoWHasTD4AlDamw0hgu8r/oMWStLC+QkQOYfjMlFZvOfU9uph2
         RmvA==
X-Gm-Message-State: AODbwcDpISFiEfOmFl/LyjqPspHg9BExs9YTqmpKbbZKhhOVeXIZk17h
        l/mku1HNsv5sq6LLLMUwAoYCfujXZA==
X-Received: by 10.107.178.130 with SMTP id b124mr19813293iof.50.1496872009518;
 Wed, 07 Jun 2017 14:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 14:46:28 -0700 (PDT)
In-Reply-To: <0cfd57d3-4092-af06-0d6c-cb3ceecc4633@gmail.com>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com> <c84864d3-9823-0b02-a337-29592b7c01f3@gmail.com>
 <CACBZZX48t3Jcy=eiga1f_ATSZZvy9_LG9wEe7avD2NCq2bsmJA@mail.gmail.com> <0cfd57d3-4092-af06-0d6c-cb3ceecc4633@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 7 Jun 2017 23:46:28 +0200
Message-ID: <CACBZZX6D8oC34qat7kdrDOWC5eYm-DRkMWG9eOPPvKKsQtgPyw@mail.gmail.com>
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 9:51 PM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 6/2/2017 7:06 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>
>> I don't have time to update the perf test now or dig into it, but most
>> of what you're describing in this mail doesn't at all match with the
>> ad-hoc tests I ran in
>>
>> https://public-inbox.org/git/CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=3Drp-7=
vXd8nURyWQ@mail.gmail.com/
>>
>> There (at the very end of the E-Mail) I'm running watchman in a tight
>> loop while I flush the entire fs cache, its runtime is never longer
>> than 600ms, with 3ms being the norm.
>
>
> I added a perf trace around the entire query-fsmonitor hook proc (patch
> below) to measure the total actual impact of running the hook script +
> querying watchman + parsing the output with perl + passing the result bac=
k
> to git. On my machine, the total cost of the hook runs between 130 ms and
> 180 ms when there are zero changes to report (ie best case).
>
> With short status times, the overhead of watchman simply outweighs any ga=
ins
> in performance - especially when you have a warm file system cache as tha=
t
> cancels out the biggest win of avoiding the IO associated with scanning t=
he
> working directory.
>
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 763a8a3a3f..cb47f31863 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -210,9 +210,11 @@ void refresh_by_fsmonitor(struct index_state *istate=
)
>          * If we have a last update time, call query-monitor for the set =
of
>          * changes since that time.
>          */
> -       if (istate->fsmonitor_last_update)
> +       if (istate->fsmonitor_last_update) {
>                 query_success =3D !query_fsmonitor(HOOK_INTERFACE_VERSION=
,
>                         istate->fsmonitor_last_update, &query_result);
> +               trace_performance_since(last_update, "query-fsmonitor");
> +       }
>
>         if (query_success) {
>                 /* Mark all entries returned by the monitor as dirty */
>
>
>
>>
>> I.e. flushing the cache doesn't slow things down much at all compared
>> to how long a "git status" takes from cold cache. Something else must
>> be going on, and the smoking gun is the gprof output I posted in the
>> follow-up E-Mail:
>>
>> https://public-inbox.org/git/CACBZZX4eZ3G8LQ8O+_BkbkJ-ZXTOkUi9cW=3DQKYjf=
HKtmA3pgrA@mail.gmail.com/
>>
>> There with the fsmonitor we end up calling blk_SHA1_Block ~100K times
>> during "status", but IIRC (I don't have the output in front of me,
>> this is from memory) something like twenty times without the
>> fsmonitor.
>>
>> It can't be a coincidence that with the fscache:
>>
>> $ pwd; git ls-files | wc -l
>> /home/avar/g/linux
>> 59844
>>
>> And you can see that in the fsmonitor "git status" we make exactly
>> that many calls to cache_entry_from_ondisk(), but those calls don't
>> show up at all in the non-fscache codepath.
>>
>
> I don't see how the gprof numbers for the non-fsmonitor case can be corre=
ct.
> It appears they don't contain any calls related to loading the index whil=
e
> the fsmonitor gprof numbers do.  Here is a typical call stack:
>
> git.exe!cache_entry_from_ondisk()
> git.exe!create_from_disk()
> git.exe!do_read_index()
> git.exe!read_index_from()
> git.exe!read_index()
>
> During read_index(), cache_entry_from_ondisk() gets called for every item=
 in
> the index (which explains the 59K calls).  How can the non-fsmonitor
> codepath not be loading the index?
>
>> So, again, I haven't dug and really must step away from the computer
>> now, but this really looks like the fscache saves us the recursive
>> readdir() / lstat() etc, but in return we somehow fall though to a
>> codepath where we re-read the entire on-disk state back into the
>> index, which we don't do in the non-fscache codepath.
>>
>
> I've run multiple profiles and compared them with fsmonitor on and off an=
d
> have been unable to find any performance regression caused by fsmonitor
> (other than flagging the index as dirty at times when it isn't required
> which I have fixed for the next patch series).
>
> I have done many performance runs and when I subtract the _actual_ time
> spent in the hook from the overall command time, it comes in at slightly
> less time than when status is run with fsmonitor off.  This also leads me=
 to
> believe there is no regression with fsmonitor on.
>
> All this leads me back to my original conclusion: the reason status is
> slower in these specific cases is because the overhead of calling the hoo=
k
> exceeds the savings gained. If your status calls are taking less than a
> second, it just doesn't make sense to add the complexity and overhead of
> calling a file system watcher.
>
> I'm working on an updated perf test that will demonstrate the best case
> scenario (warm watchman, cold file system cache) in addition to the worst
> case (cold watchman, warm file system cache).  The reality is that in nor=
mal
> use cases, perf will be between the two. I'll add that to the next iterat=
ion
> of the patch series.

I'll try to dig further once we have the next submission + that perf test.

On Linux the time spent calling the hook itself is minimal:

    $ touch foo; time .git/hooks/query-fsmonitor 1 $(($(date +%s) *
1000000000 - 10))
    Watchman says these changed: foo
    foo
    real    0m0.009s
    user    0m0.004s
    sys     0m0.000s

So I'm fairly sure something else entirely is going on, but anyway, we
can look at that later with the next submission.

Aside from that, I wonder on Windows how much speedier this could be
for you if the entire hook was written in perl instead of a
shellscript that calls perl. I could help with that if you'd like.

You can likely replace that call to uname with reading the $^O variable.

What you're doing shelling out to cygpath can probably be done by
loading the File::Spec library, but I'm not sure.

The echo / watchman / perl would need to be an IPC::Open3 invocation I thin=
k.

I think it being in shellscript is fine, just a suggestion in case
having it all in one process (aside from the watchman shell-out) would
help or Windows.
