Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B42F20986
	for <e@80x24.org>; Sat, 22 Oct 2016 20:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbcJVUqP (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 16:46:15 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33312 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbcJVUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 16:46:14 -0400
Received: by mail-qt0-f171.google.com with SMTP id s49so107718918qta.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g9OyZSPXNINjEBXPtx5kFtOPB435JWyVtEqC/F7LOp4=;
        b=KSuuUUi16mIOzpmjiCq9yxvHwqMPla/6DcziWBmgmZ+EbLnUnGbiM+bfA2twiTNGFN
         KnzK8v7PjzqjGhrLvrt4BHIBdGQ/4JAlmZQhIi/CQ0qhEnAma2UgH/tf6BCSn8fKIUKR
         SAAkZJuhvZLtDeiy3e9FD1NG9A6T4kK68qElymCoZ0UooavZ067g2TkoWgZtkx6IVjtO
         p/f4JMsQtz9FFHuPYIOvu/492gP+YIjfwNOcfy1aeTt4MXcF+u6VMF2yL8qsTx2B81MA
         EzMJvuEvgQYNeb0ijNA8w+IqSYtK6r7Q25auZM2fsfxtkFnENa7Rtm39yxi1KKtOA4Za
         9ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g9OyZSPXNINjEBXPtx5kFtOPB435JWyVtEqC/F7LOp4=;
        b=gwpZ3aVJxj0kv/1NAPjKL+/dQAU8MJUgCiRSe8UlH6O6uJq7ons4T2GazBHPgKD39i
         VUmUIzVym24j7BSIeO9/lsMJoiKPWnw7dHi3qjTbuWgWlmI8FxNKuxSfKGkPCgDfDRFJ
         Qu5jx1ksuJZv4NKthK1rFjbmF0tTBmaTP812dIHtO8ucIp3uB5jEN3iIzDKNtYAD3Pfd
         +rWUzlSbHCWTlvYi5CVno1uGe2uY52TrcvnUuNmr1iCZj641oteGQAmlVLrIe+Rezx8H
         yKJack2XSvXUK+jNiWzcDROslt+zajT+8wom0Ziho0K6jcRiEb9fctar81/MJkaccdnD
         6GFA==
X-Gm-Message-State: ABUngvfwX3fGWKEcOTTGfLDoVgHqQNBCRIAYi84xYHe4UD9HII5ruxKWYmnhGcwkEpTBCMyToF7houB5tyCe6KWF
X-Received: by 10.200.51.240 with SMTP id d45mr8208902qtb.18.1477169173034;
 Sat, 22 Oct 2016 13:46:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Sat, 22 Oct 2016 13:46:12 -0700 (PDT)
In-Reply-To: <xmqqh984aldl.fsf@gitster.mtv.corp.google.com>
References: <20161021235939.20792-1-sbeller@google.com> <20161021235939.20792-3-sbeller@google.com>
 <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org> <xmqqh984aldl.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 22 Oct 2016 13:46:12 -0700
Message-ID: <CAGZ79kaukGh2ynkOQcF=skzxTMYr8CFRyGJw6FEmNsTAcaG_VQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2016 at 12:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> The logic to construct the relative urls is not smart enough to
>>> detect that the ending /. is referring to the directory itself
>>> but rather treats it like any other relative path, i.e.
>>>
>>>     path/to/dir/. + ../relative/path/to/submodule
>>>
>>> would result in
>>>
>>>     path/to/dir/relative/path/to/submodule
>>>
>>> and not omit the "dir" as you may expect.
>>>
>>> As in a later patch we'll normalize the remote url before the
>>> computation of relative urls takes place, we need to first get our
>>> test suite in a shape with normalized urls only, which is why we should
>>> refrain from cloning from '.'
>>
>> But you are removing a valid use case from the tests. Aren't you
>> sweeping something under the rug with this patch?
>
> I share the same reaction.

Oh I see. I agree.
I reverted the lines that replace . by "$(pwd)" and it still works, but it
still works because the code path regarding local paths was not broken
(both . as well as "$(pwd)" are working without the fix)

>
> If the primary problem being solved is that the combination of a
> relative URL ../sub and the base URL for the superproject which is
> set to /path/to/dir/. (due to "clone .") were incorrectly resolved
> as /path/to/dir/sub (because the buggy relative path logic did not
> know that removing "/." at the end does not take you to one level
> up), and a topic that fixes the bug would make that relative URL
> ../sub to be resolved as /path/to/sub, of course.  Otherwise, the
> topic did not fix the bug.
>
> Now if a test that wanted to have a clone of the superproject by
> "clone .", which results in the base URL of /path/to/dir/., actually
> wants to refer in its .gitmodules to /path/to/dir/sub (which after
> all was where the submodule the test created with or without the
> bugfix), I would think the right adjustment for the test that used
> to rely on the buggy behaviour would be to stop using ../sub and
> instead use ./sub as the relative URL, no?  After all, the bug forced
> the original test writer to write ../sub but the submodule in this
> case actually is at ./sub relative to its superproject, and that is
> what the original test writer would have written if the bug weren't
> there in the first place, no?

True.

I have looked into it again, and by now I think the bug is a feature,
actually.

Consider this:

    git clone . super
    git -C super submodule add ../submodule
    # we thought the previous line is buggy
    git clone super super-clone

Now in the super-clone the ../submodule is the correct
relative url, because the url where we cloned from doesn't
end in /.

If we were to fix the bug with the /. ending, then we would need the
following:

    git clone . super
    git -C super submodule add ./submodule
    # correct relative URL above!

    git clone super super-clone
    cd superclone && sed s|url =./|url = ../|
    # make sure we fix the relative URLs to account for a different remote.

And this doesn't seem right to me as it burdens the user of the super-clone.

>
> Another thing I do not quite understand is why this step comes
> before the fix.  If the "clone ." is adjusted to avoid triggering
> the buggy behaviour, i.e. making the base URL to /path/to/dir
> (instead of /path/to/dir/.), wouldn't the relative URL ../sub that
> was written to work around the bug that hasn't been fixed yet in
> this step need to be adjusted anyway?  It would end up referring to
> /path/to/sub and not /path/to/dir/sub until the fix is put in place.
>
> Is the removal of remote.origin.url a wrong workaround for that
> breakage, I wonder...  I do not understand that change at all, and I
> do not think it was explained in the log message.

I think it is wrong, because it is sidestepping the actual issue.
Continuing from above:

    git clone super-clone super-clone2
    # this works again, as the remote change doesn't matter.

    mkdir test && git -C test clone ../ .
    # submodule urls need to be "undone again to work:
    cd test && sed s|url =../|url = ./|

So I think keeping the /. around as it currently is, is a pretty
useful bug.

>
> If we really wanted to update the test before fixing the bug, I
> would understand if this step changed ../sub (or whatever relative
> URL that has extra ../ only because the base URL has extra /. at the
> end to compensate for the buggy resolution) to ./sub in the tests
> and marked them to expect failure, and then a later step that fixes
> the bug turns them to expect success without make any other change.

I'll think about this further, but currently I am inclined to declare
it a nonbug
and as it eases testing a lot. Also if someone wants to clone a repository
with broken relative urls, they can work around that by e.g.

    git clone <url>/.

to fix one level of indentation, though it is not documented and seems
to be brittle.

Thanks,
Stefan
