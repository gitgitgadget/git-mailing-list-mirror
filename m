Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88E7202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 21:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936990AbdKPVSI (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 16:18:08 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:42425 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936015AbdKPVRy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 16:17:54 -0500
Received: by mail-vk0-f42.google.com with SMTP id o70so477862vkc.9
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZqQnXTBTYrAYFeWAPdEKEiTTzFCAbhqWmtSG8Wq3oaQ=;
        b=M56+0oGBipnO0+n3ZWRB96mLSO/Bt+nrr+eyrIud5z+EH5gEet/I4sg2kJD48ZWStf
         bJYD3Wyq8WMQI8B82uinG9WlFsd9VC4DdGb3iy2yw2kthLknQXFjpiu0Jf/iSnxc4r4n
         a4Id07NxzwMN0V48hfza7HdQkIxskheJADQHHk3nKqSNhkMinun2c7zRevnVvrY/1hYb
         H7dvaClRtC4Ecz6FMqjIb8ruvvNNb/jFTVtA5w//ewwiWvX+5ckIQ5zrvaWozCf9yB+P
         hFi8EOR1bc+v7w0IPXsErq4mlMGZkQSGbGdcr5vFr+LykSgPhm6IYjZL8DSk6Kcw6ezN
         GVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZqQnXTBTYrAYFeWAPdEKEiTTzFCAbhqWmtSG8Wq3oaQ=;
        b=SeV4mJJERP811+HyUKz0eat0u80e6EvkqCbtSZbcf6kDlqY49EEvZcw3/lQmLoxhbV
         9Wjywj8O5E7lGQLrTAhAklwPUiHwDKnKQA8bCHKAD7riOhkVCaN6cbL45FeCv/quBAMH
         JWRoPWrqmyUQsr798mIvnzk+v8Fa16OZTuMm5LFERzqvbbdMSmMbQguMUkXoIPi8/SwX
         G3YjbS7nddybVkCF1QXtmQdpZVM/ze1zg4xE6s68HsP8YQCsZtPXZ9CBA9ljfq8HNt3H
         t08DYCA65gOazynVV2wQtaTHY3QVQLYIXJh2voWlucvuptFuXOwRDMtX9AJfD9/tXzW/
         cAyQ==
X-Gm-Message-State: AJaThX6Lh8kA66+nePLbCGkPFoMWbvIKlahvBJrOvlpnMszJXIQ5mH0t
        naI6duhZT7twnRXfDtP81BWbXrTPBshebIFRe/A=
X-Google-Smtp-Source: AGs4zMYPITx6/Xc3rG3RoxJjHWKIrkpCzlaiPLjzIKrpRRJjZmBEnbUAKKv0b2vSiy1FrAXPYSfZaWkdJD016ZdAwnw=
X-Received: by 10.31.176.133 with SMTP id z127mr2327993vke.183.1510867072960;
 Thu, 16 Nov 2017 13:17:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.193 with HTTP; Thu, 16 Nov 2017 13:17:52 -0800 (PST)
In-Reply-To: <CAGZ79kb13gGJ6V9d08evHKLvTdTQwcp8VAyzi36BnGn-m5pTXQ@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-13-newren@gmail.com>
 <CAGZ79kb13gGJ6V9d08evHKLvTdTQwcp8VAyzi36BnGn-m5pTXQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Nov 2017 13:17:52 -0800
Message-ID: <CABPp-BF5=vKUhGGrzkV=FZ_4Syuer+WEZT36kvEHbaxtHVdTsQ@mail.gmail.com>
Subject: Re: [PATCH 12/30] directory rename detection: miscellaneous testcases
 to complete coverage
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 12:03 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
>
>> +# Testcase 9d, N-fold transitive rename?
>> +#   (Related to testcase 9c...and 1c and 7e)
>> +#   Commit A: z/a, y/b, x/c, w/d, v/e, u/f
>> +#   Commit B:  y/{a,b},  w/{c,d},  u/{e,f}
>> +#   Commit C: z/{a,t}, x/{b,c}, v/{d,e}, u/f
>> +#   Expected: <see NOTE first>
>> +#
>> +#   NOTE: z/ -> y/ (in commit B)
>> +#         y/ -> x/ (in commit C)
>> +#         x/ -> w/ (in commit B)
>> +#         w/ -> v/ (in commit C)
>> +#         v/ -> u/ (in commit B)
>> +#         So, if we add a file to z, say z/t, where should it end up?  In u?
>> +#         What if there's another file or directory named 't' in one of the
>> +#         intervening directories and/or in u itself?  Also, shouldn't the
>> +#         same logic that places 't' in u/ also move ALL other files to u/?
>> +#         What if there are file or directory conflicts in any of them?  If
>> +#         we attempted to do N-way (N-fold? N-ary? N-uple?) transitive renames
>> +#         like this, would the user have any hope of understanding any
>> +#         conflicts or how their working tree ended up?  I think not, so I'm
>> +#         ruling out N-ary transitive renames for N>1.
>> +#
>> +#   Therefore our expected result is:
>> +#     z/t, y/a, x/b, w/c, u/d, u/e, u/f
>> +#   The reason that v/d DOES get transitively renamed to u/d is that u/ isn't
>> +#   renamed somewhere.  A slightly sub-optimal result, but it uses fairly
>> +#   simple rules that are consistent with what we need for all the other
>> +#   testcases and simplifies things for the user.
>
> Does the merge order matter here?

No.

> If B and C were swapped, applying the same logic presented in the NOTE,
> one could argue that we expect:
>
>     z/t y/a x/b w/c v/d v/e u/f
>
> I can make a strong point for y/a here, but the v/{d,e} also seem to deviate.

I don't understand; I thought my argument as presented was agnostic of
direction.  Perhaps I have an unstated assumption I'm not realizing or
something; could you explain how my logic above could lead to this
conclusion?

Also, let me try a different tack to see if it's clearer than the
above argument I made.  Looking at each path:

* z/t from commit C does not get renamed to y/t despite B's rename of
z/ -> y/ because C renamed y/ elsewhere.
* z/a from commit A was renamed to y/a in commit B.  We do not
transitively rename further from y/a to x/a (despite C's rename of y/
to x/) because B renamed x/ elsewhere.
* y/b from commit A was renamed to x/b in commit C.  We do not
transitively rename further from x/b to w/b (despite B's rename of x/
to w/) because C renamed w/ elsewhere.
* x/c from commit A was renamed to w/c in commit B.  We do not
transitively rename further from w/c to v/c (despite C's rename from
w/ to v/) because B renamed v/ elsewhere.
* w/d from commit A was renamed to v/d in commit C.  We DO
transitively rename from v/d to u/d because of B's rename of v/ to u/
and because C did not rename u/ to somewhere else.

(And, to complete the list, e and f are simple: v/e is renamed to u/e
in commit B, and there's no directory name on u on either side, so
there's no special logic needed at all.  u/f is even simpler; there's
no renames or directory renames or anything affecting it.)


>> +# Testcase 9e, N-to-1 whammo
>> +#   (Related to testcase 9c...and 1c and 7e)
>> +#   Commit A: dir1/{a,b}, dir2/{d,e}, dir3/{g,h}, dirN/{j,k}
>> +#   Commit B: dir1/{a,b,c,yo}, dir2/{d,e,f,yo}, dir3/{g,h,i,yo}, dirN/{j,k,l,yo}
>> +#   Commit C: combined/{a,b,d,e,g,h,j,k}
>> +#   Expected: combined/{a,b,c,d,e,f,g,h,i,j,k,l}, CONFLICT(Nto1) warnings,
>> +#             dir1/yo, dir2/yo, dir3/yo, dirN/yo
>
> Very neat!

:-)

>> +# Testcase 9f, Renamed directory that only contained immediate subdirs
>> +#   (Related to testcases 1e & 9g)
>> +#   Commit A: goal/{a,b}/$more_files
>> +#   Commit B: priority/{a,b}/$more_files
>> +#   Commit C: goal/{a,b}/$more_files, goal/c
>> +#   Expected: priority/{a,b}/$more_files, priority/c
>
>> +# Testcase 9g, Renamed directory that only contained immediate subdirs, immediate subdirs renamed
>> +#   (Related to testcases 1e & 9f)
>> +#   Commit A: goal/{a,b}/$more_files
>> +#   Commit B: priority/{alpha,bravo}/$more_files
>> +#   Commit C: goal/{a,b}/$more_files, goal/c
>> +#   Expected: priority/{alpha,bravo}/$more_files, priority/c
>
> and if C also added goal/a/another_file, we'd expect it to
> become priority/alpha/another_file.

Yep!  I thought that was covered enough by other tests, but do you
feel I should add that to this testcase?

> What happens in moving dir hierarchies?
>
> A: root/node1/{leaf1, leaf2}, root/node2/{leaf3, leaf4}
> B: "Move node2 one layer down into node1"
>     root/node1/{leaf1, leaf2, node2/{leaf3, leaf4}}
> C: "Add more leaves"
>     root/node1/{leaf1, leaf2, leaf5}, root/node2/{leaf3, leaf4, leaf6}

Works just fine; similar to testcase 9a.  Do you feel this one is
different enough to add to the testsuite?  I'm happy to do so.

> Or chaining putting things in one another:
> (Same A)
> B: "Move node2 one layer down into node1"
>     root/node1/{leaf1, leaf2, node2/{leaf3, leaf4}}
> C: "Move node1 one layer down into node2"
>     root/node2/{leaf3, leaf4, node1/{leaf1, leaf2}}
>
> Just food for thought.

That's evil.  I mean, it's a brilliant testcase designed to really
mess things up.  I'm not entirely sure what the right answer should
be, but I am confident saying my current implementation handles it
wrong.  I'm digging into why.
