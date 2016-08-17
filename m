Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9662022A
	for <e@80x24.org>; Wed, 17 Aug 2016 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbcHQODE convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Wed, 17 Aug 2016 10:03:04 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:56540 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550AbcHQODD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2016 10:03:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9F2AA26A9;
	Wed, 17 Aug 2016 16:02:59 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Lhwlnt6lQsY; Wed, 17 Aug 2016 16:02:59 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 86239268B;
	Wed, 17 Aug 2016 16:02:59 +0200 (CEST)
Date:	Wed, 17 Aug 2016 16:24:10 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	Stephen Morton <stephen.morton@nokia.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	git@vger.kernel.org
Message-ID: <1592315356.1230893.1471443850115.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <f58933df-352a-9d2b-a35a-9c48cb2d958e@nokia.com>
References: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com> <CAP8UFD04Z7JpoAA1kXkYFk5LD-GngbUDkbnpCEc3DNDXUgetEA@mail.gmail.com> <f58933df-352a-9d2b-a35a-9c48cb2d958e@nokia.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: git cherry-pick conflict error message is deceptive when cherry-picking multiple commits
Thread-Index: Bq3Bu1VJVPx244KGONTx8lwW04tXrg==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stephen Morton <stephen.morton@nokia.com> writes:
> [snip]
> On 2016-08-16 4:44 AM, Remi Galan Alfonso wrote:
>> Hi Stephen,
>>
>> Stephen Morton <stephen.morton@nokia.com> writes:
>>> +                        if  (multiple_commits)
>>> +                               advise(_("after resolving the conflicts,
>>> mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
>>> +                                        "then continue with 'git %s
>>> --continue'\n"
>>> +                                        "or cancel with 'git %s
>>> --abort'" ), action_name(opts), action_name(opts));
>>> +                        else
>>> +                                advise(_("after resolving the
>>> conflicts, mark the corrected paths\n"
>>> +                                        "with 'git add <paths>' or 'git
>>> rm <paths>'\n"
>>> +                                        "and commit the result with
>>> 'git commit'"));
>> In both cases (multiple_commits or not), the beginning of the advise
>> is nearly the same, with only a '\n' in the middle being the
>> difference:
>>
>> multiple_commits:
>>   "after resolving the conflicts, mark the corrected paths with 'git
>>   add <paths>' or 'git rm <paths>'\n"
>>
>> !multiple_commits:
>>   "after resolving the conflicts, mark the corrected paths\n with 'git
>>   add <paths>' or 'git rm <paths>'\n"
>>                                                    ~~~~~~~^
>>
>> In 'multiple_commits' case the advise is more than 80 characters long,
>> did you forget the '\n' in that case?
> A previous comment had indicated that having 4 lines was too many. And I
> tend to agree. So I tried to squash it into 3. Back in xterm days, 80
> characters was sacrosanct, but is it really a big deal to exceed it now?

Either way (3 or 4 lines) I find it strange to have both advices
start in the same way except that one is split and not the other.

I cannot tell if it's a big deal or not to exceed 80 characters
but FWIW most of my stuff (terminal and emacs) is 80 columns
long, and I haven't known the "xterm days".

Thanks,
Rémi
