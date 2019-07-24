Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C6B1F461
	for <e@80x24.org>; Wed, 24 Jul 2019 13:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGXNdJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 09:33:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGXNdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 09:33:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so43807859wrm.8
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cbBeGM/YZKsA/uJrQxmKp7YKX2pBpklmQxIkOwJ2tiM=;
        b=eB0lKar1tMUHpOA5tT/GxQxKBhu8QnF6CrYKjpqdvTo5x5CgQnkEn/WgAgiY4xJAq9
         tK3S7DX1T7ySxZIBV3HvqZFnmfv53AMunq1dHlmeHs7+w/eNNYnprDGEkRxUOnYWBWWR
         n91cbNdyD75kDBZvCR+4zVqGLFJI5apo1/TpDl6PLXTDIl8tC7gvSRJjtQ9PMDskIQhO
         eshKEAf8SAPv7S4ilQZAFJf6pwJn9bZFUDyhn/WbjVU66teIe4PThm+y8jWUwXavN3O5
         /GhkSyq53XhpVvxYHbhUqenxX2AcZPRZ+H/3NBlmv8IRtItGVdEeX5WI9g+5V6Vu//qr
         t5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cbBeGM/YZKsA/uJrQxmKp7YKX2pBpklmQxIkOwJ2tiM=;
        b=aav2UErZt9aZ9pvvNvLb/5qTXr/FWILiUH7YJTlqJtB0foOUwKmZvfUZtbJKaGKaO8
         acIPcew+MzHJ9r0tYWWVKec5X1gHWB6ZF/GKijqwj138NOFVnSYRA2/jDorfJSepX/Vf
         AdUPm28FbedNu3nPaA4TAST69JnG/LrelrEBXwsqo9Qkgokqv2602P9CxgWlCpSoFwnx
         y92hpcx04VCBwFBzol/jLY4rZkQwF3Vn3F+hS1T2Yy78aD1lCJkqVYWo9DcvXdoAk934
         D4UUWZAmErIKC9yxbI6SER6xKXxNnHnwHLPEZB1xATlTvGPIkWJFrb14EogE/9LXV8Zq
         xZtA==
X-Gm-Message-State: APjAAAVlKx/pNwczMg6HsU2XG5DY9LZc+wcEf++DlZFHhFR1g5vep1bi
        wxXtzIlWDiNL36VdDGtX7lo=
X-Google-Smtp-Source: APXvYqxuiIzhOeO+qaqcXo+22nN8KnvTjoH0EM8CgJzntcIUVwZzCLRJC/JSAPMjwrWjYG2VLdSpgQ==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr87024188wrp.101.1563975187411;
        Wed, 24 Jul 2019 06:33:07 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-131.as13285.net. [92.22.12.131])
        by smtp.gmail.com with ESMTPSA id x24sm44891296wmh.5.2019.07.24.06.33.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 06:33:06 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 2/2] rebase -i: support
 --committer-date-is-author-date
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood@dunelm.org.uk>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
References: <7f53b294-57f7-77bf-ca0a-e9621227377c@gmail.com>
 <20190723195722.16745-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <dbe0fe4d-9553-fd8e-5c5a-5457dc5e3eae@gmail.com>
Date:   Wed, 24 Jul 2019 14:33:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723195722.16745-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 23/07/2019 20:57, Rohit Ashiwal wrote:
> Hi Phillip
> 
> On Sat, 20 Jul 2019 15:56:50 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> [...]
>>
>>> @@ -467,6 +470,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>>    		OPT_BOOL(0, "autosquash", &opts.autosquash,
>>>    			 N_("move commits that begin with squash!/fixup!")),
>>>    		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
>>> +		OPT_BOOL(0, "committer-date-is-author-date",
>>> +			 &opts.committer_date_is_author_date,
>>> +			 N_("make committer date match author date")),
>>
>> I guess it's good to do this for completeness but does
>> rebase--preserver-merges.sh support --committer-date-is-author-date? It
>> is the only caller of rebase--interactive I think so would be the only
>> user of this code.
> 
> Oh! Yes, I did it for the completeness. Let's add the flag while we
> still have that _rebase--interactive_ command hanging out with us.
> 
>> [...]
>>
>>> +	if (read_author_script(rebase_path_author_script(),
>>> +			       NULL, NULL, &date, 0))
>>> +		die(_("failed to read author date"));
>>
>> Can we have this return an error please - we try quite hard in the
>> sequencer not to die in library code.
> 
> Yes, we can through an error and continue, but then the user will
> see the unchanged author date which is against his / her will but
> it will not crash the program at least.

I dont think it should continue, the error should be propagated up to 
cmd_rebase() (In your patch I think one of the context lines in 
run_git_commit() shows this happening)

> 
>> [...]
>>
>>> +	if (opts->committer_date_is_author_date) {
>>> +		char *date = read_author_date_or_die();
>>> +		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s", date);
>>> +		free(date);
>>> +	}
>>
>> It's a shame to be doing this twice is slightly different ways in the
>> same function (and again in try_to_commit() but I don't think that can
>> be avoided as not all callers of run_git_commit() go through
>> try_to_commit()). As I think the child inherits the current environment
>> modified by cmd.env_array we could just call setenv() at the top of the
>> function. It would be worth looking to see if it would be simpler to do
>> the setenv() call in the loop that picks the commits, then we would
>> avoid having to do it in do_merge() and try_to_commit() separately.
> 
> Ok, I'll have to change the code according to what Junio suggested.
> Let's see how this area will look after that.
> 
>> [...]
>>
>>> +		if (file_exists(rebase_path_cdate_is_adate())) {
>>> +			opts->allow_ff = 0;
>>
>> This is safe as we don't save the state of allow_ff for rebases so it
>> wont be overridden later. It would be an idea to add to the checks in
>> the assert() at the beginning of pick_commits() no we have another
>> option that implies --force-rebase.
> 
> Are you suggesting to modify this assert() call (in pick_commits())?
> 
>      if (opts->allow_ff)
>          assert(!(opts->signoff || opts->no_commit ||
>                  opts->record_origin || opts->edit));

Yes I think it should check for opts->committer_date_is_author_date here

Best Wishes

Phillip

> Thanks
> Rohit
> 
