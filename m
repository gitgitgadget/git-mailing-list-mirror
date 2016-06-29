Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA76520FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbcF2VuP (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:50:15 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37684 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbcF2VuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:50:12 -0400
Received: by mail-wm0-f52.google.com with SMTP id a66so92216312wme.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 14:49:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8A0FlGRgzXG1YOSKhU/P8/geXPJkg1c6IDD/VLaAwSY=;
        b=u14OcJV6MZcVDgzZsP7ofLYYz+YFlXpyc5blLHbLKjdfGQZ7+0QWK9wWTAKVhytqrP
         PDqaqRDYVWSmtH9PNmpDNSB5ajDQ+RJiEF6cqa4ZTZ1eQZgLe2dgI+Zuvul1rK7qSh88
         D7kKPBZKGmC0OcYDTADgDjDKzhAwjk/VvEPo4EDCBez1ShTTYQWaShDfdLZu+0Sa2teB
         UfxlgKb5X3vygnwaRF/8nkisS9wJRBewvCOVqgB5wjDyLBczX0fT8TLoPbZnRUWS/Qte
         mclZuzsk+Uads4SqNHE4cPtKMf1/YNZ92NvScg2XjjknrG206gT63unzQR+76i9JNdW5
         +t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=8A0FlGRgzXG1YOSKhU/P8/geXPJkg1c6IDD/VLaAwSY=;
        b=Z9tRnZp3HAJxpL5xNVWC8Esf6+TVJgXeUDj/pueN10/T4JKixgH/bEXKe+8iL+5lxZ
         hUidjlMu/PKsj+xu49LCLrzuLcjj7SPbD2Llcszy19lOAdTyq2wSU2ra/kGePaKh5ML2
         lQk2Pj9Kvs735jWqlO41MMf/TLXl5wfyxfO5zhk5xoRhLuP9TQ9ZYud3KR65qFxkxg54
         +pDG+zlnSgaVSJvUXOyEp//thVaVqKjpLUUh2py0o+cDSOjzqMg/lBiwjPHs5o48CJnb
         mvVIe0dHvWGo5iHMOsuyMxRzKjxlgw5giemQzw8dGj7i1xA7TGfyat3CqKP6oqTAyw0F
         xgJQ==
X-Gm-Message-State: ALyK8tIJj8T6GCpaustSxan2lFqD44t8rhsYDsZQ2VUgGzmiUWHNRWETTnbAtz3NQgrm9A==
X-Received: by 10.194.109.232 with SMTP id hv8mr10552899wjb.115.1467236992923;
        Wed, 29 Jun 2016 14:49:52 -0700 (PDT)
Received: from [192.168.1.34] (aefh205.neoplus.adsl.tpnet.pl. [79.186.137.205])
        by smtp.googlemail.com with ESMTPSA id n26sm213973wmi.3.2016.06.29.14.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 14:49:51 -0700 (PDT)
Subject: Re: topological index field for commit objects
To:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5774426F.3090000@gmail.com>
Date:	Wed, 29 Jun 2016 23:49:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160629205647.GA25987@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-29 o 22:56, Jeff King pisze:
> On Wed, Jun 29, 2016 at 01:39:17PM -0700, Junio C Hamano wrote:
> 
>>> Would it make sense to refuse creating commits that have a commit date
>>> prior to its parents commit date (except when the user gives a
>>> `--dammit-I-know-I-break-a-wildy-used-heuristic`)?
>>
>> I think that has also been discussed in the past.  I do not think it
>> would help very much in practice, as projects already have up to 10
>> years (and the ones migrated from CVS, even more) worth of commits
>> they cannot rewrite that may record incorrect committer dates.
> 
> Yep, it has been discussed and I agree it runs into a lot of corner
> cases.
> 
>> If the use of generation number can somehow be limited narrowly, we
>> may be able to incrementally introduce it only for new commits, but
>> I haven't thought things through, so let me do so aloud here ;-)
> 
> I think the problem is that you really _do_ want generation numbers for
> old commits. One of the most obvious cases is something like "tag
> --contains HEAD", because it has to examine older tags.
> 
> So your history looks something like:
> 
>   A -- B -- ... Z
>         \        \
> 	 v1.0     HEAD
> 
> Without generation numbers (or some proxy), you have to walk the history
> between B..Z to find the answer. With generation numbers, it is
> immediately obvious.
> 
> So this is the ideal case for generation numbers (the worst cases are
> when the things you are looking for are in branchy, close history where
> the generation numbers don't tell you much; but in such cases the
> walking is usually not too bad).

There are other approaches (special indices) that help reachability
queries beside "generation number".

> 
> So I think you really do want to be able to generate and store
> generation numbers after the fact. That has an added bonus that you do
> not have to worry about baking incorrect values into your objects; you
> do the topological walk once, and you _know_ it is correct (at least as
> correct as the parent links, but that is our source of truth).

By the way, what should happen if you add a replacement (in the git-replace
meaning) that creates a shortcut, therefore invalidating generation numbers,
at least in strict sense - committerdate as generation number would be still
good, I think?
 
> I have patches that generate and store the numbers at pack time, similar
> to the way we do the reachability bitmaps. They're not production ready,
> but they could probably be made so without too much effort. You wouldn't
> have ready-made generation numbers for commits since the last full
> repack, but you can compute them incrementally based on what you do have
> at a cost linear to the unpacked commits (this is the same for bitmaps).

Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it still
limited to object counting?

-- 
Jakub Narębski

