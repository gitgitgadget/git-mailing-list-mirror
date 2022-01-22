Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A267CC433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 14:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiAVOrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 09:47:48 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:33349 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbiAVOrs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 09:47:48 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Jgzcd4XlPz5tlB;
        Sat, 22 Jan 2022 15:47:45 +0100 (CET)
Message-ID: <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org>
Date:   Sat, 22 Jan 2022 15:47:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Some sub-commands can't be completed by TAB key.
Content-Language: en-US
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>
In-Reply-To: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.01.22 um 09:42 schrieb Hongyi Zhao:
> I find that there are some  sub-commands can't be completed by TAB key:
> 
> $ git <TAB>
> add               cherry-pick       fetch             latexdiff
> [...]
> As you can see, there are some sub-commands which are not listed in
> the above list, for example, the following ones:
> 
> $ git ls-remote
> $ git ls-files
> 
> Any hints for this problem?

Tab completion is only available for user-facing sub-commands
("porcelain"), but not for sub-commands intended for scripting
("plumbing"). The intent is to make tab completion more efficient during
day-to-day work on the command line. For example,

   $ git l<TAB>

arrives at

   $ git log <cursor here>

instead of

   log     ls-files     ls-remote     ls-tree
   $ git l<cursor here>

-- Hannes
