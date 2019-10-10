Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34ABD1F4C3
	for <e@80x24.org>; Thu, 10 Oct 2019 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJJUVz (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 16:21:55 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34036 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfJJUVz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 16:21:55 -0400
Received: by mail-pg1-f176.google.com with SMTP id y35so4387303pgl.1;
        Thu, 10 Oct 2019 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gl3svGlsM53L38IRfEzeS/tg9Zkbe5DGymxCv8c/HUs=;
        b=bqpauZjL+gkqVotbEYgyl8pf6QBdOydpXNr2u+wTH+dVrjN5aRU7SYF0eg7s5T5926
         retEbt3NLzH8CcPAY5Ppp22y4dHvn14L7WuOaeFbBAFAKMn/Y7tgl6ssXgn3ptQDfL/R
         dx9K9dL3s7TZSj9QWPpT39PBHNh3/xr6dFlIQ0AFCmxH7+4mmlRLVgN3Kkj5Cta8g6mg
         7zl5YqS3AJ5eapBB3i6VacHqff967j50iNsyPm+wf+LOB9he9LSAVIngbdxbxirFWOz2
         t8bUAFdFcOej5uvbrOleR9uxgaq5wqyamQS69GMBKb43WB9F6O+At6zTXu6vCjCyNQdp
         Iq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gl3svGlsM53L38IRfEzeS/tg9Zkbe5DGymxCv8c/HUs=;
        b=adErMYT2OBRDMvDWnOM+PoHTFLz4DvQ8bvBWi5hWLFXhGMfDMzwUvRKcOG2M9higUz
         JiAiiLKWsp/pWaHxePrnNYgGkBj8tdDRdNVw9lnvP0rrxbbKF9xigx0PVt+WCZbE8JCj
         J6Vz7y5Uvf4BbwjGw3tlX7QPCyq2uRrS+80xswUH5aTlJBtkOx1Dk5ttZFjATroE5mb9
         2WYzzzVJkqGYdM+qXmS5phdDZ61N5kxNqvxQOm60tQSbjRJSmZHTdnXCaD8b1WxaYC1x
         MvLI5z1JKnXeQWMgVod9kv58H8E+oN5DBHTPqk/WYTybU76pCi7pR7GEYxj9JCvoT2WK
         4XkA==
X-Gm-Message-State: APjAAAUZ4BTRUwwgijeeOUW+SQIgRIKT9OY+sfqfpFboZIaxpwX5DpWn
        Q4bt7N6Ro7EDa52wUq8MckLkT2aO
X-Google-Smtp-Source: APXvYqx1i3J4AsR37s7T78U8UcGIBBrRyBHuX6+co4Wqo6yDSvzdySSktE97tfHBLBhr7cD3H4S6Ug==
X-Received: by 2002:a62:e807:: with SMTP id c7mr12385917pfi.18.1570738913161;
        Thu, 10 Oct 2019 13:21:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 22sm6715013pfj.139.2019.10.10.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:21:52 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:21:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        patchwork@lists.ozlabs.org, workflows@vger.kernel.org,
        git@vger.kernel.org
Subject: Re: RFE: use patchwork to submit a patch
Message-ID: <20191010202151.GC191800@google.com>
References: <20191010144150.hqiosvwolm3lmzp5@chatter.i7.local>
 <20191010150729.1355f33d@coco.lan>
 <20191010195335.fmh6atylozhehftt@chatter.i7.local>
 <20191010200528.GA5612@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010200528.GA5612@dcvr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

>> This is actually really fast if you already have a local copy of the
>> repository with most objects. Try this yourself if you have
>> torvalds/linux.git locally:
>>
>> git clone --bare -s torvalds/linux.git test
>
> Yep, -s (--shared) makes cloning really cheap.  One of my goals is to get
>
> 	git clone -s https://example.com/torvalds/linux.git
>
> and
>
> 	git clone -s https://example.com/torvalds/linux.git/clone.bundle
>
> working.  That would make it easier for new contributors to
> setup lightweight clones and pull in history on an as-needed
> basis w/o hacks like shallow cloning.

Does "git clone --filter=blob:none" do what you're looking for?

Thanks,
Jonathan
