From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of a config value
Date: Sun, 7 Feb 2016 19:26:21 +0100
Message-ID: <920E424B-B052-43A0-A0AA-59EB8E093573@gmail.com>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com> <20160205112001.GA13397@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 19:26:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSU2i-0007cx-R5
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 19:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbcBGS0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 13:26:32 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35662 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbcBGS0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 13:26:25 -0500
Received: by mail-wm0-f50.google.com with SMTP id r129so87380693wmr.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OBl3jnCX0zs72Tq8ZiAPTKl4rbc0YU2brseyLlsxzso=;
        b=ICGWti8rTPtMOttOz/0oCVVbesd07FjicnguBfX4HrvQVm6HbBNi6ZNQcKj9KK+bV6
         dKdtYtj1bfsLMRowWNk4qyEawm2oNgWTc7c/ZBD2PdfTecF/9x2bHUftWVHxUQEjsCUf
         W5roPQRsiJOVsHAm06rpfCJDvTGXax9frDY6nMYCfvSplcQi6HDcH7qz7map2uuJqh8O
         pwNNDT+3q41eznmftvczML19tmeAVyKPbaU3oIwHBLjWgu4cLdaT3HO9rrwwHcibnp43
         sCInA5EMTfdOAk6tGJ38ht2PffUjpO3aSsU1uAyjAuq5bj8C38vXloI0PNpRQqi7F7pF
         4hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=OBl3jnCX0zs72Tq8ZiAPTKl4rbc0YU2brseyLlsxzso=;
        b=KuBlM1IBsiQ7/XHKHBolXVsmY9xXRJp7v1iwgKfHUH9ifSW+xXg09yVu85kzix2efM
         r5TJMd9D/DplKCv8VxrhVY89BrUtzibeS1p6CE6NkREJtLbXlebG0DxI29238eDfTTbz
         DGh+KOTzgfn1CCIKj2psG649BE9Wl0TddJRlcEQkvTKh8meWnj7w/jiK7ofyXPcbDM3w
         Jswr/a7X+Fyc7MMsCSKzHF1I/IEJ4T628kvgHuvkySJO7N+1jcMFT/KmZhFmgoWHoOOM
         bT5LyKfb82XSeyUrz7qpd1jeYMn7OruFH346Ixr1byIH9MKEX8Vw/5DLGRDA+VL6246N
         Xgmg==
X-Gm-Message-State: AG10YOQJvE7P2WFS5DAECHJP5HifTBkCmlB/HuiWa/8PXy6sftDDkAJVe9VUwZwGOlAaJg==
X-Received: by 10.194.19.164 with SMTP id g4mr23828801wje.120.1454869584164;
        Sun, 07 Feb 2016 10:26:24 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB606F.dip0.t-ipconnect.de. [93.219.96.111])
        by smtp.gmail.com with ESMTPSA id e194sm8921526wma.19.2016.02.07.10.26.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 10:26:23 -0800 (PST)
In-Reply-To: <20160205112001.GA13397@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285735>


On 05 Feb 2016, at 12:20, Jeff King <peff@peff.net> wrote:

> On Fri, Feb 05, 2016 at 09:42:30AM +0100, larsxschneider@gmail.com wrote:
> 
>> @@ -538,6 +569,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>> 		error("--name-only is only applicable to --list or --get-regexp");
>> 		usage_with_options(builtin_config_usage, builtin_config_options);
>> 	}
>> +
>> +	const int is_query_action = actions & (
>> +		ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST|
>> +		ACTION_GET_COLOR|ACTION_GET_COLORBOOL|ACTION_GET_URLMATCH
>> +	);
>> +
>> +	if (show_sources && !is_query_action) {
>> +		error("--sources is only applicable to --list or --get-* actions");
>> +		usage_with_options(builtin_config_usage, builtin_config_options);
>> +	}
> 
> Hmm. I had originally envisioned this only being used with "--list", but
> I guess it makes sense to say "--sources --get" to show where the value
> for a particular option is coming from.
> 
> The plural "sources" is a little funny there, though, as we list only
> the "last one wins" final value, not all of them (for that, you can use
> "--sources --get-all", which seems handy). I think it would be
> sufficient for the documentation to make this clear (speaking of which,
> this patch needs documentation...).
Oops. I will add documentation.

> 
> Also, I don't think the feature works with --get-color, --get-colorbool,
> or --get-urlmatch (which don't do their output in quite the same way).
> I think it would be fine to simply disallow --sources with those options
> rather than worry about making it work.
OK, I'll remove them. I don't have experience with these options as I 
have never really used them, yet.


>> +/* output to either fp or buf; only one should be non-NULL */
>> +static void show_config_source(struct strbuf *buf, FILE *fp)
>> +{
>> +	const char *fn = current_config_filename();
>> +	if (!fn)
>> +		return;
> 
> I'm not sure returning here is the best idea. We won't have a config
> filename if we are reading from "-c", but if we return early from this
> function, it parses differently than every other line. E.g., with your
> patch, if I do:
> 
>  git config -c foo.bar=true config --sources --list
> 
> I'll get:
> 
>  /home/peff/.gitconfig <tab> user.name=Jeff King
>  /home/peff/.gitconfig <tab> user.email=peff@peff.net
>  ...etc...
>  foo.bar=true
> 
> If somebody is parsing this as a tab-delimited list, then instead of the
> source field for that line being empty, it is missing (and it looks like
> "foo.bar=true" is the source file). I think it would be more friendly to
> consumers of the output to have a blank (i.e., set "fn" to the empty
> string and continue in the function).
I actually wondered about that exact point in your original patch but
"parsing" did not come to my mind. Now I understand your reasoning and I
agree.


> 
>> +
>> +	char term = '\t';
> 
> This declaration comes after the "if" above, but git style doesn't allow
> declaration-after-statement (to support ancient compilers).
Interesting, I noticed the style and wondered about it! Should we add 
"-Werror=declaration-after-statement" to the TravisCI [1] build to catch these
kind of cases automatically?

After enabling this flag the compiler showed me that I did the same
error a few lines above in "const int is_query_action ...".

[1] https://travis-ci.org/larsxschneider/git/jobs/107610347


> 
>> +test_expect_success '--sources' '
>> +	>.git/config &&
>> +	>"$HOME"/.gitconfig &&
>> +	INCLUDE_DIR="$HOME/include" &&
>> +	mkdir -p "$INCLUDE_DIR" &&
>> +	cat >"$INCLUDE_DIR"/include.conf <<-EOF &&
>> +		[user]
>> +			include = true
>> +	EOF
>> +	cat >"$HOME"/file.conf <<-EOF &&
>> +		[user]
>> +			custom = true
>> +	EOF
>> +	test_config_global user.global "true" &&
>> +	test_config_global user.override "global" &&
>> +	test_config_global include.path "$INCLUDE_DIR"/include.conf &&
> 
> Here you include the file by its absolute path. I wondered what would
> happen if we used a relative path. E.g.:
> 
>  git config include.path=foo
>  git config -f .git/foo included.config=true
>  git config --sources --list
> 
> which shows it as ".git/foo", because we resolved it by manipulating the
> relative path ".git/config". Whereas including it from ~/.gitconfig will
> show the absolute path, because we use the absolute path to get to
> ~/.gitconfig in the first place.
> 
> I think that's all sane. I don't know if it's worth noting it in the
> documentation or not.
I agree, this is the behavior I would expect and therefore I don't think
any additional documentation is necessary. The relative include is a good
idea! I added it to the test case.

> 
>> +	cat >expect <<-EOF &&
>> +		$HOME/.gitconfig	user.global=true
>> +		$HOME/.gitconfig	user.override=global
>> +		$HOME/.gitconfig	include.path=$INCLUDE_DIR/include.conf
>> +		$INCLUDE_DIR/include.conf	user.include=true
>> +		.git/config	user.local=true
>> +		.git/config	user.override=local
>> +		user.cmdline=true
>> +	EOF
> 
> If the filename has funny characters (e.g., a literal tab), it will be
> quoted here (but not in the --null output below). Worth including in the
> test?
Yes! Added!

> 
>> +	cat >expect <<-EOF &&
>> +		.git/config	local
>> +	EOF
>> +	git config --sources user.override >output &&
>> +	test_cmp expect output &&
> 
> Good thoroughness in checking the override case.
Thanks :)

> 
>> +	cat >expect <<-EOF &&
>> +		a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
>> +	EOF
>> +	blob=$(git hash-object -w "$HOME"/file.conf) &&
>> +	git config --blob=$blob --sources --list >output &&
>> +	test_cmp expect output
> 
> This one was unexpected to me, but I think it makes sense. The option is
> "--sources" and not "--source-filenames", after all. It's probably worth
> mentioning in the documentation.
OK

> 
> I think we also use the original name given, so if there was ref
> resolution, you would see the ref name. Might be worth testing that.
Good idea! Added!


Thanks for the review,
Lars
