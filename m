Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06F1C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiEWUbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiEWUbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:31:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2E62BE5
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:31:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i74so9800372ioa.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uEkTNyFledoenJ3ZW5oQB1T5dJPXkZhOWLHVnFf1m4A=;
        b=Xr17XwfqXo5zWdsMxyAnrEkL+Uoc0WfuKlFczX79sB/Bw0WwRplQauhaqAHzHST2Pt
         VsXUOSu0vH977Uz2BkTGjHfUAEyN3PbcJ7GoRBTQa3tyEcY6DTNUz2Tpey0kFgumBs8u
         7Y59+LRzoctYn34V/Dj+ac1PcJlapuEAbU4NaAyhcWq5RS7hLClNdzgKPYCYhg6iMdHW
         /txFFW8+lsLUw5svc5esGywJ8B9Lidyv2Dy1V9aChu2FdqHxifOX16pWwWW4Z1hr0ofT
         4Ghmr8eX42Oe3zn9LGRimLKtVeRK/FMTWLHAZLhaGMRSSTxRb/ARKUZF8RET83uaRko7
         79nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uEkTNyFledoenJ3ZW5oQB1T5dJPXkZhOWLHVnFf1m4A=;
        b=t6ojndbVOeyQuettHh0uqVq3kvg5rJntEsd99sXndlMNDSNCZC+QDHb11JMP8tC4Vl
         Yl8TpZ0XudWFGgE93kQ46VAeOBFy5yNbQQn3DsgLD6rnWP3JW/ojzGoxlyn0369EV8PI
         iF8VWF2kUEGAV82uxlHp1BemZhhRuCn2l6b+MNZq8Wa0XJUc7fR2AOggGYrCp8vDbDvd
         ZRM5xhFTpB0W3bmFWaFWSmPTjjan9UvJABJ0ljS9Yzv0unCLL6yBGP5wRID98vbCHeAd
         +gWfodd1NpGOeQ5Yv6JylRzpOeEf3A3zwZQ70nsVj6Px07C8gLLzgVxbk5W0ogqbi8t8
         5rCQ==
X-Gm-Message-State: AOAM5323DIHIwSBr+fXtfpdB+jNi9KojzW2Jsl/IHbJy0FFNBc9qI8Sm
        LEia8xJOntLVcqhybjau404M
X-Google-Smtp-Source: ABdhPJwybIgwwvRlm8XoWJG+CRe2WKLihs5Y2wLewTBrCa8D3E168G4WHfhOjGqKggbSVFLKbJZe8g==
X-Received: by 2002:a6b:3ec1:0:b0:65a:499f:23a4 with SMTP id l184-20020a6b3ec1000000b0065a499f23a4mr10557203ioa.189.1653337906387;
        Mon, 23 May 2022 13:31:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d5d2:1564:989:490a? ([2600:1700:e72:80a0:d5d2:1564:989:490a])
        by smtp.gmail.com with ESMTPSA id u22-20020a02b1d6000000b0032e5e0f1bd5sm2907204jah.164.2022.05.23.13.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:31:45 -0700 (PDT)
Message-ID: <7495dac8-0241-ad56-59e3-100673c88c52@github.com>
Date:   Mon, 23 May 2022 16:31:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <xmqqr14kqdag.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqr14kqdag.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/2022 3:06 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Create a new "fetch.credentialsInUrl" config option and teach Git to
>> warn or die when seeing a URL with this kind of information. The warning
>> anonymizes the sensitive information of the URL to be clear about the
>> issue.
> 
> The issue sounds vaguely familiar---I must have heard something
> similar on this list not in too distant past.

It certainly felt like not too distant, but [1] was over a year ago!
 
>> This change currently defaults the behavior to "ignore" which does
>> nothing with these URLs. We can consider changing this behavior to
>> "warn" by default if we wish. At that time, we may want to add some
>> advice about setting fetch.credentialsInUrl=ignore for users who still
>> want to follow this pattern (and not receive the warning).
> 
> It sounds more like "pass" than "ignore", the latter of which can be
> read as "strip" instead of "pass it as-is".

Perhaps "allow" would be more clear than all of these options?

> The name "warn", and its stronger form "die", both sound right.
> 
>> ... Running the test suite succeeds except for the
>> explicit username:password URLs used in t5550-http-fetch-dumb.s and
>> t5541-http-push-smart.sh. This means that all other tested URLs did not
>> trigger this logic.
> 
> We are not testing the form we are not encouraging, in other words ;-).

Right, but in addition we are hopefully testing most of the forms we
_do_ encourage, and without triggering these warnings.

>>     urlmatch: create fetch.credentialsInUrl config
>>     
>>     This is a modified version of the patch I submitted a while ago [1].
>>     
>>     Based on the feedback, changing the behavior to fail by default was not
>>     a good approach. Further, the idea to stop storing the credentials in
>>     config and redirect them to a credential manager was already considered
>>     by Peff [2] but not merged.
> 
> I just peeked [2] and I am not sure why we didn't X-<.  The solution
> there covers "git clone" that records the origin URL but this one
> would cover URL regardless of where the URL came from---as long as
> an insecure URL is used, we warn or die, and it is even against the
> URL that came from the command line.

The only reason I can guess is that credential helpers were not as
commonplace then. Perhaps now is the right time to revisit it with
the knowledge that more users have credential helpers for HTTPS URLs
(or use SSH with registered public keys).

> In a sense, I think these are more or less orthogonal.  [2]'s "clone
> can strip the user:pass from the URL it writes to the config, while
> passing user:pass to the credential API", especially if it is
> extended to "git remote add", would stop two common avenues that
> such an insecure URL can go to the configuration file.  The approach
> taken by this patch would complement it to a degree, as long as the
> user cares.

I agree that these are mostly orthogonal. I think that the parsing
logic in urlmatch.c would be involved in the 

> I am not sure if there is a legitimate case where the user does not
> care, though.  For a script, it may be handy if a URL can contain an
> ever-changing user:pass pair, where the pass is generated by
> something like s/key, for example, and for such a command line that
> knowingly have user:pass pair, having to set the configuration to
> "ignore" may be cumbersome.

Would it make sense to check isatty(2) if we make "warn" the default?
We could avoid breaking scripts and third-party tools that way.

>> diff --git a/urlmatch.c b/urlmatch.c
>> index b615adc923a..6b91fb648a7 100644
>> --- a/urlmatch.c
>> +++ b/urlmatch.c
>> @@ -1,5 +1,6 @@
>>  #include "cache.h"
>>  #include "urlmatch.h"
>> +#include "config.h"
> 
> Yuck.  Having to do config lookups at this deep a level in the
> callchain does not look too attractive to me.
> 
> I am wondering if we can make it the responsibility of the callers
> to figure out and pass down the settings of the new configuration
> variable.
> 
> Offhand I do not think of an easy and clean way to do so (well,
> "easy" is easy---add one to the list of globals in environment.c;
> "clean" is the harder part).

Even with something like a global in environment.c, what would
initialize it? Would we make it be part of the default Git
config so it is initialized at the start of every builtin? Or,
would we initialize the config the first time we parse a URL.

With that in mind, it might be good to have a static enum that
stores the parsed config value and uses that immediately instead
of calling git_config_get_string() repeatedly. Are there places
where we might inspect a huge number of URLs?

>>  #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
>>  #define URL_DIGIT "0123456789"
>> @@ -106,6 +107,46 @@ static int match_host(const struct url_info *url_info,
>>  	return (!url_len && !pat_len);
>>  }
>>  
>> +static void detected_credentials_in_url(const char *url, size_t scheme_len)
>> +{
>> +	char *value = NULL;
>> +	const char *at_ptr;
>> +	const char *colon_ptr;
>> +	struct strbuf anonymized = STRBUF_INIT;
>> +
>> +	/* "ignore" is the default behavior. */
>> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||
>> +	    !strcasecmp("ignore", value))
>> +		goto cleanup;
>> +
>> +	at_ptr = strchr(url, '@');
>> +	colon_ptr = strchr(url + scheme_len + 3, ':');
> 
> We expect that at_ptr would come after colon_ptr (i.e. in
> "scheme://<u>:<p>@host", no @ exists in <u> or <p> part) and the
> while() loop below assumes that for redacting.  Are we better off if
> we assert it here, or has the calling parser already rejected such
> cases?

This computation of at_ptr matches the one in url_normalize_1(),
so it at least agrees about where the "username[:password]" section
could be. That does mean that the password cannot contain an "@"
symbol (unless it is special-cased somehow?).

Thanks,
-Stolee
