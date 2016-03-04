From: Christian Couder <christian.couder@gmail.com>
Subject: Re: t9700-perl-git.sh is broken on some configurations
Date: Fri, 4 Mar 2016 11:30:36 +0100
Message-ID: <CAP8UFD3jZ2b8jgw8dR0U=AkPTTm5nO1F92UVjyeAMsfiOaJ_5w@mail.gmail.com>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
	<20160304085649.GA29752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 11:30:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abn0Q-00029p-Q7
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 11:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758851AbcCDKal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 05:30:41 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34445 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbcCDKai (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 05:30:38 -0500
Received: by mail-lb0-f180.google.com with SMTP id cf7so39663932lbb.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5dniU9663uXTxXr6fVJoQ6qN6wOwBeou7Yl7OUZ+xlY=;
        b=VSxIcf+kmRafgmm1ncXHYPHzkHyLtfZR/j68YSXoFZAfrt/1msKjz1pk0+VyTrwqbY
         vzJOq5BeFHNR6+z9zGD2mEibdY2H5HM9W7piDitpVRSn4KC8kGfil+9/dWGzz+JjWsjx
         YbK7aVV9FiEdiZmrH5XWZQpBZ9YUcrgln46C025VRQ3064Gy96B0s8Hta9iZwEX8MrcU
         Ow226fduNQjdoD2EH8Ty4UYPdORU53jMagMk7Ee0lBWvy44YVFxXxO+ZG89FYGKS4wBU
         68sjgEumEdP2P5BMBxnA8JGHxGylE6cdT1ZdvoN8+rx7VNMO7ExXjaISlhuN5bxjYTlV
         U7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5dniU9663uXTxXr6fVJoQ6qN6wOwBeou7Yl7OUZ+xlY=;
        b=hkg+AKa0EGZ9xAFd4HptTXtmGNMTKlfcAU2SSnw8ZfDj56VKF8hU0MdAXi59sy8ni4
         eyGLX+EBZuLbJPLa7MhX1rBZzTIZYseECFjhd/j7xJyRsyMIHfc31NOtTjDW0959+zTe
         sDS0yWpfuPsQTyDmQVooi0XBsI8JOu9X0ttQvOLAs+ZLVqc2EM+PiLhyKbxN4FsPOnrD
         Nc4J6Fo5aKRHXGi0JvPRmgLyvwukf6OVxP5Xe1HnIlsV76ytdlGTheBhbB5tvhgoG1HB
         h36hPdbOZhm/mTjVaAoCuq6Nh9IKghu3/sSGxvmTCZdP0p2GB1GcT6r4I4KmMjJLNG82
         PnnQ==
X-Gm-Message-State: AD7BkJLxye4UHE6mQDzyX49WLV5lOEjwfTitST8dToJp2Gnk6N3WYkbhhBykkFKmeChz2TfU+10F/UrIluX2EQ==
X-Received: by 10.25.163.199 with SMTP id m190mr2720758lfe.7.1457087437040;
 Fri, 04 Mar 2016 02:30:37 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Fri, 4 Mar 2016 02:30:36 -0800 (PST)
In-Reply-To: <20160304085649.GA29752@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288241>

On Fri, Mar 4, 2016 at 9:56 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 04, 2016 at 09:13:51AM +0100, Christian Couder wrote:
>
>> Indeed on the command line I get:
>>
>> ------------------------
>> $ t/t9700/test.pl
>> ok 2 - use Git;
>> Bareword found where operator expected at t/t9700/test.pl line 36,
>> near "s/\\/\//gr"
>> syntax error at t/t9700/test.pl line 36, near "s/\\/\//gr"
>> Execution of t/t9700/test.pl aborted due to compilation errors.
>> ------------------------
>>
>> A quick look at t/t9700/test.pl line 36 was not enough for me to spot
>> the problem.
>>
>> Perl version is: perl 5, version 18, subversion 2 (v5.18.2) built for
>> x86_64-linux
>>
>> The machine is running CentOS 6.5.
>
> I can't reproduce on any of the machines I have handy (perl 5.14, 5.20,
> and 5.22). I don't have 5.18 handy. The line in question looks fine to
> me, so perhaps it is a temporary regression in 5.18.

It is strange because on the same machine there is also v5.10.1
installed and I get the same error with it.

> Does it help to wrap it in parentheses, like:
>
> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> index 7e8c40b..edeeb0e 100755
> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -33,7 +33,7 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
>  is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
>  ok($r->config_bool("test.booltrue"), "config_bool: true");
>  ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
> -is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
> +is(($r->config_path("test.path") =~ s/\\/\//gr), $r->config("test.pathexpanded"),
>     "config_path: ~/foo expansion");
>  is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
>     "config_path: multiple values");

No, parentheses don't help.

> or even write it out longhand without "/r":
>
> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> index 7e8c40b..52471cf 100755
> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -33,7 +33,9 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
>  is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
>  ok($r->config_bool("test.booltrue"), "config_bool: true");
>  ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
> -is($r->config_path("test.path") =~ s/\\/\//gr, $r->config("test.pathexpanded"),
> +my $test_path = $r->config_path("test.path");
> +$test_path =~ s/\\/\//g;
> +is($test_path, $r->config("test.pathexpanded"),
>     "config_path: ~/foo expansion");
>  is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
>     "config_path: multiple values");
>
> ?

Yeah, it works like the above with both perl versions.

> Those are just guesses, but if we are tickling a bug in perl's parser,
> this might avoid them. I also wondered when "/r" appeared. It was in
> 5.14, so you're presumably good there.

If I just remove the "r" at the end of "s/\\/\//gr", I get with both
Perl versions:

Can't modify non-lvalue subroutine call at t/t9700/test.pl line 36.

> The "use" statement at the top of
> the script says "5.008", so perhaps we should be writing it out longhand
> anyway (that version is "only" 5 years old, so I suspect there are still
> systems around with 5.12 or older).

Yeah, it would work.

Thanks,
Christian.
