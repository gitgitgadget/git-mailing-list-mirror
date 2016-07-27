Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2AF203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 15:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbcG0Pat (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 11:30:49 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34179 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbcG0Pat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 11:30:49 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so31797142wma.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 08:30:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PbohzaFeTf8lp3Kud506PU5KvW93SgMJZ4xQPn0sHbs=;
        b=RVUe5UcDUAVz9DKNVJKRSRFu6tm3BeIzCbM9lkMYsS/Pq93ycHh9XFfjGzEeGnZee8
         5rHR9NQDNucx+zm50LvVKA6UwX15p+vbUMwfr/a8cpoFUK2EK4KhTm8DImzm4Xqdf+/Z
         muUUadwVQpc0dbgTJropbrxiI5+S86M8MEBnDKVIBd2gsLCFihsMQuQt77SzNJBU/CQA
         qebDg9ucHSvhBhorDBB7ewAxjcyvieQAb0BmCqNMsPcW3qOhrhrKeEHLYhx3fjE9D1F2
         JAavQJVLB560v/GKz/W3ycKWrS1/fUkRGVZKeiNACoAkIsGMsifMQSlGlbXWdDJw1ohf
         gz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PbohzaFeTf8lp3Kud506PU5KvW93SgMJZ4xQPn0sHbs=;
        b=hacaq5V8Tz56QLlEv8hR6mLqkecJTEOXDL1HFtp+rEYJnNb5Jlw2fezzpA8xYkhTQo
         OLqiYe1qI3vkRweEmcgUxZfH4nekWOmXhZOc9QYM5bc5GKfOK2Nume4Z100Jbl23xb4T
         MhQZsH7kH4Qg7XhrEzodDPTalIQ62TICXWxmBZpofjlNgwjaeXMr7Hyl9WroA6odok3R
         JbE2VamoaG/XxtJfCcH9Leot7HTx6lCyRYworQHI0qV39g7KBmCM0PQdkmMjy5dkjJcy
         6Q2aMzghdFx6wpXJxK7JE8xgLQQ3xg7o/z+7JT3B5w0vWcoL6sPyJxU0BVZj4VI57LPg
         Jyow==
X-Gm-Message-State: AEkoousN6wFHOTGjpQMcV9CjYP1oo/xbb2WXRVZBBX9u+OBqKwcV8pS2tDslL9XU+1Jz9f8RZMyN4Wh27oDYtQ==
X-Received: by 10.194.85.232 with SMTP id k8mr28201841wjz.147.1469633447363;
 Wed, 27 Jul 2016 08:30:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.154.134 with HTTP; Wed, 27 Jul 2016 08:30:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607271649120.14111@virtualbox>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
 <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com>
 <20160726203041.GA4675@sigill.intra.peff.net> <CAH8BJxH0_RhmDaHWBkFg6QP7WWucUtPSQfsAemdVWkTzN42MPw@mail.gmail.com>
 <CAH8BJxFvyEDuj-mm=N=ca3kxysopaBpro-HsuL-HZehqE_nxDA@mail.gmail.com> <alpine.DEB.2.20.1607271649120.14111@virtualbox>
From:	Stephen Morton <stephen.c.morton@gmail.com>
Date:	Wed, 27 Jul 2016 11:30:46 -0400
Message-ID: <CAH8BJxGPzpymSWPpxXRcCCx-OPckm5bVgENUEjVM-+9sr1T+6A@mail.gmail.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 11:03 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stephen,
>
> On Wed, 27 Jul 2016, Stephen Morton wrote:
>
>> Here is my patch then. (Personally, I would add some capitalization and
>> punctuation, but I didn't see much of that in the existing code.) I'm
>> not a regular pull-requester, do I do that, or can somebody else handle
>> that for me?
>
> The process of the patch submission is described in
> Documentation/SubmittingPatches (yes, it is a bit involved, and it is
> slightly easier when you use http://submitgit.herokuapp.com/, but please
> note that this process has served us well over one decade).
>
> Please also note that top-posting is highly discouraged on this list:
>
> A: Because it messes up the order in which people normally read text.
>>Q: Why is top-posting such a bad thing?
>>>A: Top-posting.
>>>>Q: What is the most annoying thing in e-mail?
>
> Now to your patch:
>
>> diff --git a/sequencer.c b/sequencer.c
>> index cdfac82..ce06876 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -176,7 +176,8 @@ static void print_advice(int show_hint, struct
>> replay_opts *opts)
>>                 else
>>                         advise(_("after resolving the conflicts, mark
>> the corrected paths\n"
>>                                  "with 'git add <paths>' or 'git rm <paths>'\n"
>> -                                "and commit the result with 'git commit'"));
>> +                                "then continue the %s with 'git %s
>> --continue'\n"
>> +                                "or cancel the %s operation with 'git
>> %s --abort'" ),  action_name(opts), action_name(opts),
>> action_name(opts), action_name(opts));
>
> That is an awful lot of repetition right there, with an added
> inconsistency that the action is referred to by its name alone in the
> "--continue" case, but with "operation" added in the "--abort" case.
>
> And additionally, in the most common case (one commit to cherry-pick), the
> advice now suggests a more complicated operation than necessary: a simply
> `git commit` would be enough, then.
>
> Can't we have a test whether this is the last of the commits to be
> cherry-picked, and if so, have the simpler advice again?
>
> Ciao,
> Johannes

Ok, knowing that I'm not on the last element of the sequencer is
beyond my git code knowledge. I see that in do_pick_commit() , we do
not have a copy of the todo_list. I would assume that would be
necessary, but I'm not certain. I could
file_exists(git_path_seq_dir()). This works to determine if one or
many commits are being cherry-picked / reverted, although it will
return true even on the last of n cherry-picks. I think that is still
reasonable.

I was trying to just take the same text as 'git status' already
displays. It could indeed be made more concise.

Happy to use the submission process, I just didn't know it. Thanks for
letting me know.

(Yup, sorry about the top-posting. I just wan't careful.)

Stephen
