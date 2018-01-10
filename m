Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9821F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeAJUyT (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:54:19 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35087 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeAJUyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:54:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id d6so462976pgv.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 12:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ecgGPIZeei1OJ6PgJgEbPN1Vac+rmncl6ZCPHSH1xxs=;
        b=hkwGHe78hGZ+YkkRHCmlIZOiIwNg6FK+Be2ULbXsFUVoAnW4Brs0hgbYfYMM3+h5sP
         q/eTB/OKXtSq3JP+uKVGRetEg+kQbr20dmMn5OOVVyNPadlteE5f4al3SstzTCPPggmx
         UWb6RIx2Rtce1nDGIM04v8YLslYAIn0SkorBOkTtu1AzL38wd8KcRzvF/ejfgHZww3QN
         kXCbCAeVjVcJO7eWZ8MVnUFMZRdUmDDWY04mAl5v/jJMBFzqosLFe58/hov3dUjRV7V7
         kjHvY0Ad1uDoMAe1Wq44UwjeDDeWM9+rsqYf5j8qkpYndwg8N/UGrKnB0KK7dgzNB8ON
         C5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecgGPIZeei1OJ6PgJgEbPN1Vac+rmncl6ZCPHSH1xxs=;
        b=rZ9W01KWJI796M9LEKicfU1VAAbijidGdwyitYNg6m4Iini1HgHp1ocI+VfL5JdpLq
         gU4XhRIVzv+V+KMi7/eNMLCgyN+qX7NSXqpSa7YWSEkwCiU1JJJS83TSTCxXWQnT0adY
         j1heJCJ8yDoxaVoSfvZXi8BrkFe6men0musrhVAruo3sL4xGsDjHp2ZvPV+370maK2k9
         XMxMf8jYWw4CMDnGnU9px4ng8X/U+yWsarP/YvhHoN8+jIt2W+8gAjw12tSHpUtFScvA
         I751G036iOUXj5bkLkweBTLgdO92sr906lF1cL1vYPstWQJ5ataJnNhjMhO36u9tnb9d
         Phqw==
X-Gm-Message-State: AKGB3mI7QN7Ux1dci/zDlk04M3sGbAcn/4GzJ8aROiPvv9FLjmvAxXx8
        oL423yWnqhFANi6KF5etCPo=
X-Google-Smtp-Source: ACJfBovKvCgl291AqVqLzreCsmywILN6wzXxqAZ8WudQV0aRzb9ioswhsmApMblburzvSrTcsqoJwA==
X-Received: by 10.84.128.72 with SMTP id 66mr19766387pla.284.1515617657430;
        Wed, 10 Jan 2018 12:54:17 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c79sm37995131pfj.49.2018.01.10.12.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jan 2018 12:54:16 -0800 (PST)
Date:   Wed, 10 Jan 2018 12:53:51 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 8/9] sequencer: try to commit without forking 'git
 commit'
Message-ID: <20180110205351.GA73826@aiede.svl.corp.google.com>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
 <20171211141330.23566-9-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211141330.23566-9-phillip.wood@talktalk.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the commit message does not need to be edited then create the
> commit without forking 'git commit'. Taking the best time of ten runs
> with a warm cache this reduces the time taken to cherry-pick 10
> commits by 27% (from 282ms to 204ms), and the time taken by 'git
> rebase --continue' to pick 10 commits by 45% (from 386ms to 212ms) on
> my computer running linux. Some of greater saving for rebase is
> because it no longer wastes time creating the commit summary just to
> throw it away.

Neat!  Dmitry Torokhov (cc-ed) noticed[1] that this causes the
prepare-commit-msg hook not to be invoked, which I think is
unintentional.  Should we check for such a hook and take the slowpath
when it is present?

Thanks,
Jonathan

[1] https://public-inbox.org/git/CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufaS_zs+w@mail.gmail.com/
