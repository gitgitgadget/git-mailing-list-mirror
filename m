Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711231F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJIBXR (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:23:17 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35512 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:23:17 -0400
Received: by mail-wr1-f53.google.com with SMTP id w5-v6so21851683wrt.2
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v/x3yVkGnYno0zmkVFz5Lt5uibUt+qkXGQ6y5Gp3xqo=;
        b=RktNz8hf86m/OIW4m1pv7XBNhFLh1nzxzVVQVQRO3PoBuIK4jcbQqyJsEWG1/bYKm5
         zIXZ9eJmq3cC5cq7ggW+WJJ9gxEG8fZj80xIXY/Wy3Itgik1PNTMy+D+ndeGZz0yVSUc
         Zx/ChJL3BgDRmQvB5r7q81oJdTezW1vLtsU48P26yQz38JtVMOYXUNFTGUjQCb0hLrWc
         Fwalai4CclwHpel2u1pT4qa3cgM0GruF/l7Wtd1+r0o3eOHCm/p1gNnuj6BWCvDfVI6B
         o8ojCp00o202HP56NzaC0xrLRkZ1+JC6glVZROTwo1qNSQ0SiDmfiuhdIfYmKuDE25CS
         k9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v/x3yVkGnYno0zmkVFz5Lt5uibUt+qkXGQ6y5Gp3xqo=;
        b=ivJkxMgpZ0+KLhALebdSG+tpkeXMq29rtF5i+QsvlaApWlUKHBhPzDjJjXeCnpgGWW
         58AO+cJgC7SFZkkoljSwZYndxZzkX4ZwZlilwadsCNXmtVBFHm1O50LenfFnnSlV+SgY
         y5AeBmyIyWLEKSYGeGy7i0WcNGLW/m1uFcaYB7E/SlE4Klg1XutP3EOjV1JP5g4DWd91
         wsaiiZIiVRZKuXuwlxeCgY1W+cJxYp1j5bWHLbLoVF/zQsgG6Bh0G0OxVy6Y6vgM92pW
         +cPiXBmifwt/J04PAgyBRkmF8/t76K9jjbCwSPfpN4nyyvzXd1SkKLQOeBzD+sXdC0dE
         XGMQ==
X-Gm-Message-State: ABuFfohh9fVXLxABV4Oi+15dMNVYi5m5RqjXCMc4EbMIRt3xDlydntuz
        Ljn56imftU8nNgO985ozw7k=
X-Google-Smtp-Source: ACcGV62FytXSflq08b1Sy3paufrCphV1R5zZjrp2BGQC8APmonXNHhb3eiuE/hFseA9A9UfS8oPs6w==
X-Received: by 2002:a5d:4b84:: with SMTP id b4-v6mr18196192wrt.168.1539022219663;
        Mon, 08 Oct 2018 11:10:19 -0700 (PDT)
Received: from szeder.dev (x4dbd30b5.dyn.telefonica.de. [77.189.48.181])
        by smtp.gmail.com with ESMTPSA id p62-v6sm40606722wrc.97.2018.10.08.11.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:10:18 -0700 (PDT)
Date:   Mon, 8 Oct 2018 20:10:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181008181015.GA23446@szeder.dev>
References: <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 12:57:34PM -0400, Derrick Stolee wrote:
> On 10/8/2018 12:41 PM, SZEDER Gábor wrote:
> >On Wed, Oct 03, 2018 at 03:18:05PM -0400, Jeff King wrote:
> >>I'm still excited about the prospect of a bloom filter for paths which
> >>each commit touches. I think that's the next big frontier in getting
> >>things like "git log -- path" to a reasonable run-time.
> >There is certainly potential there.  With a (very) rough PoC
> >experiment, a 8MB bloom filter, and a carefully choosen path I can
> >achieve a nice, almost 25x speedup:
> >
> >   $ time git rev-list --count HEAD -- t/valgrind/valgrind.sh
> >   6
> >
> >   real    0m1.563s
> >   user    0m1.519s
> >   sys     0m0.045s
> >
> >   $ time GIT_USE_POC_BLOOM_FILTER=y ~/src/git/git rev-list --count HEAD -- t/valgrind/valgrind.sh
> >   6
> >
> >   real    0m0.063s
> >   user    0m0.043s
> >   sys     0m0.020s
> >
> >   bloom filter total queries: 16269 definitely not: 16195 maybe: 74 false positives: 64 fp ratio: 0.003934

> Nice! These numbers make sense to me, in terms of how many TREESAME queries
> we actually need to perform for such a query.

Yeah...  because you didn't notice that I deliberately cheated :)

As it turned out, it's not just about the number of diff queries that
we can spare, but, for the speedup _ratio_, it's more about how
expensive those diff queries are.

git.git has a rather flat hierarchy, and 't/' is the 372th entry in
the current root tree object, while 'valgrind/' is the 923th entry,
and the diff machinery spends considerable time wading through the
previous entries.  Notice the "carefully chosen path" remark in my
previous email; I think this particular path has the highest number of
preceeding tree entries, and, in addition, 't/' changes rather
frequently, so the diff machinery often has to scan two relatively big
tree objects.  Had I chosen 'Documentation/RelNotes/1.5.0.1.txt'
instead, i.e. another path two directories deep, but whose leading
path components are both near the beginning of the tree objects, the
speedup would be much less impressive: 0.282s vs. 0.049s, i.e. "only"
~5.7x instead of ~24.8x.

> >But I'm afraid it will take a while until I get around to turn it into
> >something presentable...
> Do you have the code pushed somewhere public where one could take a look? I
> Do you have the code pushed somewhere public where one could take a 
> look? I could provide some early feedback.

Nah, definitely not...  I know full well how embarassingly broken this
implementation is, I don't need others to tell me that ;)

