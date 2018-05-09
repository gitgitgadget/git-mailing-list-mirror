Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C2A1F424
	for <e@80x24.org>; Wed,  9 May 2018 19:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965576AbeEITyz (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 15:54:55 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45330 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965524AbeEITyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 15:54:53 -0400
Received: by mail-qt0-f173.google.com with SMTP id j42-v6so47273612qtj.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ayE+SbMX0WUu30F56nxtZQ0kR+g5d5pP3yW6jucUtwo=;
        b=XS3drGYFP8cswCxSL9IKQAAhzQET2JtTPyrWAKlW8BbbbrVjaYCgl9B30/dB4UQ+js
         /oBw5KV5Q2tFSdFX1YVhhkG/cuk7TDfw/9/KwL16YXpF/KOCM3mc7DRyuMm7oxUMGibi
         AvNU5mjEXeMSJYokoY1jeTT7gj6JUNl7moO+xVgKqkNKFs/VghYhkXQYgo62cf8I5lyl
         TiM2jAynXOPDQimxUdku/c5SIah2WudSJ/XN0JFdZiaES61+h2fEp7TtEQ9JPKg4eatM
         856c6y0qUwOvqAxomRffEoTZ6CeXpizZnSpafrYt3p/LZi+pyVlibrNbkSWwtaMbHMZt
         n9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ayE+SbMX0WUu30F56nxtZQ0kR+g5d5pP3yW6jucUtwo=;
        b=qw39zaTBo3b6JSDOmRhgFNjMV1LtOo6ctbDrv/AZB3enViJ29XdPu1RMvpABiI2fJ4
         7ZUXFMpAJW9MLZME2P+oEw75R2Twtb8zNdk/07iqgYZoOABW9+qoqjdKpti/CIl5tlC8
         DXpCj+hkd1luYfM+3CAqZx/ZwXwnJkg/VQED52A3XEccZ6TurKrZXE2gy6ft9z8GT9/i
         HhQL00vdKu5TWlk7WlAa4a99vAXO3RRh9OlkNi5+nXL9ZNktZrbmIl5zemC0iVQI54Cd
         Q7yejYf6Ph0UiA007KSTBnUZe9cuE8fYgpy3KdAS4zSDS0NgN+AWZ3CJ2C/Jptupetsl
         XswA==
X-Gm-Message-State: ALQs6tCK6b4h6cR4jSpn9xbcRudirTyrCyIpCKuMggDpzVXyYkAEbKZl
        e/5qzwGa5MI5pKD57XHhUm8=
X-Google-Smtp-Source: AB8JxZpxmWQ8tpqueHy3Ea0S1fnP2d1EVuZH3XUpSKLB6YyCqtoZWbyMFrPTwt/tl9Kes2+GLY5Aeg==
X-Received: by 2002:a0c:9655:: with SMTP id 21-v6mr42940566qvy.226.1525895692660;
        Wed, 09 May 2018 12:54:52 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 42-v6sm2783891qte.41.2018.05.09.12.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 12:54:51 -0700 (PDT)
Subject: Re: [PATCH v1] add status config and command line options for rename
 detection
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
 <CABPp-BEkQN55diiovv+33P=Ouk+FcK8N4p85EZZqVmw-mxuL1A@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c386ec5c-4e82-2b52-10ef-885a335a14dc@gmail.com>
Date:   Wed, 9 May 2018 15:54:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEkQN55diiovv+33P=Ouk+FcK8N4p85EZZqVmw-mxuL1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/9/2018 12:56 PM, Elijah Newren wrote:
> Hi Ben,
> 
> Overall I think this is good, but I have lots of nit-picky things to
> bring up.  :-)
> 
> 

Thank you for the review.  I appreciate the extra set of eyes on these 
changes.  Especially when dealing with the merge logic and settings 
which I am unfamiliar with.

> 
> I suspect that status.renames should mention "copy", just as
> diff.renames does.  (We didn't mention it in merge.renames, because
> merge isn't an operation for which copy detection can be useful -- at
> least not until the diffstat at the end of the merge is controlled by
> merge.renames as well...)
> 

I wasn't supporting copy (as you noticed later in the patch) but will 
update the patch to do so and update the documentation appropriately.

> Also, do these two config settings only affect 'git status', or does
> it also affect the status shown when composing a commit message
> (assuming the user hasn't turned commit.status off)?  Does it affect
> `git commit --dry-run` too?
> 

The config settings only affect 'git status'

>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -109,6 +109,10 @@ static int have_option_m;
>>   static struct strbuf message = STRBUF_INIT;
>>
>>   static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>> +static int diff_detect_rename = -1;
>> +static int status_detect_rename = -1;
>> +static int diff_rename_limit = -1;
>> +static int status_rename_limit = -1;
> 
> Could we replace these four variables with just two: detect_rename and
> rename_limit?  Keeping these separate invites people to write code
> using only one of the settings rather than the appropriate inherited
> mixture of them, resulting in a weird bug.  More on this below...
> 

This model was inherited from the diff code and replicated to the merge 
code.  However, it would be nice to get rid of these 4 static variables. 
  See below for a proposal on how to do that...

>> @@ -1259,11 +1273,29 @@ static int git_status_config(const char *k, const char *v, void *cb)
>>                          return error(_("Invalid untracked files mode '%s'"), v);
>>                  return 0;
>>          }
>> +       if (!strcmp(k, "diff.renamelimit")) {
>> +               diff_rename_limit = git_config_int(k, v);
>> +               return 0;
>> +       }
>> +       if (!strcmp(k, "status.renamelimit")) {
>> +               status_rename_limit = git_config_int(k, v);
>> +               return 0;
>> +       }
> 
> Here, since you're already checking diff.renamelimit first, you can
> just set rename_limit in both blocks and not need both
> diff_rename_limit and status_rename_limit.  (Similar can be said for
> diff.renames/status.renames.)

It really doesn't work that way - the call back is called for every 
config setting and there is no specific order they are called with. 
Typically, you just test for and save off any that you care about like 
I"m doing here.

I can update the logic here so that as I save off the settings that it 
will also enforce the priority model (ie the diff setting can't override 
the status setting) and then compute the final value once I have the 
command line arguments as they override either config setting (if present).

On the plus side, this change passes the red/green test but it now 
splits the priority logic into two places and doesn't match with how 
diff and merge handle this same issue.

> 
> <snip>
> 
>> @@ -1297,6 +1329,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>                    N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
>>                    PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>>                  OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
>> +               OPT_BOOL(0, "no-renames", &no_renames, N_("do not detect renames")),
>> +               { OPTION_CALLBACK, 'M', "find-renames", &rename_score_arg,
>> +                 N_("n"), N_("detect renames, optionally set similarity index"),
>> +                 PARSE_OPT_OPTARG, opt_parse_rename_score },
> 
> Should probably also document these options in
> Documentation/git-status.txt (and maybe Documentation/git-commit.txt
> as well).

Good point, will do.

> 
> Not sure if we want to add a flag for copy detection (similar to
> git-diff's -C/--find-copies and --find-copies-harder), or just leave
> that for when someone finds a need.  If left out, might want to just
> mention that it was considered and intentionally omitted for now in
> the commit message.
> 

I tend to only implement the features I know are actually needed so 
intentionally omitted this (along with many other potential diff options).

>> +       if ((intptr_t)rename_score_arg != -1) {
> 
> I don't understand why rename_score_arg is a (char*) and then you need
> to cast to intptr_t, but that may just be because I haven't done much
> of anything with option parsing.  A quick look at the docs isn't
> making it clear to me, though; could you enlighten me?
> 

Yes, it is related to making parse_options() do what we need.  -1 means 
the command line option wasn't passed so use the default.  NULL means 
the command line argument was passed but without the optional score.  A 
non NULL, non -1 value means the optional score was passed and needs to 
be parsed.  The (intptr_t_) cast is to enable comparing a pointer to an 
integer (-1) without generating a compiler warning.

>> +               s.detect_rename = DIFF_DETECT_RENAME;
> 
> What if status.renames is 'copy' but someone wants to override the
> score for detecting renames and pass --find-renames=40?  Does the
> --find-renames override and degrade the 'copy'?  I think it'd make
> more sense to increase s.detect_rename to at least DIFF_DETECT_RENAME,
> rather than just outright setting it here.
> 

I understand your argument and agree that it makes some sense.  I am 
matching the same logic in merge-recursive.c which just sets 
detect_rename to 1 in this case.  I believe more strongly that they 
should be consistent than in one option over the other.

If I'm reading the merge logic for this case incorrectly or if you're 
willing to patch the merge logic to match :), I'm happy to change this to:

		if (s.detect_rename < DIFF_DETECT_RENAME)
			s.detect_rename = DIFF_DETECT_RENAME;

>> +                                        s.rename_limit;
>> +
>> +       /*
>> +        * We do not have logic to handle the detection of copies.  In
>> +        * fact, it may not even make sense to add such logic: would we
>> +        * really want a change to a base file to be propagated through
>> +        * multiple other files by a merge?
>> +        */
>> +       if (s.detect_rename > DIFF_DETECT_RENAME)
>> +               s.detect_rename = DIFF_DETECT_RENAME;
> 
> This comment and code made sense in merge-recursive.c (which doesn't
> show detected diffs/renames/copies but just uses them for internal
> processing logic).  It does not make sense here; git status could show
> detected copies much like `git diff -C --name-status` shows it.  In
> fact, a quick grep for DIFF_STATUS_COPIED shows multiple hits in
> wt-status.c, so I suspect it already has the necessary logic for
> displaying copies.
> 

Clearly I was following my similar patch series for merge too closely 
without thinking through how they should be different.  Thanks for 
catching this.  Gone. :)

