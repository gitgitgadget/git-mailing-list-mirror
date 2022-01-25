Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0B3C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 21:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiAYV0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:26:41 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:31552 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbiAYV0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 16:26:40 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Jk0KT4d8Dz5tlC;
        Tue, 25 Jan 2022 22:26:37 +0100 (CET)
Message-ID: <5740b0c5-7df8-5947-a4c9-0ece2bf17891@kdbg.org>
Date:   Tue, 25 Jan 2022 22:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/4] i18n: factorize more 'incompatible options' messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, phillip.wood@dunelm.org.uk
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
 <ba203623-87b1-f3eb-9498-52c4ea4ba07e@kdbg.org>
 <80593381-2ecc-5de5-76b7-0e6c6452559f@gmail.com> <2894278.sRLLl5rxgE@cayenne>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <2894278.sRLLl5rxgE@cayenne>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.01.22 um 21:52 schrieb Jean-Noël AVILA:
> Le lundi 24 janvier 2022, 12:06:19 CET Phillip Wood a écrit :
>> On 24/01/2022 07:14, Johannes Sixt wrote:
>>> A general comment: To me, it looks like you didn't want to change the
>>> variable name 'f' in the first hunk above, and then just named the array
>>> 'f_options' to go with 'f'. Perhaps `exclusive_opt` (not plural!) for
>>> the array. Now, renaming 'f' to something longer makes the code a bit
>>> unwieldy. Therefore, let me suggest yet another approach: factor out
>>> functions check_exclusive_opts3(), check_exclusive_opts4(), to be used 
> like
>>>
>>> 	check_exclusive_opts3(use_stdout, "--stdout",
>>> 		rev.diffopt.close_file, "--output",
>>> 		output_directory, "--output-directory");
>>>
>>> I am not yet proposing check_exclusive_opts2(), but others may think it
>>> is an improvement, too, (if they think that such functions are an
>>> improvement in the first place).
> 
> Will factorize away such exclusive options, but I'm not sure where. Should it 
> be in git-compat-util.h?

How about parse-options.*? There are already some helper functions near
the end of parse-options.c. Perhaps the names I suggested must be
revised, though.

-- Hannes
