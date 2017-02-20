Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06293201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbdBTRSE (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 12:18:04 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36500 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbdBTRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 12:17:59 -0500
Received: by mail-wr0-f196.google.com with SMTP id z61so11928313wrc.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OZWdYt9/YMh78goxhIUuJOUeS1KL58ROZe2pXGrF/fg=;
        b=t3gwW9j9G+9R51XBXp28R5Yy11+7efk0tgSXBQaJrLJ4ewb9TwfAAgPhlLbDmlcUSo
         yyRUkplk3hrUChYSsbcCp94Wmu6yre/YTLPgGYnam/PFAVDrWNfp5iJfLaNEW6e49YHa
         S+f2T+4pKKwjC/9N/GpHSeJXse/FdLxg8MY6h2u7YIqZuQNBx7X80xQSItXyl5XD3Sd5
         BCQxqWW/L8AYHcbc4CrmbelrkhdSqTtYLoFEezg/wC1b2GAMw+r4NnHy7G6UYr3GMhVi
         vY78UNf60wjQqycRRy2X1bSiD/SSrNIkyG6ZPsh3x+26ZfwVWolXAaSbKT1zQBlOAb2F
         ZBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OZWdYt9/YMh78goxhIUuJOUeS1KL58ROZe2pXGrF/fg=;
        b=LF0ihm5v9/itNd2+uH/M3oh6rgkoRRLi2jSqYJw1vKlMR81ZKTxw7KmSSq7iVXQ0qh
         DWs9R9xytI8nk1/ymS+Qz7M+gIqcAIN5RwJSdDpFgp5c3W1cFCInIyV2rC5bJ4VOxfzC
         c70/5ZonHav9XTno6Dhk+gOyZJOxCZ7RaGpNjnHfqvVlgAw8ZFSm4zE31cbh3oADqgat
         kmMftKF+TQk2+qAY+pb7v63uxnrgnL772nhtj3RslREd6EVLfWSEKNZFxbBuAGZlj6T6
         ay3iUQOaEtleNiQGDWKB13/fbM4FYO2xuOAMYeKKrzDnzbZ8Hi8fwMYCI2uNzPKb1P3R
         Y2/w==
X-Gm-Message-State: AMke39kptSMAAWoGJy4Xo2PExoIjiLhKbSIHYACbgoIx+RigyfXRDZ2YaEfwQaARv6xMvA==
X-Received: by 10.223.154.210 with SMTP id a76mr14865884wrc.193.1487611067591;
        Mon, 20 Feb 2017 09:17:47 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d75sm10118294wmd.25.2017.02.20.09.17.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 09:17:46 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config on the command line
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 20 Feb 2017 18:17:46 +0100
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, sbeller@google.com
Content-Transfer-Encoding: 7bit
Message-Id: <CC2769D6-2F21-433B-A972-ED795F31A868@gmail.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com> <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com> <f238248f-0df2-19a5-581d-95c8a61b4632@google.com> <xmqqy3x712if.fsf@gitster.mtv.corp.google.com> <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com> <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com> <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com> <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net> <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com> <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 20 Feb 2017, at 10:58, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I still haven't queued any of the variants I posted (and I do not
>> think other people sent their own versions, either).  I need to pick
>> one and queue, with a test or two.  Perhaps after -rc2.  
>> 
>> Others are welcome to work on it while I cut -rc2 tomorrow, so that
>> by the time I see their patch all that is left for me to do is to
>> apply it ;-)
> 
> Since nothing seems to have happened in the meantime, here is what
> I'll queue so that we won't forget for now.  Lars's tests based on
> how the scripted "git submodule" uses "git config" may still be
> valid, but it is somewhat a roundabout way to demonstrate the
> breakage and not very effective way to protect the fix, so I added a
> new test that directly tests "git -c <var>=<val> <command>".

Agreed. Please ignore my tests.
If you want to you could queue this tiny cleanup, though:
http://public-inbox.org/git/20170215113325.14393-1-larsxschneider@gmail.com/

> ...
> 
> +/*
> + * downcase the <section> and <variable> in <section>.<variable> or
> + * <section>.<subsection>.<variable> and do so in place.  <subsection>
> + * is left intact.
> + */
> +static void canonicalize_config_variable_name(char *varname)
> +{
> +	char *cp, *last_dot;

What does cp stand for? "char pointer"?

> +
> +	/* downcase the first segment */
> +	for (cp = varname; *cp; cp++) {
> +		if (*cp == '.')
> +			break;
> +		*cp = tolower(*cp);
> +	}
> +	if (!*cp)
> +		return;
> +
> +	/* scan for the last dot */
> +	for (last_dot = cp; *cp; cp++)
> +		if (*cp == '.')
> +			last_dot = cp;
> +
> +	/* downcase the last segment */
> +	for (cp = last_dot; *cp; cp++)
> +		*cp = tolower(*cp);
> +}
> +
> int git_config_parse_parameter(const char *text,
> 			       config_fn_t fn, void *data)
> {
> @@ -221,7 +249,7 @@ int git_config_parse_parameter(const char *text,
> 		strbuf_list_free(pair);
> 		return error("bogus config parameter: %s", text);
> 	}
> -	strbuf_tolower(pair[0]);
> +	canonicalize_config_variable_name(pair[0]->buf);
> 	if (fn(pair[0]->buf, value, data) < 0) {
> 		strbuf_list_free(pair);
> 		return -1;
> diff --git a/t/t1351-config-cmdline.sh b/t/t1351-config-cmdline.sh
> new file mode 100755
> index 0000000000..acb8dc3b15
> --- /dev/null
> +++ b/t/t1351-config-cmdline.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description='git -c var=val'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'last one wins: two level vars' '
> +	echo VAL >expect &&
> +
> +	# sec.var and sec.VAR are the same variable, as the first
> +	# and the last level of a configuration variable name is
> +	# case insensitive.  Test both setting and querying.
> +
> +	git -c sec.var=val -c sec.VAR=VAL config --get sec.var >actual &&
> +	test_cmp expect actual &&
> +	git -c SEC.var=val -c sec.var=VAL config --get sec.var >actual &&
> +	test_cmp expect actual &&
> +
> +	git -c sec.var=val -c sec.VAR=VAL config --get SEC.var >actual &&
> +	test_cmp expect actual &&
> +	git -c SEC.var=val -c sec.var=VAL config --get sec.VAR >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'last one wins: three level vars' '
> +	echo val >expect &&
> +
> +	# v.a.r and v.A.r are not the same variable, as the middle
> +	# level of a three-level configuration variable name is
> +	# case sensitive.  Test both setting and querying.
> +
> +	git -c v.a.r=val -c v.A.r=VAL config --get v.a.r >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c v.A.r=VAL config --get V.a.R >actual &&
> +	test_cmp expect actual &&
> +
> +	echo VAL >expect &&
> +	git -c v.a.r=val -c v.a.R=VAL config --get v.a.r >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c V.a.r=VAL config --get v.a.r >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c v.a.R=VAL config --get V.a.R >actual &&
> +	test_cmp expect actual &&
> +	git -c v.a.r=val -c V.a.r=VAL config --get V.a.R >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> -- 
> 2.12.0-rc2-221-g8fa194a99f
> 

Looks good to me!

Thank you,
Lars

