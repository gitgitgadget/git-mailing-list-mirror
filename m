From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 15 Feb 2016 10:41:11 +0100
Message-ID: <5DE14BA4-6F90-4337-A5F6-345775E9734A@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com> <1455373456-64691-4-git-send-email-larsxschneider@gmail.com> <20160213174449.GH30144@sigill.intra.peff.net> <20160213180412.GA9516@sigill.intra.peff.net> <20160213181529.GB9516@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 10:41:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVFem-0006N9-50
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbcBOJlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 04:41:19 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35902 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbcBOJlP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 04:41:15 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so49406785wme.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VN9eo0YMKtYPBVPekjRC27CXVKJAyN9569Lt3yW79Ag=;
        b=idWLuRP9mhzZU5NVDutRGYJxlTA7IHJ5Flrh9PPYvI1VDdCZjQETCvbfwjrTxHoiFm
         bYEr+v4IGDW1TA1X4t/fn8lAsP7aK6xa1cxQ6wQXWTrLi5J8fND+qHoHgSIYzYb8GasJ
         0eSdQ8gtIzFQa7QMKVIwouNyBe/zotBwt4uEr8GEv8C9LtkdBqkXlu2V+1IH17eQqnDr
         OxRoWsqU9g5uCui5/u6ttqEz6mcCUDjp7jnwdh5v+Sjj3Oh/yzuHJhbHmD/4aOAfO6Kf
         Je/VZ9v6yPao76HgJGrD4H1WtgY1C2mJj4tKK36Xo3ufquCv1EO6VZCUPhFdce0+SQRt
         0t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=VN9eo0YMKtYPBVPekjRC27CXVKJAyN9569Lt3yW79Ag=;
        b=j3hhG3CfIVjJ7ujwOfHfVCwyv3UnwrSRF0hgUN37puHKh0v7RRrfbq58TmyjdXKR/2
         e8zDtFG5bn22PR3ITJsZNKIaQZjwgaq2FuADpHw1nuAmzk18puvXDLxwF76YnsJt8QUr
         THyV5lQa2M2r2YjyTrfHLySY9u1BLqrP9vnPgcKWf5QuNXptf1DjFG9j/O9uji3YbR9R
         eipgrGLQxlhoswJRnRDiDkjivlmJe9xadj9J1R7X61t+whWbZFmT/wPazJLBPVzhyV5D
         xnI7kwUo1Epq5aCsjKYofcyGRW6ivMwuJgAlsBoQJQc7Um4QXFkvHq7Thy+9NO5Sb3NR
         LFow==
X-Gm-Message-State: AG10YOThzmD35hgz459nukE6L6ZDFJ1SaJYvlSYfw9J0E726+XCZRNCVhKsrszrF5xyZTA==
X-Received: by 10.194.63.7 with SMTP id c7mr15234349wjs.168.1455529274495;
        Mon, 15 Feb 2016 01:41:14 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB477C.dip0.t-ipconnect.de. [93.219.71.124])
        by smtp.gmail.com with ESMTPSA id a128sm14743762wmh.6.2016.02.15.01.41.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Feb 2016 01:41:13 -0800 (PST)
In-Reply-To: <20160213181529.GB9516@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286189>


On 13 Feb 2016, at 19:15, Jeff King <peff@peff.net> wrote:

> On Sat, Feb 13, 2016 at 01:04:12PM -0500, Jeff King wrote:
> 
>> On Sat, Feb 13, 2016 at 12:44:49PM -0500, Jeff King wrote:
>> 
>>>> +test_expect_success '--show-origin' '
>>> [...]
>>> I see you split this up more, but there's still quite a bit going on in
>>> this one block. IMHO, it would be more customary in our tests to put the
>>> setup into one test_expect_success block, then each of these
>>> expect-run-cmp blocks into their own test_expect_success.
>> 
>> Here's a squashable patch that shows what I mean.
> 
> And here are a few comments on the changes...
> 
>> -test_expect_success '--show-origin' '
>> -	>.git/config &&
>> -	>"$HOME"/.gitconfig &&
>> +test_expect_success 'set up --show-origin tests' '
>> 	INCLUDE_DIR="$HOME/include" &&
>> 	mkdir -p "$INCLUDE_DIR" &&
>> -	cat >"$INCLUDE_DIR"/absolute.include <<-EOF &&
>> +	cat >"$INCLUDE_DIR"/absolute.include <<-\EOF &&
>> 		[user]
>> 			absolute = include
>> 	EOF
>> -	cat >"$INCLUDE_DIR"/relative.include <<-EOF &&
>> +	cat >"$INCLUDE_DIR"/relative.include <<-\EOF &&
>> 		[user]
>> 			relative = include
>> 	EOF
>> -	test_config_global user.global "true" &&
>> -	test_config_global user.override "global" &&
>> -	test_config_global include.path "$INCLUDE_DIR"/absolute.include &&
>> -	test_config include.path ../include/relative.include &&
>> -	test_config user.local "true" &&
>> -	test_config user.override "local" &&
>> +	cat >"$HOME"/.gitconfig <<-EOF &&
>> +		[user]
>> +			global = true
>> +			override = global
>> +		[include]
>> +			path = "$INCLUDE_DIR/absolute.include"
>> +	EOF
>> +	cat >.git/config <<-\EOF
>> +		[include]
>> +			path = ../include/relative.include
>> +		[user]
>> +			local = true
>> +			override = local
>> +	EOF
> 
> I preserved your ordering here (as the later "--list" tests care). But
> it might be worth ordering both files the same way, so that a reader
> does not wonder if it is significant (and just update the --list
> output expectation later).
OK, fixed!


> 
>> @@ -1253,25 +1263,32 @@ test_expect_success '--show-origin' '
>> 		localQcmdline:Quser.cmdline
>> 		trueQ
>> 	EOF
>> -	git -c user.cmdline=true config --null --list --show-origin | nul_to_q >output &&
>> +	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
>> +	nul_to_q <output.raw >output &&
> 
> We usually try to avoid putting git on the left-hand side of a pipe,
> because it hides the exit code, and we want to make sure git does not
> fail. I won't be surprised if you copied the style from elsewhere in the
> script, though, as this is an old one and we were not always consistent.
Make sense, fixed!


> 
>> 	echo >>output &&
>> -	test_cmp expect output &&
>> +	test_cmp expect output
> 
> This "echo" might be worth a comment. I think we are just adding the
> extra newline that the here-doc insists on, but that --null output would
> not include.
Done.

> 
> Overall, I find the "--show-origin --null" output pretty weird to read.
> We use a newline to split the config key/value, a NUL between config
> entries, but now also a NUL between the filename and the rest of the
> config entry.
> 
> That makes parsing pretty weird, as you cannot just use something like
> 
>  git config --show-origin --list --null | perl -0ne ...
> 
> to process entries; every other entry you get will be a filename. But at
> the same time, we do not go all out and say "there is a NUL between each
> field", because the key/value separator is a newline in this case, and
> the reader has to parse that separately after splitting on NULs.
> 
> But I think it's too late to do anything about it now. The weirdness is
> really the mixed NUL/newline thing, and you are not introducing that.
> 
>> -CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
>> -cat >"$CUSTOM_CONFIG_FILE" <<-\EOF &&
>> -	[user]
>> -		custom = true
>> -EOF
>> +test_expect_success 'set up custom config file' '
>> +	CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
>> +	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
>> +		[user]
>> +			custom = true
>> +	EOF
>> +'
> 
> Everything, even mundane setup, should generally go in a test_expect
> block. That means we'll notice unexpected failures, and any output will
> follow the usual "--verbose" rules.
> 
> Arguably this setup could just go into the initial setup block.
> 
> Also, you may not that the filename does _not_ actually have tabs in it,
> because the shell does not expand "\t". It does have backslashes in it,
> though, which is enough to trigger our C-style quoting.
Oh, thanks for the explanation. I was already wondering about the double
backslash earlier...

> 
> So the test isn't wrong, but the filename is misleading. If you really
> want tabs, you'd have to do:
> 
>  CUSTOM_CONFIG_FILE="$(printf "file\twith\ttabs.conf")
> 
> or similar.
> 
>> test_expect_success '--show-origin escape special file name characters' '
>> 	cat >expect <<-\EOF &&
>> @@ -1302,8 +1321,6 @@ test_expect_success '--show-origin stdin' '
>> '
>> 
>> test_expect_success '--show-origin stdin with file include' '
>> -	INCLUDE_DIR="$HOME/include" &&
>> -	mkdir -p "$INCLUDE_DIR" &&
>> 	cat >"$INCLUDE_DIR"/stdin.include <<-EOF &&
>> 		[user]
>> 			stdin = include
> 
> Here we can assume that the setup block succeeded (if it didn't, all of
> the tests are screwed anyway, so you'd want to fix that first).

Thanks,
Lars