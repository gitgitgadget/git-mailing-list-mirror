Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6001F404
	for <e@80x24.org>; Mon,  5 Feb 2018 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeBEVBf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:01:35 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36863 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeBEVBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:01:33 -0500
Received: by mail-qt0-f194.google.com with SMTP id t25so7851657qtg.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GZMZmmB4SUrhzoJwtd2fAptWuilDJ1X7o47S9iyrRQw=;
        b=N0JdowVs8Yi1fG4QvnNToPyDDX4wxvt8ejNBFp0NS53qWK7o5a6TtHp9+0Ouvfgcf7
         Cc3f+ULoTelntJ/ov0lvdPa1TXHaebZcKdvna09fZ/xtd1XULl73rsnb0WGMigak6w5G
         f0pBfAAlrlVGt0XR6fq+uULbnrjwZXOpCOTW33hn+OSneoKhgNIX+pvkpwuPg5EQd4Dm
         RPBxTNhxem7dPkbEKxyQ2Ugkt4U8xRC4jA4Om9gssrGsHeftJ038ki0Ss4JQYQRKwX/o
         PqisuraDLDNcOzVqCxpT9ekX34GYTrdtwL3k7jAzzDKYHsGkCTiggVeatNrHrxlvzX/A
         ZLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GZMZmmB4SUrhzoJwtd2fAptWuilDJ1X7o47S9iyrRQw=;
        b=bS+92LzN+pMaSps9IP7uXP4Ldkgr1axn2Av6UmAy1k1ngCRPC+DBSmvBPTcC0SxPqE
         Np20DB/NR6Z72fKP4/jLhhDQd/u586JewLhuqE1fzqSvhhBvv5byI5Z0cOBqbufHd9NO
         Q4fUcVNkR1yZ1x58xYdgyIpcIVuxGbfvkiNyL6S712NfHKpN7kEjX9lfRGijqIDpqorG
         VUXEikRHZ05UQIC3g1Hv28WSrhR/nXz6drli2a30sADTffVPiud6YrSUITsfWi25EWE/
         Hi4qLazoKc8FFu5IIDzUZWbj0ovN21CGB8CuiIPJ9dC6KkJ8sKVAA9XvK145pBv0RWP6
         TXbw==
X-Gm-Message-State: APf1xPBb2hMywjOcwcI5aC+A2TFvjunEDkaOqO0DNW79SHORtTophzG3
        OYJ3INa41QDGu221QpcpNk0=
X-Google-Smtp-Source: AH8x2260pAuWHjpE4kDHrHNF5onLUyhqpUn6wKajiSMGQgJi/lNGitgwGlnR+Q0/RlRsd8yXvJkjIA==
X-Received: by 10.200.39.241 with SMTP id x46mr213608qtx.266.1517864492858;
        Mon, 05 Feb 2018 13:01:32 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y30sm6598124qtm.50.2018.02.05.13.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 13:01:32 -0800 (PST)
Subject: Re: [PATCH v2 07/14] commit-graph: implement git-commit-graph
 --update-head
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-8-git-send-email-dstolee@microsoft.com>
 <20180202013552.24931-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <316c100b-2c27-83e3-53d8-46b545f0353e@gmail.com>
Date:   Mon, 5 Feb 2018 16:01:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202013552.24931-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2018 8:35 PM, SZEDER Gábor wrote:
>> It is possible to have multiple commit graph files in a pack directory,
>> but only one is important at a time. Use a 'graph_head' file to point
>> to the important file.
> This implies that all those other files are ignored, right?

Yes. We do not use directory listings to find graph files.

>
>> Teach git-commit-graph to write 'graph_head' upon
>> writing a new commit graph file.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/git-commit-graph.txt | 34 ++++++++++++++++++++++++++++++++++
>>   builtin/commit-graph.c             | 38 +++++++++++++++++++++++++++++++++++---
>>   commit-graph.c                     | 25 +++++++++++++++++++++++++
>>   commit-graph.h                     |  2 ++
>>   t/t5318-commit-graph.sh            | 12 ++++++++++--
>>   5 files changed, 106 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index 09aeaf6c82..99ced16ddc 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -12,15 +12,49 @@ SYNOPSIS
>>   'git commit-graph' --write <options> [--pack-dir <pack_dir>]
>>   'git commit-graph' --read <options> [--pack-dir <pack_dir>]
>>   
>> +OPTIONS
>> +-------
> Oh, look, the 'OPTIONS' section I missed in the previous patches! ;)
>
> This should be split up and squashed into the previous patches where
> the individual --options are first mentioned.
>
>> +--pack-dir::
>> +	Use given directory for the location of packfiles, graph-head,
>> +	and graph files.
>> +
>> +--read::
>> +	Read a graph file given by the graph-head file and output basic
>> +	details about the graph file. (Cannot be combined with --write.)
>  From the output of 'git commit-graph --read' it seems that it's not a
> generally useful option to the user.  Perhaps it should be mentioned
> that it's only intended as a debugging aid?  Or maybe it doesn't
> really matter, because eventually this command will become irrelevant,
> as other commands (clone, fetch, gc) will invoke it automagically...

I'll add some wording to make this clear.

>
>> +--graph-id::
>> +	When used with --read, consider the graph file graph-<oid>.graph.
>> +
>> +--write::
>> +	Write a new graph file to the pack directory. (Cannot be combined
>> +	with --read.)
> I think this should also mention that it prints the generated graph
> file's checksum.
>
>> +
>> +--update-head::
>> +	When used with --write, update the graph-head file to point to
>> +	the written graph file.
> So it should be used with '--write', noted.
>
>>   EXAMPLES
>>   --------
>>   
>> +* Output the hash of the graph file pointed to by <dir>/graph-head.
>> ++
>> +------------------------------------------------
>> +$ git commit-graph --pack-dir=<dir>
>> +------------------------------------------------
>> +
>>   * Write a commit graph file for the packed commits in your local .git folder.
>>   +
>>   ------------------------------------------------
>>   $ git commit-graph --write
>>   ------------------------------------------------
>>   
>> +* Write a graph file for the packed commits in your local .git folder,
>> +* and update graph-head.
>> ++
>> +------------------------------------------------
>> +$ git commit-graph --write --update-head
>> +------------------------------------------------
>> +
>>   * Read basic information from a graph file.
>>   +
>>   ------------------------------------------------
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 218740b1f8..d73cbc907d 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -11,7 +11,7 @@
>>   static char const * const builtin_commit_graph_usage[] = {
>>   	N_("git commit-graph [--pack-dir <packdir>]"),
>>   	N_("git commit-graph --read [--graph-hash=<hash>]"),
>> -	N_("git commit-graph --write [--pack-dir <packdir>]"),
>> +	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head]"),
>>   	NULL
>>   };
>>   
>> @@ -20,6 +20,9 @@ static struct opts_commit_graph {
>>   	int read;
>>   	const char *graph_hash;
>>   	int write;
>> +	int update_head;
>> +	int has_existing;
>> +	struct object_id old_graph_hash;
>>   } opts;
>>   
>>   static int graph_read(void)
>> @@ -30,8 +33,8 @@ static int graph_read(void)
>>   
>>   	if (opts.graph_hash && strlen(opts.graph_hash) == GIT_MAX_HEXSZ)
>>   		get_oid_hex(opts.graph_hash, &graph_hash);
>> -	else
>> -		die("no graph hash specified");
>> +	else if (!get_graph_head_hash(opts.pack_dir, &graph_hash))
>> +		die("no graph-head exists");
>>   
>>   	graph_file = get_commit_graph_filename_hash(opts.pack_dir, &graph_hash);
>>   	graph = load_commit_graph_one(graph_file, opts.pack_dir);
>> @@ -62,10 +65,33 @@ static int graph_read(void)
>>   	return 0;
>>   }
>>   
>> +static void update_head_file(const char *pack_dir, const struct object_id *graph_hash)
>> +{
>> +	struct strbuf head_path = STRBUF_INIT;
>> +	int fd;
>> +	struct lock_file lk = LOCK_INIT;
>> +
>> +	strbuf_addstr(&head_path, pack_dir);
>> +	strbuf_addstr(&head_path, "/");
>> +	strbuf_addstr(&head_path, "graph-head");
> strbuf_addstr(&head_path, "/graph-head"); ?
>
>> +
>> +	fd = hold_lock_file_for_update(&lk, head_path.buf, LOCK_DIE_ON_ERROR);
>> +	strbuf_release(&head_path);
>> +
>> +	if (fd < 0)
>> +		die_errno("unable to open graph-head");
>> +
>> +	write_in_full(fd, oid_to_hex(graph_hash), GIT_MAX_HEXSZ);
>> +	commit_lock_file(&lk);
> The new graph-head file will be writable.  All other files in
> .git/objects/pack are created read-only, including graph files.  Just
> pointing it out, but I don't think it's a bit deal; other than
> consistency with the permissions of other files I don't have any
> argument for making it read-only.

I don't have strong opinions on the permissions difference, except that 
a graph-<hash>.graph file should not change contents (or the hash will 
be wrong) but a user or external tool could change the graph-head 
contents to point to a different file. I can't think of a case where 
that is important.
