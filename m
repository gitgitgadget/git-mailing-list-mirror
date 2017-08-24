Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFEB20285
	for <e@80x24.org>; Thu, 24 Aug 2017 18:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbdHXS7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 14:59:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36901 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdHXS7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 14:59:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id b189so331812wmd.4
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m2oS33ev372/cLoPXkMF5hTtxdl85IIlvB7WhCOZ6GY=;
        b=ILYSXAiJPWQjdTd/J+zIibcLNl4kbxSg+GTu0uY9K1b2UhbGaBnlGQmhdx7TU8IGIA
         8avfteP1NZy1yc42tu+cr5PF6WaxkWP4rIKX9A+4dRWW27LwMNB8NRhdstHLMLzMU9sF
         2XB9hdM/YPp6ArtEN0zxF5AwbUnxdzh4+1ii6W+4xgAcsUk7Gn7etSvI/GpK6tQjtOOp
         h5+QgyL4Le3oqEeChcxI0diDF8VkOC6OGxhO1s/Ab+GzKNW2hZQAgxf6f2vbSwzbyNg+
         BdvfyxcJ/TiamZETsbawNphhDh9bSMuWjfiWIEnU5BHknKMznBEmUpBvhLUr8V5sKzdy
         TlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m2oS33ev372/cLoPXkMF5hTtxdl85IIlvB7WhCOZ6GY=;
        b=C5Z7Id0U6Q4paMJCxH+SswiIA9raYvXUYZFpYulL8wWkkATyKWnVYrfofcl9fNYqFF
         5GmiH30MbVzcCkmWYj18b0w3nATHrM150amxQ6Sv+BKTFn+g46N/q/dM+YR51em1Jyze
         7Byh0P0qwfKvRWCWNuZfrCEisjYUGGliP5E7zIWJz1dVIsy1u1w7YzGNnbyte7Is/ib6
         38zke2niTKU84MN2wWYtp+2vBxeA4ufKBWfcL3C2in/UPhLtrCWah/YvpbRtgLFYm8Vj
         LEEUxD/jGXe96KSGBcPdiWoxvDgEnYbZTwOhTPxcNNo9t3Hbt6arTes+fxudfDN5ZgJp
         +cvQ==
X-Gm-Message-State: AHYfb5jKfM1/L4gGbTwf3t+u/kDCPsNTYpygfg52tk3dI7sQ51wiYY2r
        FNyATD9kiUmyfw==
X-Received: by 10.28.13.202 with SMTP id 193mr919325wmn.19.1503601140084;
        Thu, 24 Aug 2017 11:59:00 -0700 (PDT)
Received: from [192.168.88.254] (host-176-36-105-88.la.net.ua. [176.36.105.88])
        by smtp.gmail.com with ESMTPSA id 67sm3706849wrm.29.2017.08.24.11.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 11:58:59 -0700 (PDT)
Subject: Re: [PATCH/RFC] push: anonymize URL in error output
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>
References: <20170823094929.13541-1-sainaen@gmail.com>
 <698B5636-BE6B-47EF-BE4B-1DB590E0028F@gmail.com>
From:   Ivan Vyshnevskyi <sainaen@gmail.com>
Message-ID: <4a1afb31-e240-fda5-416d-b85c968819f4@gmail.com>
Date:   Thu, 24 Aug 2017 21:58:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <698B5636-BE6B-47EF-BE4B-1DB590E0028F@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/17 13:57, Lars Schneider wrote:
> 
>> On 23 Aug 2017, at 11:49, Ivan Vyshnevskyi <sainaen@gmail.com> wrote:
>>
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
>>
>> Signed-off-by: Ivan Vyshnevskyi <sainaen@gmail.com>
>> ---
>>
>> This is my first attempt to propose a patch, sorry if I did something wrong!
>>
>> I've tested my changes on Travis CI, and the build is green [1].
>>
>> Not sure how much of the background should be included in the commit message.
>> The "commonly used pattern" I mention could be found in the myriad of
>> online tutorials and looks something like this:
>>
>>    git push -fq https://$GIT_CREDS@github.com/$REPO_SLUG
>>
>> Note, that a lot of developers mistakenly assume that '--quiet' ('-q') will
>> suppress all output. Sometimes, they would redirect standard output to
>> /dev/null, without realizing that errors are printed out to stderr.
>>
>> I didn't mention this in the commit, but another typical offender is a tool that
>> calls 'git push' as part of its execution. This is a spectrum that starts with
>> shell scripts, includes simple one-task apps in Python or Ruby, and ends with
>> the plugins for JavaScript, Java, Groovy, and Scala build tools. (I'd like to
>> avoid shaming their authors publicly, but could send you a few examples
>> privately.)
>>
>> I gathered the data by going through build logs of popular open source projects
>> (and projects of their contributors) hosted on GitHub and built by Travis CI.
>> I found about 2.3k unique credentials (but only about nine hundred were active
>> at the time), and more than a half of those were exposed by a failed push. See
>> the advisory from Travis CI [2] for results of their own scan.
>>
>> While the issue is public for several months now and addressed on Travis CI,
>> I keep finding build logs with credentials on the internet. So I think it's
>> worth fixing in the git itself.
>>
>> [1]: https://travis-ci.org/sainaen/git/builds/267180560
>> [2]: https://blog.travis-ci.com/2017-05-08-security-advisory
>>
> 
> This sounds very reasonable to me! Thanks for the contribution!>
Thank you!

> I wonder if we should even extend this. Consider this case:
> 
>   $ git push https://lars:secret@server/org/repo1
>   remote: Invalid username or password.
>   fatal: Authentication failed for 'https://lars:secret@server/org/repo1/'
> 
> I might not have valid credentials for repo1 but my credentials could
> very well be valid for repo2.
> 
> - Lars
> 
Yeah, you're right. In fact, there was a similar scenario:
1. maintainer creates a "<something>-bot" GitHub account to use for
pushing from CI back to the repository, but forgets to add this new
account to the project's organization
2. then they update the build to do the push with new credentials
3. auto-triggered build fails because the "*-bot" has no access yet

After that, they'd typically revoke exposed token and create a new one,
but sometimes they forget, and so the active token stays in the build log.

I found the place where this and couple of other errors seem to be
emitted ('discover_refs()' in remote-curl.c), but, to be honest, it just
seemed harder to figure out for the first patch: do I include the
transport.h here just to use this one function or should I copy it over?
Or move it to url.c (I guess?) and replace other usages?

Though, with some help, I'd be happy to tackle harder cases too. :)

> 
>> builtin/push.c             |  2 +-
>> t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
>> 2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/push.c b/builtin/push.c
>> index 03846e837..59f3bc975 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -336,7 +336,7 @@ static int push_with_options(struct transport *transport, int flags)
>> 	err = transport_push(transport, refspec_nr, refspec, flags,
>> 			     &reject_reasons);
>> 	if (err != 0)
>> -		error(_("failed to push some refs to '%s'"), transport->url);
>> +		error(_("failed to push some refs to '%s'"), transport_anonymize_url(transport->url));
>>
>> 	err |= transport_disconnect(transport);
>> 	if (!err)
>> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
>> index d38bf3247..0b6fb6252 100755
>> --- a/t/t5541-http-push-smart.sh
>> +++ b/t/t5541-http-push-smart.sh
>> @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
>> 	grep "^To $HTTPD_URL/smart/test_repo.git" status
>> '
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
>> +
>> +test_expect_success 'failed push status output scrubs password' '
>> +	cd "$ROOT_PATH"/test_repo_clone &&
>> +	test_must_fail git push "$HTTPD_URL_USER_PASS/smart/test_repo.git" +HEAD:scrub_err 2>stderr &&
>> +	grep "^error: failed to push some refs" stderr >act &&
>> +	test_i18ncmp exp act
>> +'
>> +rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
>> +
>> stop_httpd
>> test_done
>> -- 
>> 2.14.1
>>
