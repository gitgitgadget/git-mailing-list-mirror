Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BDF1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 22:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbeCHWGD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 17:06:03 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:39548 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeCHWGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 17:06:02 -0500
Received: by mail-wr0-f181.google.com with SMTP id w77so7184675wrc.6
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hURL72jHqsSLb91/3l4TrDe12aOz+XDefbIDBYwlrxE=;
        b=PWnf1r76pZwpMo7O/pzwYNGkJWnWEDu/fjhgmBx4j2C9s8/Wl3ro07H5aQbQyrN7sV
         qdqHhE9PwiMnNK8DKnakr8WO7ANYlibIQw19KFdJ70mC7gKLQq3XxZ/YBqyZ6NXlFDyK
         1Mx9ATZBO/RVxiXcv9kV5mws10g5gIOzOqKsq9BGfNk529henz+x5Fpook4ZC+o3HCOk
         WH9chPMjTMo3txou1oihDaBg9QqQKabLBXbyNrW8k4Rr53Og9WuVYWLaQnbTp8TvpHHj
         2c1tiuNYil7EGdUwxrtthOjh53rpVzs1mDZf4I5qni1a12RyOxI/mVXn19mcLiPZAHYS
         IG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hURL72jHqsSLb91/3l4TrDe12aOz+XDefbIDBYwlrxE=;
        b=gNE139XrmHVna0waTu2futhHrRHGpKdCkFl/S+FRFXNTojoGkxNBBKtfaEZ0u9AWak
         93S9wbVMqPOqTpxcsKnEFYDM6xaRPxPoou2EwUCuLFTdQvzQin2LxoPJ/1bY/EfchZll
         nVovxPs1rRtHjWCBAmB4eHVWnhHuTk1lf/xJKcqSerhUu6B0g/muHcxHuKR1iXymMmGL
         h3POGjlLxD0DMZ8KFSOFj9PSZrBV45toNyOZua28gyr+kx6JsEH7SqHrTGlW4ZpuLTGt
         caiBxw/KPmxFuyde4dezKgELt5GKbL53SwGY4sURBRb6zUp8IsVDAfacQ0DDI1X6Xj73
         f3pg==
X-Gm-Message-State: APf1xPC/iZ8+3Sz+r0nqNSYy8eXlCJOdGNqKDbUOReXiz0nf3V3uNWYY
        EianV5FYB7pq620bbyPEu40=
X-Google-Smtp-Source: AG47ELs3nAaxjZ4EwcYZ2hr82Jt9V3P8fE3Pa+0ufBe1x6Uz55v5BCDb/pp4MSWd9M7X8ShlVXes8A==
X-Received: by 10.223.196.143 with SMTP id m15mr22930560wrf.207.1520546761385;
        Thu, 08 Mar 2018 14:06:01 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id s125sm13597580wmf.4.2018.03.08.14.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 14:06:00 -0800 (PST)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
 <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
Message-ID: <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
Date:   Thu, 8 Mar 2018 23:05:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2018 21:27, Igor Djordjevic wrote:
> 
> > 	git merge-recursive U1' -- M U2'
> > 	tree="$(git write-tree)"
> > 	# in case of original merge being octopus, we would continue like:
> > 	# git merge-recursive $tree -- M U3'
> > 	# tree="$(git write-tree)"
> > 	# git merge-recursive $tree -- M U4'
> > 	# ... and so on, then finally:
> > 	git merge-recursive $tree -- "$(git merge-base U1' U2' B1')" B1'
> > 	# in more general case, it would be:
> > 	# git merge-recursive $tree -- "$(git merge-base <all-parents-of-new-merge-commit>)" B1'
> > 	tree="$(git write-tree)"
> > 	git tag M' "$(git log --pretty=%B -1 M | git commit-tree $tree -p B3' -p B4 -p B1')"
> 
> That last line should obviously read just:
> 
> 	git log --pretty=%B -1 M | git commit-tree $tree -p B3' -p B4 -p B1'
> 
> ..., above mentioned `git tag M'` part being a leftover from my other test script.

Eh, pardon me, I managed to mess up all the merge-recursive lines, 
too, in regards to where the merge-base commit goes... Here`s a 
complete (and corrected) sample:

	git merge-recursive M -- U1' U2'
	tree="$(git write-tree)"
	# in case of original merge being octopus, we would continue like:
	# git merge-recursive M -- $tree U3'
	# tree="$(git write-tree)"
	# git merge-recursive M -- $tree U4'
	# ... and so on, then finally:
	git merge-recursive "$(git merge-base U1' U2' B1')" -- $tree B1'
	# ... or even:
	# git merge-recursive "$(git merge-base B3' B4 B1')" -- $tree B1'
	# as in more general case, it would be:
	# git merge-recursive "$(git merge-base <all-parents-of-new-merge-commit>)" -- $tree B1'
	tree="$(git write-tree)"
	git log --pretty=%B -1 M | git commit-tree $tree -p B3' -p B4 -p B1'
