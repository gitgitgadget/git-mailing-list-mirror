Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDA61F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJIBkc (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:40:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38067 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBkc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:40:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id 204-v6so12646200qkd.5
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szTzDsEvzPDNSdwbEpGFz0aKv7aHv21GJmCg/xCmB0c=;
        b=CKAYxZDLNg/GivzcH+8+EQEl0YfMXZSgYIUJCfYt7RAnzqvOPT0uhesB9egFODgfE6
         R9L/u5/S1sdGp+CFbRYU+ma2OJaXIRGl62dnkVcxpz/31pfgt8odtDG7xh1bfj3ehsfd
         eQePRC+HXJ9FHYCw9HtSP8yrrd6FFTihj8NuZyw1kWOcOjA1k2NEEof5+YFbwKw6uKu3
         kD2h0yulhByP7fc/0PoCnhzgs6h8uVO+CvqqkhIJ8iV+lvdZ+aj0ta2R+Pd6ojHvjtUQ
         gb5VZDLfBHEtw+SdUP612pvWPYYHrNwap1xmoPCtJqibCN1NRMigDAJA+WOnloa65zye
         KgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szTzDsEvzPDNSdwbEpGFz0aKv7aHv21GJmCg/xCmB0c=;
        b=RFuy+vWbcRgq3bdq+WWDsbI28ZHkeR5AGUqGOZNj5F6+2Ua14eVL3k1UV3gdFA0CGB
         5cho1XmahffC3Zm8Zw3P6RIhqPr2A+QEY728eP1EyoHSGFddrjQsjbVyZc0jAC/IYHYb
         hM5sGf3YhSDUWKUriWc9qMzAPQXI9Zz/0glkVTn6HzVTFk7JIbQ5H6l6+L4npZlG1y52
         1FdW7Uz/ntb24NjHSpUccxIYzzPoQeMIuHqh3mBD+fUI3Y82aqFIMMVBNqAtc1+ztifG
         nko8nWhNGGAzLur0kSRVuSW8RCULhzWE/+Jd3FTKcImS8IIyHuoq4OkNQFby3tJREjMB
         cGgQ==
X-Gm-Message-State: ABuFfogn/AshAmHZmQkO+x+z04kqilrsTPcg0t7oP4cGMLkvkPhvY0PL
        7gMb6gzGGNMcKHYi/30b+j0=
X-Google-Smtp-Source: ACcGV629h2AeNeKbxyaebZREx5iYTi2ceoDS99WhliqqhBp/32sDwWlof6owGJED+eNPHIHGahVN5Q==
X-Received: by 2002:a37:a20d:: with SMTP id l13-v6mr19525781qke.297.1539023250437;
        Mon, 08 Oct 2018 11:27:30 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id c43-v6sm10246007qtd.85.2018.10.08.11.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:27:29 -0700 (PDT)
Subject: Re: t3404.6 breaks on master under GIT_FSMONITOR_TEST
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <87k1vwn9qe.fsf@evledraar.gmail.com>
 <87sh2mrefa.fsf@evledraar.gmail.com> <87a7noa5ch.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8d486342-e62f-c02c-9d4b-f5e911a12a2f@gmail.com>
Date:   Mon, 8 Oct 2018 14:27:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87a7noa5ch.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/8/2018 10:19 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Sep 06 2018, Ævar Arnfjörð Bjarmason wrote:
> 
>> On Thu, Feb 01 2018, Ævar Arnfjörð Bjarmason wrote:
>>
>>> The GIT_FSMONITOR_TEST variable allows you to roundtrip the fsmonitor
>>> codpath in the whole test suite. On both Debian & CentOS this breaks for
>>> me:
>>>
>>>      (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t3404-rebase-interactive.sh -i)
>>>
>>> Whereas this works:
>>>
>>>      (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all GIT_SKIP_TESTS=t3404.6 ./t3404-rebase-interactive.sh -i)
>>>
>>> The entirety of the rest of the test suite still passes with
>>> GIT_FSMONITOR_TEST.
>>>
>>> This has been failing ever since GIT_FSMONITOR_TEST was introduced in
>>> 883e248b8a ("fsmonitor: teach git to optionally utilize a file system
>>> monitor to speed up detecting new or changed files.", 2017-09-22). Under
>>> -v -x -i:
>>>
>>>      + echo test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
>>>      test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
>>>      + return 1
>>>      error: last command exited with $?=1
>>>      not ok 6 - rebase -i with the exec command checks tree cleanness
>>>      #
>>>      #               git checkout master &&
>>>      #               set_fake_editor &&
>>>      #               test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^ &&
>>>
>>> Maybe once this is fixed running the test suite under GIT_FSMONITOR_TEST
>>> would be a useful Travis target, but I don't know the current status of
>>> adding new options to Travis.
>>
>> *Poke* at this again. Ben, or anyone else with knowledge of fsmonitor:
>> Can you reproduce this?
>>
>> This failure along with the one I noted in
>> https://public-inbox.org/git/87tvn2remn.fsf@evledraar.gmail.com/ is
>> failing the tests on Linux when run with GIT_FSMONITOR_TEST.
>>
>> I'm looking at this again because SZEDER's patches to the split index
>> reminded me again that we have these long-standing failures in rare test
>> modes (see
>> https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ for the
>> split index discussion).
> 
> For what it's worth this is still broken, but more importantly (I'm not
> just keeping bumping the same thing) the only thing that's now broken
> under fsmonitor. I.e. my skip config is now GIT_SKIP_TESTS="t3404.7"
> whereas before 43f1180814 ("git-mv: allow submodules and fsmonitor to
> work together", 2018-09-10) I needed to add "t7411.3 t7411.4" to that.
> 

I glanced at this for a few minutes but it wasn't obvious what was 
happening.  It will take some additional effort to dig into and figure 
out the underlying issue.  I haven't forgotten about this - it's still 
on my list, just below some other things I need to get finished up first.
