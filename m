Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A8F202A4
	for <e@80x24.org>; Sun, 10 Sep 2017 05:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdIJFHc (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 01:07:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45069 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750730AbdIJFHb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Sep 2017 01:07:31 -0400
X-AuditID: 1207440c-7fdff7000000143e-1d-59b4c892c546
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.42.05182.298C4B95; Sun, 10 Sep 2017 01:07:31 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC2B0.dip0.t-ipconnect.de [87.188.194.176])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8A57Sgo016214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 10 Sep 2017 01:07:29 -0400
Subject: Re: [PATCH v2 08/11] t1404: demonstrate two problems with reference
 transactions
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1504877858.git.mhagger@alum.mit.edu>
 <76d473f62a8c1d6328eb15003c4d0d4dbc8f277d.1504877858.git.mhagger@alum.mit.edu>
 <20170909111753.pidf26f5koaewyho@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cdfea8a5-fc86-095d-7f5f-89a8f922cac9@alum.mit.edu>
Date:   Sun, 10 Sep 2017 07:07:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170909111753.pidf26f5koaewyho@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqDv5xJZIg0+9rBZrn91hsni+/gS7
        RdeVbiaLht4rzBbdU94yWvxo6WG22Ly5ncWB3WPnrLvsHgs2lXo8693D6HHxkrLH501yAaxR
        XDYpqTmZZalF+nYJXBmrHn5lLpjPX3F98SH2Bsb93F2MHBwSAiYSt79adzFycQgJ7GCSmP9j
        OXsXIyeQc4FJ4ucuVhBbWCBaYsqD/YwgtoiArMT3wxsZQRqYBbYwSbyb28EO0X2IUWLbvnlM
        IFVsAroSi3qawWxeAXuJJ813wWwWAVWJ3UcmgtmiAhESfW8vs0PUCEqcnPmEBcTmFHCR2Ne0
        AWwzs4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoMAtJ+ywkLbOQtMxC0rKAkWUVo1xiTmmu
        bm5iZk5xarJucXJiXl5qka6hXm5miV5qSukmRkg08Oxg/LZO5hCjAAejEg/vBOctkUKsiWXF
        lbmHGCU5mJREed8dBwrxJeWnVGYkFmfEF5XmpBYDg4GDWUmE9/VRoBxvSmJlVWpRPkxKmoNF
        SZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYL3MchQwaLU9NSKtMycEoQ0EwcnyHAeoOG3QGp4
        iwsSc4sz0yHypxgVpcR5c0ESAiCJjNI8uF5YsnrFKA70ijDvS5AqHmCig+t+BTSYCWhwyfMN
        IINLEhFSUg2M1WWC1Tvs+bSyn8/s+6Ae8jpmZs593yf9V9TX8gQ/XLq5y8i22/G17skN5i+l
        d39W2Mt+yeHg+8SzvLJLEzM8b1l69k+Uc+Le/XpnkPpv/QtRyQsfmOWtNr4mlbFnwurH1V7B
        AUXcrs8YFnd0LX0n4n6VkXv6GleJgI5XmdckWfpzJu/Z82uTEktxRqKhFnNRcSIAJpxAVDED
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/09/2017 01:17 PM, Jeff King wrote:
> On Fri, Sep 08, 2017 at 03:51:50PM +0200, Michael Haggerty wrote:
> [...]
> So if we get what we want, we execute ":" which should be a successful
> exit code.

I think the `:` is superfluous even if we care about the exit code of
the `case`. I'll remove it.

>> +	undefined)
>> +		# This is not correct; it means the deletion has happened
>> +		# already even though update-ref should not have been
>> +		# able to acquire the lock yet.
>> +		echo "$prefix/foo deleted prematurely" &&
>> +		break
>> +		;;
> 
> But if we don't, we hit a "break". But we're not in a loop, so the break
> does nothing. Is the intent to give a false value to the switch so that
> we fail the &&-chain? If so, I'd think "false" would be the right thing
> to use. It's more to the point, and from a few limited tests, it looks
> like "break" will return "0" even outside a loop (bash writes a
> complaint to stderr, but dash doesn't).
> 
> Or did you just forget that you're not writing C and that ";;" is the
> correct way to spell "break" here? :)

An earlier version of the patch used a loop and needed the `break`. But
when I removed the loop, I probably didn't notice the now-unneeded
breaks because of what you said. I'll take them out.

>> [...]
>> +	esac >out &&
>> [...]
>> +	test_must_be_empty out &&
> 
> The return value of "break" _doesn't_ matter, because you end up using
> the presence of the error message.
> 
> I think we could write this as just:
> 
>   case "$sha1" in
>   $D)
> 	# good
> 	;;
>   undefined)
>         echo >&2 this is bad
> 	false
> 	;;
>   esac &&
> 
> I'm OK with it either way (testing the exit code or testing the output),
> but either way the "break" calls are doing nothing and can be dropped, I
> think.

Yes, using the exit code to decide success is simpler. I'll make that
change, too.

Thanks for your comments.

Michael
