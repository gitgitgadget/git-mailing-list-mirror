From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] Update documentations for git-log to include the new
 --merges option and also its corresponding config option.
Date: Sun, 22 Mar 2015 17:17:30 -0400
Message-ID: <CAPig+cTQK_NF9pULobpggg8eXEKN_exj2buBEmk26TKY=DkapA@mail.gmail.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
	<1427048921-28677-3-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 22:17:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZnFa-0003WO-2z
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 22:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbCVVRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 17:17:33 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:36811 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbCVVRb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 17:17:31 -0400
Received: by yhjf44 with SMTP id f44so60539723yhj.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EQmzp9G+NSI79mI0isGKWgtqTkf9ZJeDpuBePkmWX7k=;
        b=ozSkPZ1e7nw0EcNmSRa12SBlMNW1x+etQYGdNMypsPIiyR0vesJ68RcBQHgDtvDxoS
         i5ajcbZwhbyHnFO6cBUSFs5kEBJ7r9TfMtRByQWc4pfNw1KVG80XRdfOKGo7mfd/v3ie
         RXPdiHWDtGEEPbAuU/Hsi6Zc146x6tTLW4aZao15pTMcAAoeh2oOFq2fug/G6YNM5KRt
         m1yo7eHB2kq1bFUzAhhvR4fsS7gMyF8eQaItQ7qvscGgKBoSOclTp6KjkIPDnbd0IvDx
         UQUgvG5tUCu/SwjH+koXQFpIDStUyEBJs7kni8mA48aH7/kdzp0gR/tjJKBAUMbGuqYF
         76lQ==
X-Received: by 10.236.45.106 with SMTP id o70mr93244538yhb.180.1427059050648;
 Sun, 22 Mar 2015 14:17:30 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 14:17:30 -0700 (PDT)
In-Reply-To: <1427048921-28677-3-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: dni_uAaH47uKlmf2dG_88IplNIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266094>

On Sun, Mar 22, 2015 at 2:28 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> Subject: Update documentations for git-log to include the new
> --merges option and also its corresponding config option.

The Subject: should be a short summary of the change; ideally less
than 70 or 72 characters. The rest of the commit message can flesh out
the description if necessary. The subject on this patch is far too
long. Also, drop capitalization, mention the area you're touching, and
drop the final period. You might say instead:

    Documentation: mention git-log --merges= and log.merges

In this case, it's probably not necessary to write anything else in
the commit message. The summary says enough, despite its conciseness.

More below.

> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 1f7bc67..506125a 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -190,6 +190,9 @@ log.showroot::
>         `git log -p` output would be shown without a diff attached.
>         The default is `true`.
>
> +log.merges::
> +    Default for `--merges` option. Defaults to `show`.

To disambiguate this from the --merges option, you should probably
spell it out explicitly as `--merges=` rather than just `--merges`.

>  mailmap.*::
>         See linkgit:git-shortlog[1].
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4ed8587..398e657 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -99,6 +99,12 @@ if it is part of the log message.
>  --merges::
>         Print only merge commits. This is exactly the same as `--min-parents=2`.
>
> +--merges=show|hide|only::
> +       If show is specified, merge commits will be shown in conjunction with
> +       other commits. If hide is specified, it will work like `--no-merges`.
> +       If only is specified, it will work like `--merges`. The default option
> +       is show.

By "The default option is show", do you mean when --merges= is not
specified? Perhaps it would be better to phrase it as:

    Default is `show` if `--merges=` is not specified.

> +
>  --no-merges::
>         Do not print commits with more than one parent. This is
>         exactly the same as `--max-parents=1`.

It might make more sense to rewrite the --merges and --no-merges
options in terms of the new --merges= option. For instance, something
like this:

     --merges::
        Shorthand for `--merges=only`.

    --merges={show|hide|only}::
        `show`: show merge and non-merge commits

        `hide`: omit merge commits; same as `--max-parents=1`

        `only`: show only merge commits; same as `--min-parents=2`

        Default is `show` if `--merges=` is not specified.

     --no-merges::
        Shorthand for `--merges=hide`.

Alternately, --merges and --merges= could be combined like this
(taking inspiration from --decorate[=]):

    --merges[=show|hide|only]::

But then you need additional explanation about what --merges means
without the '=' and following keyword.

> --
> 2.3.3.263.g095251d.dirty
