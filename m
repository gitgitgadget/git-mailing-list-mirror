Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B252023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbdCBASx (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:18:53 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33740 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753424AbdCBASw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:18:52 -0500
Received: by mail-oi0-f52.google.com with SMTP id 2so31343975oif.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A8K9In8b/U1pgZGi5EbEDA2xLmTnq1LFDq0ERYoCL0U=;
        b=KdmgDWi/Odac6huwY8QTunuNK2oxLaCejVS6sn4UtCJJu7VB1MujqHTfuFkFttJkq1
         JfzZOsV7taXW9LKiHYl4AHVwLrBba6aptLnfAvXPxjJG1Qi5MAkejwvbI0Ke5u+3nbHO
         rIIU41OxqiweBIcCs7SC2+CaO3T5qbTCObe+XDZTX6S7JpU1L8vGkgjpTDM+aAIsis5t
         4w0JWzz24V4gYeUrhIHaG1BglQFZR/fRf43MUAFcjksRC8dQj41dP4Z6j7e5IXRKSzQH
         w6CzWpKc0jj6s9TshdvImG499TTebGyeO9Wb2tulgyKDLXEZrTNNXxDKo+XL6rvuxI7z
         HQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=A8K9In8b/U1pgZGi5EbEDA2xLmTnq1LFDq0ERYoCL0U=;
        b=ZJ3JWjhSLuCsb62axU/ORgLaGSIgkXrzCw67Yn8L7Z1FpCyUinVnxCiB8QtCTl80GD
         ZCKNRX3K+PUsAoX80MTopqTfqH664f2HbbZIxVliNUPrzQuiRJ114YfBLTSAZHoZr09Z
         hbifMnxsU0lzL7OcOj+B2KcOH5c0R2mviYO2KIcrnrZQHuLwmDbhk0Ruc2629OY7E1MW
         BpaJGlDN6MzohFQxz9Wjabu4HojhdIOt+Vg5RpVtfp+ZILs7PO4MkRUoJGDrHjAIkJHX
         5DyzeUxoKt2Uahgo/5usEwP4ABQ6nqs7+cWDiM9sNX25hUQslZVzqQFmsSzqXFKHnvkw
         tlGA==
X-Gm-Message-State: AMke39kGgpbtAa6lrRSpJAoduU2mdCoFHK0KxQZ4HHspOqpBL2fjqJzt5E5L1ysIy2sTEA==
X-Received: by 10.202.5.5 with SMTP id 5mr6103720oif.141.1488413527479;
        Wed, 01 Mar 2017 16:12:07 -0800 (PST)
Received: from [172.31.98.12] (96-83-49-155-static.hfc.comcastbusiness.net. [96.83.49.155])
        by smtp.gmail.com with ESMTPSA id g21sm1591523otd.7.2017.03.01.16.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 16:12:06 -0800 (PST)
Subject: Re: Delta compression not so effective
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
 <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com>
 <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Marius Storm-Olsen <mstormo@gmail.com>
Message-ID: <603afdf2-159c-6bed-0e85-2824391185d1@gmail.com>
Date:   Wed, 1 Mar 2017 18:12:10 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2017 12:30, Linus Torvalds wrote:
> On Wed, Mar 1, 2017 at 9:57 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>>
>> Indeed, I did do a
>>     -c pack.threads=20 --window-memory=6g
>> to 'git repack', since the machine is a 20-core (40 threads) machine with
>> 126GB of RAM.
>>
>> So I guess with these sized objects, even at 6GB per thread, it's not enough
>> to get a big enough Window for proper delta-packing?
>
> Hmm. The 6GB window should be plenty good enough, unless your blobs
> are in the gigabyte range too.

No, the list of git verify-objects in the previous post was from the 
bottom of the sorted list, so those are the largest blobs, ~249MB..


>> This repo took >14hr to repack on 20 threads though ("compression" step was
>> very fast, but stuck 95% of the time in "writing objects"), so I can only
>> imagine how long a pack.threads=1 will take :)
>
> Actually, it's usually the compression phase that should be slow - but
> if something is limiting finding deltas (so that we abort early), then
> that would certainly tend to speed up compression.
>
> The "writing objects" phase should be mainly about the actual IO.
> Which should be much faster *if* you actually find deltas.

So, this repo must be knocking several parts of Git's insides. I was 
curious about why it was so slow on the writing objects part, since the 
whole repo is on a 4x RAID 5, 7k spindels. Now, they are not SSDs sure, 
but the thing has ~400MB/s continuous throughput available.

iostat -m 5 showed trickle read/write to the process, and 80-100% CPU 
single thread (since the "write objects" stage is single threaded, 
obviously).

The failing delta must be triggering other negative behavior.


> For example, the sorting code thinks that objects with the same name
> across the history are good sources of deltas. But it may be that for
> your case, the binary blobs that you have don't tend to actually
> change in the history, so that heuristic doesn't end up doing
> anything.

These are generally just DLLs (debug & release), which content is 
updated due to upstream project updates. So, filenames/paths tend to 
stay identical, while content changes throughout history.


> The sorting does use the size and the type too, but the "filename
> hash" (which isn't really a hash, it's something nasty to give
> reasonable results for the case where files get renamed) is the main
> sort key.
>
> So you might well want to look at the sorting code too. If filenames
> (particularly the end of filenames) for the blobs aren't good hints
> for the sorting code, that sort might end up spreading all the blobs
> out rather than sort them by size.

Filenames are fairly static, and the bulk of the 6000 biggest 
non-delta'ed blobs are the same DLLs (multiple of them)


> And again, if that happens, the "can I delta these two objects" code
> will notice that the size of the objects are wildly different and
> won't even bother trying. Which speeds up the "compressing" phase, of
> course, but then because you don't get any good deltas, the "writing
> out" phase sucks donkey balls because it does zlib compression on big
> objects and writes them out to disk.

Right, now on this machine, I really didn't notice much difference 
between standard zlib level and doing -9. The 203GB version was actually 
with zlib=9.


> So there are certainly multiple possible reasons for the deltification
> to not work well for you.
>
> Hos sensitive is your material? Could you make a smaller repo with
> some of the blobs that still show the symptoms? I don't think I want
> to download 206GB of data even if my internet access is good.

Pretty sensitive, and not sure how I can reproduce this reasonable well. 
However, I can easily recompile git with any recommended 
instrumentation/printfs, if you have any suggestions of good places to 
start? If anyone have good file/line numbers, I'll give that a go, and 
report back?

Thanks!

-- 
.marius
