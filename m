Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4431C202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 07:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdJ1HqB (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 03:46:01 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:53568 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdJ1HqA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 03:46:00 -0400
Received: by mail-wm0-f48.google.com with SMTP id r196so7335115wmf.2
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vqX3y6cQCDDV8hiMg1rMqDvdlW6QytoTXZjz1oFahrc=;
        b=YOYJXJYZvIUJwmN6Pe2ksELBfo1y6T9hs2jZXIM2e+WsS7+CktHd/+PHg4P3qc+fGB
         WUxQyIssrAcecxMyEbRyM89m2XM//5OoTPpkgAD/mpVKad4eLACijcK4IyBXjoI+0dZo
         yiFzcBsYZuC/+b2vWftRS8KD+EhfUTxNI5lbc8CVTXrt+n9VmMTwwVBPEjKCUy0xOzPE
         n0oAYQ1t/V8XIKUadalTZr6oltuqzJakLhxfuHC6PYHrBDoRNmFAFhxp/tvukqN9xOZx
         poGr8obNZo0KGli1DwKvbdYGnW34CRK8pyGiQH+2wNBSfcppy50CbYaVi9GqWCgkUSy4
         7Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vqX3y6cQCDDV8hiMg1rMqDvdlW6QytoTXZjz1oFahrc=;
        b=JkiF4+WMwItMATzecQiSu7nQF+oru3NN+bTR7Mk1qWRigpeFUmu2RaZIQirj0EOUc/
         vOJUid6P59To/eOSA+B1aQqUAehTJLIDlW5bTzRNhuVffj1u9FkJ+rrZX1Ye0zxxssAu
         A31IMg+IUulJ62g/GPiK9RweUE13KMRtwVd0R0U0rek/aqA0faEotdkT3Qvn7fjHpgeY
         tJ3X5Pn1tZnjrZdHbfXtlCXTRKrUW0vl8sDDyskZVDQadYL9HSDueVUeGZ1+fQIdfm0r
         liSLGeEV+6LvJXjk3LjdTZYQcCUQCLfkNCaLVfD7VqHZ8UCHrWRKEzsRtdCE4WsCihIc
         p9rA==
X-Gm-Message-State: AMCzsaXHU0tBQl/GZTj2cznOY15lN6kC096dCamsgkTKtvIREZnPENUh
        8dPGPrpDxPQ2mxpdwNNC+dk=
X-Google-Smtp-Source: ABhQp+Tz6m1adxeXT0zsgsfSbCZywobi5skhxJ2IAF3hv1NE8Y6DIRliQYvxxZQFSZqCPGPWP+dvmw==
X-Received: by 10.80.173.37 with SMTP id y34mr3634572edc.193.1509176759552;
        Sat, 28 Oct 2017 00:45:59 -0700 (PDT)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id e56sm7055904edb.72.2017.10.28.00.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Oct 2017 00:45:56 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1e8LoZ-0001en-9n; Sat, 28 Oct 2017 09:45:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: grep vs git grep performance?
References: <1509030170.10651.59.camel@perches.com> <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com> <1509039696.11245.9.camel@perches.com> <CAGZ79kYWPunzZ2u=MtCoCadxXu_4etEK5DYnhYXo+CgeHrXQwQ@mail.gmail.com> <1509124942.1914.9.camel@perches.com> <877evgxmu7.fsf@evledraar.booking.com> <1509146542.1914.19.camel@perches.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1509146542.1914.19.camel@perches.com>
Date:   Sat, 28 Oct 2017 09:45:55 +0200
Message-ID: <8760azyato.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 27 2017, Joe Perches jotted:

> On Sat, 2017-10-28 at 00:11 +0200, Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Oct 27 2017, Joe Perches jotted:
> []
>> > git grep performance has already been
>> > quite successfully improved.
>>
>> ...and I have WIP patches to use the PCRE engine for patterns without -P
>> which I intend to start sending soon after the next release.
>
> One addition that would be quite nice would be
> an option to have regex matches span input lines.
>
> grep v2.54 was the last grep version that allowed
> this and I keep it around just for that.
>
> ie:
>
> $ cat hello.txt
> Hello
> World
> $ grep -P "Hello\s*World" hello.txt
> $ grep-2.5.4 -P "Hello\s*World" hello.txt
> Hello
> World

I'm unable to build 2.5.4 and can't find anything relevant in the
release notes at a quick glance around that time saying that this would
be removed, if you can still build it I'd be interested to see what this
bisects down to in grep.git.

But aside from that, a feature like this constrains the regex
implementation a lot since it's going to need to either match the entire
file as we'd need to do with PCRE, or we'd need to really deeply embed
the core logic of the regex matcher into our grep implementation.

I.e. in this case a more optimal implementation would start by parsing
this regex down:

    ((EXACT "Hello")
     (STAR (POSIXU "\s"))
     (EXACT "World"))

Then when you open the file you can start searching for the fixed-string
"Hello", if you don't find that you're done, if you do you can forward
look-ahead for the fixed "World", and only if you find that do you need
to match the more complex part in the middle.

Whereas our API for the internal regex matchers now is that we find the
boundaries of newlines and batch-match a bunch of lines with a match()
function that takes a string, and if that matches we drill down to what
specific line matches.

Which is not to say that this can't be done without a potentially
unacceptable memory trade-off (i.e. matching the entire file in all
cases), the PCRE2 engine in particular includes some I/O abstractions
that we're not using but could (but I haven't looked into it).

But right now the entire internal API we have is constrained by catering
to the lowest common denominator (a regexec that takes a char*), so
supporting more fancy multi-line matching features can be a PITA since
we'd need to maintain both codepaths.

Or we could make PCRE a hard dependency, which given the performance
advantages I'm increasingly willing to make the case for.
