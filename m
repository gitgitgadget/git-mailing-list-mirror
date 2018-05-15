Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145B01F406
	for <e@80x24.org>; Tue, 15 May 2018 20:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeEOUtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:49:08 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44664 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeEOUtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:49:07 -0400
Received: by mail-yw0-f196.google.com with SMTP id l142-v6so500505ywc.11
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l3dRe1b0T23n7YlTnhuXgGjCLib17haDzgJDnIIypEc=;
        b=vk/8DccxIaD1I6Ffp8eveiTypms97WXBwuhd8wFHFOOWZy2kncXVicjlBg95LzGOeH
         JI43T2ROeIGaN9C9HwsFoSTvwkWVlmXExA9qk11IboXaKhgQ3hxmbQmugUO66IVnjGwL
         5rFkR4uBlmmXqLppvdOn8Rk6FDH35NBE7SevwLAGTV43GmOtGdANqXT/HiPNAhTJADWm
         ldXPvRBADkkSxk9Nm3tkrq2rKyPtll3FHuz2/zIsKIU+bfJau8G7N4RduygDa5NVSyw0
         aE+M9CeoH/U8tTYgSMtIoGAIZ6lLimBvL0ZYpjNiSRvdSn2Tuz+iNpA9Q/bHlYOAxjHs
         /B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l3dRe1b0T23n7YlTnhuXgGjCLib17haDzgJDnIIypEc=;
        b=XXPpGgAbw8/JnIjGzLGuYBdVwKNrU4I1jsmVNCFRUXKuQoxqHo/7EXPzAQU5HKPJ3E
         TF5KStKPfBYMQWRhg8CKnGw6ZD46mDaNct3d9Djk8I9rgo9cM++UGqnRut1gGnVVitQi
         NMayB5jfaXK0N7wLwpBApki16/Q4GxqX3WfURHqCdNJ0SFAuIV7L+z/bL6+LqkkOq4UE
         Tn9LaPljWUZi46ijbUKGaG78wGUYCV7Yje9RUPpBpeeNWIhy5s1/36LjJBuQz3b0FOAA
         nZz8K1Yf16cBjLp8o/BsSU+Ji80/Om234tQPWA05imjNOWTGfw90hceUn2ZLM17nWcWH
         p+vA==
X-Gm-Message-State: ALKqPwc2YHKw9nOKhzuDwST3GbemBHuLvannMvRGAqzsdmv29VXs2ZxS
        wPr3In3d86DcT7vpNXNQRfs4traEtwDDmiXVMlPyIA==
X-Google-Smtp-Source: AB8JxZrOXjFiuh7KV1QqgfvahZIYIjRnPCvmzRgk7KQ6VRAQ3QaXfRII1vSWYgtjSfDwUu6BL86NhbwmBQfzkXAq2oo=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr7267630ywf.238.1526417346299;
 Tue, 15 May 2018 13:49:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Tue, 15 May 2018 13:49:05
 -0700 (PDT)
In-Reply-To: <CANw0+A-FK-zkuhX-jU8q7LfqgaNM6E4Xy92UOs2gkwkBf1TYOA@mail.gmail.com>
References: <20180515200030.88731-1-sbeller@google.com> <CANw0+A-FK-zkuhX-jU8q7LfqgaNM6E4Xy92UOs2gkwkBf1TYOA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 May 2018 13:49:05 -0700
Message-ID: <CAGZ79kanoU5W7phXRQQmAJrQDF9fhd57ck0geeAf+4Q9QAn+QA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Reroll of sb/submodule-merge-in-merge-recursive
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 1:15 PM, Leif Middelschulte
<leif.middelschulte@gmail.com> wrote:
> Hello Stefan,
>
> thank you once again for your effort.
>
> Am 15. Mai 2018 um 22:00:34, Stefan Beller
> (sbeller@google.com(mailto:sbeller@google.com)) schrieb:
>
>> This rerolls the two commits found at [1] with the feedback of Eliah
>> and puts Leifs patch[2] on top, that I edited according to Eliahs feedba=
ck,
>> but kept Leifs ownership.
>>
>> This has addressed all of Eliahs feedback AFAICT.
>> You'll find a branch-diff below[3], which lacks
>> the new patch of Leif in that series, but is part of the reroll?
>>
>> Leif, what do you think?
>
> Seems great to me. Thank you for picking up and improving my changes :)
> One Question though: Shouldn=E2=80=99t an enum (like
> NOTES_MERGE_VERBOSITY_DEFAULT) be used instead of numbers?

Hah! I did not know that existed.

$ git grep NOTES_MERGE_VERBOSITY_DEFAULT
builtin/notes.c:810:    o.verbosity =3D verbosity + NOTES_MERGE_VERBOSITY_D=
EFAULT;
notes-merge.c:22:       o->verbosity =3D NOTES_MERGE_VERBOSITY_DEFAULT;
notes-merge.h:9:        NOTES_MERGE_VERBOSITY_DEFAULT =3D 2,

It doesn't seem to be used much, as opposed to numbers:

$ git grep show -- merge-recursive.c
merge-recursive.c:201:static int show(struct merge_options *o, int v)
merge-recursive.c:211:  if (!show(o, v))
merge-recursive.c:570:  opts.show_rename_progress =3D o->show_rename_progre=
ss;
merge-recursive.c:1096:         if (show(o, 3)) {
merge-recursive.c:1099:         } else if (show(o, 2))
merge-recursive.c:1108:         if (show(o, 3)) {
merge-recursive.c:1111:         } else if (show(o, 2))
merge-recursive.c:2178:         if (show(o, 4) || o->call_depth)
merge-recursive.c:2275: if (show(o, 4)) {
merge-recursive.c:2286: if (show(o, 5)) {
merge-recursive.c:2351: if (show(o, 2))

(The first two are the implementation of show/output, third is
somewhat unrelated to show() and all the rest is numbers).

If we'd want to use  NOTES_MERGE_VERBOSITY_DEFAULT,
I would suggest to send a followup series on top of this?

I would think numbers are fine for now.

Thanks,
Stefan
