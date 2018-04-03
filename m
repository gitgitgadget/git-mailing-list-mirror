Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255B81F424
	for <e@80x24.org>; Tue,  3 Apr 2018 11:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755344AbeDCLj1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 07:39:27 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:44502 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755387AbeDCLjY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 07:39:24 -0400
Received: by mail-qk0-f180.google.com with SMTP id u9so4742052qkk.11
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8/OyoWTVH8R1UIPqMoFdFnSlMMk9ih6NsfaQcfVa8gU=;
        b=igj/ww+YcR7YRS+VRRQsFOX9Tu7txxVztKrRrSPDs95UjWr2YZCZV44ctU5q7AP8H9
         CtplM4bX2qWBojjT2JhLddPu+M5qLbMmZbkBmftd16IhLG1bkO8vMtc2qQnVmw8cf08Z
         VbPeUAnzCpGffgolcWMqycRWX4w1qgArHwlM7fAcrQ53Bv2FJIBAUoq+rQBOfQpsnfZI
         rgek8E9Nojuc+MO5HBqMR7qrqLg4uyjADIY2vBxZCST/MedEkJOGn5G9lkJboDQnvDqb
         zJ0lFjzwxPOFNX//q+nab2O8d72BhKPrI1d7AOfDllpIVwVmpbCuIBleZEgBqAiSg8p1
         1DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8/OyoWTVH8R1UIPqMoFdFnSlMMk9ih6NsfaQcfVa8gU=;
        b=cXcIXHTS/hCMaJQ8I7YUzrbcdLPkm/JE+OTP/hkNzGcd/1xv/du9saRcHyOXqlwydO
         Lecn/w8+jGQND5EwpRo8lKRLFbvfPOXtaX5LfE3OUFurZD5HjmrpWPZJNAI5wmfDJzKs
         AgsMCP+lnuDc4TU/sVPqvnG0F7VtIlhm3tftX6DGoifn5wOlK7m5CQgN7cvGn5YAsOiv
         SJX8jHUid5032WBoh/ecwSE9mkBqina3tgSFxIGBiQUwQjPNceFPNOgXIb9drBDG9+h9
         VzJze+SBwvK7BhCvdnySusFGulkV6Tw5nAKZg3XLb9/j0hcYm9P1R8CtPzz+oQ79okTD
         zurg==
X-Gm-Message-State: ALQs6tDH+bThLUfEXnCIdv54VScEjKEZzLjeTgt/ZXQsK2snS2C800xw
        RbqzX30k8idnRpUh+27xUfg=
X-Google-Smtp-Source: AIpwx4/1TgKTFK3RHyQxn1pGymLwEV4GIBjRDN7lMUFAIW4aQPpkQLmBsDShGtBGUqjRlX6VxGoLqw==
X-Received: by 10.55.138.194 with SMTP id m185mr12030806qkd.103.1522755562414;
        Tue, 03 Apr 2018 04:39:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b125sm2076268qkd.62.2018.04.03.04.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 04:39:21 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
 <20171221204356.GA58971@aiede.mtv.corp.google.com>
 <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
 <20171224143318.GC23648@sigill.intra.peff.net>
 <xmqq1sjgoyph.fsf@gitster.mtv.corp.google.com>
 <20180104192604.GA27528@sigill.intra.peff.net>
 <091D90DC-DAA2-4338-AAFA-01CB75807992@gmail.com>
 <87vad8vbid.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d63b54e9-5ec6-f523-d882-756ac38b882b@gmail.com>
Date:   Tue, 3 Apr 2018 07:39:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87vad8vbid.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 6:18 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Apr 03 2018, Lars Schneider wrote:
>> What is the state of this series? I can't find it in git/git nor in
>> git-for-windows/git. I think Stolee mentioned the config in
>> his Git Merge talk [1] and I was about to test it/roll it out :-)
> It's in the gvfs branch of git@github.com:Microsoft/git.git, i.e. it's
> not in Git for Windows, but used in Microsoft's own in-house version
> used for Windows.git.

Thanks for adding me to CC. I mentioned it in my talk because that was 
one thing we shipped internally as a "quick fix" until we could do the 
right thing.

If I remember correctly, Jeff abandoned shipping this upstream because 
it did have the feel of a hack and we wanted to see if users used the 
config setting or really cared about the output values. We saw fast 
adoption of the feature and even turned the config setting on 
automatically in the following version of GVFS.

> I may be misunderstanding this feature, but my impression was that it
> was a kludge as a workaround until the commit graph code landed, because
> once we have that then surely we can just cheaply report the actual (or
> approximate?) number in the common case, but of course it may still be
> slow if your commit graph file is out of date.

You are correct that the commit-graph file may be out of date, causing 
slower performance. Even worse: the current graph patch only provides a 
constant-multiple speedup (still walking the same number of commits, but 
each commit is parsed much faster).

Speaking of our GVFS-specific fork [0], the 'gvfs' branch was updated 
just yesterday with a couple of changes that I am prepping for 
submission upstream:

* Lazy-load trees when parsing commits from commit-graph [1]
* Compute and consume generation numbers [2]

Each of these will speed up this ahead/behind calculation in different 
ways. [1] makes the cost of loading each commit a bit faster, saving up 
to 20% overall. [2] uses generation numbers in paint_down_to_common() to 
make the while() condition O(1) instead of O(Q) where Q is the size of 
the priority queue. The Windows repo is particularly "wide" with many 
parallel branches being merged in complicated ways, so the queue becomes 
quite large. This use of generation numbers saves about 4% on some 
ahead/behind calculations. This speedup is modest, but the existing code 
already made good use of limiting the commit walk to be mostly the 
"important" commits.

The real benefit of generation numbers will manifest in a way to make 
--topo-order much faster when rendering a small number of commits.

The generation numbers _could_ be used to approximate the ahead/behind 
calculation in the following way: When comparing A and B, and gen(A) < 
gen(B), then A is at least (gen(B) - gen(A)) behind. That's the only 
information that can be gathered directly from those values, but may be 
enough to short circuit an exact count.

To truly accelerate these ahead/behind calculations to be sub-linear* in 
the ahead/behind counts, we would need a bitmap-based approach. The 
object-reachability bitmap is a non-starter for client machines in the 
Windows repo, but perhaps a commit-reachability bitmap could be 
interesting. Performing set operations on the bitmaps could more quickly 
answer these questions. Just thinking about it makes me want to go down 
a deep rabbit hole, investigating ways to compute, store, and use these 
bitmaps. However: let's wait and see how necessary it is as the 
commit-graph feature stabilizes. (*These bitmap approaches are not 
guaranteed to be sub-linear, because it may include iterating through a 
list of O(N) bits, but good run-length encodings will likely make the 
count operation very fast, even with a set-difference operation included.)

There are too many fun things to work on, not enough time!

Thanks,
-Stolee

[0] https://github.com/microsoft/git
     Fork of GitForWindows that ships to Windows developers

[1] 
https://github.com/Microsoft/git/commit/29114bf86f591f5c87075f779a1faa2d0f17b92f
     Lazy-load trees when parsing commits from commit-graph 
(accidentally squashed to one commit)

[2] 
https://github.com/microsoft/git/compare/879b7d3b1bddea2587b28cdd656c9c655018683a...a0731ca93a35fd042560c4b30e8e0edbdfa4bf9f
     Compute and consume generation numbers
