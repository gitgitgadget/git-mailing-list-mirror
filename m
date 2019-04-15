Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C459920248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfDONvm (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:51:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35395 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDONvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:51:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id a71so9867028qkg.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5RhhVevvpsfrXyaox0lE2oSa2tUAMUGY3jggr3oxdRI=;
        b=v/s8WfH8FyR6d1K3O276gESO7wju9wZOSruha6bxCiy4qy9ju9aMp6kt285gvNYvjO
         35evJ/cO4D2b5K9AB0832X432Wq5FOIREeoHkn0YC2GzGnmNzHUIe/9ClAtd0GgFDJ18
         cra53cTr/UDzueZvS1emt+0HaGDJEoapso8TKQPBjO2JiVFDwQaZYz/LzwIsLg0mNVO6
         /d4IPpd1DNsL5AHvu8VVdyuAulw1IZHJW/J1v1nmKDzCKx3bM8yhLcdJkuHQ0dSTdWgZ
         t03g46wXHQ/77oyrFl2QSk33d6Ru3WzY+zhUzdCA6FPKTO6tI8cIFNCOLU9MMmBOCQlC
         0r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RhhVevvpsfrXyaox0lE2oSa2tUAMUGY3jggr3oxdRI=;
        b=KUbuy21TEL39pgGCQuDykEP6I0YiyP+9glN/vIRGhJWV7v/UtmItMAc2U7HCYlEwS7
         XuLOF7EZPWW9F4wh3dCHWX9UxX7eCkOqzNeqfA6Yf7L/Kf9drmZUEsOgaO7mQY6PZHl3
         ll7dWWCJwkleRbuS+CJYUSLX6WJgWWD8KBR5vrGitkMD0rIXSCuEzYaFJbBFkuO3NR34
         zy/Y5B5onv/uNC7OmxiYW+wrezhn/hbBcSncpdD8qhAzF1sRQkupF3YpgxuADbThiYkn
         3JFXKLlYgIM8ykDL7FVtapTebYAngaoE1BPPelTCJ5DxqFNx4MBSrEF5lCYb9YJ9uegy
         kwLw==
X-Gm-Message-State: APjAAAXEQjytQ4Jlv9XVYxb9aQ7VqrXNcsgFwRxShIQTH6YMPEuKGAfg
        +3Q4fI/BqHGz69CtoQdlFjcw0A==
X-Google-Smtp-Source: APXvYqySwZPRFSAfVFB6mbleLxRGWqRXsrIBasbqFHo6hKMoOlYLmRNSUyJ4a3Ems9ghFErUbFDwzw==
X-Received: by 2002:a37:4ed5:: with SMTP id c204mr59046489qkb.68.1555336300092;
        Mon, 15 Apr 2019 06:51:40 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id k3sm34555845qtf.28.2019.04.15.06.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:51:39 -0700 (PDT)
Subject: Re: [PATCH v6 4/6] blame: add config options to handle output for
 ignored lines
To:     Michael Platings <michael@platin.gs>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=c3=a9_Schar?= =?UTF-8?Q?fe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20190410162409.117264-1-brho@google.com>
 <20190410162409.117264-5-brho@google.com>
 <xmqqo959w8pq.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9S8XFH=JnQX8WcfgOZ7cr+X6kk45k9g8t3u5aP5wwdu0Q@mail.gmail.com>
 <xmqqbm18x4tt.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9TRk99Kwq5S7udVqYsXnupGD=t3o_Ss8ewvwWuTQOy_YQ@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <1a1b3cd1-5f00-37c9-7382-72de000dd925@google.com>
Date:   Mon, 15 Apr 2019 09:51:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJDYR9TRk99Kwq5S7udVqYsXnupGD=t3o_Ss8ewvwWuTQOy_YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 4/14/19 7:27 AM, Michael Platings wrote:
> On Sun, 14 Apr 2019 at 11:24, Junio C Hamano <gitster@pobox.com> wrote:
>>> If you only enable blame.markIgnoredLines then the hash for
>>> "unblamable" lines appears as e.g. "*3252488f5" - this doesn't seem
>>> right to me because the commit *wasn't* ignored,
>>
>> I think you misunderstood me.  I was merely suggesting to use the
>> approach to mark the line in a way other than using the NULLed out
>> object name that has been reserved for something totally different,
>> and hinting with "the same *idea*".
> 
> Hi Junio, that paragraph wasn't targetted at yourself, more a comment
> on the functionality as it exists in the latest patch series. Sorry
> for not making that clear.
> 
>> the "^" marker
>> that is used to say "the line is attributed to this commit, but that
>> may only be because you blamed with commit range A..B and we reached
>> the bottom of the range---if you dug further, you might find the
>> line originates from another commit" is the origin of the same idea,
>> and this topic borrows it and uses a different mark, i.e. '*', for
>> the "we are not certain---take this with grain of salt" mark.
> 
> So it sounds like we have many types of blame to consider:
> 
> 1) This commit is truly the last one to touch this line, and you
> didn't ask to ignore it.
> 2) This commit is truly the last one to touch this line, but you asked
> to ignore it (AKA "unblamable").
> 3) This commit is at the bottom of the range of commits (^)
> 4) The "true" commit was ignored but we guess this is the one you're
> actually interested in (*)
> 5) The "true" commit was ignored and we've reached the bottom of the
> range of commits (^*)?
> 6) This commit is at the bottom of the range of commits, and you asked
> to ignore it.
> 
>> If you ended up hitting the commit the user wanted to ignore,
>> perhaps you can find another character that is different from '^' or
>> '*' and use that, following the same idea.
> 
> I personally don't find the "unblamable" lines interesting enough to
> justify giving them a symbol. But if Barret strongly feels that such
> lines should get a '*' then I won't fight it - these lines tend to be
> as simple as "}".

I'm fine with not zeroing the hash, so long as there's some way to mark it.

We could mark with another *, such that if we mark-ignored and 
mark-unblamable you get "**hash".  You can't have an unblamable that 
isn't from an ignored commit, so a single '*' has only one meaning, 
based on your config options.

If that works for you all, I can change this to markIgnoredUnblamables 
(instead of 'mask') in the next version.

>> By the way, a configuration only feature is something we usually do
>> not accept.  A feature must be guarded with --command-line-option
>> and then optionally can have a corresponding configuration once the
>> option proves to be useful enough that it becomes useful to be able
>> to say "in this repository (or to this user), the feature is on by
>> default".
> 
> In that case we definitely need a --mark-ignored-lines option to git
> blame, and I would strongly prefer that we also keep the
> blame.markIgnoredLines option as I for one will be switching it on.

I'd also keep this set.  I think the whole reason for these config 
options was that everyone has a different preference, but that 
preference rarely changes.  I don't want to have to type 
--mark-ignored-lines every time I run git blame.  If I had to, I'd have 
to alias git blame or something.

I think having config options for these sorts of things is fine, since 
we know already that for a given user+repo, we want the feature on (or 
off).  But if I have to remove it, then let me know.

Thanks,

Barret

