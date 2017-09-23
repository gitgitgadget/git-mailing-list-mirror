Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760C820A26
	for <e@80x24.org>; Sat, 23 Sep 2017 11:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdIWLcL (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 07:32:11 -0400
Received: from mout.web.de ([212.227.15.14]:64998 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdIWLcK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 07:32:10 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWirL-1dtEd01SCh-00Xq4N for
 <git@vger.kernel.org>; Sat, 23 Sep 2017 13:32:09 +0200
Subject: Re: is there a "symlink" option for cloning a repo in a separate
 filesystem?
To:     Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1709230418340.22644@localhost.localdomain>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <94fae18a-09e5-e387-213d-d840dd5201bd@web.de>
Date:   Sat, 23 Sep 2017 13:32:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1709230418340.22644@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:4Hu36yjWyYgZ7m7fLpJlXH8KyvLSX4V7IsPuBZN5X7fweXNu8o2
 xAv+f2BWsliFj7h8IBkK5xz6dbeQVFzcXUmpe8m/sVnYisq8LibOcPgbV9B02O+HwH+hzZV
 L8nYDEanJji1GJmCZrHyuqqmg241jP9Tirv/rI8NShR5CynhJiuOZme86zsiYN8rzBIi3Oi
 Hou7NKb8mHXAScmrOTlVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZsNizzM9TJ4=:BukXecRDfwErjgqlOUre/y
 cqiAZNHl7kmjsbOgTwwrCAEHnyi0CBSzq3zgdUkr5BXyUthHX0XUto/MD9NJUxCRurt5yGVeg
 lDopuyDqhyzteThJ7sB2QcsYOo5CYMbBFx0bhAFWcDDUqa7qQTL4IBn7VItsKMCNlVl4gLhkI
 4CEFh1zT1jAvntCToQ3zaKlOQzKTWHUF2GfOOhu3FPsHUz8GqCaA9Y2qJYXEWYO1gBu6XXIt9
 yWhfmvdBocoitNvsY4M+fF4agQB740CIhrmnd3SUxRkJHpcq0rGrQchMJKi7kfL1KOMqAa0Lu
 J+t7Og5O8+BJyyjSscypPGJhMECCZSZ92mML9CS77FP/qw/ZC8C3Y2AJ+5TnzH9CRQtAPNe77
 9AM0HKZg/fodgVk5p62Rl3LLp+MN5qyFMlrmoL22MXg39xWmpJj06AvnRE+7Y2dyFywyhZxDt
 X32AmXZjwqWdhxezyQtnBAkqlFnJ6N1pVLDwNivQnn/fxiAyf2mv/rcoJkNOgG9tk9yqX7fwC
 wGiwPezhM9swQSuVhkiqTVxn9HAd6DOUsu2ZN60/iWrtSBoTnuSV+7iXSPUKLiTMoT29CyYT1
 R+SU6toQJfUJmk29dopCSSxtXhg5vN++vfBD5oHJba+nPwxQ2gjIsu24KkaCZaeKLao1Z8kB+
 +MdpNAOiaM2zs97hEuVGbQzaGlZeZ3ovh19Tg6X3Hftgv+s8+I86coP01nU8oh8k4SxeSjktU
 Cfw8wajx7URcYZWhVzo03PJ7VcM4P9gawuEr/gg0Lro6fBkF3QGyRvpM8IG0nHnNn2pGLE0pU
 3llaYKn0Xg492eGS8Y1CExeoQFZcRDar9a+MLrocMd+R5gSOq4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-09-23 10:22, Robert P. J. Day wrote:
> 
>   reading "man git-clone", and i understand the mechanics of the local
> protocol, so that if i run:
> 
>   $ git clone /path/to/repo
> 
> then "files under .git/objects/ directory are hardlinked to save space
> when possible."
> 
>   but if the repo is in a separate filesystem, or on an NFS mount,
> hardlinks clearly won't work, so what happens then? does it default
> all the way back to regular copies? is there no intermediate symlink
> feature that would still work? (i suspect i am far from the first
> person to wonder this.)
> 
> rday
> 

Isn't that what "--reference" is good for ?

https://git-scm.com/docs/git-clone

or

man git-clone

PS:
Robert P. J. Day <rpjday@crashcourse.ca>
Does not work from web.de
