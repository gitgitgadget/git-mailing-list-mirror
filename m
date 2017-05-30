Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14052027C
	for <e@80x24.org>; Tue, 30 May 2017 23:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdE3XLa (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:11:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34275 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdE3XL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:11:28 -0400
Received: by mail-qt0-f195.google.com with SMTP id l39so47537qtb.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+WIbLWyILb1A9T0fS6vQxBDwENjwSrCDktPop6Qk6Rs=;
        b=C2I+bzZAUh6DTFEeubJB9YFZupfJ71/5sadiT3oFR76h1Tsf8VCIm4+LLrGObV+nlG
         asxO1Z3cZabRIIUc7cjyPhDCevwS44VwHAuE6N1o6RkROLg9QNl6Bo+9Nh2yMiJwAj0i
         CsYTamRIarLe54Z54r1zTez0sj+VvjkKEL3rpqbms6TLeA2jdyyCLF8G8bF5k34rfk+f
         WVKDCL55Kys6zCPZaH3GJTNkU//zUC6Jr0vQf+ULouaNwguGM85hxnRJydqktsf34osB
         bM/RilqVqnZ3lq5gefKQlIr1m84BDZxYRPaXRNQ8quIwzTOu7RrivPx0LPa2tIslx356
         EiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+WIbLWyILb1A9T0fS6vQxBDwENjwSrCDktPop6Qk6Rs=;
        b=IkGN6aI/QnJ6l6OnNFXpBH39xMSWCcKkxFVZMuqqocLWUqE5zL5UApwXO1kpUNfqh9
         yY4KyBg7y8eHxmDWoCKk8BYs1QFjgpBrmuwzDGe0Aczd/3Nr2F1GEdA3KIk10Z3uHrix
         tMyvQh8DS3+8s7vWSecGb8jHU+fftM6ulGTDftALxFrbY0nQ8XaVFXvxZ/8gaXjzk7IH
         Dt/kZ14h4wsY/unIuR2ZiZEvhfsL/A2h7cprH18kWRllaze5GButq7IoKoCnfmlB3GzO
         AxN5w2jyxesTABcuZG6QAVycxUR2EGfDhHeNyE6zYxWnb+2xsatScQeFNOeh6sF5sVMg
         GULA==
X-Gm-Message-State: AODbwcAS2JAvWz+sGQEy6tqG0hrCxBBtkLF8rPW4Yxg5biTRwZrbgnLg
        01Ha7UOQ7xDs1Q==
X-Received: by 10.237.59.225 with SMTP id s30mr27197879qte.192.1496185887836;
        Tue, 30 May 2017 16:11:27 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id u51sm9514377qta.56.2017.05.30.16.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 16:11:27 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
 <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
 <CAP8UFD1L+caWyLS5KCX3QqToVuzii+0tX81=eGA=1_+L6O7ynA@mail.gmail.com>
 <8ac721a5-a90d-3d58-e9dd-a3eb2199d387@gmail.com>
 <CAP8UFD0xrGrB+QFSV9XYq23w8-eN6JKWSJm3iTc4Sn9Kf44NUw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0d553422-5b4f-cfdd-961a-d007826b68cb@gmail.com>
Date:   Tue, 30 May 2017 19:11:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0xrGrB+QFSV9XYq23w8-eN6JKWSJm3iTc4Sn9Kf44NUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/30/2017 4:33 PM, Christian Couder wrote:
> On Tue, May 30, 2017 at 8:05 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>>
>> On 5/27/2017 2:57 AM, Christian Couder wrote:
>>>
>>> On Thu, May 25, 2017 at 3:55 PM, Ben Peart <peartben@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 5/24/2017 6:54 AM, Christian Couder wrote:
>>>>>>
>>>>>>
>>>>>> Design
>>>>>> ~~~~~~
>>>>>>
>>>>>> A new git hook (query-fsmonitor) must exist and be enabled
>>>>>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>>>>>> outputs to stdout all files that have been modified since the requested
>>>>>> time.
>>>>>
>>>>>
>>>>>
>>>>> Is there a reason why there is a new hook, instead of a
>>>>> "core.fsmonitorquery" config option to which you could pass whatever
>>>>> command line with options?
>>>>
>>>>
>>>>
>>>> A hook is a simple and well defined way to integrate git with another
>>>> process.  If there is some fixed set of arguments that need to be passed
>>>> to
>>>> a file system monitor (beyond the timestamp stored in the index
>>>> extension),
>>>> they can be encoded in the integration script like I've done in the
>>>> Watchman
>>>> integration sample hook.
>>>
>>>
>>> Yeah, they could be encoded in the integration script, but it could be
>>> better if it was possible to just configure a generic command line.
>>>
>>> For example if the directory that should be watched for filesystem
>>> changes could be passed as well as the time since the last changes,
>>> perhaps only a generic command line would be need.
>>
>>
>> Maybe I'm not understanding what you have in mind but I haven't found this
>> to be the case in the two integrations I've done with file system watchers
>> (one internal and Watchman).  They require you download, install, and
>> configure them by telling them about the folders you want monitored.  Then
>> you can start querying them for changes and processing the output to match
>> what git expects.  While the download and install steps vary, having that
>> query + process and return results wrapped up in an integration hook has
>> worked well.
> 
> It looks like one can also just ask watchman to monitor a directory with:
> 
> watchman watch /path/to/dir
> 
> or:
> 
> echo '["watch", "/path/to/dir"]' | watchman -j
> 
> Also for example on Linux people might want to use command line tools like:
> 
> https://linux.die.net/man/1/inotifywait
> 
> and you can pass the directories you want to be watched as arguments
> to this kind of tools.
> 
> So it would be nice, if we didn't require the user to configure
> anything and we could just configure the watching of what we need in
> the hook (or a command configured using a config option). If the hook
> (or configured command) could be passed the directory by git, it could
> also be generic.
> 

OK, I think I understand what you're attempting to accomplish now. 
Often, Watchman (and other similar tools) are used to do much more than 
speed up git (in fact, _all_ use cases today are not used for that since 
this patch series hasn't been accepted yet :)).  They trigger builds, 
run verification tools, test passes, or other tasks.

I'm afraid that attempting to have the user configure git to configure 
the tool "automatically" is just adding an extra layer of complexity 
rather than making it simpler.  I'll leave that to a future patch series 
to work out.

>>> I am also wondering about sparse checkout, as we might want to pass
>>> all the directories we are interested in.
>>> How is it supposed to work with sparse checkout?
>>
>> The fsmonitor code works well with or without a sparse-checkout.  The file
>> system monitor is unaware of the sparse checkout so will notify git about
>> any change irrespective of whether git will eventually ignore it because the
>> skip worktree bit is set.
> 
> I was wondering if it could ease the job for the monitoring service
> and perhaps improve performance to just ask to watch the directories
> we are interested in when using sparse checkout.
> On Linux it looks like a separate inotify watch is created for every
> subdirectory and there is maximum amount of inotify watches per user.
> This can be increased by writing in
> /proc/sys/fs/inotify/max_user_watches, but it is not nice to have to
> ask admins to increase this.
> 

Having a single instance that watches the root of the working directory 
is the simplest model and minimizes use of system resources like inotify 
as there is only one needed per clone.

In addition, when the sparse-checkout file is modified, there is no need 
to try and automatically update the monitor by adding and removing 
folders as necessary.

Finally, if files or directories are excluded via sparse-checkout, they 
are removed from the working directory at checkout time so don't add any 
additional overhead to the file system watcher anyway as they clearly 
can't generate write events if they don't exist.
