Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EEFB1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 01:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeA3BVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 20:21:15 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:42609 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeA3BVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 20:21:13 -0500
Received: by mail-qk0-f173.google.com with SMTP id k201so8148498qke.9
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WKDpQ+jP2nxrhHG3BFtlr0IetJOXwhqjS8DkjiGq2gE=;
        b=kD2NrUBlzmtr7KdSqj8jfIZ/0kj2UNfEL+GszwEyW+ZtT8T4pxB/Y9llQArNNE0ncL
         XY3kxL1NOUzMHkxjTG56bYbDEWcM020nssDZlgy7Sqs8WmP/s0LwBBHRIw8m3gsPZ7yH
         B/59onVC5HlSvPqURMRy54H3C4awtrpptH6bz4irdLfM8AeprTj2fJCvNFeX6SKtg9Zp
         2/VXfcO1sxz34XtrC6heoprJOotNgXBy0ARO4qIpiL2iK0vCqKG/phasNJZc6Dhiw5u6
         bmPfkZOAUIwu4nskKyjF3LNmRLXo/wknFi1iQce0yT0kSvDGtqCFG5XgSr89sHURsO3i
         0p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WKDpQ+jP2nxrhHG3BFtlr0IetJOXwhqjS8DkjiGq2gE=;
        b=mUz6qQHR/lxyCxyCr0AXuLBl+h3EVUh5x40FudIR/Lzb30ggyOaTtF5dxrnc/cQd1t
         GL5d7BOtlx3DovSCpnadGdeJzm/Z/Se4N6amFWmOLqCHck9KDr/rc4nj6JAMCLwUZRn4
         qdHhD5jS0nQMK5lWcGm3GLyfZEh8w+iEuTmWJl2ZB/uVRw+KZb2ZPha87HHw51BVXwqD
         BH7m6so5sQOVbIL7qjsjs5F/kE1K943cFrpJq3N7R2ioznYDXzUDuvdDkI3uKC3c0m8+
         6PwOI2++tHHKctO+lPp6Yg7O9rz8XGQ1ioVW4eYewWvcRz72UCBjci5yEKoELmOy6B5/
         2vFg==
X-Gm-Message-State: AKwxytdxeg6UpR1HjZZmzAG1AqV5xmII/p54qOC9wDMYc/8bkRHtO2R2
        zvDA82UPQQ4RvVNCnPRdWdabnODs
X-Google-Smtp-Source: AH8x224VPk6rodkLC92tSLBnBNX9TqySX5D9gi5VBAmbzmPxcL5BAGZUc5pTVgp+C9XPWhxdGe7fWw==
X-Received: by 10.55.125.197 with SMTP id y188mr30997596qkc.111.1517275272791;
        Mon, 29 Jan 2018 17:21:12 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l24sm11145744qtb.65.2018.01.29.17.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 17:21:11 -0800 (PST)
Subject: Re: Some rough edges of core.fsmonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
References: <87efmcw3fa.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1801282140330.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CACBZZX74WcK4qX5O1E_6nxv7f4Vpns3O-7dcURbs+QneKsA87Q@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <56b8d8a3-9483-330d-64a4-ec0295b254ac@gmail.com>
Date:   Mon, 29 Jan 2018 20:21:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CACBZZX74WcK4qX5O1E_6nxv7f4Vpns3O-7dcURbs+QneKsA87Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/28/2018 5:28 PM, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Jan 28, 2018 at 9:44 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Sat, 27 Jan 2018, Ævar Arnfjörð Bjarmason wrote:
>>
>>> I just got around to testing this since it landed, for context some
>>> previous poking of mine in [1].
>>>
>>> Issues / stuff I've noticed:
>>>
>>> 1) We end up invalidating the untracked cache because stuff in .git/
>>> changed. For example:
>>>
>>>      01:09:24.975524 fsmonitor.c:173         fsmonitor process '.git/hooks/fsmonitor-watchman' returned success
>>>      01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callback '.git'
>>>      01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callback '.git/config'
>>>      01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callback '.git/index'
>>>      01:09:25.122726 fsmonitor.c:91          write fsmonitor extension successful
>>>
>>> Am I missing something or should we do something like:
>>>
>>>      diff --git a/fsmonitor.c b/fsmonitor.c
>>>      index 0af7c4edba..5067b89bda 100644
>>>      --- a/fsmonitor.c
>>>      +++ b/fsmonitor.c
>>>      @@ -118,7 +118,12 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
>>>
>>>       static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
>>>       {
>>>      -       int pos = index_name_pos(istate, name, strlen(name));
>>>      +       int pos;
>>>      +
>>>      +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
>>>      +               return;
>>>      +
>>>      +       pos = index_name_pos(istate, name, strlen(name));
>>
>> I would much rather have the fsmonitor hook already exclude those.
> 
> As documented the fsmonitor-watchman hook we ship doesn't work as
> described in githooks(5), unless "files in the working directory" is
> taken to include .git/, but I haven't seen that ever used.
> 
> On the other hand relying on arbitrary user-provided hooks to do the
> right thing at the cost of silent performance degradation is bad. If
> we're going to expect the hook to remove these we should probably
> warn/die here if it does send us .git/* files.
> 

I'm not sure how often something is modified in the git directory when 
nothing was modified in the working directory but this seems like a nice 
optimization.

We can't just blindly ignore changes under ".git" as the git directory 
may have been moved somewhere else.  Instead we'd need to use get_git_dir().

Rather than assuming the hook will optimize for this particular case, I 
think a better solution would be to update 
untracked_cache_invalidate_path() so that it doesn't invalidate the 
untracked cache and mark the index as dirty when it was asked to 
invalidate a path under GIT_DIR.  I can't think of a case when that 
would be the desired behavior.

Somewhat off topic but related to the overall performance discussion: 
I've also thought the untracked cache shouldn't mark the index as dirty 
except in the case where the extension is being added or removed.  We've 
observed that it causes unnecessary index writes that actually slows 
down overall performance.

Since it is a cache, it does not require the index to be written out for 
correctness, it can simply update the cache again the next time it is 
needed. This is typically faster than the cost of the index write so 
makes things faster overall.  I adopted this same model with the 
fsmonitor extension.

>> If you *must* add these comparisons, you have to use fspathcmp() and
>> fspathncmp() instead (because case-insensitivity).
> 
> Thanks.
> 
