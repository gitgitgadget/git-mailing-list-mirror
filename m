Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D011F461
	for <e@80x24.org>; Tue, 14 May 2019 00:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfENAQO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:16:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38660 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfENAQO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 20:16:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y2so2620837pfg.5
        for <git@vger.kernel.org>; Mon, 13 May 2019 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zvPqynYcQLzImnUrrYsksQAmSH/Rr+o7HfRbE7D3z/w=;
        b=tPxlr2e2taG913NTq7SEUSVPGXOYpvsrPIA4j6tn6Nqh3C4McFwtrVmsGw6X0+Jiq3
         6fRFrxyrGqcJqsDwFa5OtDrK3QRmowa7VZHgK6uyJdfaT6gCUsTV2neE24CLqXpOodyb
         W3+VTJXQehWqKD5UQFsDxrDA6TLO+RJZiDIC4R+4pPoY+4BJ8lHGAcN4HZjtUesIn+X3
         8v2YnQ3l2Z2rW6b43RqfX3Qilfb34vVsDwfObmmAdikh8FTp1YTn94XHM6NVkv/zpFQk
         ezSg70GHQyJMWttq267LYOAUCR/TdHEuPdvQwgjaAyKhZs8fLPlTOTI1aEMVgRcKTMFu
         aAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zvPqynYcQLzImnUrrYsksQAmSH/Rr+o7HfRbE7D3z/w=;
        b=DP0k1AUaX9HpdES854AEuonv45wzddtQ9MnNqF2MEdjiFpkSzu3MS6Dbif4w52V9kH
         afRL8e7zj1MBhy5nMCkxRwp3Zx99EoIwAf98uqR4UHXuE9G337t5EKvSCLCi6YmHdrhL
         nfXzWbu4GmAkhxcayG4+6EYtHxedeLffKdtu6qrabV519VkmGkxNN71CS421yXIXV7Sl
         +TvAvw3FAT4ppF8iaFrcwcEfgnRUkUnf90qpBndxauOpmrByAgg0+BxbmHMYKaqN+qz6
         4Mu/6LDg7t7Beol31iFDAOoHqltcDHjKjQgSOPMdstFI2T8ea2CV5Xer9cyaGdIuWRmD
         ivKw==
X-Gm-Message-State: APjAAAXlo8IIKIXu4VzAbF3amu/RBequQ5Vxlbor4MQKgdneY5/osgu5
        2Q1vnkg2pmo2Xe+4m6sdDIWBUhn/
X-Google-Smtp-Source: APXvYqy6iE08Te69tZyv7+ADdk+IjVmqVSL/wR2zLgLwdRpRpswL8TQS5+sjzW5q5/YFWTf/3+MIdg==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr37029136pfm.191.1557792973240;
        Mon, 13 May 2019 17:16:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id i22sm18281368pfa.127.2019.05.13.17.16.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 17:16:12 -0700 (PDT)
Date:   Mon, 13 May 2019 17:16:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Proposal: object negotiation for partial clones
Message-ID: <20190514001610.GA136746@google.com>
References: <A0ADEE11-E3E1-4DE0-81BA-40771C783E4E@comcast.net>
 <20190509180022.91700-1-jonathantanmy@google.com>
 <4A3BD0B7-894F-4FB0-A3BA-15675F60046C@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A3BD0B7-894F-4FB0-A3BA-15675F60046C@comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Matthew DeVore wrote:
> On 2019/05/09, at 11:00, Jonathan Tan <jonathantanmy@google.com> wrote:

>> - Supporting any combination of filter means that we have more to
>>  implement and test, especially if we want to support more filters in
>>  the future. In particular, the different filters (e.g. blob, tree)
>>  have different code paths now in Git. One way to solve it would be to
>>  combine everything into one monolith, but I would like to avoid it if
>>  possible (after having to deal with revision walking a few times...)
>
> I don’t believe there is any need to introduce monolithic code. The
> bulk of the filter implementation is in list-objects-filter.c, and I
> don’t think the file will get much longer with an additional filter
> that “combines” the existing filter. The new filter is likely
> simpler than the sparse filter. Once I add the new filter and send
> out the initial patch set, we can discuss splitting up the file, if
> it appears to be necessary.
>
> My idea - if it is not clear already - is to add another OO-like
> interface to list-objects-filter.c which parallels the 5 that are
> already there.

Sounds good to me.

For what it's worth, my assumption has always been that we would
eventually want the filters to be stackable.  So I'm glad you're
looking into it.

Jonathan's reminder to clean up as you go is a welcome one.

Thanks,
Jonathan
