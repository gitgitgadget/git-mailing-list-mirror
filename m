From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 28/44] builtin-am: pass git-apply's options to git-apply
Date: Wed, 1 Jul 2015 10:01:35 -0700
Message-ID: <CAGZ79kZt2dpNyw7AE6T_ox24tR7poAV3hm7rvfnn3kJ+LVR3UA@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-29-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbzwv8m47t5W+1djFEWGL_X1nHPf7FWcwcKAZ34oFszxg@mail.gmail.com>
	<CACRoPnTeg08nJfMw6Lh6RUAOaKsSx30-=hhj2QD7_bPfKTHtTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 19:01:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZALOH-0002Bm-Ur
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 19:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbbGARBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 13:01:37 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35590 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbGARBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 13:01:35 -0400
Received: by ykdy1 with SMTP id y1so44796370ykd.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ErlDmesx4geF7ZoE2JpGU4l34YEDvhJO2Cewosgd7NY=;
        b=Fjd6bQWJNIQCLTPQgbfrUsD2EQdVHPQ+XY/eVg+tZaynfKDGwQL9UCJllLDOci71Fo
         r8qSp1YUup6nSRavCSoVqMOcu49DBuD0ybNcZ2gPqrymrR4UMbzCPAw44mcskQvTyX60
         0st8orslqOWUAaYL6Ol+zaQZxBWn9LFuIMoL6O0DpfPiZLHWUo57VMxFcF3qf7OCRrmQ
         pR8WyarPZowFCV9C7CBThcT+smYFU0t8/6uImA/8ou+9UsWgNQtdaYHFFRuVd+LIgoZX
         KI3ZdTjTdY289kx/arzDJQHrgTtPMcUqbAPN2GSOp5OKK70elE5EmQGqxkFRsAmR+Kvm
         eBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ErlDmesx4geF7ZoE2JpGU4l34YEDvhJO2Cewosgd7NY=;
        b=SeEo+d3+g4UsmqX7N0WPOrL7YSn/B6KRR+KhR8j9RCkXjob67X5wFmeUQANKBrm1pu
         /Di3hjssvgghZEtc8507ZipY4npTJa6UbvzU3BQ86al6rWA9vw28eyDfcaIu4dm7q4rS
         QWxCwvrsGyVyp1zuaifp48j9NYBJ6kOQHMP7zxkIYWVq1B3cwlGTM6xN1ufXfCb21wK6
         I0Y7E3A1DTh6Lw4fni7CBG5WpcS6Od6QqJUy6sYIRhuiisDoStuJ1vcvENjVUOGDtfzd
         vC6sFnLBrjsox9tSWWGDEX/rGxbGKs9vijHMpFzpqPzUBPU0u0MTNuyIC8TY04b+RXDI
         Q6Iw==
X-Gm-Message-State: ALoCoQl5/avgrodFI7Gr4iG+EPWdGdA9X5yPmO3hPqYXxM5Lay5RnmAnvnk5XV6Bpz0omwr235/4
X-Received: by 10.170.94.84 with SMTP id l81mr32942804yka.101.1435770095240;
 Wed, 01 Jul 2015 10:01:35 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Wed, 1 Jul 2015 10:01:35 -0700 (PDT)
In-Reply-To: <CACRoPnTeg08nJfMw6Lh6RUAOaKsSx30-=hhj2QD7_bPfKTHtTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273164>

On Wed, Jul 1, 2015 at 3:22 AM, Paul Tan <pyokagan@gmail.com> wrote:
> On Tue, Jun 30, 2015 at 7:56 AM, Stefan Beller <sbeller@google.com> wrote:
>> I realize this was in am.sh as well, but I find the help strings a bit
>> unfortunate.
>> (Yes, you actually need to look them up at another place as most people are
>> not familiar with the apply options).
>
> Yeah I agree, it would be an improvement. I think the same can be said
> for git-mailinfo's and git-mailsplit's options. e.g. "pass -k flag to
> git-mailinfo" is not very descriptive either, so we should change
> their help strings as well.
>
> Since git-am combines most of the options from git-mailsplit,
> git-mailinfo and git-apply together, I wonder if we should split their
> options into different groups, e.g:
>
> usage: git am [options] [(<mbox>|<Maildir>)...]
>    or: git am [options] (--continue | --skip | --abort)
>
>     -i, --interactive     run interactively
>     -3, --3way            allow fall back on 3way merging if needed
>     -q, --quiet           be quiet
>     -s, --signoff         add a Signed-off-by line to the commit message
>     --patch-format <format>
>                           format the patch(es) are in
>     --resolvemsg ...      override error message when patch failure occurs
>     --continue            continue applying patches after resolving a conflict
>     -r, --resolved        synonyms for --continue
>     --skip                skip the current patch
>     --abort               restore the original branch and abort the
> patching operation.
>     --committer-date-is-author-date
>                           lie about committer date
>     --ignore-date         use current timestamp for author date
>     --rerere-autoupdate   update the index with reused conflict
> resolution if possible
>     -S, --gpg-sign[=<key-id>]
>                           GPG-sign commits
>
> options for git-mailsplit
>     --keep-cr             pass --keep-cr flag to git-mailsplit for mbox format
>     --no-keep-cr          do not pass --keep-cr flag to git-mailsplit
> independent of am.keepcr
>
> options for git-mailinfo
>     -u, --utf8            recode into utf8 (default)
>     -m, --message-id      pass -m flag to git-mailinfo
>     -c, --scissors        strip everything before a scissors line
>     -k, --keep            pass -k flag to git-mailinfo
>     --keep-non-patch      pass -b flag to git-mailinfo
>
> options for git-apply
>     --whitespace <action>
>                           detect new or modified lines that have
> whitespace errors
>     --ignore-space-change
>                           ignore changes in whitespace when finding context
>     --ignore-whitespace   ignore changes in whitespace when finding context
>     --directory <root>    prepend <root> to all filenames
>     --exclude <path>      don't apply changes matching the given path
>     --include <path>      apply changes matching the given path
>     -C <n>                ensure at least <n> lines of context match
>     -p <num>              remove <num> leading slashes from
> traditional diff paths
>     --reject              leave the rejected hunks in corresponding *.rej files
>
> We may wish to put these changes in their own preparatory patch series though.
>
> What do you think?

I think this is an improvement!
But as you said, we should do it as an additional patch on top of the series.

Thanks,
Stefan

>
> Regards,
> Paul
