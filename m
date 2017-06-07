Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F02B1FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 19:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbdFGTvb (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 15:51:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33993 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdFGTva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 15:51:30 -0400
Received: by mail-qt0-f193.google.com with SMTP id o21so3484649qtb.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V9YxnbZsfFqWG8dz3bbUf5BZfUe0nca638rtMPAkUp4=;
        b=Ui0MJs+F3s+G/tnCVliTkdB9/jwXQ4l0yRg5U8kUMRcQvQbnDbuGjszPnR9K20S8hU
         W7xf1izTetlrINXVJcl6r+kYte1lnIBXBkFF0163NF+Ix8KR7W3k35emKt/zBsY8LrHZ
         4g9tJeH13Rt+S+59h82CbLR2oWRrzxr4COmsF8zrbLED0lU8gk0iSpdh3kO5skcrm1gY
         kQJXS7Qx/nAToIVhTMcv8bxnMQ0qolST0O3cCzrgoPScZ08vEe9APLXyuPJfoKR8mJDu
         blL3TaJ6RfzV7VKOpfq+I40ceeRd+U82ICg39bTMCMz8U4fsyCfE/MgG1ZzJ8el9LVPR
         jqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V9YxnbZsfFqWG8dz3bbUf5BZfUe0nca638rtMPAkUp4=;
        b=ltd+lfDv3BvIe0R1Cc10yUzt0soNgSLDinUQGIBILjvVGQDPdLYdova2DAtzM/i+DW
         eAp89BYw0/f/rM6CQUy80E+ltzrrbO5TK5QWnFsxhmvCRbdMRStQU7ZvlSWRm/kX5V+q
         46fsDjaU1Wd+gh1K7YZTFDTqfHycJCqlhYR3UjLbxBle0LI576teuU739858/YzVIAiD
         5UfwoPPp0Ihs+GRnlEDa0QQMwmopPgaojvQ3SWlJ5Y9ZjKDfcCdtxJFQtcC8AiGY4Mo7
         +tfH+xz2/bhmsLKtncpnk5nDNTSf7lbwk4VhxGWGUHkj38F04t+J5VZvMOU0unDWSqw8
         +Jsg==
X-Gm-Message-State: AKS2vOxFx8phlBPgATMGm3r8+vzmlA4aCq0q/XM17pq91D7LfjgmUw7d
        ueGfHpF5X99apA==
X-Received: by 10.55.215.130 with SMTP id t2mr27063149qkt.188.1496865089009;
        Wed, 07 Jun 2017 12:51:29 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id v89sm1683469qkl.30.2017.06.07.12.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 12:51:28 -0700 (PDT)
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com>
 <c84864d3-9823-0b02-a337-29592b7c01f3@gmail.com>
 <CACBZZX48t3Jcy=eiga1f_ATSZZvy9_LG9wEe7avD2NCq2bsmJA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0cfd57d3-4092-af06-0d6c-cb3ceecc4633@gmail.com>
Date:   Wed, 7 Jun 2017 15:51:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX48t3Jcy=eiga1f_ATSZZvy9_LG9wEe7avD2NCq2bsmJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/2/2017 7:06 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> I don't have time to update the perf test now or dig into it, but most
> of what you're describing in this mail doesn't at all match with the
> ad-hoc tests I ran in
> https://public-inbox.org/git/CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=rp-7vXd8nURyWQ@mail.gmail.com/
> 
> There (at the very end of the E-Mail) I'm running watchman in a tight
> loop while I flush the entire fs cache, its runtime is never longer
> than 600ms, with 3ms being the norm.

I added a perf trace around the entire query-fsmonitor hook proc (patch 
below) to measure the total actual impact of running the hook script + 
querying watchman + parsing the output with perl + passing the result 
back to git. On my machine, the total cost of the hook runs between 130 
ms and 180 ms when there are zero changes to report (ie best case).

With short status times, the overhead of watchman simply outweighs any 
gains in performance - especially when you have a warm file system cache 
as that cancels out the biggest win of avoiding the IO associated with 
scanning the working directory.


diff --git a/fsmonitor.c b/fsmonitor.c
index 763a8a3a3f..cb47f31863 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -210,9 +210,11 @@ void refresh_by_fsmonitor(struct index_state *istate)
          * If we have a last update time, call query-monitor for the set of
          * changes since that time.
          */
-       if (istate->fsmonitor_last_update)
+       if (istate->fsmonitor_last_update) {
                 query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION,
                         istate->fsmonitor_last_update, &query_result);
+               trace_performance_since(last_update, "query-fsmonitor");
+       }

         if (query_success) {
                 /* Mark all entries returned by the monitor as dirty */



> 
> I.e. flushing the cache doesn't slow things down much at all compared
> to how long a "git status" takes from cold cache. Something else must
> be going on, and the smoking gun is the gprof output I posted in the
> follow-up E-Mail:
> https://public-inbox.org/git/CACBZZX4eZ3G8LQ8O+_BkbkJ-ZXTOkUi9cW=QKYjfHKtmA3pgrA@mail.gmail.com/
> 
> There with the fsmonitor we end up calling blk_SHA1_Block ~100K times
> during "status", but IIRC (I don't have the output in front of me,
> this is from memory) something like twenty times without the
> fsmonitor.
> 
> It can't be a coincidence that with the fscache:
> 
> $ pwd; git ls-files | wc -l
> /home/avar/g/linux
> 59844
> 
> And you can see that in the fsmonitor "git status" we make exactly
> that many calls to cache_entry_from_ondisk(), but those calls don't
> show up at all in the non-fscache codepath.
> 

I don't see how the gprof numbers for the non-fsmonitor case can be 
correct.  It appears they don't contain any calls related to loading the 
index while the fsmonitor gprof numbers do.  Here is a typical call stack:

git.exe!cache_entry_from_ondisk()
git.exe!create_from_disk()
git.exe!do_read_index()
git.exe!read_index_from()
git.exe!read_index()

During read_index(), cache_entry_from_ondisk() gets called for every 
item in the index (which explains the 59K calls).  How can the 
non-fsmonitor codepath not be loading the index?

> So, again, I haven't dug and really must step away from the computer
> now, but this really looks like the fscache saves us the recursive
> readdir() / lstat() etc, but in return we somehow fall though to a
> codepath where we re-read the entire on-disk state back into the
> index, which we don't do in the non-fscache codepath.
> 

I've run multiple profiles and compared them with fsmonitor on and off 
and have been unable to find any performance regression caused by 
fsmonitor (other than flagging the index as dirty at times when it isn't 
required which I have fixed for the next patch series).

I have done many performance runs and when I subtract the _actual_ time 
spent in the hook from the overall command time, it comes in at slightly 
less time than when status is run with fsmonitor off.  This also leads 
me to believe there is no regression with fsmonitor on.

All this leads me back to my original conclusion: the reason status is 
slower in these specific cases is because the overhead of calling the 
hook exceeds the savings gained. If your status calls are taking less 
than a second, it just doesn't make sense to add the complexity and 
overhead of calling a file system watcher.

I'm working on an updated perf test that will demonstrate the best case 
scenario (warm watchman, cold file system cache) in addition to the 
worst case (cold watchman, warm file system cache).  The reality is that 
in normal use cases, perf will be between the two. I'll add that to the 
next iteration of the patch series.
