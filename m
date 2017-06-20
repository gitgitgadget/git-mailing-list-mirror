Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9A420D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 02:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbdFTCMm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:12:42 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:35246 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdFTCMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:12:41 -0400
Received: by mail-ot0-f176.google.com with SMTP id u13so66031642otd.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AvmCRLwYfItjWlZBqQDBZJfzyo9QR3sjEuuQakXkbxk=;
        b=QdhbXqjOXtNK1qMOOfGndKJNyukvHed/oBOMsWUPsYQQishaQ0ruvzqbo5ydwBHtPk
         xDuEsl5u6+OI+V5YkL8eLGqG7uQG2kaMk2OVRhuT7IyoVBoh54wNNAxZ/lONWGrpk5n1
         a+FYd9i0qnUChEag064NpXzcPoxdFNff7NhnYDjrlSOdqpvvRW4IMm8WKBcfk3Jgj/d3
         xacnpe/j1oy2Dx9yRWeYTjQIMYPaQ0Q8kkiJhqnzkj23KTMzmY5Kyukr2C4KpujL81Ox
         sOrrE5t+3EW8j3KwXMSjK5T1AU0wx5UBFRd/CImrpYRkmD7uYShiVfHmDCerY1sSwZDL
         Zufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AvmCRLwYfItjWlZBqQDBZJfzyo9QR3sjEuuQakXkbxk=;
        b=psw9XpSEuhQaKBABFSCoFHY++pX2qe2T5m9nsrv5nqNF1C0nGhBABSj/V9dWFBa5sC
         a2PvA6TQLVQ3btXu7VRSUPFPVQpd7JR0fCUF0HZAldVNv3tzeJFE/xCUjFPmwovjHEIn
         j43oNQLdQKZfL+SV6UR2Jdj0/dn8zUZfNYAuzoePK8RgEyzwPAQ5AyADVHL0s6TrxuQs
         9QpEEwGf3IeJESG06cmjVGDYYwu1jgkTUA6kkS4YjDEsY2vxeE+q/wa0g+uRqm3OzDwz
         k99XR69A5lfjGoFr3NqS3OLi9dYwvLlA0ZSUqvgTaQmXRh7pG5oVUfywObB1v7X68Sgk
         Pl4A==
X-Gm-Message-State: AKS2vOwGlj4mA2xcio4gELc+PZen636dXXWiUS5G10h9SzsURB8xrXhM
        KjYGy+pqxLWPD/KAxJ5Pk4nTDLrY7zGz
X-Received: by 10.157.43.10 with SMTP id o10mr4379629otb.73.1497924760867;
 Mon, 19 Jun 2017 19:12:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.36.136 with HTTP; Mon, 19 Jun 2017 19:12:20 -0700 (PDT)
In-Reply-To: <xmqqvanvv9be.fsf@gitster.mtv.corp.google.com>
References: <20170608005535.13080-1-joel@teichroeb.net> <20170608005535.13080-6-joel@teichroeb.net>
 <xmqqvanvv9be.fsf@gitster.mtv.corp.google.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Mon, 19 Jun 2017 19:12:20 -0700
X-Google-Sender-Auth: GD76c6gqm6jISnoQSq4grJvCltY
Message-ID: <CA+CzEk8+B71RoMeiZukfST-e6Ry+BijkNzHBusHycq2nhh2sPw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Joel Teichroeb <joel@teichroeb.net> writes:
>> +/*
>> + * Untracked files are stored by themselves in a parentless commit, for
>> + * ease of unpacking later.
>> + */
>> +static int save_untracked(struct stash_info *info, const char *message,
>> +             int include_untracked, int include_ignored, const char **argv)
>> +{
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +     struct strbuf out = STRBUF_INIT;
>> +     struct object_id orig_tree;
>> +     int ret;
>> +     const char *index_file = get_index_file();
>> +
>> +     set_alternate_index_output(stash_index_path);
>> +     untracked_files(&out, include_untracked, include_ignored, argv);
>> +
>> +     cp.git_cmd = 1;
>> +     argv_array_pushl(&cp.args, "update-index", "-z", "--add", "--remove",
>> +             "--stdin", NULL);
>> +     argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
>> +
>> +     if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0)) {
>> +             strbuf_release(&out);
>> +             return 1;
>> +     }
>> +
>
> OK, that's a very straight-forward way of doing this, and as we do
> not care too much about performance in this initial conversion to C,
> it is even sensible.  In a later update after this patch lands, you
> may want to use dir.c's fill_directory() API to find the untracked
> files and add them yourself internally, without running ls-files (in
> untracked_files()) or update-index (here) as subprocesses, but that
> is in the future.  Let's get this round finished.
>
>> +     strbuf_reset(&out);
>> +
>> +     discard_cache();
>> +     read_cache_from(stash_index_path);
>> +
>> +     write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0,NULL);
>
> SP before "NULL".
>
>> +     discard_cache();
>> +
>> +     read_cache_from(stash_index_path);
>
> Hmph, what did anybody change in the on-disk stash_index (or
> contents in the_index) since you read_cache_from()?
>
>> +     write_cache_as_tree(info->u_tree.hash, 0, NULL);
>
> Then you write exactly the same index contents again, this time to
> info->u_tree here.  I am not sure why you need to do this twice, and
> I do not see how orig_tree.hash you wrote earlier is used?
>

I'm not sure I understand what's happening here either. When I was
writing this, it was essentially a lot of trial and error in order to
get the index handling correct. Getting rid of any single one of these
lines makes the test fail. At some point I'd like to redo all the
index handling parts here, as I think I can do without an additional
index, but I'd need to make sure the error handling is perfect first.
