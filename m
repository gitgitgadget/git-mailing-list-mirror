Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D382E1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 11:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbeFDL7Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 07:59:25 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36081 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeFDL7S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 07:59:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id o9-v6so6360934qtp.3
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xq/QUEMawDvgULT2SrUMFZTsKB+lpuUgey5b+zHi3Ig=;
        b=UP3em0OEgDwA5/xjX6S47ZoydIecb9Rd1PpWvVo5mGEi0LYjZ+4kkpyjoXg8XTFeIN
         457qUTbVw5s4GnNYWGU4MLm1AlPK3wrt8DPNDdgCOmMRbQOSyR/U7xFFE047RYNyWh4l
         AvoGevZKBWNoe8Df033inG4EGza/5AF0YdMAV4VttYWG205kP+4N16fAJNwKx5o3/V5R
         KlIwJhNLNNv74nWd6Uh2vY8ut7YGX4+z5yChG/8PODQUVdq+bCYW4M1of7+rTf7B3ta+
         zaOlkZJ5YH+G44dOmgxNEPtvIwY9flxqGukk9tHnnmNLNh4cMuv45OKSdlCCMfE9JMfP
         Znpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xq/QUEMawDvgULT2SrUMFZTsKB+lpuUgey5b+zHi3Ig=;
        b=fkVIMNzfOpJ+Ywyh9//sxGWnRE/X6Yn7ipRr5WJWXnqE1t5hC3//Jp3AT73+LjIYhc
         WnDvmzB/TMss6QA6iCigymgt6+VluG1DVLGftKKQClJ5enlIW70yUC2Exx7eLDpeBTMD
         IBZ3d07z5TNTR1HkT2q7VBTjLIeR32cIpjCxC7b0iD44+vGnpfFwiXy9QNr9ETjTITAa
         LcZOH4HqnrT/Kvj5KCkh+iNC/TMYpyP86OobGwlV/6Rtrhh3WYCF8QITiZeok6daMxaa
         62OgeIls0T2TRRW87bGIRMGyPGZ7MjeGqqGZmg/L4/NWWHzazOz43vr3ug1cLVDeh68x
         E9EQ==
X-Gm-Message-State: APt69E10P7JFKM6SF61tHKSpTNYY5uiQhtxUXaqc/vMZNIGr5uDobXmK
        IkVyYEntZduhVSLIvS3nRNQ=
X-Google-Smtp-Source: ADUXVKKSiFsu1Y0Fmj5g/kiz2B/AfJM+PCuVG7c40oWg0hM+XKxMRrxX+zx3D5K1HROPZ8AWZpJ6CA==
X-Received: by 2002:aed:20e2:: with SMTP id 89-v6mr19805857qtb.8.1528113557432;
        Mon, 04 Jun 2018 04:59:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2d1c:9d08:485:87f2? ([2001:4898:8010:0:1652:9d08:485:87f2])
        by smtp.gmail.com with ESMTPSA id w21-v6sm14600904qkb.36.2018.06.04.04.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 04:59:16 -0700 (PDT)
Subject: Re: [PATCH v3 17/20] fsck: verify commit-graph
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-18-dstolee@microsoft.com> <867enhtb6n.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c1fa14f3-f1cc-a91f-6192-e97e6437d0c4@gmail.com>
Date:   Mon, 4 Jun 2018 07:59:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <867enhtb6n.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 12:17 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> If core.commitGraph is true, verify the contents of the commit-graph
>> during 'git fsck' using the 'git commit-graph verify' subcommand. Run
>> this check on all alternates, as well.
> All right, so we have one config variable to control the use of
> serialized commit-graph feaature.  Nice.
>
>> We use a new process for two reasons:
>>
>> 1. The subcommand decouples the details of loading and verifying a
>>     commit-graph file from the other fsck details.
> All right, I can agree with that.
>
> On the other hand using subcommand makes debugging harder, though not in
> this case (well separated functionality that can be easily called with a
> standalone command to be debugged).
>
>> 2. The commit-graph verification requires the commits to be loaded
>>     in a specific order to guarantee we parse from the commit-graph
>>     file for some objects and from the object database for others.
> I don't quite understand this.  Could you explain it in more detail?

We use `lookup_commit()` when verifying the commit-graph. If these 
commits were loaded earlier in the process and parsed directly from the 
object database, then we aren't comparing the commit-graph file contents 
against the ODB.

>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/git-fsck.txt |  3 +++
>>   builtin/fsck.c             | 21 +++++++++++++++++++++
>>   t/t5318-commit-graph.sh    |  8 ++++++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
>> index b9f060e3b2..ab9a93fb9b 100644
>> --- a/Documentation/git-fsck.txt
>> +++ b/Documentation/git-fsck.txt
>> @@ -110,6 +110,9 @@ Any corrupt objects you will have to find in backups or other archives
>>   (i.e., you can just remove them and do an 'rsync' with some other site in
>>   the hopes that somebody else has the object you have corrupted).
>>   
>> +If core.commitGraph is true, the commit-graph file will also be inspected
> Shouldn't we use `core.commitGraph` here?
>
>> +using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
>> +
>>   Extracted Diagnostics
>>   ---------------------
>>   
>> diff --git a/builtin/fsck.c b/builtin/fsck.c
>> index ef78c6c00c..a6d5045b77 100644
>> --- a/builtin/fsck.c
>> +++ b/builtin/fsck.c
>> @@ -16,6 +16,7 @@
>>   #include "streaming.h"
>>   #include "decorate.h"
>>   #include "packfile.h"
>> +#include "run-command.h"
>>   
>>   #define REACHABLE 0x0001
>>   #define SEEN      0x0002
>> @@ -45,6 +46,7 @@ static int name_objects;
>>   #define ERROR_REACHABLE 02
>>   #define ERROR_PACK 04
>>   #define ERROR_REFS 010
>> +#define ERROR_COMMIT_GRAPH 020
> Minor nitpick and a sidenote: I wonder if it wouldn't be better to
> either use hexadecimal constants, or use (1 << n) for all ERROR_*
> preprocesor constants.
>
>>   
>>   static const char *describe_object(struct object *obj)
>>   {
>> @@ -815,5 +817,24 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>>   	}
>>   
>>   	check_connectivity();
>> +
>> +	if (core_commit_graph) {
>> +		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
>> +		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL, NULL };
> I see that NULL at index 2 and 3 (at 3rd and 4th place) are here for
> "--object-dir" and <alternates-object-dir-path>, the last one is
> terminator for that case, but what is next to last NULL (at 5th place)
> for?
>
>> +		commit_graph_verify.argv = verify_argv;
>> +		commit_graph_verify.git_cmd = 1;
>> +
>> +		if (run_command(&commit_graph_verify))
>> +			errors_found |= ERROR_COMMIT_GRAPH;
>> +
>> +		prepare_alt_odb();
>> +		for (alt = alt_odb_list; alt; alt = alt->next) {
>> +			verify_argv[2] = "--object-dir";
>> +			verify_argv[3] = alt->path;
>> +			if (run_command(&commit_graph_verify))
>> +				errors_found |= ERROR_COMMIT_GRAPH;
>> +		}
>> +	}
> For performance reasons it may be better to start those 'git
> commit-graph verify' commands asynchronously earlier, so that they can
> run in parallel / concurrently wth other checks, and wait for them and
> get their error code at the end of git-fsck run.
>
> But that is probably better left for a separate commit.
>
>> +
>>   	return errors_found;
>>   }
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 2680a2ebff..4941937163 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -394,4 +394,12 @@ test_expect_success 'detect invalid checksum hash' '
>>   		"incorrect checksum"
>>   '
>>   
>> +test_expect_success 'git fsck (checks commit-graph)' '
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	git fsck &&
>> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
>> +		"incorrect checksum" &&
>> +	test_must_fail git fsck
>> +'
> All right; though the same caveats apply as with previous commit in
> series.  Perhaps it would be better to truncate commit-graph file, or
> corrupt it in some 'random' place.
>
>> +
>>   test_done
> Best,

