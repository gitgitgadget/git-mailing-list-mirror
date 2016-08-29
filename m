Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665001FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 23:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbcH2XKg (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 19:10:36 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35333 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbcH2XKf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 19:10:35 -0400
Received: by mail-oi0-f42.google.com with SMTP id j203so3521011oih.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wen89ZMnTCwFwWlJ8VBuZXQL2V7gO6ngSRgp/L2ndTY=;
        b=dB4JO5JFvBxybTmGOZ608EaMSgomgg6J537W0e+6KMVyaTgH8qeByN/FEdgNeyC4Ex
         94klg2B1hRZpJHoBOdVmt0qyjE4usGg/RHLGDPv2GOyPUSyMtn6tqTyFNfd2br0vOflK
         q4ADS4Mv5eFz3R+LeR81j7/JwfcEBLvguKn3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wen89ZMnTCwFwWlJ8VBuZXQL2V7gO6ngSRgp/L2ndTY=;
        b=T2EADLJKvi89mTdSRtjdcwS/hA/VZD/8BJJok3aepfwUYhISYOUhfpw+FGr8iT9KbR
         5P0fKjexM7+LZKsSFtwVScrSlXY25gGkr9uQH6irVgTBoURlKIfgMgewlICSs+MH8cXJ
         OQQt0T+aH5EnDeeBu0fXIjvv4K/hbvpNk44VRydF9pVbZTw+JZYgab9DI8IVvYmISkt9
         ugq9XqNNOgc14FfzR1dyiCyDie0wMOJiZlGv7e1PGf27+r3WiUB3jNbnorqNmFv1pdQZ
         HOD3q1WKo6V3pUbhoyzVJxpQeiAFuX8H00oaMx2DRFNXU0WcCg9YiVxd8CikGSSeeErO
         YE+g==
X-Gm-Message-State: AE9vXwPPYvb5NArTCLIXHdz6qvmqzNV0Gxr03Hj4OXMtGiV2xi3V7uiIDFiWgdxCLfEvc9Zwi0YDJt8azEcgJW9v
X-Received: by 10.202.244.133 with SMTP id s127mr498026oih.15.1472511884138;
 Mon, 29 Aug 2016 16:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Mon, 29 Aug 2016 16:04:43 -0700 (PDT)
In-Reply-To: <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com> <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Mon, 29 Aug 2016 16:04:43 -0700
Message-ID: <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With respect to my original problem with a corrupted .git directory
under the submodule directory, I am thinking of adding the following 4
lines marked with ### to is_submodule_modified() to detect the
corrupted dir and die quickly instead of forking several child
processes:

               strbuf_addf(&buf, "%s/.git", path);
               git_dir = read_gitfile(buf.buf);
               if (!git_dir) {
                 ### strbuf_addf(&head_ref, "%s/HEAD",buf.buf);
                 ### if (strbuf_read_file(&temp_ref, head_ref.buf,0) < 0) {
                          ### die("Corrupted .git dir in submodule %s", path);
                 ###}
                         git_dir = buf.buf;
              }

This fixes my issue but what do you think? Is this the right way to
fix it? Is there a better way?

Thanks,
Uma

On Mon, Aug 29, 2016 at 2:13 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
> Ok that makes sense. Thanks much.
>
> Uma
>
> On Mon, Aug 29, 2016 at 2:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Mon, Aug 29, 2016 at 2:03 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
>>> On Mon, Aug 29, 2016 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> A top-level superproject can have a submodule bound at its "dir/"
>>>> directory, and "dir/.git" can either be a gitfile which you can read
>>>> with read_gitfile() and point into somewhere in ".git/modules/" of
>>>> the top-level superproject.  "dir/.git" can _ALSO_ be a fully valid
>>>> Git directory.  So at the top of a superproject, you could do
>>>>
>>>>         git clone $URL ./dir2
>>>>         git add dir2
>>>>
>>>> to clone an independent project into dir2 directory, and add it as a
>>>> new submodule.  The fallback is to support such a layout.
>>>>
>>> Thanks for the reply. However, in this case....
>>>
>>>       git clone $URL ./dir2
>>>       git add dir2
>>>
>>> how will "dir2" get ever get registered as a submodule?
>>
>> With a separate invocation of "git config -f .gitmodules", of course.
>> The layout to use gitfile to point into .git/modules/ is a more recent
>> invention than the submodule support itself that "git add" knows about.
>> The code needs to support both layout as well as it can, and that
>> is what the "can we read it as gitfile?  If not, that directory itself may
>> be a git repository" codepath you asked about is doing.
