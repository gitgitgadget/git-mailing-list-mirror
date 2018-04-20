Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BA21F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeDTR7e (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:59:34 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35432 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeDTR7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:59:33 -0400
Received: by mail-qt0-f173.google.com with SMTP id s2-v6so10758141qti.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbYMrudo8DdV0k4dq6qwsocc9//9rvRQz04ux6VvV70=;
        b=uEvyXXUzfzoyILDL1oJBXK9+RN0kcnSaXthWcBiLS7CNk5ECq4XvFKrDFbw5EXOXrj
         Kf4/L8WWTIBhowR225C2/j77EtsyI1/XEi9pGk60CcOiAf6oGWD988AuKHRlrqJ8Hlyk
         xwZwMdgVOnBeSC+NKopTQ9XPyRk5MfWHHLKmoYSj0t0+yYHHHOWrYx53qX7g3d2QuUuV
         0Xd4iOFb3u7oT+MdzSN5oRtYwrsgzEuMUQOJPAVSDTQ1mqCEvXXqqwfzrGS9EScbYucf
         8zKDWYXM2LT9YPmXRAFn9GL/XZAN/JSdJcxe/cvu0sNvu+kvp++aumSzuLI6PEDojYeP
         eI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbYMrudo8DdV0k4dq6qwsocc9//9rvRQz04ux6VvV70=;
        b=fply9Yr31LIVuexJQyAfylNnrSBLnw0ZfNVUsjmqWVyEDb0+liAnSrufWDZ3XuAy7U
         I8dH1bfY/+fC6mbCg/Y/4/Mv4c/iGYQb+enFKk7NWJ3oVN6ndRBRg6mC540bDMHqaxPD
         U3FzI81nSRRpbQcrpPB8vyxX5CgJvGJylTJRlQtn1pE90KBkcAER7BsXsvtH1cStO0LU
         httDWu0ST/FE/a025R/pdtOkyAOXEOyDSiRahNpIvUVFFQGCX48rok1MFBBSBKkkJEJv
         hZTl0PWZwy2DRdkR1ZlmvkLhxS4eqhXQ/4UOsc6E7MWI+UNawuqmNkmCUgmqnfINfbOR
         s9dg==
X-Gm-Message-State: ALQs6tCW74kBU67IQCte7g4imtYc/K7dbFCdlDS9r3U2E4bV7l8wCWeN
        MZNQIuHNpEj2NoxKJvDf6Zw=
X-Google-Smtp-Source: AIpwx490REy1E5PSOTN3YSOerKADnQDBUh+LqgSVfVHMYOzlaHlQzU2OKwNUjw3gGqIAYjUJ1CKX2w==
X-Received: by 2002:ac8:181c:: with SMTP id q28-v6mr11671674qtj.309.1524247172361;
        Fri, 20 Apr 2018 10:59:32 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id u42-v6sm5282425qtb.54.2018.04.20.10.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 10:59:31 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
Date:   Fri, 20 Apr 2018 13:59:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/2018 1:02 PM, Elijah Newren wrote:
> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> --- a/Documentation/merge-config.txt
>> +++ b/Documentation/merge-config.txt
>> @@ -37,6 +37,11 @@ merge.renameLimit::
>>          during a merge; if not specified, defaults to the value of
>>          diff.renameLimit.
>>
>> +merge.renames::
>> +       Whether and how Git detects renames.  If set to "false",
>> +       rename detection is disabled. If set to "true", basic rename
>> +       detection is enabled. This is the default.
> 
> One can already control o->detect_rename via the -Xno-renames and
> -Xfind-renames options.  

Yes, but that requires people to know they need to do that and then 
remember to pass it on the command line every time.  We've found that 
doesn't typically happen, we just get someone complaining about slow 
merges. :)

That is why we added them as config options which change the default. 
That way we can then set them on the repo and the default behavior gives 
them better performance.  They can still always override the config 
setting with the command line options.

I think the documentation should mention that
> "false" is the same as passing -Xno-renames, and "true" is the same as
> passing -Xfind-renames.  However, find-renames does take similarity
> threshold as a parameter, so there's a question whether this option
> should provide some way to do the same.  I'm not sure the answer to
> that; it may be that we'd want a separate config option for that, and
> we can wait to add it until someone actually wants it.

I'm of the opinion that we shouldn't bother adding features that we 
aren't sure someone will want/use.  If it comes up, we can certainly add 
it at a later date.

> 
>>   merge.renormalize::
>>          Tell Git that canonical representation of files in the
>>          repository has changed over time (e.g. earlier commits record
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 9c05eb7f70..cd5367e890 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -3256,6 +3256,7 @@ static void merge_recursive_config(struct merge_options *o)
>>          git_config_get_int("merge.verbosity", &o->verbosity);
>>          git_config_get_int("diff.renamelimit", &o->diff_rename_limit);
>>          git_config_get_int("merge.renamelimit", &o->merge_rename_limit);
>> +       git_config_get_bool("merge.renames", &o->detect_rename);
>>          git_config(git_xmerge_config, NULL);
>>   }
> 
> I would expect an explicitly passed -Xno-renames or -Xfind-renames to
> override the config setting.  Could you check if that's the case?
> 

Yes, command line options override the config settings.  You can see 
that in the code where the call to init_merge_options() which loads the 
config settings is followed by parse_merge_opt() which loads the command 
line options.  I've also verified the behavior in the debugger (it's on 
by default in the code, the config setting turns it off, then the 
command line option turns it back on).

> Also, if someone sets merge.renameLimit (to anything) and sets
> merge.renames to false, then they've got a contradictory setup.  Does
> it make sense to check and warn about that anywhere?
> 

I don't think we need to.  The merge.renameLimit is only used if 
detect_rename it turned on no matter how that gets turned on (default, 
config setting, command line option) so there isn't really a change in 
behavior here.
