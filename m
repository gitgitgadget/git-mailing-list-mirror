Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F24CC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05673610C7
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhJ1PlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:41:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46708 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhJ1PlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 11:41:21 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mg7UT-000AVQ-9l; Thu, 28 Oct 2021 16:38:53 +0100
Message-ID: <9561c0de-fb97-093b-4615-6d6d7d595d51@iee.email>
Date:   Thu, 28 Oct 2021 16:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: conflict markers in markdown files
Content-Language: en-GB
To:     Nicholas Bransby-Williams <nbransby@gmail.com>, git@vger.kernel.org
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/2021 15:00, Nicholas Bransby-Williams wrote:
> Isn't it quite unfortunate that markdown chose setext-style headers by
> “underlining” with equal signs (=) meaning if a header is 7 characters
> long it's going to clash with the git conflicts markers (example
> below).
>
> Would it make sense to add an option to merge-file so merge tools can
> specify a custom marker that is statistically much less likely to
> clash with the kinds of text files that are typically stored in git
> repositories?
>
> cat ./ours.md
> A Second Level Header
> ---------------------
> Ours
> =======
> Its ours
> The quick brown fox jumped over the lazy
> dog's back.
>
> cat ./base.md
> A Second Level Header
> ---------------------
> The quick brown fox jumped over the lazy
> dog's back.
>
> cat ./theirs.md
> A Second Level Header
> ---------------------
> Theirs
> =======
> Its theirs
> The quick brown fox jumped over the lazy
> dog's back.
>
> git merge-file -p ./ours.md ./base.md ./theirs.md
> A Second Level Header
> ---------------------
> <<<<<<< ./ours.md
> Ours
> =======
> Its ours
> =======
> Theirs
> =======
> Its theirs
>>>>>>>> ./theirs.md

In a similar vein, the above `>>>>>>> ./theirs.md` is being formatted as
repeated side bars in Thunderbird. But that's someone else's problem ;-)

> The quick brown fox jumped over the lazy
> dog's back.

