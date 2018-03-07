Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A13E1FAE2
	for <e@80x24.org>; Wed,  7 Mar 2018 09:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbeCGJgK (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 04:36:10 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33166 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeCGJgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 04:36:10 -0500
Received: by mail-qk0-f179.google.com with SMTP id f25so1856882qkm.0
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 01:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eETLiuYE4XQmJ44F63HK+IKyql2fuwLPNMKWRzvcvGw=;
        b=N7Ay2NFa8kcROzCcHPK4GGy9rKZxOnnPQWB9onJSfvvYNxynoSLavJf3RgG6z3pJvd
         QO1ZKT83nWZPwOdWZLymis+1deoACBrpO7d02o4q1Tf2Mkxmu+PpCq2z7UWSKAFftibV
         evsGgGK618avWvaIbPrsuA/nR610WzoKg7hOvWUCwQu6jpSIoVy6oaBtnBIJZcwjdXbK
         ae1dqJLRDMnP2RAHxW5ZTu0x9kPA5RdmpQmnluLqNx1j9xO868HCm7fSZdu77OPF1h8v
         /+e1Mc6H6Mxx7MdxPMeitzev/savgDLrTd9koLzqcPhz8mailBBR3EGguJMZwTIR3wZ/
         iwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eETLiuYE4XQmJ44F63HK+IKyql2fuwLPNMKWRzvcvGw=;
        b=RuiuflBE+029mtp7pizySKF5GMHp4YT1iAlh94J6sBhKD5BQtkrFP0qargE2tO4Dr/
         ZDkrLHl0eySF4cz5kfR4sJhVVTFSoC5DB1TJb6qhXeunfCdTMa95KKAbRE4Ghq7IYCTM
         PHuVmZ+uD+yU+lCucK/pvLIh7DAIYuMlZ2EDbPxfkLvH93ZsSfGTySdPfnD9Xzf+w/Vh
         ygNHGXD2DraFtq/WqRbQLEXFEyEgm1+nmEqjNDZkOj11feK6RpIukq/8+zmP32rEd1Cr
         c4/eqba/Na1Xm6L2sLqXRDyq6UJOh5WsOylWBzyMRoWGP6OBvFlbtJv2U7ic8potWW0i
         Scxw==
X-Gm-Message-State: AElRT7Fry5wHPytsZFY31DbHaQ5lief+SrAGFuZDjfbG/O6znyiutGMm
        roDYPn7wrBA5cgrkqnN5bE2h1TdHNbtkpU6HlA3udQ==
X-Google-Smtp-Source: AG47ELvhr6ETjE5CaON16M60NwLVsCdgbzRgIsWfkwFtZyIhc60bYXZzWS641jbkJZTxppaQBnPkGswCm5uWLGci5uw=
X-Received: by 10.55.134.133 with SMTP id i127mr32918843qkd.275.1520415369341;
 Wed, 07 Mar 2018 01:36:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Wed, 7 Mar 2018 01:36:08 -0800 (PST)
In-Reply-To: <1520370729-sup-3241@x1c>
References: <1520337165-sup-4504@x1c> <CAPig+cRYsf161-Xomw7daj8XdEBxZAEQQRdOn4krRTpSAFkPOw@mail.gmail.com>
 <1520370729-sup-3241@x1c>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Mar 2018 04:36:08 -0500
X-Google-Sender-Auth: QOxy-rAYEIvQMAcgzf4VULx95wA
Message-ID: <CAPig+cToTv063z-HB=8Y9LkpbqQaKCVJG_nU0Qd7O9ZdJY-p6g@mail.gmail.com>
Subject: Re: [PATCH] xdiff: improve trimming preprocessing
To:     Jun Wu <quark@fb.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 6, 2018 at 6:05 PM, Jun Wu <quark@fb.com> wrote:
> Excerpts from Eric Sunshine's message of 2018-03-06 14:23:46 -0500:
>> On Tue, Mar 6, 2018 at 6:53 AM, Jun Wu <quark@fb.com> wrote:
>> > +  printf "x%.0s" {1..934} >>d # pad common suffix to 1024 bytes
>>
>> The expression {x..y} is not portable to non-POSIX shells.
>
> Is there a recommended way to generate a repetitive string?
> Maybe `seq 1000 | sed 's/.*/x/'` ?

That seems reasonable, although you'd want to use the test suite's
more portable test_seq rather than seq.

>> > +       /* prefix - need line count for xecfg->ptrimmed */
>> > +       for (i = 0; ++i < smaller && *ap == *bp;) {
>> > +               lines += (*ap == '\n');
>> > +               ap++, bp++;
>>
>> Is there a good reason for not placing 'ap++, bp++' directly in the 'for'?
>
> "lines += (*ap == '\n');" needs the "ap" before adding. Alternatives are
>
>     for (i = 0; ++i < smaller && *ap == *bp; ) /* 1 */
>         lines += (*ap++, *bp++) == '\n';
>
>     for (i = 0; ++i < smaller && *ap == *bp; ap++, bp++) /* 2 */
>         lines += (*(ap - 1) == '\n');
>
> Maybe will pick /* 1 */ to make the code shorter.

I was thinking specifically about #2 when asking the question. The
reason I asked is that, as one reading the code, the
not-quite-idiomatic loop made me stop and wonder if something special
was going on which wasn't obvious at a glance.

And, apparently, I'm still wondering since I'm not groking what you mean by:

    "lines += (*ap == '\n');" needs the "ap" before adding

It's quite possible that I'm being dense and overlooking something
blindingly obvious.
