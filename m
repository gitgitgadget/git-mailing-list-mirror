Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2911820899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbdHKRsq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:48:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36356 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbdHKRsp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:48:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id t83so4023596pfj.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eCmWt29QpaMZgMG3Dpv9Ls9aIxOSztIBVW7e8Zr+8ek=;
        b=nTHKnXRIXYnoMLVDVUvEB1RzHfA0F/YKToTiW4Ge+slQMI4ZqfF6/p/hUNRFjBWePB
         tSY6YSn+YFb72lXhJHNMcQxpOygtj+GvF4YsPykm9qg9pNTCGYMLP3tFncsKcg7qFmom
         QLd7vOFl06TsZ5UzLkc6aVrTasW+QyLuaZNDTtJXYd3de4fjX1v/gYa8bExPGPiXCJhO
         RCzLCjTCr3pdzZg7WT6equCKVRDXEJQs5xJR4lX9y3X3UKpAdsa5b1owhWCXQaVB04Ci
         PJYVYKnsHW58/9MJecvS4SgjIlSnXGk8SUZ5S77GpIpyK8CkIAIqFDcTfi6sBydKDlXG
         eQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eCmWt29QpaMZgMG3Dpv9Ls9aIxOSztIBVW7e8Zr+8ek=;
        b=Q1kvIaEiHmvmYsFsHRhRXi45fsNQtf1Kt7rZQj3SiC7robwToiog8b92uCkkPCELtZ
         GkSl2oaA+4A9CvWznzk5AZlAM9ok5B14ZW9L24fbhaCMCB0NhpEyJBnqgcjxJgvAbyKx
         2xCepM1R/E/0WUPCNanrAEdYVoWuR2K/u60jcKh7pBIe0KDeEMIMefmigNIL7cUYRi4E
         V6x2ZQd3+Ev2VxEX2tTxyshkYF2R03cVvXKQx7pvydU6tpmM5TmHaMjbA3REYQqtX7v9
         q9ZLH3uOrwnRY4SMXQ4V4GfUcT/Y3LDyv6A/c/S79mi3Gadi2uXDlqgKO21ygPkXCXLz
         1ixA==
X-Gm-Message-State: AHYfb5gIB4GBfv/xeedBWYQ6/JaqnNoZ7BsgVhXYZUuC9Zq04/ZjjDnb
        NoI9ya1AQjl0+Q==
X-Received: by 10.98.1.199 with SMTP id 190mr10621587pfb.178.1502473724859;
        Fri, 11 Aug 2017 10:48:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13f:a51f:6772:ed2d:f03b? ([2001:4898:8010:1::7])
        by smtp.gmail.com with ESMTPSA id p77sm2766902pfi.153.2017.08.11.10.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Aug 2017 10:48:44 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] dir: teach status to show ignored directories
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jameson Miller <jamill@microsoft.com>
References: <20170810184936.239542-1-jamill@microsoft.com>
 <20170810184936.239542-2-jamill@microsoft.com>
 <CAGZ79kb8cWR1P=1FSkfZ72Ai63T0WapwtCCN3gwqrWE_=MzOLg@mail.gmail.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <2bbb1d0f-ae06-1878-d185-112bd51f75c9@gmail.com>
Date:   Fri, 11 Aug 2017 13:48:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb8cWR1P=1FSkfZ72Ai63T0WapwtCCN3gwqrWE_=MzOLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/10/2017 04:03 PM, Stefan Beller wrote:
> On Thu, Aug 10, 2017 at 11:49 AM, Jameson Miller
> <jameson.miller81@gmail.com> wrote:
>
> Welcome to the Git mailing list. :)

Thank you for the welcome and the review! I will include the
suggested code changes in the next patch version.

>> Teach Git to optionally show ignored directories when showing all
>> untracked files. The git status command exposes the options to report
>> ignored and/or untracked files. However, when reporting all untracked
>> files (--untracked-files=all), all individual ignored files are reported
>> as well. It is not currently possible to get the reporting behavior of
>> the --ignored flag, while also reporting all untracked files.
> Trying to understand this based off the documentation for
> --untracked=all and --ignored, I realize that the documentation
> for --ignored seems to be lacking as I do not understand what the
> --ignored behavior is in combination with --untracked=[all, normal, no]
>

The set of files listed by "--ignored" changes when different
values are given to "--untracked-files".  If would be nice to
be able to make the ignored output independent of the untracked
settings.  This patch attempts to do that while maintaining
backward compatibility with the existing behavior.

When "--ignored" is used by itself ("--untracked-files=normal"),
ignored directories (both directories that explicitly match a
directory ignore pattern -and- directories containing only ignored
files) are listed. Individual files within are *not* listed.

When "--ignored" is used with "--untracked-files=all", git always
lists the individual files within the ignored directories and DOES
NOT collapse the output to just the containing (explicitly or
implicitly ignored) directory.

This can cause a massive performance problem when there are
a lot of ignored files in a well-defined set of ignored directories.
For example, on Windows, Visual Studio creates a bin/ and
obj/ directory inside your project where it writes all .obj
files.  Normal usage is to explicitly ignore those 2 directory
names in your .gitignores (rather than or in addition to *.obj).
We just want to see the "bin/" and "obj/" paths
regardless of which "--untracked" flag is passed in.

We want to see the paths that explicitly match an ignore pattern.
This means that if a directory only contains ignored files, but the
directory itself is not explicitly ignored, then we want to see the
individual files. This is slightly different than the current behavior
of "--ignored".

I am open to suggestions on how to present the options to control
this behavior.

>> This
>> change exposes a flag to report all untracked files while not showing
>> individual files in ignored directories.
> By the description up to here, it sounds as if you want to introduce
> mode for --untracked, e.g. "normal-adjusted-for-ignored" (it's a bad
> suggestion)? However the patch seems to add an orthogonal flag,
> such that
>
>    status --no-ignored --untracked=no --show-ignored-directory
>
> would also be possible. What is a reasonable expectation for
> the output of such?

The current patch does add another flag. This flag only has meaning if
the "--ignored" and "--untracked=all" flags are also specified. Another
option I had considered is to let the "--ignored" flag take an argument.
Then, we could express this new behavior through (for example) a
"--ignored=exact" flag to reflect the fact that this new option
returns paths that match the ignore pattern, and does not
collapse directories that contain only ignored files.

>> Motivation:
>> Our application (Visual Studio) needs all untracked files listed
>> individually, but does not need all ignored files listed individually.
> For parsing output, I would strongly recommend --porcelain[=2],
> but that is a tangent.
>
>> Reporting all ignored files can affect the time it takes for status
>> to run. For a representative repository, here are some measurements
>> showing a large perf improvement for this scenario:
>>
>> | Command | Reported ignored entries | Time (s) |
>> | ------- | ------------------------ | -------- |
>> | 1       | 0                        | 1.3      |
>> | 2       | 1024                     | 4.2      |
>> | 3       | 174904                   | 7.5      |
>> | 4       | 1046                     | 1.6      |
>>
>> Commands:
>>   1) status
>>   2) status --ignored
>>   3) status --ignored --untracked-files=all
>>   4) status --ignored --untracked-files=all --show-ignored-directory
>> (2) is --untracked-files=normal I'd presume, such that this flag
>> can be understood as a tweak to "normal" based on the similar size
>> between 2 and 4? (The timing improvement from 2 to 4 is huge though).
(2) is --untracked-files=normal. Although the count of ignored
files similar between 2 and 4, I consider this flag more of a
tweak on 3, as we want the untracked files reported with
the "--untracked=all" flag. The counts between 2 and 4 are
similar in this case because most of the ignored files are
contained in ignored directories.

Our application calls status including the following flags:

--porcelain=v2 --ignored --untracked-files=all --ignore-submodules=none

This means we have bad performance compared to just "git status"
when there is a large number of files in ignored directories
With this new behavior, our application would move from case 3 to
case 4 for this repository.

You also point out the timing difference between case 2 and 4. I
think there is an optimization we can make when running "git
status --ignored" logic that will improve the the timing
here. Currently, the logic in dir.c is iterating over all files
contained in an ignored directory to see if it is empty or
not. This is not necessary - we should be able to stop after
finding any file. I plan to follow up on this in a different
patch.

>> This changes exposes a --show-ignored-directory flag to the git status
> s/changes/change/
>
>> command. This flag is utilized when running git status with the
>> --ignored and --untracked-files options to not list ignored individual
>> ignored files contained in directories that match an ignore pattern.
>>
>> Part of the perf improvement comes from the tweak to
>> read_directory_recursive to stop scanning the file system after it
>> encounters the first file. When a directory is ignored, all it needs to
>> determine is if the directory is empty or not. The logic currently keeps
>> scanning the file system until it finds an untracked file. However, as
>> the directory is ignored, all the contained contents are also marked
>> excluded. For ignored directories that contain a large number of files,
>> this can take some time.
> I think it is possible to ignore a directory and still track files in it, what
> are the implications of this flag on a tracked (and changed) file in an
> ignored dir?
It is possible to have tracked files in an ignored directory. The
behavior with this patch is to show individual files in the
ignored directory. This patch includes a test covering this
scenario. I think this behavior is reasonable for this case - I
am interested if there are other opinions on this.
>
> What happens to empty directories that match an ignore pattern?
>
The "git status" command would not show empty directories. From
the lower level implementation in dir.c, I think it *should*
depend on the DIR_HIDE_EMPTY_DIRECTORIES flag, but does not
currently. I will fix this with the next patch version.
>> @@ -1362,6 +1363,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>                    N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
>>                    PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>>                  OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
>> +               OPT_BOOL(0, "show-ignored-directory", &show_ignored_directory,
> Is it possible to directly read into  s.show_ignored_directory here?
>
>> +test_expect_success 'Verify behavior of status on folders with ignored files' '
>> +       test_when_finished "git clean -fdx" &&
>> +       git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
>> +       test_i18ncmp expect output
>> +'
>> +
>> +# Test status bahavior on folder with tracked and ignored files
> behavior
>
>> +cat >expect <<\EOF
>> +? expect
>> +? output
>> +! dir/tracked_ignored/ignored_1.ign
>> +! dir/tracked_ignored/ignored_2.ign
>> +! tracked_ignored/ignored_1.ign
>> +! tracked_ignored/ignored_2.ign
>> +EOF
> I think our latest 'best style' is to include these heredocs into the test.

