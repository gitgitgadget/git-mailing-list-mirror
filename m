Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD9F1FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 06:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdDDGXG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 02:23:06 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:54297 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdDDGXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 02:23:05 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 74A945AF37
        for <git@vger.kernel.org>; Tue,  4 Apr 2017 08:23:02 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 555C05AE0C
        for <git@vger.kernel.org>; Tue,  4 Apr 2017 08:23:02 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Tue, 04 Apr 2017 08:23:02 +0200
Message-Id: <58E33BC4020000A100025797@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 14.2.2 
Date:   Tue, 04 Apr 2017 08:23:00 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Jakub Narebski" <jnareb@gmail.com>,
        "=?UTF-8?Q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: Terrible bad performance for it blame --date=iso -C
References: <58E1F239020000A100025732@gwsmtp1.uni-regensburg.de>
 <20170403105641.16912-1-szeder.dev@gmail.com>
 <0ccc5cab-26b7-4b02-b964-452b61e92579@gmail.com>
In-Reply-To: <0ccc5cab-26b7-4b02-b964-452b61e92579@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Jakub Narebski <jnareb@gmail.com> schrieb am 03.04.2017 um 17:16 in
Nachricht
<0ccc5cab-26b7-4b02-b964-452b61e92579@gmail.com>:
> W dniu 03.04.2017 o 12:56, SZEDER Gábor pisze:
>> Ulrich Windl wrote:
> 
>>> In the other case (for the user bored of waiting seeking for some
>>> entertainment ;-)) a "-v (verbose) option could be useful.  Or at the
>>> very least: If git is expecting that some operation will take (or
>>> already did take) a lot of time, give some message explaining why it
>>> is taking a lot of time, and maybe how to avoid that.
>> 
>> It already does so by default since v2.8.0, see aba37f495 (blame: add
>> support for --[no-]progress option, 2015-12-12).
>> 
>>   $ time git blame sha1_file.c |wc -l
>>   4026
>>   
>>   real    0m1.744s
>>   user    0m1.672s
>>   sys     0m0.068s
>>   $ time git blame -C -C sha1_file.c |wc -l
>>   Blaming lines: 100% (4026/4026), done.
>>   4026
>>   
>>   real    0m3.832s
>>   user    0m3.716s
>>   sys     0m0.112s
>> 
>> However, after a short peek at that commit, it only displays progress
>> by default when stderr is a terminal, which might not be the case when
>> invoked from emacs.
> 
> Emacs (magit?) should use `git blame --porcelain`, and do its own
> progress report, just like 'git gui blame' and incremental blame mode
> of gitweb.

I was thinking similar: The pain vc-annotate obviously should work without
those "-C" options, and with prefix argument (C-u <num> in Emacs) it could
start looking for copied stuff. HMO...

Worse than no progress reporting is the inability to kill the process (if you
run out of patience) with C-g (that stops most commands in Emacs).

> 
> Actually... there already is git-blamed - Minor mode for incremental
> blame for Git, and mo-git-blame - An interactive, iterative 'git blame'
> mode for Emacs, both available on ELPA (Emacs Lisp Package Archive).

I confess taht is still use RCS from time to time, and I prefer the
higher-level Emacs commands ;-)

Regards,
Ulrich

