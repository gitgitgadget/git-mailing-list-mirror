Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5015A1F600
	for <e@80x24.org>; Sun, 23 Jul 2017 23:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdGWXtC (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 19:49:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38226 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdGWXrl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 19:47:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id r123so1358681wmb.5
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Bb1pUOa/tUdaklMgGTkSB2hwCI5Pi1UPQC5fYC5IZuk=;
        b=MHAC7JzEWz9Bf9Be6gFXyLBGpE+GieYlVKVB6viNXQfawP4tQVXjqFrl/V81+dAoMc
         CALW69jlRnI8JxF1I1sDN6lHFo+jbXYhyniSG2/iZgqm1aSxToTGQy2KkLp2jEwukEtV
         AniHfjGALGzkGjbZN4jv+y0xdFi/dq9D9rIUrKwYq+j+AhCqDYdub2ZlHNJ3pFtux0FS
         WtObOvxik7DZ/fs16LZydXhhWBWWxdAmihlN0ss62RQK1sIBMm+PYuLsWMWZ77UUK88J
         wRs04Kipe12WqWKc/xvHp8suxY894G6ulOnOPszh3VuZMq9DXPtXPKm1qOsAdDMfn4jm
         HyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Bb1pUOa/tUdaklMgGTkSB2hwCI5Pi1UPQC5fYC5IZuk=;
        b=FOj/3OhuO1bE70XgiS+mbZCweLGIjzcNs5S3zh7HUjlUtONaBXH5W2hKAF2wLyQDPf
         voRaKwRN03iTqqnEDxGMnnzIIeeViuU1+KWktki02aH+LeFelLQTfcAknV0sn9+RUXVt
         yKNoHQLQydnQaopXM3Y4HGYxQNd/fi9qHuGghT5tl7IyUY/NjUVCNkB3a/f1qELZaHTP
         ijGKz9l/Jm5iZ0DbR2AhQLmtIDoxKSkbCQKfKILS+mhQpoyQI3LbeyzVmJClBwaw4XDb
         tTCct6cEm/qtuLoS0X8mngaASgBD1Ly0pgQ0D8Sp60/KR32khaoWW+zCt2YvS63PRY8P
         oJYg==
X-Gm-Message-State: AIVw1105/H6nerYFGUK+TrD+JpcIaihW2XqGFgQGD8Q5iUmG1nxosNSE
        vM9e13q+bifziA==
X-Received: by 10.80.143.35 with SMTP id 32mr12900633edy.197.1500853660215;
        Sun, 23 Jul 2017 16:47:40 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id h58sm5837615edh.52.2017.07.23.16.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jul 2017 16:47:39 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dZQb4-0003bg-70; Mon, 24 Jul 2017 01:47:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: reftable [v2]: new ref storage format
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com> <xmqqlgnmhmep.fsf@gitster.mtv.corp.google.com> <CAJo=hJuP9GdudFsA_ToFQwx-zESaDHRDXHLxmvAXSX5CKmh7JQ@mail.gmail.com> <87k234tti7.fsf@gmail.com> <CAJo=hJtCL6ZH2DPgCAkQptouM0xSbSnfwMX-f+RM=1wCucay9g@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAJo=hJtCL6ZH2DPgCAkQptouM0xSbSnfwMX-f+RM=1wCucay9g@mail.gmail.com>
Date:   Mon, 24 Jul 2017 01:47:38 +0200
Message-ID: <87o9sapvfp.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 23 2017, Shawn Pearce jotted:

> My apologies for not responding to this piece of feedback earlier.
>
> On Wed, Jul 19, 2017 at 7:02 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> On Tue, Jul 18 2017, Shawn Pearce jotted:
>>> On Mon, Jul 17, 2017 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Shawn Pearce <spearce@spearce.org> writes:
>>>>> where `time_sec` is the update time in seconds since the epoch.  The
>>>>> `reverse_int32` function inverses the value so lexographical ordering
>>>>> the network byte order time sorts more recent records first:
>>>>>
>>>>>     reverse_int(int32 t) {
>>>>>       return 0xffffffff - t;
>>>>>     }
>>>>
>>>> Is 2038 an issue, or by that time we'd all be retired together with
>>>> this file format and it won't be our problem?
>>>
>>> Based on discussion with Michael Haggerty, this is now an 8 byte field
>>> storing microseconds since the epoch. We should be good through year
>>> 9999.
>>
>> I think this should be s/microseconds/nanoseconds/, not because there's
>> some great need to get better resolution than nanoseconds, but because:
>>
>>  a) We already have WIP code (bp/fsmonitor) that's storing 64 bit
>>     nanoseconds since the epoch, albeit for the index, not for refs.
>>
>>  b) There are several filesystems that have nanosecond resolution now,
>>     and it's likely more will start using that.
>
> The time in a reflog and the time returned by lstat(2) to detect dirty
> files in the working tree are unrelated. Of course we want the
> dircache to be reflecting the highest precision available from lstat,
> to reduce the number of files that must be content hashed for racily
> clean detection. So if a filesystem is using nanoseconds, dircache
> maybe should support it.
>
>> Thus:
>>
>>  x) If you use such a filesystem you'll lose time resolution with this
>>     ref backend v.s. storing them on disk, which isn't itself a big
>>     deal, but more importantly you lose 1=1 time mapping as you
>>     transition and convert between the two.
>
> No, you won't. The reflog today ($GIT_DIR/logs) is storing second
> precision in the log record. What precision the filesystem is using as
> an mtime is irrelevant.

To this & the point above: Sorry about being unclear, I'm talking about
the mtime on the modified loose ref. This format proposes to replace
both loose & packed refs, does it not? The reflog time is not the only
place were we store the mtime of a ref. On my local ext4:

    $ tail -n 1 .git/logs/refs/heads/master
    <sha1> <sha1> Ævar Arnfjörð Bjarmason <avarab@gmail.com> 1500852355 +0200   commit: test
    $ perl -wE 'say ~~localtime shift' 1500852355
    Mon Jul 24 01:25:55 2017
    $ stat -c %y .git/logs/refs/heads/master
    2017-07-24 01:25:55.531379799 +0200

Of course you lose this information as soon as you "git pack-refs", but
it's there now & implicitly part of our current FS-backed on-disk
format.

So what I meant by "x" is that if to test this new reftable backend you
write a "git pack-reftable" you won't be able to 1=1 map it to the
mtimes you have on the fs showing when the ref was updated, but I see
now that you were perhaps never intending to use the more accurate FS
time at all for the loose refs, but just use the second resolution
reflog data.

> Further, microsecond is sufficient resolution for reflog data. From my
> benchmarking just reading a reference from a very hot reftable costs
> ~20.2 usec. Any update of a reference requires a read-compare-modify
> cycle, and so updates aren't going to be more frequent than 20 usec.

Right, I'm not arguing that it isn't sufficient, just that it's
introducing a needless variation by adding a third timestamp resolution
to git.

Even if it's not the same logical area in git (dir management v.s. ref
management) code to e.g. pretty format timestamps of sec/usec/nsec
resolution would tend to get shared, so we'd end up with 3 variants of
those instead of 2.

That's of course trivial, but so would be just deciding that ~500 years
of future proofing is good enough without any extra storage size for
those 64 bits and doing away with 1/3.

Just standardizing that makes more sense than picking the exact right
time resolution for every use case IMO. Otherwise we'll come up with
some other thingy in the future that just needs e.g. millisecond in its
format, and then end up with 4 variants....

I also see from "Update transactions" that unlike the current loose
backend the reftable backend wouldn't support multiple writers on
multiple machines (think NFS-mounted git master) updating unrelated
refs, which would break this usec assumption (but which holds due to the
locking involved in the new backend).

>>  y) Our own code will need to juggle second resolution epochs
>>     (traditional FSs, any 32bit epoch format), microseconds (this
>>     proposal), and nanoseconds (new FSs, bp/fsmonitor) internally in
>>     various places.
>
> But these are also unrelated areas. IMHO, the nanosecond stuff should
> be confined to the dircache management code and working tree
> comparison code, and not be leaking out of there. Commit objects are
> still recorded with second precision, and that isn't going to change.
>
> Therefore I decided to stick with microseconds in the reftable v3
> draft that I posted on July 22nd.
