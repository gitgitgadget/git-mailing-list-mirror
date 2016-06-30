Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD171F744
	for <e@80x24.org>; Thu, 30 Jun 2016 10:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbcF3Kbf (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 06:31:35 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37066 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcF3Kbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 06:31:32 -0400
Received: by mail-wm0-f53.google.com with SMTP id a66so111816237wme.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 03:30:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TUgIz2zRaV4ETNNU7fo2I0JiWQQgloycMyxd2kk6svU=;
        b=VKxVSF5suLoMGJOJATd7YAVJFuatV1/WxlWQGOKa9Jl29JOG/Aa5OOODwl6riendxE
         dA6YB97aTGTtlwAMXuASk2Zlz5Fo9759qZ5i+0YWGmUsb0Y2XS0d+Y1VzE/85sf1w4mF
         aTjXfR4e3OSYxCu3lloY9jbFW3qIPkBAKFf6Z6ehbWTr6KvjEfbAAE3u5/ruKQ/TB3UB
         MoclH/Fj7C8HkEl5C61pKX/mPN39A4QlizsWjqGMeqPTBLMebXEGbUEo+Cb6IIcImK5V
         jn4bz7+Cg+dhCQPLSyu6l6lJzZ6zs4JhthSAg1xTr1s6mbiPBJc/KK1jJuOK1XO/9/AN
         PfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=TUgIz2zRaV4ETNNU7fo2I0JiWQQgloycMyxd2kk6svU=;
        b=SfFgKNOMQeOagLG/9JImcKDFbjNoLPzXaM534git3bokCx7L8FhApmnqAliXalvY3Y
         8qWarKBRBY2QXaDShgndDWczEonlb3QsnhlBbhpR8m+Cn4zPqghEaxRknEKVYN2+BvvO
         sLT4PB336L62RgBnsinMfICsjsUMaZfHjOGj6OEoethWJqk3mCzBowXi+HH3n4Y6ApcO
         Y7rFFSU0pYJOkGP2fj7S2eOSkVSE/VCy7m+PgWAIZYeBjGNlzdE2mK8KEIYcpHfm7Jc8
         FoDcUPCrztXTBwzakMhBqseBZvg0jc+7z4Lv2Kw3U647q10YnzFidc0PRFfhkoin/qjn
         WDIg==
X-Gm-Message-State: ALyK8tIK52aLYxsyr/WxsWHZGnnFsYa/kZ/1GoU6aW+zDX8jg25nxPlEX2Fat5zNv2Ks9Q==
X-Received: by 10.194.158.225 with SMTP id wx1mr12884547wjb.177.1467282649381;
        Thu, 30 Jun 2016 03:30:49 -0700 (PDT)
Received: from [192.168.1.34] (daw105.neoplus.adsl.tpnet.pl. [83.23.22.105])
        by smtp.googlemail.com with ESMTPSA id bb4sm2284305wjb.32.2016.06.30.03.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2016 03:30:48 -0700 (PDT)
Subject: Re: topological index field for commit objects
To:	Jeff King <peff@peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5774F4C7.805@gmail.com>
Date:	Thu, 30 Jun 2016 12:30:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160629220049.GA4416@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-30 o 00:00, Jeff King pisze:
> On Wed, Jun 29, 2016 at 11:49:35PM +0200, Jakub Narębski wrote:
> 
>>> So this is the ideal case for generation numbers (the worst cases are
>>> when the things you are looking for are in branchy, close history where
>>> the generation numbers don't tell you much; but in such cases the
>>> walking is usually not too bad).
>>
>> There are other approaches (special indices) that help reachability
>> queries beside "generation number".
> 
> Yes, though generation numbers can help with more questions (e.g., "what
> is the merge base").

Well, those special indices usually need generation number anyway. For
example FELINE indices^1 (from "Reachability Queries in Very Large Graphs",
http://openproceedings.org/EDBT/2014/paper_166.pdf, that I found when
trying to find more about compressed bitmap indices used by Git) also
utilize generation numbers to speed up reachability analysis. The idea
behind FELINE is to associate every vertex (commit) with a unique ordered
pair of natural integers (i.e. two more numbers, in addition to the level
aka generation number), so that partial order over N^2 is superset of
partial order of graph (DAG of revisions). It can answer in O(1) that
nodes are not connected, and cut search space if they are.

BTW. some references in this paper ("Related work" section) use PWAH
compression scheme - perhaps it would work with EWAH that Git uses?

1. FELINE = Fast rEfined onLINE search ... or fun with acronyms

>> By the way, what should happen if you add a replacement (in the git-replace
>> meaning) that creates a shortcut, therefore invalidating generation numbers,
>> at least in strict sense - committerdate as generation number would be still
>> good, I think?
> 
> This is one of the open questions. My older patches turned them off when
> replacements and grafts are in effect.

Well, if you store the cache of generation numbers in the packfile, or in
the index of the packfile, or in the bitmap file, or in separate bitmap-like
file, generating them on repack, then of course any grafts or replacements
invalidate them... though for low level commands (like object counting)
replacements are transparent -- or rather they are (and can be) treated as
any other ref for reachability analysis.

Well, if there are no grafts, you could still use them for doing
"git --no-replace-objects log ...", isn't it?

SIDENOTE: should grafts be deprecated and later removed, now that Git has
superior alternative in the form of git-replace, and a simple way to convert
grafts to replacements?

Anyway, if file with mapping from revisions to its generation numbers
were stored outside of packfiles, it could simply be updated / rewritten
when adding new replacement. You could use one cache for no-replace,
and one for replace. Though I do wonder if it would be possible to do
such rewrite fast... well, fast enough assuming that adding replacements
is rare.

Answering my own question:
>> committerdate as generation number would be still good, I think?
No, it wouldn't:

  pre replace:

    1 <-- 2 <-- 3 <-- 5 <--
           \
            \----- 4 <-- 6 <-- 7 <-- 8

  post replace

   1 <-- 2                              \-- 3' <-- 5
          \                              \
           \------ 4 <-- 6 <-- 7 <-- 8 <--\

Either the replacement commit would have generation number correct, but
its child wouldn't, or its child would have correct generation number but
the replacement wouldn't.
 
>>> I have patches that generate and store the numbers at pack time, similar
>>> to the way we do the reachability bitmaps.

Ah, so those cached generation numbers are generated and stored at pack
time. Where you store them: is it a separate file? Bitmap file? Packfile?

>>>                                            They're not production ready,
>>> but they could probably be made so without too much effort. You wouldn't
>>> have ready-made generation numbers for commits since the last full
>>> repack, but you can compute them incrementally based on what you do have
>>> at a cost linear to the unpacked commits (this is the same for bitmaps).
>>
>> Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it still
>> limited to object counting?
> 
> At GitHub we are using them for --contains analysis, along with mass
> ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
> plan is to send patches upstream, but they need some cleanup first.

That would be nice to have, please.

Er, is mass ahead/behind something that can be plugged into Git
(e.g. for "git branch -v -v"), or is it something GitHub-specific?


P.S. Having Git ensure that committerdate (as an epoch) is greater
than committerdates of its parents at the commit creation time (with
providing warning about time skew, perhaps not doing it if skew is
too large) would be not costly. No need to add anything, and it would
help future queries to be faster, I think.

-- 
Jakub Narębski

