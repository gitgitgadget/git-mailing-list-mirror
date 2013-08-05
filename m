From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH ALTERNATIVE v6.v3 4/6] config: parse http.<url>.<variable> using urlmatch
Date: Mon, 5 Aug 2013 16:57:23 -0700
Message-ID: <503E9E2D-93E5-43CB-BB61-499052B35F4F@gmail.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com> <1375298768-7740-7-git-send-email-gitster@pobox.com> <20130731224511.GA25882@sigill.intra.peff.net> <62E17EDB-B24D-4F37-95F8-E2E26118E5E9@gmail.com> <5acf57129e37a87611ed03648f7b368@f74d39fa044aa309eaea14b9f57fe79> <7vsiyniw63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 01:57:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6UeZ-0005Dh-OY
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 01:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab3HEX52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 19:57:28 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:53551 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3HEX50 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 19:57:26 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so3974460pbc.21
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=rftogO73hKEacgxYgpnI1dB0dpBVZtU0Mk1I89ef/1s=;
        b=GMyXqBiQH5Md4tuDct6Rmrqn3S5cb8I6t6lUtvhsE+m6H86I9Ooxp4yP5fssqRfNz6
         wqwEUakYGV8AG0idL5bksGFRIIM13mPKh7J+FXK8B73NNk+U2GowI2RHMVT3Dyq+nmsp
         qXZDSPGe8Ra9ZkME7IHKYD7HEe8j8R5JJOeEiYf0fBlqdTs31UMJi1mLh/xM/rvSBtod
         2qcV1gl50DBatTvSllZJhuxvqFPaSNLXfZUD4f7avVqyO1kJ4jlbmiRvjUF74cJ/2XMi
         FsvKy5BU8SoqeBKUKSpn+VqwLAwwz/heLHmF5Y3ueccDJbZLsBNH2mYKzTy+r/xn808h
         vrpA==
X-Received: by 10.68.103.131 with SMTP id fw3mr24932541pbb.65.1375747046275;
        Mon, 05 Aug 2013 16:57:26 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kd1sm220211pab.20.2013.08.05.16.57.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 05 Aug 2013 16:57:25 -0700 (PDT)
In-Reply-To: <7vsiyniw63.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231708>

On Aug 5, 2013, at 15:56, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> Use the urlmatch_config_entry() to wrap the underlying
>> http_options() two-level variable parser in order to set
>> http.<variable> to the value with the most specific URL in the
>> configuration.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> Oops, what did we sign-off?

Some code removal.  No new additions.  Actually this:

On Aug 1, 2013, at 14:44, Junio C Hamano wrote:

> * jc/url-match (2013-07-31) 6 commits
> - config: "git config --get-urlmatch" parses section.<url>.key
> - builtin/config: refactor collect_config()
> - config: parse http.<url>.<variable> using urlmatch
> - config: add generic callback wrapper to parse section.<url>.key
> - config: add helper to normalize and match URLs
> - http.c: fix parsing of http.sslCertPasswordProtected variable
>
> Reroll of km/http-curl-config-per-url topic.  Peff raises many good
> points about the tests for http.* variables.
>
> Waiting for the discussion to conclude, hopefully with a replacement  
> test.

As requested.

>> This version of 4/6 moves the tests to t0110 since urlmatch is now  
>> global.
>> The config tests are removed since part 6/6 already has those and  
>> they no
>> longer belong with the urlmatch normalization tests.
>>
>> The Makefile rule has been removed since it's no longer needed to  
>> build
>> correctly as the test program no longer includes http.c.
>>
>> Other than those changes (and a minor rename to reflect the new  
>> location),
>> this patch is identical to the previous v6.v2 4/6.
>
> Ahh, figures.  Thanks.

The remaining tests, by the way, have not changed.  They are identical  
to previous versions.

> Peff, any comments?
>
>> diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch- 
>> normalization.sh
>> new file mode 100755
>> index 00000000..8d6096d4
>> --- /dev/null
>> +++ b/t/t0110-urlmatch-normalization.sh
>> @@ -0,0 +1,177 @@
>> +#!/bin/sh
>> +
>> +test_description='urlmatch URL normalization'
>> +. ./test-lib.sh
>> +
>> +# The base name of the test url files
>> +tu="$TEST_DIRECTORY/t0110/url"
>> +
>> +# Note that only file: URLs should be allowed without a host
>
> It is somewhat unfortunate that the form most commonly used for
> pushing is not supported at all, i.e.
>
> 	host:path

That is an SSH extension and they are certainly not URLs according to  
RFC 3986 because that would require every host to be its own scheme.

Also, host:path cannot in the general case, be unambiguously  
translated to a URL.

For example, repo.or.cz:srv/git/alt-git, has no translation.  It is  
different from repo.or.cz:/srv/git/alt-git which does have a  
translation.  There's no guarantee that inserting a '/' will not  
change the meaning of the URL (that only happens to be the case on  
repo.or.cz because all the ssh git users in the chroot jail have a '/'  
home directory).

> Current configuration set may not have anything interesting to
> affect the git-over-ssh push codepath, so in practice it may not
> matter, though.
>
>> +test_expect_success 'url authority' '
>
> "authority" refers to the host part? (not a complaint, but is a
> question)

It refers to this production from RFC 3986 Section "3.2 Authority":

authority = [ userinfo "@" ] host [ ":" port ]

>> +test_expect_success 'url port checks' '
>> +	test-urlmatch-normalization "xyz://q@some.host:" &&
>
> This is presumably replaced by a default port for xyz:// scheme,
> whatever the default port is, in other words, it is as if no colon
> is given at the end?

Yes.

The "port" production above is:

port = *DIGIT

which means 0 or more digits.

>> +	test-urlmatch-normalization "xyz://q@some.host:456/" &&
>> +	! test-urlmatch-normalization "xyz://q@some.host:0" &&
>> +	! test-urlmatch-normalization "xyz://q@some.host:0000000" &&
>
> Port #0 is disallowed?

Intentionally so.

The comments from urlmatch.c talk about this:

/*
  * Port number must be all digits with leading 0s removed
  * and since all the protocols we deal with have a 16-bit
  * port number it must also be in the range 1..65535
  * 0 is not allowed because that means "next available"
  * on just about every system and therefore cannot be used
  */

>> +	test-urlmatch-normalization "xyz://q@some.host:0000001?" &&
>
> Is it the same as specifying "xyz://q@some.host:1?" and does it
> match "xyz://q@some.host:1"?
>
>> +	test-urlmatch-normalization "xyz://q@some.host:065535#" &&
>
> Ditto, for 65535 and without #-fragment at the end?
>
>> +test_expect_success 'url port normalization' '
>> +	test "$(test-urlmatch-normalization -p "http://x:800")" = "http:// 
>> x:800/" &&
>> +	test "$(test-urlmatch-normalization -p "http://x:0800")" =  
>> "http://x:800/" &&
>> +	test "$(test-urlmatch-normalization -p "http://x:00000800")" =  
>> "http://x:800/" &&
>> +	test "$(test-urlmatch-normalization -p "http://x:065535")" =  
>> "http://x:65535/" &&
>> +	test "$(test-urlmatch-normalization -p "http://x:1")" = "http://x: 
>> 1/" &&
>> +	test "$(test-urlmatch-normalization -p "http://x:80")" = "http:// 
>> x/" &&
>> +	test "$(test-urlmatch-normalization -p "http://x:080")" = "http:// 
>> x/" &&
>> +	test "$(test-urlmatch-normalization -p "http://x:000000080")" =  
>> "http://x/" &&
>> +	test "$(test-urlmatch-normalization -p "https://x:443")" = "https://x/ 
>> " &&
>> +	test "$(test-urlmatch-normalization -p "https://x:0443")" = "https://x/ 
>> " &&
>> +	test "$(test-urlmatch-normalization -p "https://x:000000443")" = "https://x/ 
>> "
>> +'
>
> OK, these answer most of the previous questions.
>
>> +# http://@foo specifies an empty user name but does not specify a  
>> password
>> +# http://foo  specifies neither a user name nor a password
>> +# So they should not be equivalent
>> +test_expect_success 'url equivalents' '
>> +	test-urlmatch-normalization "httP://x" "Http://X/" &&
>> +	test-urlmatch-normalization "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me 
>> :%4D^p@the.HOST:80/" &&
>> +	! test-urlmatch-normalization "https://@x.y/^" "httpS://x.y:443/ 
>> ^" &&
>
> The comment is about this test, which seems to make sense.  What is
> "^"?  Just a random valid character that can appear in the path?
> (not a complaint, but is a question).

The character '^' is one of the always-unsafe characters that must  
always be escaped.  It's also one of the always-unsafe characters  
that's easy to include in the tests as it doesn't require escaping or  
backslashing or binary includes.  It doesn't otherwise have any  
special meaning.
