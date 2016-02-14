From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add 'type' to config_source struct that identifies config type
Date: Sun, 14 Feb 2016 13:24:55 +0100
Message-ID: <394CD8BC-49CF-4D07-A9C2-CC8C60373A2B@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com> <1455373456-64691-3-git-send-email-larsxschneider@gmail.com> <20160213172435.GG30144@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:25:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvja-0002uV-Ei
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 13:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbcBNMY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 07:24:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35942 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcBNMY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2016 07:24:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id a4so5999699wme.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 04:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uOmxDLMpEuPxPM79Jsjq6hVpTEelB6n/9h5DjiOA36I=;
        b=qEBNduXJUe501+5d9c6zwuC1V6ON4TNKLOR6ItKNAQPWQ7GB/eAmHbeZ5VIGyRNKZZ
         3Ku45HssBT3mgQWTYlmXNLxVu/X1TUW2nszbnZUaYrEg7/KRy5QQF5eTmL5lGZ+kl4Ms
         oUt/9pVv84d2bjtdsh7XG29pmJWJG9XqCUnryG7XE0e4H7xSrql/7/7qtYE7UltZEqXI
         +HXFmKwcrWiBX9a6xPriTvCW+JTLSBscmxLi8epHZBtQi0e61w5sLG/Nqf36prpGcUrM
         o+A+KYpLW4ySGzr9MSav3cM0snaoqxPefrHOuCXeoHnJtb1/v+INvPSopXLJq//RmTY3
         hDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=uOmxDLMpEuPxPM79Jsjq6hVpTEelB6n/9h5DjiOA36I=;
        b=HMW8/LyY2IUncwCptqfoy3+YCeRnip2v0VZBfyq+qKFc1ol9jRqUro0oAaVjPT3sFZ
         GYd2zu4vDPLGqJ0ybOUyjxNlvQR+VLVcI4tnqYLpU0MGyo6fIRI5kEKKKBfAgyGKiWMc
         Ur6nZR9vWg8MaxxJR0b1eNcjZP3U5QADWp1pzyueSAwT4naSzsk5gy0zzBNRqPQwMX79
         c6wNkjzwxPCCM65i97DQfqypr+YLdeRMZ7xRFwhNek1du6J4mImYIqK5mJxVOwLSUzgP
         WwNmZQo69FP2YZDyT768xraOJj623O4IwFMM2eQOid83qqNCsJfwuIbkA3uAtASq1N+j
         Jl1A==
X-Gm-Message-State: AG10YORkenE9TvPlzK1iZkv+BN41G3rOojRWle58nUKtdciwyiuVE01rXjg5NM2nuoh5GA==
X-Received: by 10.194.185.237 with SMTP id ff13mr12215361wjc.129.1455452696614;
        Sun, 14 Feb 2016 04:24:56 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4789.dip0.t-ipconnect.de. [93.219.71.137])
        by smtp.gmail.com with ESMTPSA id os7sm20586762wjc.18.2016.02.14.04.24.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 04:24:56 -0800 (PST)
In-Reply-To: <20160213172435.GG30144@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286151>


On 13 Feb 2016, at 18:24, Jeff King <peff@peff.net> wrote:

> On Sat, Feb 13, 2016 at 03:24:15PM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Use the config type to print more detailed error messages that inform
>> the user about the origin of a config error (file, stdin, blob).
> 
> This looks OK overall. A few minor nits...
> 
>> @@ -1104,6 +1106,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
>> 	top.u.buf.buf = buf;
>> 	top.u.buf.len = len;
>> 	top.u.buf.pos = 0;
>> +	top.type = "blob";
>> 	top.name = name;
>> 	top.path = NULL;
>> 	top.die_on_error = 0;
> 
> This function is about reading config from a memory buffer. The only reason
> we do so _now_ is when reading from a blob, but I think it is laying a
> trap for somebody who wants to reuse the function later.
> 
> Should git_config_from_buf() take a "type" parameter, and
> git_config_from_blob_sha1() pass in "blob"?
Haha, fun fact: this was how I implemented it initially. Because of that
I noticed that "submodule-config.c" also uses "git_config_from_buf" :-)

However, then I thought the list wouldn't like it if I change the
interfaces. I will add the type parameter, again.


> 
>> @@ -1066,7 +1067,8 @@ static int do_config_from_file(config_fn_t fn,
>> 	struct config_source top;
>> 
>> 	top.u.file = f;
>> -	top.name = name;
>> +	top.type = path ? "file" : "stdin";
>> +	top.name = name ? name : "";
>> 	top.path = path;
>> 	top.die_on_error = 1;
>> 	top.do_fgetc = config_file_fgetc;
>> @@ -1078,7 +1080,7 @@ static int do_config_from_file(config_fn_t fn,
>> 
>> static int git_config_from_stdin(config_fn_t fn, void *data)
>> {
>> -	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
>> +	return do_config_from_file(fn, NULL, NULL, stdin, data);
>> }
> 
> Likewise here, we make assumptions in do_config_from_file() about what
> the NULL path means. I think this is less likely to be a problem than
> the other case, but it seems like it would be cleaner for "file" or
> "stdin" to come from the caller, which knows for sure what we are doing.
> 
> Similarly, I think git_config_from_stdin() can simply pass in an empty
> name rather than NULL to avoid do_config_from_file() having to fix it
> up.
OK


> 
>> +test_expect_success 'invalid stdin config' '
>> +	echo "fatal: bad config line 1 in stdin " >expect &&
>> +	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
>> +	test_cmp expect output
>> +'
> 
> The original would have been "bad config file line 1 in <stdin>"; I
> think this is an improvement to drop the "file" here.


Thanks,
Lars
