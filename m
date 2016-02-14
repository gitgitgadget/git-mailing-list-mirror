From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Sun, 14 Feb 2016 13:48:59 +0100
Message-ID: <CF48D0B6-66BD-4C5D-A93B-AB0BBC00615D@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com> <1455373456-64691-4-git-send-email-larsxschneider@gmail.com> <20160213174449.GH30144@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:49:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUw6v-0007gF-KO
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 13:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbcBNMtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 07:49:04 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36745 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbcBNMtD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2016 07:49:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id a4so6067182wme.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FsvvsdWjhKnnRdH/jsBh/EuOO1xDl3SkmTxENnD7efE=;
        b=H0g/BZQu82T3no+R0yiK/MbA4mHOZhJTcBiHKcNcdHX2nawCT0vXMCxBG/8tx/Zrru
         JctkuH7u3HwwMzKSq/iDqAR1Oky129dKbdinNAeOFHw+0smEPkV0czs4NfHP6+D83caK
         dNAi6ajwaiM5C+rJ9dBYA6OxBYVzy5BSMZkN1YVUMVlDpHFGKk/+bicskIh5TbDBEnEf
         o6sqGaYm9JJ8fUhWWWrqIIR2r3qV3BpLyPbq6rhktI3XP3qN++b4JA9BxDHlq054hgrT
         R4I+FNnLRaMcjHsM+Gcp/EpanC8r/ofm9HwUODX7W0sJ/siw/IiHbWyrs82NL7eHRJQM
         zNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=FsvvsdWjhKnnRdH/jsBh/EuOO1xDl3SkmTxENnD7efE=;
        b=QPx0rJGXRoSrjI8ydSi+IUiyu4CUxB8Vlhg9vSE7x9Ni1TNMQi7eLaMNZBTu6DYtZm
         u5aEd3QTbsslXWFKOCwEcwoE8X6Wda1twC1RUg1zBn6Cmtf8JI/CXKtAC4vWnf4lkIje
         GvWVVMVrJf2MHbEc2CxBzpICHyH7HRkLfvZQEWXmxhLnZlbBe+2DgSrOBVLI6bSircef
         HhXivQjCVyOOVqEHGLwX1IR5EosjOW8oP88tZiRmsMlkqk7WvEBCXSsEpUWojHboqqEB
         h5pt0ZYO63Bcs6BVptRDAliZr3OUkcRQicEqcGZgf9u5qJ84l9v1STi3cdl6eYDbklBW
         s1fg==
X-Gm-Message-State: AG10YOSftqzzo2PyPfttfLCS1uY7jXNrir3E3ypgXbuVgrSHktfdOye2UEPiRxyVn09gCA==
X-Received: by 10.28.215.16 with SMTP id o16mr7131256wmg.57.1455454141362;
        Sun, 14 Feb 2016 04:49:01 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4789.dip0.t-ipconnect.de. [93.219.71.137])
        by smtp.gmail.com with ESMTPSA id e194sm10974380wma.19.2016.02.14.04.48.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 04:49:00 -0800 (PST)
In-Reply-To: <20160213174449.GH30144@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286153>


On 13 Feb 2016, at 18:44, Jeff King <peff@peff.net> wrote:

> On Sat, Feb 13, 2016 at 03:24:16PM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> If config values are queried using 'git config' (e.g. via --get,
>> --get-all, --get-regexp, or --list flag) then it is sometimes hard to
>> find the configuration file where the values were defined.
>> 
>> Teach 'git config' the '--show-origin' option to print the source
>> configuration file for every printed value.
> 
> Thanks, I think this version fixes the correctness issues I mentioned
> earlier. I do still have nits to pick (of course :) ), that we may or
> may not want to deal with.
> 
>> +static void show_config_origin(struct strbuf *buf)
>> +{
>> +	const char term = end_null ? '\0' : '\t';
>> +	const char *type;
>> +	const char *name;
>> +
>> +	current_config_type_name(&type, &name);
> 
> This double out-parameter feels like a clunky interface.
> 
> I was tempted to suggest that we simply make the "struct config_source"
> available to builtin/config.c (which is already pretty intimate with the
> rest of the config code), and then it can pick out what it wants. But
> there _is_ some logic in the function to convert the NULL "cf" into
> "cmdline".
> 
> Perhaps it would be simpler to just have two accessor functions, and do:
> 
>  strbuf_addstr(buf, current_config_type());
>  ...
>  strbuf_addstr(buf, current_config_name());
> 
> I admit it is a pretty minor point, though.
Agreed, this looks nicer.


> 
>> static int show_all_config(const char *key_, const char *value_, void *cb)
>> {
>> +	if (show_origin) {
>> +       struct strbuf buf = STRBUF_INIT;
>> +       show_config_origin(&buf);
>> +       fwrite(buf.buf, 1, buf.len, stdout);
>> +       strbuf_release(&buf);
>> +	}
> 
> The indentation is funky here.
True! Indentation without intention :-) 

> 
> The use of fwrite() to catch the embedded NULs is subtle enough that it
> might be worth a comment.
> 
> It also made me wonder how format_config() handles this. It looks like
> we send the result eventually to fwrite() there, so it all works (and it
> does _not_ have the comment I mentioned :) ).
I will add a comment in both places :-)


> 
>> +test_expect_success '--show-origin' '
>> +	>.git/config &&
>> +	>"$HOME"/.gitconfig &&
>> +	INCLUDE_DIR="$HOME/include" &&
>> +	mkdir -p "$INCLUDE_DIR" &&
>> +	cat >"$INCLUDE_DIR"/absolute.include <<-EOF &&
>> +		[user]
>> +			absolute = include
>> +	EOF
>> +	cat >"$INCLUDE_DIR"/relative.include <<-EOF &&
>> +		[user]
>> +			relative = include
>> +	EOF
>> +	test_config_global user.global "true" &&
>> +	test_config_global user.override "global" &&
>> +	test_config_global include.path "$INCLUDE_DIR"/absolute.include &&
>> +	test_config include.path ../include/relative.include &&
>> +	test_config user.local "true" &&
>> +	test_config user.override "local" &&
>> +
>> +	cat >expect <<-EOF &&
>> +		file:$HOME/.gitconfig	user.global=true
>> +		file:$HOME/.gitconfig	user.override=global
>> +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
>> +		file:$INCLUDE_DIR/absolute.include	user.absolute=include
>> +		file:.git/config	include.path=../include/relative.include
>> +		file:.git/../include/relative.include	user.relative=include
>> +		file:.git/config	user.local=true
>> +		file:.git/config	user.override=local
>> +		cmdline:	user.cmdline=true
>> +	EOF
>> +	git -c user.cmdline=true config --list --show-origin >output &&
>> +	test_cmp expect output &&
>> +
>> +	cat >expect <<-EOF &&
>> +		file:$HOME/.gitconfigQuser.global
>> +		trueQfile:$HOME/.gitconfigQuser.override
>> +		globalQfile:$HOME/.gitconfigQinclude.path
>> +		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
>> +		includeQfile:.git/configQinclude.path
>> +		../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
>> +		includeQfile:.git/configQuser.local
>> +		trueQfile:.git/configQuser.override
>> +		localQcmdline:Quser.cmdline
>> +		trueQ
>> +	EOF
> 
> I see you split this up more, but there's still quite a bit going on in
> this one block. IMHO, it would be more customary in our tests to put the
> setup into one test_expect_success block, then each of these
> expect-run-cmp blocks into their own test_expect_success.
> 
> It does mean that the setup mutates the global test state for further
> tests (and you should stop using test_config_*, which clean up at the
> end of the block), but I think that's the right thing here. The point of
> test_config is "flip on this switch just for a moment, so we can test
> its effect without hurting further tests". But these are config tests in
> the first place, and it is OK for them to show a progression of
> mutations of the config (you'll note that like the other tests in this
> script, you are clearing out .git/config in the first place).
> 
TBH I am always a little annoyed if Git tests depend on each other. It makes
it harder to just disable all uninteresting tests and only focus on the one that 
I am working with. However, I agree with your point that the test block does too
many things. Would it be OK if I write a bash function that performs the test
setup? Then I would call this function in the beginning of every individual 
test. Or do you prefer the global state strategy?

Thanks,
Lars