Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BA61F609
	for <e@80x24.org>; Wed, 28 Nov 2018 22:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeK2J5I (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 04:57:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35394 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeK2J5I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 04:57:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so20672328lfc.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qoLJnCi35MPLys9UPoaasurkqJ6XRxI8l3/T6rKmicg=;
        b=Md55aJa230J+JZGqBF8JgPDeZvHPZYYx76dJOryQujLL74iQSmKUHNdbeFF5riTJWT
         2Yrp1SzTpZfM+jL8YfOI2scRWBz81FBwQGxhN2Wmb2hvRMpNiHwukH9VnXT+swY7fYo2
         I+guz32jDIGn+TuF5Xt55MyFxs+PPRgbK0Yn8ItnmCCPlSQCGuKLFclAVgYqBmacguyY
         TAA1r7T8zwdqRuX1a3RUeBG3FUy4+XJ3I/hYJyUBR8mOz62k2u68vcxUTA5yOHzriBS0
         hb+igStTmEG8hMGXI0bAIBtucKxCXlK69A5PR3CtrqDWghMNzm2fJuGoyKZw3d5+F/c3
         Tk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qoLJnCi35MPLys9UPoaasurkqJ6XRxI8l3/T6rKmicg=;
        b=ZGAQyU8SZ+i47MxtZ5y6QhRJcM9DX43nNjKq5oUmyk4bFXcEZVUnyp9A0fl8El8Bso
         +7SqaOQIPwTfmuolJC1F8w2ZZgIy1mE+0WJSDJvKCjUJMGDjUB+2nNK05liW6YAJTPML
         r7++gUIKyMdmHv19JauiaYsilR4+cdXKgJh/1eV9AddJYw23iFxLG1S9G2dqiFQTGuYH
         ZEKc3+0TIfvNWmTLNEtZ3JKX/bmMTYPj5cizY0Sd9PGmi5DIJMeeZ+5/51cnBvunw+m3
         BfSv6L0sOU2L1W/5s9TAWIagM4G6E4jrQSDCzZK5KTX8oeVnj4sqtGq/COzoJbBD3Y4i
         juTw==
X-Gm-Message-State: AA+aEWaXobrVHkLhjb/72H8vxK8sDP5j2SEpg6881KYobR5z9H5rtpOB
        TrswU7vOj3+i4XZIQDPKMM8/rcmW0VE57hrUfryAvS/Zwqg=
X-Google-Smtp-Source: AFSGD/Ueyo7qx3Bj3G3nYIykDyW3/stKGv1MsgBns8+E0xt3kBinZKownC1qMCdY2aZ8KZ0CZ78p6+JjPsMUQx7WKr0=
X-Received: by 2002:a19:e601:: with SMTP id d1mr16292323lfh.71.1543445631984;
 Wed, 28 Nov 2018 14:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com> <CAPL8Ziuj7Ffmdvz6NZWSJ+vzAtxFQhO1cfY2wmXm16J_8sY5fw@mail.gmail.com>
In-Reply-To: <CAPL8Ziuj7Ffmdvz6NZWSJ+vzAtxFQhO1cfY2wmXm16J_8sY5fw@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Wed, 28 Nov 2018 14:53:39 -0800
Message-ID: <CAPL8ZivFJXQw=yLXjOPxsjabwN5XAP_qe0LK3sODO4NkgCjZag@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
To:     pclouds@gmail.com
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think users have problems with detached heads for several reasons:

1. Users often enter the detached head state unexpectedly (for
example, by mistyping a "checkout" command or not understanding its
multipurpose nature, or as a side-effect of running a submodule
command). The change described here will go in the right direction
towards addressing this, since you won't be able to accidentally
detach your head by mistyping checkout. If detaching was always an
intentional action by the user, it would be much less intimidating.

2. Git shows a lot of scary error messages when running in a detached
head state. They tell you you're doing something dangerous, which
dissuades users from experimenting with the feature. IMO, it would be
better to replace the scary warning messages with instructions on
where to get more information about detached heads (and those
instructions should frontload info on how to reattach to a branch and
how to recover commits from the reflog).

3. When in a detached head state, a lot of commands add extra
confirmation prompts, which are unnecessary and intimidating.

Basically, the current user interface implies to the user that a
detached head is an error condition they'll need to recover from
rather than the normal and useful mode of working that it is.

(I'm resending this email without html - sorry if you received it twice).

So - IMO - detaching should always be an explicit action. Some options
that occur to me:

git switch-branch --detach
git detach
git switch-branch HEAD

  - Stefan

On Wed, Nov 28, 2018 at 2:48 PM Stefan Xenos <sxenos@google.com> wrote:
>
> I think users have problems with detached heads for several reasons:
>
> 1. Users often enter the detached head state unexpectedly (for example, b=
y mistyping a "checkout" command or not understanding its multipurpose natu=
re, or as a side-effect of running a submodule command). The change describ=
ed here will go in the right direction towards addressing this, since you w=
on't be able to accidentally detach your head by mistyping checkout. If det=
aching was always an intentional action by the user, it would be much less =
intimidating.
>
> 2. Git shows a lot of scary error messages when running in a detached hea=
d state. They tell you you're doing something dangerous, which dissuades us=
ers from experimenting with the feature. IMO, it would be better to replace=
 the scary warning messages with instructions on where to get more informat=
ion about detached heads (and those instructions should frontload info on h=
ow to reattach to a branch and how to recover commits from the reflog).
>
> 3. When in a detached head state, a lot of commands add extra confirmatio=
n prompts, which are unnecessary and intimidating.
>
> Basically, the current user interface implies to the user that a detached=
 head is an error condition they'll need to recover from rather than the no=
rmal and useful mode of working that it is.
>
>   - Stefan
>
> On Wed, Nov 28, 2018 at 12:01 PM Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Tue, Nov 27, 2018 at 5:53 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> >
>> > v2 is just a bit better to look at than v1. This is by no means final.
>> > If you think the command name is bad, the default behavior should
>> > change, or something else, speak up. It's still very "RFC".
>> >
>> > v2 breaks down the giant patch in v1 and starts adding some changes in
>> > these new commands:
>> >
>> > - restore-paths is renamed to checkout-paths. I wrote I didn't like
>> >   "checkout" because of completion conflict. But who am I kidding,
>> >   I'll use aliases anyway. "-files" instead of "-paths" because we
>> >   already have ls-files.
>> > - both commands will not accept no arguments. There is no "git
>> >   checkout" equivalent.
>> > - ambiguation rules are now aware that "switch-branch" for example
>> >   can't take pathspec...
>>
>> Another thing. Since we start with a clean slate, should we do
>> something about detached HEAD in this switch-branch command (or
>> whatever its name will be)?
>>
>> This is usually a confusing concept to new users and I've seen some
>> users have a hard time getting out of it. I'm too comfortable with
>> detached HEAD to see this from new user's perspective and a better way
>> to deal with it.
>> --
>> Duy
