Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D933A2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 20:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbcGMUOg (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 16:14:36 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33013 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGMUOe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 16:14:34 -0400
Received: by mail-vk0-f51.google.com with SMTP id x130so81689695vkc.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 13:14:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JtDrK+bG8Z/cRHxCyxLiNyC+lw0rkKLZsYrHRO3TWis=;
        b=S4zo8iXSlx7TS88+FvrnHjzXonW4mIvZBr9sGp23Ugb0EZpcPNCsS53zRgDuMlNoCN
         TrOs06K3V+qqW7rThwSYnLghHWCbCylXSjm4H7n2yIS7l9mCLQFAGRX0SAXuhYrNrKjw
         5itkZvhUxlOjBBA0r1pRhqP5fZyWfEHSlD9lOnaXgx+8iCG8I+5i+hq61Sib6OEBjU5S
         tUo8XvDeDYsiZE2e/19ZXBcRQx1PR5PP1YCuuS1PpMHYR3bfafBvtmUquoaq8cGcFty9
         69zXB3KkfNVFi4CejV58zDszKgIDV3PxwOo2ZomccW+woGguzjEkrKrxi+Am3C22Ddb1
         LvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JtDrK+bG8Z/cRHxCyxLiNyC+lw0rkKLZsYrHRO3TWis=;
        b=IY5qjgnsremA4bYxbgUhbXlk7Ou+rrWyK5+T0bkP8QzkjQ293nA8yH54pfV5zdamP1
         g8epn/LGczNbAveC+IhMZ8kblfzRSH03rm07lYpG5UrU0q3TYJnvSGkbduPKhHdxKLFv
         uMwEoLmJoTL0jlYLxGeCcU2B+kpHLqauLUbZ5o5z5kmruQRQC8nabkhYtrWy0jy/q7uh
         Jhjdm9P783yJmGypnTMfZWEvh8GZ8gHmakWLLavTUPEtuA95x+Sv2z09n4DmTumOm1zF
         +8FRJMyq6MmaGnCUpl+E53gGkXf0oPTvj//S/3CnDNV0a1zT1OEXZtEGaHdAVfsLj+1x
         yIlw==
X-Gm-Message-State: ALyK8tJs2VHfnhDAuBzHBDtrVwxcxwbjmimQ0L1Pt7zOgln1DgH7xLuK/xy1R0kWtOsKLuxFtk3PsUnGslAwlA==
X-Received: by 10.31.75.67 with SMTP id y64mr4790318vka.40.1468440868753; Wed,
 13 Jul 2016 13:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.65.5 with HTTP; Wed, 13 Jul 2016 13:14:09 -0700 (PDT)
In-Reply-To: <xmqqlh151lst.fsf@gitster.mtv.corp.google.com>
References: <CAFgjPJ-E0k8KQjdcRki4Qr1tPjwfJVtuFWOKYV-+f6POgb-=wg@mail.gmail.com>
 <xmqqtwft1nbi.fsf@gitster.mtv.corp.google.com> <CAFgjPJ-E=eW_ZiAUf2jKu6z3WfW_p+BMbEJwf=OSGUXQB78kwQ@mail.gmail.com>
 <xmqqlh151lst.fsf@gitster.mtv.corp.google.com>
From:	=?UTF-8?B?SmVoYW4gUGFnw6hz?= <jehan.marmottard@gmail.com>
Date:	Wed, 13 Jul 2016 22:14:09 +0200
Message-ID: <CAFgjPJ_er6QCaYenU=10_935HoKbc=8hqbJku5p6kF2BYkSrjw@mail.gmail.com>
Subject: Re: Bug report: --invert-grep and --author seems to be incompatible.
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Wed, Jul 13, 2016 at 7:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jehan Pagès <jehan.marmottard@gmail.com> writes:
>
>>> I think --author=someone greps the "author " field in the commit
>>> object looking for the hit with "someone", and your request asks to
>>> show commits that either do not have "something" or was not written
>>> by "someone", I would guess.
>>
>> Note that I can still see commits with "something", and I can also see
>> commits by "someone" in my results. So my request actually ask for
>> commits which have neither "something" nor are done by "someone".
>>
>> Anyway I don't think that's the expected result, hence is still a bug.
>> Am I wrong?
>
> Unlike "git grep", "git log" works with boolean expression that does
> not explicitly have a way to say "--and" and "--or", so only one
> interpretation has been chosen long time ago.  All the terms are
> ORed together, and then the whole thing can be inverted with
> "--invert-grep".  i.e. you are telling an equivalent of
>
>     $ git grep --not \( -e "author someone" --or -e "something" \)
>
> with the command line, and there is no way to combine the requested
> match criteria (there are two, "author must be somebody" and
> "something must be in the message") differently.
>
> Given that, that is the "right" expectation, and as long as you get
> the behaviour, there is no "bug".

I see. Well it's a little counter-intuitive though, since the option
is called --invert-grep. And the man indicates:

« Limit the commits output to ones with log message that do not match
the pattern specified with --grep=<pattern>. »

So it gives the impression that the option is made only to invert the
--grep part. Whereas in fact, you are saying it inverts any other
optional selection (or at least also --author). A better naming should
have been called --invert-matches, or even just --invert.
And the man description should definitely be completed, IMO.

> You can call it a lack of feature, though, and patches to implement
> a more flexible combination of match criteria like "git grep" allows
> is always welcome.

Maybe I will! This would be useful to have a little more capabilities
for commit selection.
Thanks.

Jehan

-- 
ZeMarmot open animation film
http://film.zemarmot.net
Patreon: https://patreon.com/zemarmot
Tipeee: https://www.tipeee.com/zemarmot
