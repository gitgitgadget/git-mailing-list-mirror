Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266AE1F406
	for <e@80x24.org>; Mon, 14 May 2018 12:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeENM5v (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 08:57:51 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:40852 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753578AbeENM5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 08:57:49 -0400
Received: by mail-qt0-f175.google.com with SMTP id h2-v6so15905895qtp.7
        for <git@vger.kernel.org>; Mon, 14 May 2018 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2VIkInBHkHpnWLblH0MeKsvsjXk2/MRM8il3ORxhyWQ=;
        b=O+jMSjZ5QDMl0UcGsrMp4W1I/DdfDDPTrR1bnzrLGO0Lhvmg8DRNu+9AWXFbbUrA/w
         S/q2wH/XAQeoS+taEqDd7Mp9VNHSYaip6kPY3Mgx0MblIoSo/RzDamucdQaubL+Zhk2U
         HPSJcC8wJpnCOnRlCbvSO/xdFBEtkjnZhKdCjLzMgzUrwm9tfqX3QW1xC575bM1XcX6i
         aW7lVBILrkKzythUAmplQBKNEGdYHTuiXJdp129xzi8c2UfPTaZSEFHDAZGLfMOIK0Oz
         UXeHs1YTxTT6mFLS2X97Veu/jGmnzFpYzRNch8SlGtO8qN/36+Jg8ULQLulnPmO64sJD
         iakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2VIkInBHkHpnWLblH0MeKsvsjXk2/MRM8il3ORxhyWQ=;
        b=OX5zIzB+y/qLlGysnGQ8+o3UXGOVnwSf5UuszkCBhuUa5/TDj1AGOGTwDc8Qy05Mg9
         MPnnapp4RXGj/HsMKKbY2NE7qomeQG2i6HVyLMUL/3Lk6iXbEG0La97KgFot9Io5HFgR
         0qva5tPe0pKa98GN1FdqzQqzh/bSIwB4+dnn3ajV+cAhp1xuYRO9rihWqezYm4BIRPal
         5g9uzFNw5Ssj9hir9VbtJd6epbrG0L1iuR7XYcMIyq+nT89IrkVUk7rH5Fo7p3+AVma6
         6YDeEng9X2Q3chc7HowiVz4Zr/9lfDGkMi5s9hKykMeiULO4ZlbHCX2ZDPbYYQ5SjbtH
         btRA==
X-Gm-Message-State: ALKqPwcCIOCqSnc2Sg5dMTR8T9xLdffricgpx5tsAUxezLNQXHeWFzLz
        JKkA7meDamzv9aY6YM1YeDQjHe7H
X-Google-Smtp-Source: AB8JxZotBIpzMfcszDbWiCND5RBf//kA5vn9C3dRd37YyRvhbPir1thTalaRd7GVf8Tm1G9f8+wtXw==
X-Received: by 2002:a0c:aa9a:: with SMTP id f26-v6mr8727964qvb.106.1526302668898;
        Mon, 14 May 2018 05:57:48 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m67-v6sm4645670qkd.30.2018.05.14.05.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 05:57:48 -0700 (PDT)
Subject: Re: [PATCH v3] add status config and command line options for rename
 detection
To:     =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com" <newren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180509144213.18032-1-benpeart@microsoft.com>
 <20180511125623.6068-1-benpeart@microsoft.com> <20180512080437.GA16679@esm>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d306e8bf-1847-ca81-16ac-fa99ee3f6755@gmail.com>
Date:   Mon, 14 May 2018 08:57:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512080437.GA16679@esm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/12/2018 4:04 AM, Eckhard Maaß wrote:
> On Fri, May 11, 2018 at 12:56:39PM +0000, Ben Peart wrote:
>> After performing a merge that has conflicts git status will, by default,
>> attempt to detect renames which causes many objects to be examined.  In a
>> virtualized repo, those objects do not exist locally so the rename logic
>> triggers them to be fetched from the server. This results in the status call
>> taking hours to complete on very large repos vs seconds with this patch.
> 
> I see where your need comes from, but as you based this on my little
> patch one can achieve this already with tweaking diff.renames itself. I
> do wonder why there is a special need for the status command here

The rename detection feature is nice and we'd like to leave it on 
whenever possible.  The performance issues only occur when in the middle 
of a merge - normal status commands behave reasonably.  As a result, we 
don't want to just turn it off completely by setting diff.renames.

Until we come up with a more elegant solution, we currently turn it off 
completely for merge via the new merge settings and then intercept calls 
to status and if there is a MERGE_HEAD we turn it off for status just 
for that specific call.  I view this as a temporary solution so would 
not want to put that logic into git proper as it is quite specific to 
when running git on a virtualized repo.

> if there is, I personally would like it more in a style that you could
> take all the options provided by diff.*-configuration and prefix that
> with status, eg status.diff.renames = true. What do you think? If you
> really only need this for merges, maybe a more specialised option is
> called for that only kicks in when there is a merge going on?
> 
> I would like that status behaves as similar as possible to
> diff/show/log. Special options will pull away from that again - passing
> -m to show or log will lead to the same performance issues, correct?
> Could it be feasible to impose an overall time limit on the detection?
> 

I agree that they should behave as similar as possible which is why all 
the new settings default to the diff setting when not explicitly set.  I 
believe this is a good model - if you don't do anything special you get 
the default/same behavior but if you know and need special behavior, you 
now have that option.

> And after writing this I wonder what were your experience with just
> tweaking renameLimit - setting it very low should have helped the
> fetching from server part already, shouldn't it?
> 
>> Add --no-renames command line option to status that enables overriding the
>> config setting from the command line. Add --find-renames[=<n>] command line
>> option to status that enables detecting renames and optionally setting the
>> similarity index.
> 
> Would it be reasonable to extend this so that we just use the same
> machinery for parsing command line options for the diffcore options and
> pass this along? It seems to me that git status wants the same init as
> diff/show/log has anyway. But I like the direction towards passing more
> command line options to the git status command.
> 

I agree that it is unfortunate that diff/merge/status all parse and deal 
with config settings differently.  I'd be happy to see someone tackle 
that and move the code to a single, coherent model but that is beyond 
the scope of this patch.

>>   static void wt_longstatus_print_unmerged_header(struct wt_status *s)
>> @@ -592,6 +595,9 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
>>   	}
>>   	rev.diffopt.format_callback = wt_status_collect_changed_cb;
>>   	rev.diffopt.format_callback_data = s;
>> +	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
>> +	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
>> +	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
>>   	copy_pathspec(&rev.prune_data, &s->pathspec);
>>   	run_diff_files(&rev, 0);
>>   }
>> @@ -625,6 +631,9 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>>   	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>>   	rev.diffopt.format_callback = wt_status_collect_updated_cb;
>>   	rev.diffopt.format_callback_data = s;
>> +	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
>> +	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
>> +	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
>>   	copy_pathspec(&rev.prune_data, &s->pathspec);
>>   	run_diff_index(&rev, 1);
>>   }
>> @@ -982,6 +991,9 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>>   	setup_revisions(0, NULL, &rev, &opt);
>>   
>>   	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
>> +	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
>> +	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
>> +	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
>>   	rev.diffopt.file = s->fp;
>>   	rev.diffopt.close_file = 0;
>>   	/*
> 
> Somehow I am inclined that those should be factored out to a common
> method if the rest of the patch stays as it is.
> 

I debated that as well but given the logic is so simple, opted to stick 
with this.  I also debated whether it would be clearer in the form:

if (s->detect_rename >= 0)
	rev.diffopt.detect_rename = s->detect_rename;

But decided git contributes are used to seeing dense code :) and this 
style better matched what I saw in the merge settings.

> Greetings,
> Eckhard
> 
