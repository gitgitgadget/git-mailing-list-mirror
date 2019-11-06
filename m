Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B211F4C0
	for <e@80x24.org>; Wed,  6 Nov 2019 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfKFLJB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 06:09:01 -0500
Received: from fossies.org ([144.76.163.196]:55098 "EHLO fossies.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbfKFLJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 06:09:01 -0500
Received: from fossies.org (localhost [127.0.0.1])
        by fossies.org (8.15.2/8.15.2) with ESMTP id xA6B88XI029342;
        Wed, 6 Nov 2019 12:08:12 +0100
Received: from localhost (admin@localhost)
        by fossies.org (8.15.2/8.15.2/Submit) with ESMTP id xA6B87PU029233;
        Wed, 6 Nov 2019 12:08:07 +0100
Date:   Wed, 6 Nov 2019 12:08:07 +0100 (CET)
From:   Fossies Administrator <Jens.Schleusener@fossies.org>
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Some misspelling errors in the git release 2.24.0
In-Reply-To: <20191105171107.27379-1-newren@gmail.com>
Message-ID: <alpine.LSU.2.21.1911061026130.15790@fossies.org>
References: <alpine.LSU.2.21.1911041704520.3956@fossies.org> <20191105171107.27379-1-newren@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 144.76.163.196
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

> On Mon, Nov 4, 2019 at 8:14 AM Fossies Administrator <Jens.Schleusener@fossies.org> wrote:
>>
>> Hi Elijah,
>>
>>> On Mon, Nov 4, 2019 at 7:07 AM Fossies Administrator
>>> <Jens.Schleusener@fossies.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> although misspelling corrections are not the most exciting issues and the
>>>> spelling errors are rarely true code bugs but mostly contained in the
>>>> comments and documentation parts they correction may still improve the
>>>> overall quality of a software project a little bit.
>>>>
>>>> In this sense I created a code misspelling report for "git" using the
>>>> program "codespell"
>>>>
>>>>   https://fossies.org/linux/misc/git-2.24.0.tar.xz/codespell.html
>>>>
>>>> or version independent
>>>>
>>>>   https://fossies.org/linux/misc/git/codespell.html
>>>
>>> Cool, thanks for sending this report along.  The typos within the
>>> Documentation/ subdirectory have mostly been addressed by the
>>> en/doc-typofix branch (in next, not yet merged to master).  There are
>>> also some false positives in this report (e.g. mmaped should not be
>>> changed to mapped, CREAT should not be changed to CREATE, examples in
>>> format-patch showing how to correct spelling errors need to keep their
>>> spelling errors or it won't make sense, and perhaps some others), but
>>> most of them look like actual spelling errors that should be
>>> corrected.  I'll send in a patch, and mark you as the reporter of the
>>> issues.
>
> So, I used your codespell program

That seems to be a misunderstanding: I'm not the author of the codespell 
program but I only use that program to detect spelling errors and point to 
their existence while offering the option to inspect the context of the 
probably misspelled words in a fast and comfortable way via a Web page.

> to catch all these and turned
> en/doc-typofix into a series of patches to fix all the errors:
>  https://public-inbox.org/git/pull.418.v2.git.1572973650.gitgitgadget@gmail.com/
>
>
> But I thought it might also be worthwhile to you to report what the
> false positives found by that program were; I've included them at the
> end of this email in the form of a patch.  The places where the program
> seemed to struggle were:
>
>  * In dealing with translation files.  It didn't recognize them as
>    such and often tried to translate foreign words to a nearby English
>    one.
>  * In handling variable names: acronyms might be similar to english
>    words (cas, for compare and swap, looks like case), abbreviations
>    might look like alternate words (ans, short for answer, looks like
>    and).
>  * Testcases with intentional spelling errors
>  * Proper names that were similar to English words (Ned -> Need,
>    Claus -> Clause)
>  * miscellaneous tech jargon or package names (e.g. 'filetest' module
>    being replaced with 'file test', 'ith' as in not first or second
>    but the item at position i being replaced with 'with', 'mmaped'
>    being replaced with 'mapped', 'CREAT' changing to 'CREATE',
>    'UserA' (out of a sequence of UserB, UserC, etc.) changing to
>    'users', 'spawnve' function name being replaced with "spawn",
>    'CAs' (certificate authorities) being replaced with 'case', etc.)

Thanks for the detailed and informed feedback. These are exactly problems 
that I noticed as well. Some additional ones are for e.g. words at the end 
of a string definition (apostrophe), mail addresses and differences 
between US-English and UK-English. Sometimes it's difficult to decide what 
to exclude: For e.g. your mentioned word "ans" is often intentionally used 
but often it's also a typo ("and") so FPs or FNs seem unavoidable. So 
codespell respectively Fossies can give only the pointers and an 
individual check seems always required.

Some of the according FPs are excluded by Fossies generally, some other 
obvious FPs are excluded by Fossies specifically for each FOSS project 
(see always the bold item "Codespell configuration" with a link to 
"Project-specific additions" or to "(no project-specific adaptions yet 
done)" that shows all the excluded words and directories/files).

> Some of these would be difficult for any tool to deal with, but e.g.
> recognizing translation files as such and ignoring them might be
> interesting.

As one can see on the page

  https://fossies.org/linux/misc/git-2.24.0.tar.xz/codespell_conf_info.html

there are already done some according attempts.

To let run codespell with an English dictionary about directories like 
"translations" or "langmap" is probably in the most cases meaningless 
(although in such directories may be contained also "English" source 
code). So if one uses codespell manually one should use options like 
"--ignore-words-list" and "--skip" (directories, files) and can look 
optionally for a starting point to the values Fossies has used.

> Anyway, thanks for the report and the pointer to the tool.

Although (hopefully) most of the FPs within your list are already excluded 
by Fossies I will check the list to make Fossies perhaps even smarter.

> -- 8< --
> Subject: [PATCH] DO NOT MERGE: False positives from `codespell -w`

[... the very big list of FPs removed in this reply mail ...]

Regards

Jens

-- 
FOSSIES - The Fresh Open Source Software archive
mainly for Internet, Engineering and Science
https://fossies.org/
