From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Thu, 20 Dec 2012 23:28:57 +0000
Message-ID: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
	<7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
	<CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
	<20121220153411.GA1497@sigill.intra.peff.net>
	<CAOkDyE9y6JvNKTCBoJqu47Hn-3axfjZPUdBhf4bOEfSP-9Q84A@mail.gmail.com>
	<20121220161110.GA10605@sigill.intra.peff.net>
	<7vy5gs4jiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:29:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlpYM-0006La-9m
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 00:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab2LTX3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 18:29:00 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56314 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab2LTX26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 18:28:58 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so2366107wib.9
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 15:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=GDjX6guYSqTzGYzmUnBBfjLCOwBEdFJmKgvSydCo7/Q=;
        b=G/5rxm6HIrdEewk31FkhOzyBmL/BS1id/4Ra1hFepT+IqG1iMXsUBQu+Gb/k44XC97
         SWYYddWU5mB5iDJUQZjuG3UUeMXypUUuFyv9rG6LFan3ppQachSAtTaDvdJyI2q3DJoK
         +pW2MXec2WM4mznWqNLTS3X2MqEYFi8WheNg1Do/zA1NCDOuvQe1DTJnwE3TV2PMhwbl
         MD3bxeHtQKfX7xW+zNU6WaGb8oqKmD2fImwxNbO0d0FFO+gZlakts4Af36v4TVTXt7le
         cqqWN0y5gL2bMf8vZNoGrgu76uzjw8qylWMJOMSdAGETooIZAD/IzFMTEMb5wzLwJf0z
         5LJQ==
Received: by 10.194.88.98 with SMTP id bf2mr20374641wjb.49.1356046137303; Thu,
 20 Dec 2012 15:28:57 -0800 (PST)
Received: by 10.194.56.232 with HTTP; Thu, 20 Dec 2012 15:28:57 -0800 (PST)
In-Reply-To: <7vy5gs4jiy.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: NoQNw_ryvxWxey4hD_01eLYLjF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211936>

On Thu, Dec 20, 2012 at 7:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>>> Good point, I forgot to check what it looked like with -v.  Since this
>>> series is already on v6, is there a more lightweight way of addressing
>>> this tiny tweak than sending v7?
>>
>> It is ultimately up to Junio, but I suspect he would be OK if you just
>> reposted patch 4/7 with the above squashed. Or even just said "I like
>> this, please squash it into patch 4 (change info messages from
>> yellow/brown to bold cyan).
>
> Surely; as long as the series is not in 'next', the change to be
> squashed is not too big and it is not too much work (and in this
> case it certainly is not).

OK.

> I actually wonder if "skipped test in bold blue" and "known breakage
> in bold yellow" should also lose the boldness.  Errors and warnings
> in bold are good, but I would say the degree of need for attention
> are more like this:
>
>         error (failed tests - you should look into it)
>         skip (skipped - perhaps you need more packages?)
>         warn (expected failure - you may want to look into fixing it someday)
>         info
>         pass
>
> The "expected_failure" cases painted in "warn" are all long-known
> failures; I do not think reminding about them in "bold" over and
> over will help encouraging the developers take a look at them.

As Peff already noted, on many (most?) X terminals "bold" colours are
just brighter colours, rather than a heavier typeface.  How bold they
look is therefore dependent on the colour scheme used by that
terminal.

> The "skipped" cases fall into two categories.  Either you already
> know you choose to not to care (e.g. I do not expect to use git-p4
> and decided not to install p4 anywhere, so I may have t98?? on
> GIT_SKIP_TESTS environment) or you haven't reached that point on a
> new system and haven't realized that you didn't install a package
> needed to run tests you care about (e.g. cvsserver tests would not
> run without Perl interface to SQLite).  For the former, the bold
> output is merely distracting; for the latter, bold _might_ help in
> this case.

Very good point.

> At least, I think
>
>         GIT_SKIP_TESTS=t98?? sh t9800-git-p4-basic.sh -v
>
> should paint "skipping test t9800 altogether" (emitted with "-v) and
> the last line "1..0 # SKIP skip all tests in t9800" both in the same
> "info" color.
>
> How about going further to reduce "bold" a bit more, like this?
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index aaf013e..2bbb81d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -182,13 +182,13 @@ then
>                 error)
>                         tput bold; tput setaf 1;; # bold red
>                 skip)
> -                       tput bold; tput setaf 4;; # bold blue
> +                       tput setaf 4;; # bold blue

The comment still says "bold".

>                 warn)
> -                       tput bold; tput setaf 3;; # bold brown/yellow
> +                       tput setaf 3;; # bold brown/yellow

Ditto here ...

>                 pass)
>                         tput setaf 2;;            # green
>                 info)
> -                       tput bold; tput setaf 6;; # bold cyan
> +                       tput setaf 6;; # bold cyan

... and here.

>                 *)
>                         test -n "$quiet" && return;;
>                 esac
> @@ -589,7 +589,7 @@ for skp in $GIT_SKIP_TESTS
>  do
>         case "$this_test" in
>         $skp)
> -               say_color skip >&3 "skipping test $this_test altogether"
> +               say_color info >&3 "skipping test $this_test altogether"
>                 skip_all="skip all tests in $this_test"
>                 test_done
>         esac

Yes, I like this last hunk especially.

I have no objection in principle to a reduction in boldness.

However, I am beginning to get disheartened that at this rate, this
series will never land.  I already submitted v4 of the series which
already had non-bold blue.  I then received feedback indicating that
bold blue would be more suitable, so despite alarm bells beginning to
ring in my head, I submitted v5 with bold blue, declaring that that
would be my last version:

  http://article.gmane.org/gmane.comp.version-control.git/206042

A further concern about "info" messages not being blue prompted me
to attempt to canvass more opinions:

  http://article.gmane.org/gmane.comp.version-control.git/209321

I received none, so submitted v6 based on my best judgement.  Now we
are talking about a potential v7 going *back* to non-bold blue.  I can
submit v7 if you think it's worth it, but would that really be the end
of the discussion?  It's clear from the above that colour scheme
design by committee is about as good an idea as asking a bunch of kids
to reach consensus on their favourite colour ;-)

So if possible I'd be very happy for Junio to simply make an executive
decision (I don't care which way, as long as it fits the traffic
lights scheme and uses distinct hues of blue/cyan for the different
categories of skip/info messages), tweak the latest v6 series
accordingly, and then push so that we can all go back to more pressing
things ;-)

Hopefully that is a reasonable way forward?

Thanks,
Adam
