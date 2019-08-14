Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443B31F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfHNSsA (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 14:48:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52822 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfHNSr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so160952wmh.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPSSHhpasRfPBHhIuT68C1zFuqsvtGFRLHn1NPHasww=;
        b=NdgDx8/dL/PAOSHblo8rsYXCARcrbdHMJJsT+OcgukxwgwM8TPrC41Et+umla74Lw8
         iiTzlYAUqnJ8/ev0WUWtpzA32JIJjlQkE18glaU9+6MAP4lBEkaCOoZz9eeB/9jFwbp/
         HhgWIW8/b5lXQzbN1slMC9JrY/Sa7jV1C5Lbdx2XWr8IFJ5r3N3e1LF011oTFllQyRSm
         /LFtlqzZDxQ3bF9kj8eW3G2aWFNvznI25ag3VGHoS8pDb7YeqOAlAq9oRujb2XblN7+j
         mCoczHCJboE3ltYOLkh7F3feG3aSPhXesdeIgiTNIqlyzcLTKXLMAAh7Da6CWyXYXmM+
         I1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPSSHhpasRfPBHhIuT68C1zFuqsvtGFRLHn1NPHasww=;
        b=NspH4MCDFNzvhaBCPWGL88NbDmDVj4T/nqnWoQRImbKY1DM/iKadU/qxuRuNRwkBn/
         pjuwjbNCKNbRGHSElHg9HzjWXXWuREE4KTzYhj2Pu922q1Z6rI4wvkH64kK12L5Ak1Rb
         jFPzgSOt4r/FySrDywDRjBqILVa64z7zVvduNz68Urx4AgwdXVkTZGiluH2IIQGhETBy
         AkPefIBdIzONc99DZS/nwAf5tb8bf9Akj6thKGwkxAl5bKpqtPwtTntZduJtncFKS40a
         H4vs456B0fLvYUjuCIDWQtvjiEO4XhInTzQOttpH9LUUuzdYaQm96AsbHzPMG92KAsTN
         J1yg==
X-Gm-Message-State: APjAAAWV+xiFv8eEPdDOmIT5SrG4qtPHPPY0b/s05sKSbhPhIHoVdiN/
        L7vNvU2aRQRB5ICDeIvR5qrFjWzZ
X-Google-Smtp-Source: APXvYqxeKavsjEx/V0D4N5Qp1WIiYhKD60IF1E//yF5CwnWcZlqTkM4IHd2Gz80HSnTeLiW3Kv55jQ==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr548173wmf.84.1565808475838;
        Wed, 14 Aug 2019 11:47:55 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id d16sm1200184wrj.47.2019.08.14.11.47.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 11:47:55 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 5/6] rebase -i: support --ignore-date
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-6-rohit.ashiwal265@gmail.com>
 <b59f0aa2-1dc3-905a-0094-5f63718dffcf@gmail.com>
 <xmqqo90t7zhl.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <812513a6-bd83-5830-055f-7c0252e5ecd8@gmail.com>
Date:   Wed, 14 Aug 2019 19:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqo90t7zhl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Rohit

On 13/08/2019 18:21, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> +static void push_dates(struct child_process *child)
>>> +{
>>> +	time_t now = time(NULL);
>>> +	struct strbuf date = STRBUF_INIT;
>>> +
>>> +	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
>>> +	argv_array_pushf(&child->args, "--date=%s", date.buf);
>>
>> it doesn't matter but it might have been nicer to set both dates the
>> same way in the environment.
>> +	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
> 
> We can see that this date string lacks timezone information, which
> would likely fall back to whatever timezone the user is in.  Is that
> what we want?  I am guessing it is, as we are dealing with "now"
> timestamp, but wanted to double check.

I think we probably want to use the local timezone as you suggest

>>> +			if (opts->ignore_date) {
>>> +				if (!author)
>>> +					BUG("ignore-date can only be used with "
>>> +					    "rebase, which must set the author "
>>> +					    "before committing the tree");
>>> +				ignore_author_date(&author);
>>
>> Is this leaking the old author? I'd rather see
>>
>> 	tmp_author = ignore_author_date(author);
>> 	free(author);
>> 	author = tmp_author;
> 
> Or make sure ignore_author_date() does not leak the original, when
> it rewrites its parameter.
> 
> But I have a larger question at the higher design level.  Why are we
> passing a single string "author" around, instead of parsed and split
> fields, like <name, email, timestamp, tz> tuple?  That would allow us
> to replace only the time part a lot more easily.  Would it make the
> other parts of the code more cumbersome (I didn't check---and if
> that is the case, then that is a valid reason why we want to stick
> to the current "a single string 'author' keeps the necessary info
> for the 4-tuple" design).

It's a bit of a mess at the moment. There are places where we want a 
single author data string when calling commit_tree_extended(), and other 
places where we want to set the name, email and date in the environment 
when running 'git commit'. For the latter case we use a file which we 
read and write as the C version just follows what the shell script did. 
I think carrying round a <name, email, timestamp, tz> tuple would be the 
sensible way to go and we can build the author string when we need it. 
Doing that would hopefully eliminate having to read and write the author 
file so much. I haven't looked at how difficult it would be to change 
the existing code to do that. We should also really carry the commit 
message around in a variable and only write it to a file if a pick fails 
or we are editing the message and running 'git commit'. If we're just 
using commit_tree_extended() there is no need to be writing the message 
to a file and then reading it back in again later.

Best Wishes

Phillip

>>> +			}
>>>    			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
>>>    					  NULL, &root_commit, author,
>>>    					  opts->gpg_sign);
>>> +		}
>>>      		strbuf_release(&msg);
>>>    		strbuf_release(&script);
>>> @@ -1053,6 +1087,8 @@ static int run_git_commit(struct repository *r,
>>>    		argv_array_push(&cmd.args, "--amend");
>>>    	if (opts->gpg_sign)
>>>    		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>>> +	if (opts->ignore_date)
>>> +		push_dates(&cmd);
>>>    	if (defmsg)
>>>    		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>>>    	else if (!(flags & EDIT_MSG))
>>> @@ -1515,6 +1551,11 @@ static int try_to_commit(struct repository *r,
>>>      	reset_ident_date();
>>>    +	if (opts->ignore_date) {
>>> +		ignore_author_date(&author);
>>> +		free(author_to_free);
>>
>> Where is author_to_free set? We should always free the old author, see
>> above.
> 
> Or require callers to pass a free()able memory to ignore_author_date()
> and have the callee free the original?
> 
