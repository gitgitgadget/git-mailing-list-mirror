Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683EEB64DD
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHCRRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCRRW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 13:17:22 -0400
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBF1BF0
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 10:17:20 -0700 (PDT)
Received: from [192.168.1.103] (089144221139.atnat0030.highway.webapn.at [89.144.221.139])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4RGwWd6dswz5tlB;
        Thu,  3 Aug 2023 19:17:17 +0200 (CEST)
Message-ID: <c2fea20d-af37-8721-5bd8-14bbc3daf937@kdbg.org>
Date:   Thu, 3 Aug 2023 19:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: .gitignore is not enough
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     git@vger.kernel.org, Aleem Zaki <aleemzaki@gmail.com>
References: <CA+sf2-+499Nfu00ciJeLwjRmBE7Bb-WZcZuCXY2-JXs88Pwz-w@mail.gmail.com>
 <CAE1pOi1Zt8i_rVi6dCGVsshhPxa_kV7qQ7SMu6R4nsSiadq7xw@mail.gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAE1pOi1Zt8i_rVi6dCGVsshhPxa_kV7qQ7SMu6R4nsSiadq7xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.08.23 um 07:35 schrieb Hilco Wijbenga:
> I think you might be looking for "git update-index --assume-unchanged
> <file>"? See https://www.git-scm.com/docs/git-update-index for more
> details.

Sorry to tell you that this is a myth that lives on because it is
repeated over and over again.

> This allows you to tell Git to ignore the changes you made to that
> (tracked) file.

No. --assume-unchanged allows you to make the *promise* to Git that you
will not change the file, and consequently Git does not have to check
whether the file was changed. If you break the promise (because you
change it), you will get what you deserve. For example, you may find
that Git overwrites your changes, or commits them nevertheless.

Perhaps a better choice is --skip-worktree, but recent answers on
Stackoverflow point out that even that is not a suitable solution for
"please, Git, ignore these changes".

-- Hannes

