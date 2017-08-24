Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC3B20285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbdHXTBz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:01:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38723 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdHXTBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:01:53 -0400
Received: by mail-wr0-f195.google.com with SMTP id y44so195552wrd.5
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ssxeFM/DUwRP07SAh4H9Sd7u4cbrKnP8VfDI6cHp7jA=;
        b=hPA3JH9pwOX7NXS2boBfAosFdlvqYYMEQZAMcFVCf4q0RbF2QD83zgpMuMyfNTG1/1
         gkdhkto48vbQI9QV/RrBaQIFAsW3xiVmOmQQX/mJAbpNmAPKZeUQGjar63hZiJBSkjqG
         ofrwudxEz4YOWYnmPl9vpFvet9hJDBs9DC1oFtCoKo1HYxI6xrYlcm+ghWyH5dq0Akg5
         ESAgNpqzQayTPMRaHTG3zThd7oQupmQusBvPAdT4iw/9WjsPEX/B7XmZpu5mLrOXTfWH
         iPYmyPX2z7GY0CgYUk+M5ApO2SRcgOue4dGKt1DEyzsi/xh4MwYUSU9wyVDuME6o+u/S
         PQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ssxeFM/DUwRP07SAh4H9Sd7u4cbrKnP8VfDI6cHp7jA=;
        b=UGwzQwxKSutF7zx7KNyQMXWBSm6XdIJ+PDVeSa+R9Pz1rBhAJo1zYpyKG2eG7OXx25
         grTBp0LOR1bwL07Fgp87yS6h7yUHCRu93UC+qWVyNooBh0WBqqZdgfNqk29ebbdCQOfR
         wEhhePMllgqxm6RVffDUgbno0lkrFKESTVXof+ToYn2FQqKRINiOIXhrz1D/GQhA15bq
         sv5y7SoqN9LJ7Wajy9zUQ6B1Php5U1EMtkn+ZNmP/CEDgaVb0nuQjLYC4j/XoHIu4eWk
         fxoz2b51tcGcCXcOZJLXsNoS06Rmel6XO5rNGWoMxEoquvEbNXWb4n5+v0wBe6BpzAN+
         GpRw==
X-Gm-Message-State: AHYfb5gEaf+CN2p1/Ho7ZLHv4e5AxdL0CGBhN0U9wXzTWOAF+BcP4yr1
        W5UHQ+NkNQTk/w==
X-Received: by 10.223.188.69 with SMTP id a5mr5182723wrh.312.1503601312305;
        Thu, 24 Aug 2017 12:01:52 -0700 (PDT)
Received: from [192.168.88.254] (host-176-36-105-88.la.net.ua. [176.36.105.88])
        by smtp.gmail.com with ESMTPSA id n71sm4660113wmg.13.2017.08.24.12.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 12:01:51 -0700 (PDT)
Subject: Re: [PATCH/RFC] push: anonymize URL in error output
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
References: <20170823094929.13541-1-sainaen@gmail.com>
 <20170823155826.m4s5y55x2esfoass@sigill.intra.peff.net>
From:   Ivan Vyshnevskyi <sainaen@gmail.com>
Message-ID: <82741094-19a6-e071-227d-f92b3b077a69@gmail.com>
Date:   Thu, 24 Aug 2017 22:01:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170823155826.m4s5y55x2esfoass@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/17 18:58, Jeff King wrote:
> On Wed, Aug 23, 2017 at 12:49:29PM +0300, Ivan Vyshnevskyi wrote:
> 
>> Commits 47abd85 (fetch: Strip usernames from url's before storing them,
>> 2009-04-17) and later 882d49c (push: anonymize URL in status output,
>> 2016-07-14) made fetch and push strip the authentication part of the
>> remote URLs when used in the merge-commit messages or status outputs.
>> The URLs that are part of the error messages were not anonymized.
>>
>> A commonly used pattern for storing artifacts from a build server in a
>> remote repository utilizes a "secure" environment variable with
>> credentials to embed them in the URL and execute a push. Given enough
>> runs, an intermittent network failure will cause a push to fail, leaving
>> a non-anonymized URL in the build log.
>>
>> To prevent that, reuse the same anonymizing function to scrub
>> credentials from URL in the push error output.
> 
> This makes sense. I suspect that most errors we output should be using
> the anonymized URL. Did you poke around for other calls?
Yes, I tried to check and unfortunately there are couple of places with
possible leaks:
* 'discover_refs()' in remote-curl.c when there's a HTTP error (see a
real-life scenario with an authz error in my response to Lars) -- is it
ok to include transport.h just to use one function or is there a cleaner
way?
* 'setup_push_upstream()' in push.c when a command doesn't have a branch
names (haven't saw problems with this in the wild, but could occur
during the CI setup) -- for this one, probably anonymization should
happen when the 'remote->name' field is set in the 'make_remote()'; same
question though, is it ok to include transport.h here?

Also there's an case of verbose output: I'm not sure I should change it,
but it does print out the non-anonymized URLs at least during push.
> 
> The general structure of the patch looks good, but I have a few minor
> comments below.
> 
>> Not sure how much of the background should be included in the commit message.
>> The "commonly used pattern" I mention could be found in the myriad of
>> online tutorials and looks something like this:
> 
> My knee-jerk reaction is if it's worth writing after the dashes, it's
> worth putting in the commit message.
> 
> However, in the case I think it is OK as-is (the motivation of "we
> already avoid leaking auth info to stdout, so we should do the same for
> error messages" seems self-contained and reasonable)
Well, I tend to be wordy, and most of the commit messages I saw were
rather short, so decided to split. Wonder, if maybe example command
should be included without the rest of it. Would it be useful?
> 
>> diff --git a/builtin/push.c b/builtin/push.c
>> index 03846e837..59f3bc975 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -336,7 +336,7 @@ static int push_with_options(struct transport *transport, int flags)
>>  	err = transport_push(transport, refspec_nr, refspec, flags,
>>  			     &reject_reasons);
>>  	if (err != 0)
>> -		error(_("failed to push some refs to '%s'"), transport->url);
>> +		error(_("failed to push some refs to '%s'"), transport_anonymize_url(transport->url));
> 
> This leaks the return value. That's probably not a _huge_ deal since the
> program is likely to exit, but it's a bad pattern. I wonder if we should
> be setting up transport->anonymous_url preemptively, and just let its
> memory belong to the transport struct.
Ah. Thanks! I knew I'd fail in the memory management even with the
one-line patch. :)

About 'transport->anonymous_url': not sure if it's worth it. There are
four calls to 'transport_anonymize_url' right now and it looks like the
new one in my patch is the first that has a transport struct instance
near by. The next likely candidate for update 'discover_refs()' also
gets the url as an argument.
> 
>> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
>> index d38bf3247..0b6fb6252 100755
>> --- a/t/t5541-http-push-smart.sh
>> +++ b/t/t5541-http-push-smart.sh
>> @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
>>  	grep "^To $HTTPD_URL/smart/test_repo.git" status
>>  '
>>  
>> +cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
>> +#!/bin/sh
>> +exit 1
>> +EOF
>> +chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
>> +
>> +cat >exp <<EOF
>> +error: failed to push some refs to '$HTTPD_URL/smart/test_repo.git'
>> +EOF
> 
> I know the t5541 script, which is old and messy, led you into these bad
> constructs. But usually in modern tests we:
> 
>  1. Try to keep all commands inside test_expect blocks to catch
>     unexpected failures or unwanted output.
> 
>  2. Use write_script for writing scripts, like:
> 
>       write_script "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-\EOF
>       exit 1
>       EOF
> 
>  3. Backslash our here-doc delimiter to suppress interpolation.
> 
>> +test_expect_success 'failed push status output scrubs password' '
>> +	cd "$ROOT_PATH"/test_repo_clone &&
>> +	test_must_fail git push "$HTTPD_URL_USER_PASS/smart/test_repo.git" +HEAD:scrub_err 2>stderr &&
>> +	grep "^error: failed to push some refs" stderr >act &&
>> +	test_i18ncmp exp act
>> +'
>> +rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
> 
> Similarly, this "rm" should probably be a test_when_finished in the
> block with the write_script (unless you really need to carry it over
> several test_expect blocks, in which case there should be an explicit
> test_expect cleaning it up).
Thanks! You're right. I just followed examples in the file.
Updated [1], will send with the next patch version.

> 
> Instead of grepping for the exact error, should we instead grep for the
> password to make sure it is not present on _any_ line?
> 
> -Peff
> 
One possible issue I see is that this will make it overlap with the
'push status output scrubs password' case above. But if it's not a
problem, I can replace last two lines with just a 'test_i18ngrep !'

[1]:
https://github.com/sainaen/git/blob/af17713/t/t5541-http-push-smart.sh#L380-L392
