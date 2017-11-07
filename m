Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4DD20A36
	for <e@80x24.org>; Tue,  7 Nov 2017 20:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbdKGUsQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 15:48:16 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43779 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933456AbdKGUsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 15:48:15 -0500
Received: by mail-qt0-f171.google.com with SMTP id j58so758925qtj.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qYGS08W/6O2VnZ/NCMdscURssYDhQuzRMFACDsw+xyI=;
        b=j3zPqWblkz7WS6KluoFOmBmsRBfltWp6DWwYOJE2wNwL2Vt7fJzlquBPwFNxH1NBQy
         2Sd5PGhWOGrHz3vtNg3deb0N9XmSJWIdewRh/+FNjh33z+nvd5r2tFQygnYyzWDl2ZCY
         Rzyt0B9MCukTJtRGVZ8w5jCWdYNh5mJasSwzVQa4wdRjOxo/ZCmR23TvLV73dvOkJn9B
         hWu6YqEq1DvDKHohntQUaoPD7ZQ5f7c0oWRXjEa/AZ2tg3NE5jsXkCRE49PMiaz2kPXD
         mkoG0kElG3EXOXNkLvBr3d88v8gM4GD1VYjePVA/eG2F+JlgmQ1Rig5DL4TqJaI9kC2Y
         hJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qYGS08W/6O2VnZ/NCMdscURssYDhQuzRMFACDsw+xyI=;
        b=CJHiQOCiBwsD7NqOytp5C0VQEYFiMmycP2IY4zg0jW1V1wtm9muRVa5mDrhPST7gZi
         atQYEbolunwFATnscjGWC4jhSdCDAuyBfirLiFUJA+m65qkK/YRdTD83lYBc7gg2iTer
         cBGtL/qhWVkQb0o7+Z2pNCsSY9VTZrTSxzEg81FzerIZDOGbwkacKqgT6pkHwI3S+IEi
         OAFRM0W3vg37Jdfwze7Gf+yYKbQyJ7gvKHirr1DTkM83BJQojNjI1iKq3URpKlu1j4Vs
         Il6di4gdmdVM20u21opfJvx622zFWF09iP684vPy2zGZZcIIfigrLDIPgLoMqDAkBcSs
         8cZA==
X-Gm-Message-State: AJaThX4/NIHVMBZwHdhVgwa8h1YD7cC0P1WNfqjOhWXBJJ8uhOmiAO7L
        hkk+Nyt8phqS05WnuIbYs69oKItTmc0S6gYxFLBddJmNJdg=
X-Google-Smtp-Source: ABhQp+Qgx0E0SFeyNbnlo1ErnmRH86dopx1jjBzazjWQdzOx0AdhqqoUW1ocwDsWfJ3f33xgojTUDhRnlmwQuXaSxh0=
X-Received: by 10.200.8.53 with SMTP id u50mr47562qth.260.1510087694138; Tue,
 07 Nov 2017 12:48:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 7 Nov 2017 12:48:13 -0800 (PST)
In-Reply-To: <CAFA_24L5nTUhO=PbMB9SdnCB1Lj+5rmOHmMJwkuLGWgy-ooxBA@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
 <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
 <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com>
 <CAFA_24K99LkeJBKV7+a-m-m9PUZik49cOd40+cEn-6zCvGmMsQ@mail.gmail.com>
 <CAGZ79kZHapHLXDM-iU9T_BU5qoYAAAS+yKWLVvfUhxMmp+6mxg@mail.gmail.com>
 <CAFA_24JXc=qJw1-_aJJUMPhW9DaBofxSb6hkVD6n4MWyeT5UOQ@mail.gmail.com>
 <CAGZ79kbWEe=TyqPFSc+D8HCRh3cOkGbkqFKZbpkdisjvkfiaFg@mail.gmail.com> <CAFA_24L5nTUhO=PbMB9SdnCB1Lj+5rmOHmMJwkuLGWgy-ooxBA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Nov 2017 12:48:13 -0800
Message-ID: <CAGZ79kYKfZC1CzoGE_6G1b2vD+MCw1_rY7J_LeWyT8rp6CAuDw@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Max Rothman <max.r.rothman@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 7, 2017 at 12:31 PM, Max Rothman <max.r.rothman@gmail.com> wrote:
> Thanks for the feedback!
>
>>> * Add bash completion for the missing --no-* options on git log
>>> * Add bash completion for --textconv and --indent-heuristic families to
>>>   git diff and all commands that use diff's options
>>> * Add bash completion for --no-abbrev-commit, --expand-tabs, and
>>>   --no-expand-tabs to git show
>>
>> This describes what happens in this patch, but not why, which helps
>> future readers of commit message more than the "what".
>
> How about:
>
>> Teach git-log tab completion about the --no-* options for ease of use
>> at the command line.
>>
>> Similarly, teach git-show tab completion about the --no-abbrev-commit,
>> --expand-tabs, and --no-expand-tabs options.
>>
>> Also, teach git-diff (and all commands that use its options) tab
>> completion about the --textconv and --indent-heuristic families of
>> options. --indent-heuristic is no longer experimental, so there's no
>> reason it should be left out of tab completion any more, and textconv
>> seems to have simply been missed.

Sounds good to me.


>> At the end of a commit message, the Git project requires a sign off.
>> (See section (5) in Documentation/SubmittingPatches;
>> tl;dr: add Signed-off-by: NAME <EMAIL> if you can agree to
>> https://developercertificate.org/)
>
> So the sign-off should include my name and email? I thought it was
> supposed to be the person who approved the patch, but I must've gotten
> confused.

Anyone touching the patch needs to sign off on it. So when you write it,
you sign off (thereby certifying that you are legally allowed to write
the patch.
For example you may be employed and the work contract requires you to
not work on side projects, or the intellectual property belongs to the employer
or such).

Hypothetically you could send it to Git-for-Windows which happens to
be a fork of git. The maintainer of GfW would gladly accept your patch,
(and also sign it off, thereby certifying he can touch it legally).
Thereafter someone such as a regular contributor from the git project
could spot the difference in GfW and git, and they would want to bring it
to "the real git", so they would make a patch out of the commit in GfW.
Additionally to the 2 sign offs, this contributor would also need to sign
off on the patch, saying it is legal what they do. And then that patch could
be picked up by the maintainer for the regular git. After that journey the
patch would have 4 sign offs, indicating the way of travel, i.e. how
it reached git finally.

An example of a longer sign off chain is  89dd32aedc
(check-ref-format doc: --branch validates and expands <branch>, 2017-10-17)
and apparently Jeff helped Junio to author a patch; Jonathan took that
patch and changed a thing, only to send it back to Junio, who then applied
it to git.


>> The patch looks good, but doesn't apply because the email contains
>> white spaces instead of tabs. Maybe try https://submitgit.herokuapp.com/
>> (or fix/change your email client to send a patch; the gmail web interface
>> doesn't work. I personally got 'git send-email' up and running;
>> The Documentation/SubmittingPatches has a section on email clients, too)
>
> Yeah, I was using the gmail interface. I'll give the heroku app a go.
> It has an option for sending a message in reply to another, and I
> assume I should send it in reply to this thread. Do you know how to
> tell what the appropriate ID to use is? Looking through the raw email,
> I see several, so it's not obvious to me which to use.

In gmail, there is a "show original" in the menu near reply, which will
show Message ID<CAFA_24L5nTUhO=PbMB9SdnCB1Lj+5rmOHmMJwkuLGWgy-ooxBA@mail.gmail.com>
for the email that I am responding to.

Another way to explore the message ids is public-inbox, as that uses
the message ids as keys, i.e.

  https://public-inbox.org/git/CAFA_24L5nTUhO=PbMB9SdnCB1Lj+5rmOHmMJwkuLGWgy-ooxBA@mail.gmail.com

is your email there.

Thanks,
Stefan
