Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E071F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeCFXVd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:21:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36061 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbeCFXVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:21:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id 188so1315812wme.1
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 15:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DyAU/ZNBiUgz3D5q9NctVE+83sBwZZ206eznPI55MZA=;
        b=bB+QXksdblIbqNJuLRsjiJoxPvkK1GE5HbDSlZJoXR/3W85fluvBPv8E+F5KNYBK73
         yP4zutMLU2AXK7XBtGB4Bj/yr0IXrGTIDUsHf2q61rJI60vhli/n1iNJtmKOclK5UFKt
         XCdPp7HX4VATne8YyhKOOWUDN+AoAuIAYjp9RAhXS/PVLQaMX7D9aF1/Ga+28IGrU9bj
         Jdsg2CEU/2lFlexhNQWsFbxTkCEgxh8WVizZB3uzh78c6D19XNY0wvZfseA1sWckSrvt
         AMURhICqCSmIaHCeXm1RR4L02Ba0vZX3i8aEhujqMPtDDeDCV0wSFeBds6inVjissOXU
         loyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DyAU/ZNBiUgz3D5q9NctVE+83sBwZZ206eznPI55MZA=;
        b=LG5zIHI1T2QBpb4YSziwNud/JBEu6lFW8hQU6aPeWDeIXRtmCjOHjj7jSen57iW2ME
         l4kZmhTR18VlSboTNs9cTNamzR3gfisxgb+oIbu75AuFt3+qVR+xYENsfs1TuYPH9Wmg
         +KvToTcVNVp3qWc5fYULkbqUhnFQmzqtwBmABttmq2L2CWmfE3Ykdnxpp7qYM3c+Xdkj
         wpnZzrgnoRKCH6cK6uD0rFGWEhbJOOhJYfm+221+XRsbRYF9SKsxrmSmoyUYv+7dMIUB
         tHlYamUG+CpGFiQkmXgmsYX7u9hBekepMLkpkqi8aq13gk0zT+Y2Dtrt+vwXYBs4Xf4/
         h5jw==
X-Gm-Message-State: AElRT7E2G9TjrhbawXrU3segJxvH/N2hw3Zy6tfBW0Gs/njo8HCd1R+e
        56D0g5iZSdfb2OXvWQg9DjY1lVyPCY0=
X-Google-Smtp-Source: AG47ELu+MIUSP5Wh8g+AjyEQ/k4dnyoZ1SzvSSaBPX00a4mekQKQuN1CKdmVC8BIgsX145YhIqFaDg==
X-Received: by 10.28.175.81 with SMTP id y78mr12004427wme.21.1520378491091;
        Tue, 06 Mar 2018 15:21:31 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id g7sm14143204wrb.78.2018.03.06.15.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 15:21:30 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
 <nycvar.QRO.7.76.6.1803051812330.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <77349f89-16c5-8f14-10da-e15381d11dc1@gmail.com>
Date:   Wed, 7 Mar 2018 00:21:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803051812330.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 05/03/2018 18:29, Johannes Schindelin wrote:
> 
> > By the way, is there documentation for `git merge-recursive` 
> > anywhere, besides the code itself...? :$
> 
> I am not aware of any. The commit message adding the command is not very
> illuminating (https://github.com/git-for-windows/git/commit/720d150c4):
> 
>     Add a new merge strategy by Fredrik Kuivinen.
> 
>     I really wanted to try this out, instead of asking for an adjustment
>     to the 'git merge' driver and waiting.  For now the new strategy is
>     called 'fredrik' and not in the list of default strategies to be tried.
> 
>     The script wants Python 2.4 so this commit also adjusts Debian and RPM
>     build procecure files.
> 
> Digging through https://public-inbox.org/git/ during that time frame comes
> up with this hit, though:
> 
> https://public-inbox.org/git/20050907164734.GA20198@c165.ib.student.liu.se/
> 
> which is still not a good documentation of the algorithm. You can probably
> dig further yourself, but I think I can describe it very quickly here:
> 
> To merge two commits recursively, you first have to find their "merge
> bases". If there was an obvious branch point, then that is the merge base.
> But when you start a branch off of master, then work a bit, then merge
> master, you already have two merge bases.
> 
> The trick about the recursive merge is to reduce the number of merge bases
> iteratively to one. It does that by taking two merge bases, and performing
> a recursive merge on them, which generates a "virtual" commit, the
> condensed merge base. That one is then merged recursively with the next
> merge base, until there is only one left.
> 
> A recursive merge of two commits with exactly one merge base is simply a
> three-way merge.
> 
> I vaguely remember that there was something funny about the order in which
> order you want to process the merge bases: if you did it in one
> (chronological) direction, it worked beautifully, in the other direction
> it would generate tons of merge conflicts or something like that.

Thanks, this is very informative (together with the linked discussion).

Not remembering seeing this before, I wasn`t really sure if this was 
some undocumented core Git (plumbing?) utility (used withing Git 
itself, too), or just a leftover (yet still useful) sample tool.

Regards, Buga
