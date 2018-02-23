Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9E01F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754509AbeBWTTa (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:19:30 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43332 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754057AbeBWTT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:19:27 -0500
Received: by mail-qk0-f193.google.com with SMTP id j4so6222614qke.10
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+APtplzf45Vsom9XxgTaZ22mI2/UlRA/ac6plJu08kU=;
        b=uKYKBhqvHqWxM5wPYp4yaprujUrY9zGi83WMLNZkZ9xMspx3XCnu1ikqgJrG75kwFB
         CwLMcwIiEDCvY3RzjJWFk9cVZfzmHiPrCXSwrjfiluadgbrUedwXnrRurGnem4aX3h3O
         Zz8YVeOMIvnmtfr2yAEL/jACFldT8b5O6Xrx50TKq8q8EBpIorCLHlf0lXrIwX8GfkcC
         IWeKAt1wAty40vXkVwSf5TeQ0D2Akjq4ZvdP4z+PM7xSV5XGKE+jBDdt/pZBhO/0YSj2
         62KCF95hGEQg14bVL/L4BsR5BOMTOf9ZfegW0/gln8A7GEsecQUHxlNnAheGr4yDERuu
         PXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+APtplzf45Vsom9XxgTaZ22mI2/UlRA/ac6plJu08kU=;
        b=tm7Sf8Q1+qtj9WrOZvACDHL9/cRhVRUboGUo367/hCg2QVKwap4yjROJ/mdk3bHo4A
         svfXrGlgEl6vfbyWw6WQpOjrlq/JwlaOPNUdLngss4DCawIDKNHoUczdKp1J8mMSHuVW
         QNmpVKvFzUtO7Xc+GUap2YbsVD3Tjckbmnw5E6Jb9pUNiE1BFGvkC+tpjQMabWk7VTqM
         JC54kr346C2ekW60lhjwL+scFZnSfCECmIA++VEo5s6NZC0u9RRAzIqoscsKB+66hjsQ
         e0i5xshCaCRigu0edkUXnQtgDBbF0ZhVbs5DCMzSgy3k97zkjq4Cik6YKEbiRSvHfViQ
         EP4w==
X-Gm-Message-State: APf1xPDHi1DT3gIPpSEOM4gyoW6/ner2U/jgOlZlSV1yuZUz4HNzAFuC
        tWJzpUmhfwNuyqzhAZr+uxM=
X-Google-Smtp-Source: AG47ELsgq3l6GO+d7OHizpoLRnzaDqeMKAIQ8XWnvjiigi63CkRS4ZNUG8T3bBWV7bShZCjTSUE70Q==
X-Received: by 10.55.239.26 with SMTP id j26mr4247964qkk.315.1519413566097;
        Fri, 23 Feb 2018 11:19:26 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id q24sm2166000qkq.75.2018.02.23.11.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 11:19:25 -0800 (PST)
Subject: Re: [PATCH v4 12/13] commit-graph: read only from specific
 pack-indexes
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-13-git-send-email-dstolee@microsoft.com>
 <CAGZ79kZbdvehOQMZj3NkkSt5RoArtv0ixb8pHvFDrHTrWmVuDg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3609f373-28e9-e849-7126-cd88b54013b9@gmail.com>
Date:   Fri, 23 Feb 2018 14:19:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZbdvehOQMZj3NkkSt5RoArtv0ixb8pHvFDrHTrWmVuDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2018 5:25 PM, Stefan Beller wrote:
> On Mon, Feb 19, 2018 at 10:53 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> Teach git-commit-graph to inspect the objects only in a certain list
>> of pack-indexes within the given pack directory. This allows updating
>> the commit graph iteratively, since we add all commits stored in a
>> previous commit graph.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/git-commit-graph.txt | 11 +++++++++++
>>   builtin/commit-graph.c             | 32 +++++++++++++++++++++++++++++---
>>   commit-graph.c                     | 26 ++++++++++++++++++++++++--
>>   commit-graph.h                     |  4 +++-
>>   packfile.c                         |  4 ++--
>>   packfile.h                         |  2 ++
>>   t/t5318-commit-graph.sh            | 16 ++++++++++++++++
>>   7 files changed, 87 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index b9b4031..93d50d1 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -42,6 +42,10 @@ With the `--delete-expired` option, delete the graph files in the pack
>>   directory that are not referred to by the graph-latest file. To avoid race
>>   conditions, do not delete the file previously referred to by the
>>   graph-latest file if it is updated by the `--set-latest` option.
>> ++
>> +With the `--stdin-packs` option, generate the new commit graph by
>> +walking objects only in the specified packfiles and any commits in
>> +the existing graph-head.
> A general question on this series:
> How do commit graph buildups deal with garbage collected commits?
> (my personal workflow is heavy on rebase, which generates lots of
> dangling commits, to be thrown out later)
>
> The second half of the sentence makes it sound like once a
> commit is in the graph it cannot be pulled out easily again, hence
> the question on the impact of graphs on a long living repository
> which is garbage collected frequently.

This is another place that I failed to update when I stopped 
automatically including commits from the existing graph. As of v4, the 
new graph should only contain commits reachable from the commits 
discovered by the three mechanisms (inspecting all packs, inspecting the 
--stdin-packs, or reading the OIDs with --stdin-commits). Thus, commits 
that are GC'd will not appear in the new graph.

If a commit has been GC'd, then parse_commit_gently() will never be 
called since it is called after lookup_object() to create the struct 
commit. The only case we could have is where we navigate to a parent 
using the commmit graph but that parent is GC'd (this does not make sense).

It may be helpful to add an "--additive" argument to specify that we 
want to keep all commits that are already in the graph.

> AFAICT you could just run
>      git commit-graph write --set-latest [--delete-expired]
> as that actually looks up objects from outside the existing graph files,
> such that lost objects are ignored?
>
>> +       const char **lines = NULL;
>> +       int nr_lines = 0;
>> +       int alloc_lines = 0;
> (nit:)
> I had the impression that these triplet-variables, that are used in
> ALLOC_GROW are allo X, X_nr and X_allow, but I might be wrong.

"git grep ALLOC_GROW" confirms your impression. Will fix.

>
>> @@ -170,7 +178,25 @@ static int graph_write(int argc, const char **argv)
>>
>>          old_graph_name = get_graph_latest_contents(opts.obj_dir);
>>
>> -       graph_name = write_commit_graph(opts.obj_dir);
>> +       if (opts.stdin_packs) {
>> +               struct strbuf buf = STRBUF_INIT;
>> +               nr_lines = 0;
>> +               alloc_lines = 128;
> alloc_lines has been initialized before, so why redo it here again?
> Also what is the rationale for choosing 128 as a good default?
> I would guess 0 is just as fine, because ALLOC_GROW makes sure
> that it growth fast in the first couple entries by having an additional
> offset. (no need to fine tune the starting allocation IMHO)

I was unaware that ALLOC_GROW() handled the alloc == 0 case. Thanks.

>
>> +               ALLOC_ARRAY(lines, alloc_lines);
>> +
>> +               while (strbuf_getline(&buf, stdin) != EOF) {
>> +                       ALLOC_GROW(lines, nr_lines + 1, alloc_lines);
>> +                       lines[nr_lines++] = buf.buf;
>> +                       strbuf_detach(&buf, NULL);
> strbuf_detach returns its previous buf.buf, such that you can combine these
> two lines as
>      lines[nr_lines++] = strbuf_detach(&buf, NULL);
>
>
>> +               }
>> +
>> +               pack_indexes = lines;
>> +               nr_packs = nr_lines;
> Technically we do not need to strbuf_release(&buf) here, because
> strbuf_detach is always called, and by knowing its implementation,
> it is just as good.
>
>
>> @@ -579,7 +581,27 @@ char *write_commit_graph(const char *obj_dir)
>>                  oids.alloc = 1024;
>>          ALLOC_ARRAY(oids.list, oids.alloc);
>>
>> -       for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
>> +       if (pack_indexes) {
>> +               struct strbuf packname = STRBUF_INIT;
>> +               int dirlen;
>> +               strbuf_addf(&packname, "%s/pack/", obj_dir);
>> +               dirlen = packname.len;
>> +               for (i = 0; i < nr_packs; i++) {
>> +                       struct packed_git *p;
>> +                       strbuf_setlen(&packname, dirlen);
>> +                       strbuf_addstr(&packname, pack_indexes[i]);
>> +                       p = add_packed_git(packname.buf, packname.len, 1);
>> +                       if (!p)
>> +                               die("error adding pack %s", packname.buf);
>> +                       if (open_pack_index(p))
>> +                               die("error opening index for %s", packname.buf);
>> +                       for_each_object_in_pack(p, if_packed_commit_add_to_list, &oids);
>> +                       close_pack(p);
>> +               }
> strbuf_release(&packname);
>
>> +       }
>> +       else
> (micro style nit)
>
>      } else

