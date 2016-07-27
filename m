Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04DD8203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbcG0SDq (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:03:46 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36708 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbcG0SDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:03:45 -0400
Received: by mail-io0-f175.google.com with SMTP id b62so77491547iod.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 11:03:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MosWJF2JQ2Niy8+81tQHB+lqTccTqSkFi2DTRhiRjTY=;
        b=PUiMi7+2txD3Z+5sXnQrkfq4vpmi/tjZHIIFk4srYrHnvI24aHDoRC1L5zMx4d1mob
         XeVNemmSW1qJlJRWsmAUAGM8KoRP2gYFawfFsfGVHIw+4VHvyKe/CE/BtmMU9y+rsgkm
         Fi2PMQKkag41kEJg0tAKxBpXKEYSvYITnSKxCvheviv8gz1XyDi4MJ/QpLca7a9nBwmg
         AbM67rOyNtyWacpDsbsjKI8B0MTEDpdtm/PZxgm2E/0bOX+joAbgTeQJ09MrKnQDjLT1
         SzcONHbbedUXbtR6TwUmC4H5GVaT1Zdcol1/lt91694mPJcn8E/pI0ubSHCd9f7TnHEO
         SV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MosWJF2JQ2Niy8+81tQHB+lqTccTqSkFi2DTRhiRjTY=;
        b=DSEoPIWV2Z0yH1QPdOqLjl9aa6f5o1IdzI9mrpti66mWPHJQiDW4KU6AB4UcY8vVjX
         g99Kd4QQfxvEVWPKEYztSJtiXI+EZfHlsNvp1wRDdIJl/Ro2Sjytewl5dSU3aNy2NjmA
         IDOHJNRZng9sHpxnGdR5muZ4bFY1VyQtox0imkobc2sGUprCAsSS6fSKehIouv/oKyD3
         HkbJUqGwJccdWhZbTGMjcQVNqMeGhuJDei4W39DfsIzgPnCkQDpOO3hybGyIhjWxpW1g
         JTtXT78rXFE/fTutzy7+HnUniqcqWlIbg4/Ic8uTmieSTjDkfKuqMqAFVXfQdpyM41Xi
         DdYA==
X-Gm-Message-State: AEkoous8nSRVIA9A3RqUyVNW98X8PpNDzHp8vXZ4X1q1Q7YN4ZKWPYyukV/hJYngcXNV4d7XH6cYXqlqJDf2/w==
X-Received: by 10.107.8.140 with SMTP id h12mr35219464ioi.95.1469642624544;
 Wed, 27 Jul 2016 11:03:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 27 Jul 2016 11:03:15 -0700 (PDT)
In-Reply-To: <CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com>
References: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
 <CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 27 Jul 2016 20:03:15 +0200
Message-ID: <CACsJy8CKLmjW82TJHUoqrM1smmiP=dcDqvOpN_QDPePEy0ZuJw@mail.gmail.com>
Subject: Re: Find a topic branch containing a commit
To:	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 7:50 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jul 27, 2016 at 10:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Before I start doing anything silly because I don't know it can
>> already be done without waving my C wand like a mad man...
>>
>> I often do this: find a commit of interest, the commit itself is not
>> enough so I need a full patch series to figure out what's going, so I
>> fire up "git log --graph --oneline" and manually search that commit
>> and trace back to the merge point, then I can "git log --patch". Is
>> there an automatic way to accomplish that? Something like "git branch
>> --contains" (or "git merge --contains")?
>
> https://github.com/mhagger/git-when-merged ?

Beautiful. If it had an option to show a topic (i.e. git-log from
merge base to merge point) I would be ecstatic. Michael, any plans on
bringing this in C Git? For many topic-based projects this would be
very helpful addition, and I think it's not so hard to do it in C
either.
-- 
Duy
