From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 18:31:08 -0500
Message-ID: <CAPig+cSXsk4Pp9adi4KvYjdCwaw4R0Jrv2vwC0JTCyzomWxaww@mail.gmail.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
	<CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
	<20160221231913.GA4094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:31:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdT8-0003qD-VI
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcBUXbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:31:10 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33248 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbcBUXbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:31:09 -0500
Received: by mail-vk0-f53.google.com with SMTP id k196so116611521vka.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=e1ali+ZkeDUhB9YjAXA0DFsPI7RDWNQ1zvsqlUUHA2g=;
        b=hPE3pgNrIvI6lpR1KV9ln99Rvl7yxrEOTx6EwdoIvKTLsP6lpr6f1aCR36+L8fqw35
         GvNtfEfrEPpjXOK1kZBHnYOZzNIPbUyrXMF8m7QcSaZGBvDJy0sDfEZaNhq5yzlhjszt
         j/tfLoBnafhQPNY5bERAHKL+goSONf5G7G6ZuK6xVE3UNiGr3W16sC29uBaW67tf7VpW
         djEAreT3OFWsaoSth/tqSXX8aQ3RWHYC4Cw30Hqi4fsGz1nfkmeAx07RfftNdWZBHuf5
         b+3JTdbKSRh9J6Afve62GjMMeBCLnxk+pKqopLfalddNCHzVoBdbdLwqGxRFUleitCoW
         YoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=e1ali+ZkeDUhB9YjAXA0DFsPI7RDWNQ1zvsqlUUHA2g=;
        b=X7FzgBpjTHdCWt3euct/UQQoDDnMmkFTHNnx9WyYKpqo6MW5gvFcYi/dQ7MF133Uv4
         YYDdidvdr5omFF3CJo13XZvUykOEQIy4ZSedT3icK4eChyVwPZtu8OJBbwjkfTVDVlbI
         j+8YeupOhPnDefpAcKWYJGpxMnRASj+H5owXx9b0p9DHM9Ua3zHHpNncLTvnoF0J3mu1
         nBryNGGUuFEsVCi6YdN5bS8sSgl/sHIeOlJNLpotJWZPotEI25X6ADG892tJXxPDPL8L
         7e5W6pOnOj2x8ZPczNp/r9+oTAeCkXPpW3GWyXxA9e19yod8JgGMl90aXutNzj8H54GG
         JiMw==
X-Gm-Message-State: AG10YORTTuW9TR/nYphh3Bv1B8kYX7ecMe/CpJIwHUOaOCTEA37imF5fXnwyFqWT6qesk+YFUKsDzns2dGQtFQ==
X-Received: by 10.31.182.143 with SMTP id g137mr20450644vkf.45.1456097468783;
 Sun, 21 Feb 2016 15:31:08 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 15:31:08 -0800 (PST)
In-Reply-To: <20160221231913.GA4094@sigill.intra.peff.net>
X-Google-Sender-Auth: Imfij7ICrp_NhpYcwafkHbk1evM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286845>

On Sun, Feb 21, 2016 at 6:19 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 21, 2016 at 04:01:27PM -0500, Eric Sunshine wrote:
>> On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
>> > -       git blame --incremental file | \
>> > -               egrep "^(author|summary) " > actual &&
>> > +       git blame --incremental file >output &&
>> > +       sed -ne "/^\(author\|summary\) /p" output >actual &&
>>
>> These tests all crash and burn with BSD sed (including Mac OS X) since
>> you're not restricting yourself to BRE (basic regular expressions).
>> You _could_ request extended regular expressions, which do work on
>> those platforms, as well as with GNU sed:
>>
>>     sed -nEe "/^(author|summary) /p" ...
>
> At that point, I think we may as well use grep, because obscure
> platforms are probably broken either way.

I came to the same conclusion but forgot to say so at the end of my message.

> I'm tempted to just go the perl route. We already depend on at least a
> baisc version of perl5 being installed for many of the other tests, so
> it's not really introducing a new dependency.
>
> Something like the patch below works for me. I think we could make it
> shorter by using $PERLIO to get the raw behavior, but using binmode will
> work even on ancient versions of perl.
>
> +filter_blame () {
> +       perl -e '
> +               binmode STDIN;
> +               binmode STDOUT;

I was worried about binmode() due to some vague recollection from
years and years ago of it being problematic on Windows, but I see
these tests are all protected by !MINGW anyhow...

> +               while (<>) {
> +                       print if /^(author|summary) /;
> +               }
> +       '
> +}
> +
>  test_expect_success !MINGW \
>         'blame respects i18n.commitencoding' '
>         git blame --incremental file | \
> -               egrep "^(author|summary) " > actual &&
> +               filter_blame >actual &&
>         test_cmp actual expected
>  '
>
> @@ -53,7 +63,7 @@ test_expect_success !MINGW \
>         'blame respects i18n.logoutputencoding' '
>         git config i18n.logoutputencoding eucJP &&
>         git blame --incremental file | \
> -               egrep "^(author|summary) " > actual &&
> +               filter_blame > actual &&
>         test_cmp actual expected
>  '
>
> @@ -69,7 +79,7 @@ EOF
>  test_expect_success !MINGW \
>         'blame respects --encoding=UTF-8' '
>         git blame --incremental --encoding=UTF-8 file | \
> -               egrep "^(author|summary) " > actual &&
> +               filter_blame >actual &&
>         test_cmp actual expected
>  '
>
> @@ -85,7 +95,7 @@ EOF
>  test_expect_success !MINGW \
>         'blame respects --encoding=none' '
>         git blame --incremental --encoding=none file | \
> -               egrep "^(author|summary) " > actual &&
> +               filter_blame >actual &&
>         test_cmp actual expected
>  '
