Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_ADSP_CUSTOM_MED,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5365F1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 12:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeADMeS (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 07:34:18 -0500
Received: from [195.159.176.226] ([195.159.176.226]:54219 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeADMeR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 07:34:17 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1eX4gt-0003vn-UX
        for git@vger.kernel.org; Thu, 04 Jan 2018 13:32:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: Fwd: Unknown option for merge-recursive:
 -X'diff-algorithm=patience'
Date:   Thu, 4 Jan 2018 15:34:04 +0300
Message-ID: <p2l6s0$eot$1@blaine.gmane.org>
References: <9e4ffb63-59de-a020-fee8-6cefae3b3dda@gmail.com>
 <CAJs94Eakp6kaD=+imH2cZdB-=2NCBJNu0Rt=MmRtWiM60QGBSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
In-Reply-To: <CAJs94Eakp6kaD=+imH2cZdB-=2NCBJNu0Rt=MmRtWiM60QGBSA@mail.gmail.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

It seems there is some issue with double escaping:

14:57:18.524010 git.c:344               trace: built-in: git 'merge'
'--no-log' '--no-ff' '--strategy=recursive' '-X' ''\''diff-algorithm=p
atience'\''' '-m' 'Merge branch '\''core-rcu-for-linus'\'' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

Where did additional quotes around diff-algorithm came from?


01.01.2018 14:28, Matwey V. Kornilov пишет:
> Hello,
> 
> I am running git 2.15.1 and facing the following issue with linux kernel
> tree.
> 
> # git checkout v3.8
> # git branch abc-3.8
> # git checkout v3.9
> # git branch abc-3.9
> # git checkout abc-3.8
> 
> Introduce new commit on top of abc-3.8. Here, I edit README.
> 
> # vim README
> # git commit -a -v
> [abc-3.8 4bf088b5d341] Hello world
> 
> Then I try to rebase abc-3.9 on top of abc-3.8 as the following:
> 
> # git rebase --preserve-merges -s recursive -Xdiff-algorithm=patience
> --onto abc-3.8 v3.8 abc-3.9
> 
> And then I see:
> 
> fatal: Unknown option for merge-recursive: -X'diff-algorithm=patience'
> Error redoing merge e84cf5d0fd53badf3a93c790e280cc92a69ed999
> 
> Attached here is GIT_TRACE=1 output.
> 


