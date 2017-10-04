Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3286C20365
	for <e@80x24.org>; Wed,  4 Oct 2017 16:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdJDQ06 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 12:26:58 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:57247 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdJDQ05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 12:26:57 -0400
Received: by mail-qt0-f171.google.com with SMTP id 34so3134056qtb.13
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NuJW2Ncj69k6KF48dVzV9nD5/qrUyNNq5N9TyXgeJJ0=;
        b=CJj1/7XvRu4uAAyTwLn4nxgQv7oyMYJQLv5YBawEOzysDXNEHWawqZ6WHqfPAwmYfq
         CedD1c8MvXyZnSe7jAfpUTQCXiywZh9ZrGKgm329PdkkYdA55hOoZY6qUZDdjpK/9p5d
         ezU/A/6ofkJH8ocrImsTB0zIMgNmLhuoo3QpryZonPwYQaJMxfTwHgMar+2xwMjI5Zsj
         SttM6Np8h9aOgW3beUHUxEOKWSR0qQHDAOg4lQ4A4+zt5lIAeaMgxM9mdj8nisDDUUir
         M+tMGtKGKHXakonc5i1eTYucovML69c4Zx/kbRieggW+sE4fIEw/yWy1RgzhwA8jNo4d
         +C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NuJW2Ncj69k6KF48dVzV9nD5/qrUyNNq5N9TyXgeJJ0=;
        b=YQ8re3KbYmdyMBACi7gUmyic4+iRxI+58SapdVKKHSs+3N/+YUioFbMV7vYavLEUuB
         PxLW0MdXSSQJin4YagF6fuRY/tQuKsYRr0tnC11vMcJ3UGq+G+3AHdaGnO+Sr4WfE5FM
         hLVfH1fSTeIEvSJmTF5Jx6AxDcGahLgaf8Y/wQxdd5OYt2StTk5yDBLmH5lzFzEabxSn
         EhtUgMfCMaQI71JwdJoZx6CM1NtpSN/l8XUYJUHr+5tk1F/+xwxZen3c/SduZc8fjZs7
         zhjEjnKsQBohlV8FloIKLodc4mIn23Gm2McPOgISWyEyxCKk7aX+3VSvdnlQiRw2Gqf8
         Ffzw==
X-Gm-Message-State: AHPjjUgp+zgoiMQuZNqPP2EPY8uMlgSXOhJjF0fKGpLIlsNLjqJ1NXOn
        X4E5i7X76JjqkeRllwMw/9YWyy4Mc3CLpBo8dQI=
X-Google-Smtp-Source: AOwi7QAduvXdzFRLdR65XZCTyxXMuGqEdCmlthGdBvbwfTKPrJ+5NHW8SAa21LlxtrEnXph09yWepfARRxPVp2FoAxs=
X-Received: by 10.13.245.198 with SMTP id e189mr18569968ywf.58.1507134416298;
 Wed, 04 Oct 2017 09:26:56 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.40.214 with HTTP; Wed, 4 Oct 2017 09:26:55 -0700 (PDT)
In-Reply-To: <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de> <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de> <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 4 Oct 2017 11:26:55 -0500
X-Google-Sender-Auth: 8nTX-7apwb7matpdwTaaiz_18wQ
Message-ID: <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
Subject: Re: Line ending normalization doesn't work as expected
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2017 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>>> $ git rm -r --cached . && git add .
>>
>> (Both should work)
>>
>> To be honest, from the documentation, I can't figure out the difference =
between
>> $ git read-tree --empty
>> and
>> $ git rm -r --cached .
>>
>> Does anybody remember the discussion, why we ended up with read-tree ?
>
> We used to use neither, and considered it fine to "rm .git/index" if
> you wanted to empty the on-disk index file in the old world.  In the
> modern world, folks want you to avoid touching filesystem directly
> and instead want you to use Git tools, and the above are two obvious
> ways to do so.
>
> "git read-tree" (without any parameter, i.e. "read these 0 trees and
> populate the index with it") and its modern and preferred synonym
> "git read-tree --empty" (i.e. "I am giving 0 trees and I know the
> sole effect of this command is to empty the index.") are more direct
> ways to express "I want the index emptied" between the two.
>
> The other one, "git rm -r --cached .", in the end gives you the same
> state because it tells Git to "iterate over all the entries in the
> index, find the ones that match pathspec '.', and remove them from
> the index.".  It is not wrong per-se, but conceptually it is a bit
> roundabout way to say that "I want the index emptied", I would
> think.
>
> I wouldn't be surprised if the "rm -r --cached ." were a lot slower,
> due to the overhead of having to do the pathspec filtering that ends
> up to be a no-op, but there shouldn't be a difference in the end
> result.

You guys are obviously worlds ahead of me on the internals of things,
but from my perspective I like to avoid the "plumbing" commands as
much as I can. Even if I used them, if I have to tell the rest of my
team "this is the way to do it", they're going to give me dirty looks
if I ask them to run things like this that make no sense to them.
That's the argument I have to deal with when it comes to Git's
usability within the team I manage. So based on this, I'd favor the
`git rm -r --cached` approach because this is the more common result
you see in Google, and also makes a little more sense from a high
level of thought perspective. However, this is just my personal
opinion. `read-tree --empty` is far less self explanatory IMHO.

Also let's not forget the second part of the command chain that
results in the different behavior. In one case, I use `git add` which
results in proper line ending normalization. In the other case, I do
`git reset --hard` which does *NOT* result in the line endings
normalized (`git status` shows no results). In both cases, I'm still
doing `git rm -r --cached`, so I am doubtful that is the root cause
for the line ending normalization piece. I'm still trying to
understand why both give different results (root cause) and also get
an understanding of what the correct (modern) solution is for line
ending normalization (not necessarily which is the right way to
clear/delete the index, which is really AFAIK just a means to this end
and an implementation detail of sorts for this specific task).
