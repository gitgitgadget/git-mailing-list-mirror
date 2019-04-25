Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FB01F462
	for <e@80x24.org>; Thu, 25 Apr 2019 17:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfDYRrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 13:47:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34046 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYRrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 13:47:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id c6so621771wrm.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TtKNUt9HbwvKw2w3/53yCUmhJ5SwyDMIhv48Pm4wKok=;
        b=ITknZ8XIepKK8HPWcGxbWhnmY4LHzKwQ+eO1lCjgW3Wjgrs3XMjaqojekwrOv5MUrc
         CnNVtmV0SKpq4EWGMWjamnxR5ZMZc2Au2iNdsJ2z6Rh1uI9sXRNJAaykxLr/TVBACoU1
         nWXY3X87J/+1v750iAsKWmdMjvm68oh+lNO7B4AXxRR2iwtSDLNU5xeJI879pFMpVGu8
         uz8RnvUv3BgbM5lOaS6TYIbPfgEDtFdqaEn92sBXfkJ+YlHQuhwg3xnN3DZSXllgXtfu
         tZAb3l924Esm+3jrg3RSEWcBY63G9VW010M1F//F+0cxkFhqz2k8GqVPwUcvnRT6fmxP
         Su8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TtKNUt9HbwvKw2w3/53yCUmhJ5SwyDMIhv48Pm4wKok=;
        b=kwt8wBHGJd1mE74wOg7hU4b2MjcB/uPzXckrSFuMB9+5RHJvZUEYCpw/hJ7pNekOz5
         1xZT9jayxYjTyovz1/rNGwrVkpE4z3Hg+C2XHVduQYT2qr/i79UHCXvNMJWfr1/z+d4M
         ws3FezYv1CT89B67ZFaN2KeLtjh1bpG1KitU4GdXJH1Jhsg7Sb6obSpbvdYf/u64hZ7M
         Cz8CH8MWVPQTH0FwBNCM/g7b1hTRYamVtUTiWJiEvROdzkDsNjwA6MuKSYbQcC7L7tBF
         Xa096s97rfq92dzW6FMyFQtj8rs+PZ+ZW08cQm+u5wpb1iPJ46ncxf/GUzpjAvNZwJPm
         x4BA==
X-Gm-Message-State: APjAAAUpgX1NTwudP33qajwrNW71YLV3TbHCaMvp6HZae5AxSACH93PA
        8L0kWnZlHjXaI+ttGVEYGg4=
X-Google-Smtp-Source: APXvYqzizcUqVqsjOR7L8t3hn7+oqQyplQ0OjYpv4bwLQVxmUnQr6ydDtlEfj8ihxq8VH+qLbtwKDw==
X-Received: by 2002:adf:eb52:: with SMTP id u18mr2803184wrn.10.1556214431296;
        Thu, 25 Apr 2019 10:47:11 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-19-253.as13285.net. [92.22.19.253])
        by smtp.googlemail.com with ESMTPSA id r10sm6046465wrr.65.2019.04.25.10.47.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:47:10 -0700 (PDT)
Subject: Re: [PATCH v1 02/12] rebase: don't translate trace strings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
 <20190417143044.17655-3-phillip.wood123@gmail.com>
 <xmqqy346czhj.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <41344c53-5b57-3d97-7b64-9128f7cba6af@gmail.com>
Date:   Thu, 25 Apr 2019 18:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqy346czhj.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/04/2019 06:53, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> commit b3a5d5a80c ("trace2:data: add subverb for rebase", 2019-02-22)
>> mistakenly marked the subverb names for translation and unnecessarily
>> NULL terminated the array.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  builtin/rebase.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 52114cbf0d..239a54ecfe 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1027,14 +1027,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  		ACTION_EDIT_TODO,
>>  		ACTION_SHOW_CURRENT_PATCH,
>>  	} action = NO_ACTION;
>> -	static const char *action_names[] = { N_("undefined"),
>> -					      N_("continue"),
>> -					      N_("skip"),
>> -					      N_("abort"),
>> -					      N_("quit"),
>> -					      N_("edit_todo"),
>> -					      N_("show_current_patch"),
>> -					      NULL };
>> +	static const char *action_names[] = { "undefined",
>> +					      "continue",
>> +					      "skip",
>> +					      "abort",
>> +					      "quit",
>> +					      "edit_todo",
>> +					      "show_current_patch" };
> 
> That's an improvement independent from the rest of the patches.

Yes I only included it as I move the definition later in the series

> Now we've had the C99 designated initialisers weather balloon
> changes for some time in our codebase, perhaps we can ensure that
> these entries match the intended & corresponding "enum action"
> constants?  If we can also ensure that the array is large enough so
> that the trace2 call done like so
> 
> 	trace2_cmd_mode(action_names[action])
> 
> is safe, that would be good, but that is secondary.
> 
> Thanks.

If what's below is ok, I'll send a re-roll, I wasn't sure if it was best
to die if action is larger than the array of names or just use a
default. My worrying with dying is that it wont be caught by tests and
will cause a problem for users who enable tracing. At least with what's
below they can still rebase and hopefully report a bug about unknown
action in their trace output.

Best Wishes

Phillip

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 52114cbf0d..3f56be230e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1027,14 +1027,15 @@ int cmd_rebase(int argc, const char **argv,
const char *prefix)
                ACTION_EDIT_TODO,
                ACTION_SHOW_CURRENT_PATCH,
        } action = NO_ACTION;
-       static const char *action_names[] = { N_("undefined"),
-                                             N_("continue"),
-                                             N_("skip"),
-                                             N_("abort"),
-                                             N_("quit"),
-                                             N_("edit_todo"),
-                                             N_("show_current_patch"),
-                                             NULL };
+       static const char *action_names[] = {
+               [NO_ACTION] = "undefined",
+               [ACTION_CONTINUE] = "continue",
+               [ACTION_SKIP] = "skip",
+               [ACTION_ABORT] = "abort",
+               [ACTION_QUIT] = "quit",
+               [ACTION_EDIT_TODO] = "edit_todo",
+               [ACTION_SHOW_CURRENT_PATCH] = "show_current_patch"
+       };
        const char *gpg_sign = NULL;
        struct string_list exec = STRING_LIST_INIT_NODUP;
        const char *rebase_merges = NULL;
@@ -1225,8 +1226,10 @@ int cmd_rebase(int argc, const char **argv, const
char *prefix)
                        trace2_cmd_mode("interactive");
                else if (exec.nr)
                        trace2_cmd_mode("interactive-exec");
-               else
+               else if (action < ARRAY_SIZE(action_names))
                        trace2_cmd_mode(action_names[action]);
+               else
+                       trace2_cmd_mode("unknown rebase action");
        }

        switch (action) {


