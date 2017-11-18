Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8D4202A0
	for <e@80x24.org>; Sat, 18 Nov 2017 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762182AbdKRJIm (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 04:08:42 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36414 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdKRJIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 04:08:38 -0500
Received: by mail-qt0-f172.google.com with SMTP id a19so9672703qtb.3
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=At2qW9XZOOsrhZZA0mKm7CRetYMLKNDqnJ9h4QZ7MPI=;
        b=TFGmWeuhXvCiPSavC2NvWtx1MnVoKn+N/Qfr84Jr6X1lODKRKNSCQDushW5NlyCbND
         Ky6xPZp7ERw9lPQjKg+N+IfsEjsQ3lqTM7h0WDyxJDOJsYt6sMnsmnZKb54KeCWrT1mB
         JF+gYaZIgxXDKG9gWmQZ3cyM9JE1iNYtAeE2veT8ihmtKA3zFsRMV4lfmacBedli1HPi
         M497ACNCIWf/CVhOMkpfzjPh/q6xx6XcR3eeLBUHH1AONX70iEjyeqNjXU10DpalHUg6
         eb6rTzYhnBqexQqbDHq4iF+e9W2cMN9pJxXYoGfyacAHqyzXekZCOKOVYJbrSiOmyAzS
         /hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=At2qW9XZOOsrhZZA0mKm7CRetYMLKNDqnJ9h4QZ7MPI=;
        b=nSUWLd7/y2fvNuZxdiYd1SG8Ei+BkYbwb6vqGvZlMZCus9QoXQ4l55bHmBdfqRHQOI
         XcF89p5Hp6Fa8B42RO/pjmHrAD9PvGdV4IR3m6hojxXO10ZfieJTc8pkGOETLerHEfpd
         vkidskY1SFrrACogcY029L2t2T6CRX4XOYbLUVjwwYETatNB1kLKrH80x3NcAsuFFIg2
         aQm4Xky7FQ3TEW8vwtr7z3NN4vuBpdttF8MaQwi4Tzt5Q1zrW2udNyDnALTekXS4PL5Q
         m0eid1NP+QE0e15R1ou6kDYD0oW5grjCPEOJEI+cj2H+2ZL5xVTibdiOGbbevb7g+j7r
         srkA==
X-Gm-Message-State: AJaThX6sYneAQk/YpLgJAghMS2aKQzAuiJyCFJbrGIM97Vurd0Ch/ADo
        4i3knDzRZEu1IqNxBdBACcIHJqhtQzMFOnUqtFY=
X-Google-Smtp-Source: AGs4zMbFyfz5g3wTmCG1vHAhtfxcqqluQthPxl+seHT9NH0cshMGCq9uGa0yxLjncFKabhWXX6bzqBqp2mK7fC6Hvvw=
X-Received: by 10.200.51.185 with SMTP id c54mr13436497qtb.54.1510996117823;
 Sat, 18 Nov 2017 01:08:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.54.4 with HTTP; Sat, 18 Nov 2017 01:08:37 -0800 (PST)
In-Reply-To: <xmqqmv3kow92.fsf@gitster.mtv.corp.google.com>
References: <CAC2Jkr+brEKLy-z45WwP2iqssA14na9xpaCoKrNKbPcTvtUxJA@mail.gmail.com>
 <xmqqzi7kp7j2.fsf@gitster.mtv.corp.google.com> <CAC2JkrLWVEHvV7tf24bPmVEDpgnrKTFtHR5UHMh+kC8v_fWumA@mail.gmail.com>
 <xmqqmv3kow92.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Sat, 18 Nov 2017 18:08:37 +0900
Message-ID: <CAC2Jkr+TkqnZ+rZVxZNv80rpJHf-BBNZqXZqW+hBVZ8hRrPRSw@mail.gmail.com>
Subject: Re: Is it not bug git stash -- <pathspec> does not work at non-root directory?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I upgraded the version of git from 2.13.1 to 2.15.0 on Mac and fixed my iss=
ue.
Thanks.

2017-11-18 16:56 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> =E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiueogawa217@gmail.com> writes:
>
>>> Please make it a habit (not limited to when interacting with
>>> _this_ project) to state a bit more than "does not work";
>>> instead, say "it is expected to do X, but instead it does Y, and
>>> the difference between X and Y I perceive is Z".
>>
>> Thanks. I'll rewrite the issue.
>>
>> Assuming that we have sub/something and something is not included anywhe=
re else,
>>
>>         cd sub && git stash -- something
>>
>>  is expected to make a stash for sub/something but instead returns error=
 like
>>
>>         error: pathspec 'something' did not match any file(s) known to g=
it.
>>         Did you forget to 'git add'?
>>
>> .
>>
>> I don't know what I should write about 'the difference between X and Y i=
s Z'.
>
> If the difference between X and Y is obvious there is no need.
>
> I just tried it and I do not see the command is broken in the way
> you describe.
>
> Trial #1 -- the command fully spelled out.
>
>     $ git.git/master: cd Documentation
>     $ Documentation/master: echo >>Makefile
>     $ Documentation/master: git stash push -m "doc-make" -- Makefile
>     Saved working directory and index state On master: doc-make
>     $ Documentation/master: git stash show --stat
>      Documentation/Makefile | 1 +
>      1 file changed, 1 insertion(+:
>
> Trial #2 -- lazily issue the command without subcommand.
>
>     $ git.git/master: cd Documentation
>     $ Documentation/master: echo >>Makefile
>     $ Documentation/master: git stash -- Makefile
>     Saved working directory and index state WIP on master: 89ea799ffc Syn=
c with maint
>     $ Documentation/master: git stash show --stat
>      Documentation/Makefile | 1 +
>      1 file changed, 1 insertion(+:
>
> Trial #3 -- make sure having files with the same name is not hiding any b=
ug.
>
>     $ git.git/master: cd Documentation
>     $ Documentation/master: echo >>CodingGuidelines
>     $ Documentation/master: git stash -- CodingGuidelines
>     Saved working directory and index state WIP on master: 89ea799ffc
>     $ Documentation/master: git stash show --stat
>      Documentation/CodingGuidelines | 1 +
>       1 file changed, 1 insertion(+)
>
> Trial #4 -- simulate a PEBKAC
>
>     $ git.git/master: cd Documentation
>     $ Documentation/master: echo >>no-such-file
>     $ Documentation/master: git stash -- no-such-file
>     error: pathspec 'Documentation/no-such-file' did not match any file(s=
) known to git.
>     Did you forget to 'git add'?
>
> The last one is an expected result---the pathspec given to the
> command does not match anything tracked, so without first adding the
> file, there is nothing for the command to do.
>
