Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908561F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 21:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756205AbdKNVnC (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 16:43:02 -0500
Received: from mail-ua0-f182.google.com ([209.85.217.182]:47260 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756355AbdKNVms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 16:42:48 -0500
Received: by mail-ua0-f182.google.com with SMTP id s28so8875280uag.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 13:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FgiJ3bwzlvvxesndEXOaI+Vz5Yck0WB8vq3jsE+so8k=;
        b=AMy2aSe3FbivA+fMMnZwEndIXsw4mu751yoSoLurBXkIceR4EUY3cihPKsmRcysK88
         jGQBQRLvV63k+NtZpPikqSX3ZGtMNGLcxx6+Oju/hBYN/zE9SlsELsaP4HbSWvIiWLT6
         g8/vTs8s+1ubcUeGA37RbrZhEf4N5NQbN3vFzMY3qEPoplJoPeTvoq8Jp1wNPAndNGLg
         lLRzZlqrL7A5YOztjVqzrdJXAiSobrTY43ze00djlNdjn40jMtYTddHMeov22+7NYE0w
         n0CH20MfGoU66aXjleXh8o/L7sxSORiLwhzSdrp5lEDi6r8AuvphPrnL8rFL+ARzPpJZ
         vCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FgiJ3bwzlvvxesndEXOaI+Vz5Yck0WB8vq3jsE+so8k=;
        b=CH1Z8eF45tt7jSMT2J64TXzO1E+tNuNfAB/INfRVRJ0GJSffNj2FV1QPvugSWJ2add
         hLO7z5PJf8vCVFSCJYSumBQ2nio/veqQtRdgsCrY6AZGMIiLo35fSWbh+J2QHlKx76RV
         UYfCdk/LEv1wBF8DFP/K9fRYdmhcUV2hrL9QjD4pYF8a4YhjyYI14hae01nai3BymNGJ
         eXrOzMKV4F/6QKeWrwfPepJuWaOHBWh49EwMA/pxQMXLja4AmeYmxwJm4XdLOCbuXjf1
         fm1v8h1d2/l4/2QiIBEiCmzxoTLoxv7J4OtwLaF9IDJwPcPbvnAJtH071ed155+ArpDq
         b+gw==
X-Gm-Message-State: AJaThX73rOz+Rcnmzzdknvvl9jHmn6t1F33Ym9pVZ1jifnnWdc5qEbX2
        m5lqQy9ccpKgWOPlD45QQErrZb5d4VdfldSx/Ak=
X-Google-Smtp-Source: AGs4zMapc+l9X7LZzd80WAy8VvXWmWGv8JoYjherpGMCSDFWumI45JAHErz2w5TbUgPr3ftXxEg0Nyj/Sshqup9kYgA=
X-Received: by 10.159.62.1 with SMTP id o1mr12450268uai.123.1510695766603;
 Tue, 14 Nov 2017 13:42:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Tue, 14 Nov 2017 13:42:46 -0800 (PST)
In-Reply-To: <CAGZ79kYCDBFwMhW4Qgwhomiv4kKRWS53cjMLuRG1NxrzULYwgg@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-12-newren@gmail.com>
 <CAGZ79kYCDBFwMhW4Qgwhomiv4kKRWS53cjMLuRG1NxrzULYwgg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Nov 2017 13:42:46 -0800
Message-ID: <CABPp-BHhf37R1LuHceXvuf=9nW4-EDaNLHkOBbgpsQhMPP2O_g@mail.gmail.com>
Subject: Re: [PATCH 11/30] directory rename detection: testcases exploring
 possibly suboptimal merges
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 12:33 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:

>> +# Possible Resolutions:
>> +#   Previous git: y/{a,b,f},   z/{c,d},   x/e
>> +#   Expected:     y/{a,b,e,f}, z/{c,d}
>> +#   Preferred:    y/{a,b,e},   z/{c,d,f}
>
> it might be tricky in the future to know what "previous git" is;
> "Previous git" means without directory renames enabled;
>
> "expected" means we expect the algorithm presented in this series to produce
> this output, preferred is what we actually expect.

Yes, how about using:
  "Without dir rename detection:"
  "Currently expected:"
and
  "Optimal:"
?

>> +# Testcase 8b, Dual-directory rename, one into the others' way, with conflicting filenames
>> +#   Commit A. x/{a_1,b_1},     y/{a_2,b_2}
>> +#   Commit B. x/{a_1,b_1,e_1}, y/{a_2,b_2,e_2}
>> +#   Commit C. y/{a_1,b_1},     z/{a_2,b_2}
>> +#
>> +# Possible Resolutions:
>> +#   Previous git: y/{a_1,b_1,e_2}, z/{a_2,b_2}, x/e_1
>> +#   Scary:        y/{a_1,b_1},     z/{a_2,b_2}, CONFLICT(add/add, e_1 vs. e_2)
>> +#   Preferred:    y/{a_1,b_1,e_1}, z/{a_2,b_2,e_2}
>
> It may be common to have sub directories with the same path having different
> blobs, e.g. when having say multiple hardware configurations in different sub
> directories configured. Then renaming becomes a pain when they overlap.

Sure, agreed.  Although, the one nice thing about this particular
testcase is that despite showing suboptimal merge behavior, it's at
least the exact same suboptimal behavior as before when we didn't have
directory rename detection.

>> +# moves directories.  Implment directory rename detection suboptimally, and
>
> Implement

Thanks.

> ok, so add "Expected" as well? (repeating "Previous git", or so?)

Yeah, I should make that more explicit.

>> +# Testcase 8d, rename/delete...or not?
>> +#   (Related to testcase 5b; these may appear slightly inconsistent to users;
>> +#    Also related to testcases 7d and 7e)
>
>> +#   Commit A: z/{b,c,d}
>> +#   Commit B: y/{b,c}
>> +#   Commit C: z/{b,c,d,e}
>> +#   Expected: y/{b,c,e}
>
> Why this?
> * d is deleted in B and not found in the result
> * the rename detection also worked well in z->y  for adding e
>
> I do not see the confusion, yet.

Um...yaay?  If you don't see it as confusing, then maybe others don't?
 I was wondering if folks would expect a rename/delete conflict (x/d
either deleted or renamed to y/d via directory rename detection), and
be annoyed if the merge succeeded and didn't even give so much as a
warning about what happened to 'd'.

>> +#   In this case, I'm leaning towards: commit B was the one that deleted z/d
>> +#   and it did the rename of z to y, so the two "conflicts" (rename vs.
>> +#   delete) are both coming from commit B, which is non-sensical.  Conflicts
>> +#   during merging are supposed to be about opposite sides doing things
>> +#   differently.
>
>   "Sensical has not yet become an "official" word in the English language, which
>   would be why you can't use it. Nonsense is a word, therefore nonsensical can
>   used to describe something of nonsense. However, sense has different meanings
>   and doesn't have an adjective for something of sense"
>
> from https://english.stackexchange.com/questions/38582/antonym-of-nonsensical
> I don't mind it, the spell checker just made me go on a detour. Maybe illogical?

Illogical works for me.

>> +# Testcase 8e, Both sides rename, one side adds to original directory
>> +#   Commit A: z/{b,c}
>> +#   Commit B: y/{b,c}
>> +#   Commit C: w/{b,c}, z/d
>> +#
>> +# Possible Resolutions:
>> +#   Previous git: z/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -> y/c vs. w/c)
>> +#   Expected:     y/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -> y/c vs. w/c)
>> +#   Preferred:    ??
>> +#
>> +# Notes: In commit B, directory z got renamed to y.  In commit C, directory z
>> +#        did NOT get renamed; the directory is still present; instead it is
>> +#        considered to have just renamed a subset of paths in directory z
>> +#        elsewhere.  Therefore, the directory rename done in commit B to z/
>> +#        applies to z/d and maps it to y/d.
>> +#
>> +#        It's possible that users would get confused about this, but what
>> +#        should we do instead?   Silently leaving at z/d seems just as bad or
>> +#        maybe even worse.  Perhaps we could print a big warning about z/d
>> +#        and how we're moving to y/d in this case, but when I started thinking
>> +#        abouty the ramifications of doing that, I didn't know how to rule out
>> +#        that opening other weird edge and corner cases so I just punted.
>
> s/about/abouty

I think you mean the other direction?  Thanks for catching, I'll fix that up.

> It sort of makes sense from a users POV.

I'm afraid I'm unsure what the antecedent of "It" is here.  (Are you
just saying that my rationale for what I listed as "Expected" makes
sense, or something else?)
