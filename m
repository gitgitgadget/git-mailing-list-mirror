From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 16:57:00 +0100
Message-ID: <CAHGBnuMDCYePJyEU4yHjGjEzyZn8mRBE73WC3qsRqbb6Amhyog@mail.gmail.com>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
	<20160210125429.GA8078@sigill.intra.peff.net>
	<CAHGBnuMMN_xEVDJ_dqWgL6QCGK08hy=ggg=6PzkSCinHr=QeFg@mail.gmail.com>
	<20160210154006.GA19867@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 16:57:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTX8d-0006sr-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 16:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbcBJP5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 10:57:03 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36270 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbcBJP5B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 10:57:01 -0500
Received: by mail-vk0-f68.google.com with SMTP id k196so1265525vka.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HtDR5eqfZbszq3o0wvNCS5w7zncjojy0D/h1zTZiFaM=;
        b=pFTy5SbvH3WwdVInwxX3dGPw/OgaQTRw3Psb67n3ko561fScCOvM3D0Her9NLGbJ46
         VuhFaJbUoZGrafxDMeNr7QEHyol06gWnoZnVhqabBlGVw+i37TD/Y1l3Kd0glDpQwgww
         H6Q9cQju+yRXq9jQigHw7uI9k9ur0l4f4JPXFiIIUhnFp2ZUIM/qCFcLICShamKUnij/
         u9KYDrdvyuoeJbx9QwDhRjIlcRzwUhlfdsaF8mRSSwjcxCdFi9JNKBge0KDA62eiIRbY
         NsHRIZEMnH/rsdMABT9OE4ilq2CBGKhT56L5dBq/0IrJNTW2FcNtDXf1+AWWPP2TKkJr
         tncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HtDR5eqfZbszq3o0wvNCS5w7zncjojy0D/h1zTZiFaM=;
        b=VNr/hDeh2GlV0l/LoiZm68JlV1ZqDdIChY78rQ8V6uHT9oLAajW22fyKVHXqkzrzHZ
         SF2EpLvb4VOjfO9GGJOxWydiVoJuxoxuTxKufP2QIyjYHmCX6FCWJjCHK8x8bG9ewpbq
         073AlZA80t58Jt595toJ3cQq7amh8A+/INZ3X9iPmK+iY0x2fjGFPq2z016NF9QPEp9i
         HJKyvuQDGyWwVB6lQE85eMt539NAedH05UHx+DHTHmf5avNsG8CItl+sEhRV9KnqWFSC
         5EOnga1jXqXUNhcAm7WVfpCq7sFLRgv+5qanKhc78yXPRJxzm41yp1y+z5PYnbgO6EUJ
         TluQ==
X-Gm-Message-State: AG10YOQghuHy+VZQ3wVIWBkQqpV6hMJX4hm5F6FL/V3qqh491NrMqbgE+C2qXWSKijJSjenvpyCcSw/0JhjlTg==
X-Received: by 10.31.49.138 with SMTP id x132mr30755894vkx.33.1455119820647;
 Wed, 10 Feb 2016 07:57:00 -0800 (PST)
Received: by 10.176.68.6 with HTTP; Wed, 10 Feb 2016 07:57:00 -0800 (PST)
In-Reply-To: <20160210154006.GA19867@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285906>

On Wed, Feb 10, 2016 at 4:40 PM, Jeff King <peff@peff.net> wrote:

>> >   file:<filename>\t</value...>
>> >   blob:<blob>\t<value...>
>> >   stdin\t<value...>
>> >   cmd\t<value...>
>> >
>> > with a single delimited slot for the source, which can then be broken
>> > down further if desired.  I can't think of any reason to prefer one over
>> > the other rather than personal preference, though. They can both be
>> > parsed unambiguously.
>>
>> I also would have expected sopme like the latter, except that I'd also
>> expect a colon after "stdin" and "cmd" (or "cmdline", as said above).
>> I.e. the colon should be part of the prefix to mark it as such.
>
> Yeah, I waffled on that. Having a colon means you can definitely parse
> to the first ":" without looking at what the prefix is. But if you don't
> know what the prefix is, I don't know what good that does you. IOW, I'd

IMO that's asking the wrong question. The question should not be "what
good does it do if we add the colons also there", but "what
justification do we have to introduce an inconsistency by not adding
them".

> That's perl, but I think most languages make prefix-parsing like that
> easy. I dunno. I doubt it matters all that much, and we are deep into
> personal preference. There's already plenty to bikeshed on the option
> name :)

I agree the option wording mostly is personal preference. On the other
hand, I find discussions like these often prematurely waved aside as
bikeshedding, just because e.g. Perl can parse the one as good as the
other. But it's not about Perl, it's about humans. IMO Git has
historically made many mistakes by not caring enough about consistency
in docs, command and command line option naming, so I don't see it as
wasted time to discuss about things like this.

-- 
Sebastian Schuberth
