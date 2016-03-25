From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Thu, 24 Mar 2016 21:18:41 -0400
Message-ID: <CAPig+cQGTcX+1nKM-zzGrJXgKsa6aaZxAHwD=z1M8-s+ugJRFg@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	<01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 02:18:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajGOq-0003qF-AS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 02:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbcCYBSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 21:18:44 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33000 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbcCYBSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 21:18:42 -0400
Received: by mail-vk0-f65.google.com with SMTP id a62so6246650vkh.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 18:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/wsLO+cVUKzq0kq30XWC8ShuKcBSWxUkbb7LssMbOxc=;
        b=mTFoP3nHiWJTWTbv/NiJxtnMJzdRYgwCZTw8GPa9WSr0g1tu24dQzmjO0zjmyqgQ8d
         0FMxFIKUrCO9EibKuS58DUoSGaG2NRHvPf9hinN4nlSEfDuBlvMKX8X4LInYZ1lRBceR
         fbrd3jt1le9eMkIq8lNzOy1OhixbYeqOQPRo/YCzowkyS0iZZy9h3Em8pvzp+yWpwm+p
         nYDvA9+oc72WXYyUXJiLrmHJib5m2/K9YJ+XHWTyz6SsXe2SKJZBnLB5xiUY9f8JmllH
         Kn/xkAf/CYnJp9tE23QQjH1VSInmpo7BoMAnzdfQAWk3sRipDtoeZH0IZPWNlLUPDERv
         fTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/wsLO+cVUKzq0kq30XWC8ShuKcBSWxUkbb7LssMbOxc=;
        b=igbszltVoFGwgAyGR1wK9PeE35HCfV3FhWzmQ467c6YgEh/xUIffi79IhrgXYuxWBK
         asTT61O4XwTtDztiGSsxoC6pkYTwfqAd999c4fiRu8ZIOh0BuGVXNwkltISB2bh6q1jm
         JUY2uc7KjHsA82DS9NW5Az6uVPa7QiBQRKl69T2nENOLJzuGgbIkcTAQWZ6YwXko4mDd
         j4othPGSV5kacxXdnT/Y6dpNqCBrbO9UC8N4v2jsfyreedhV/E7GLF0nVQMgnSf7oVbQ
         FvVaDioc/LwgwTfrxLydYRa8SBxUvnCGQKCPjNdsq2qEeQS/PH9iRwDvO1PhFGuhNSoN
         2tuw==
X-Gm-Message-State: AD7BkJJaDMXEh6/wuuoHZTZ8iE1jzi0SSj6EEv8+cXvPuc3ciMbzRpnphBoYf80Z5AN8RITavuY3alYcfONMkA==
X-Received: by 10.31.8.142 with SMTP id 136mr6343352vki.14.1458868721407; Thu,
 24 Mar 2016 18:18:41 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 18:18:41 -0700 (PDT)
In-Reply-To: <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: GzChSTRCjkdbh1jShP4VOmzILzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289840>

On Thu, Mar 24, 2016 at 2:07 AM, Ray Zhang <zhanglei002@gmail.com> wrote:
> By adding this option which defaults to true, we can use the
> corresponding --no-checkout to make some customizations before
> the checkout, like sparse checkout, etc.

This version of the patch looks better. Thanks. A few comments below...

> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
> ---

Here, below the "---" line is a good place to explain to reviewers
what changed since the previous version of the patch. It's also
helpful to provide a link to the previous version, like this[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289659

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -87,6 +87,10 @@ OPTIONS
>         With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
>         in linkgit:git-checkout[1].
>
> +--checkout::

We can make it more clear that this is a boolean option by formatting
it either like this:

    --[no-]checkout::

or this:

    --checkout::
    --no-checkout::

I don't have a strong preference, and existing documentation uses either form.

> +       Default option with `add`, populate the new working tree. Use
> +       `--no-checkout` to skip the checkout.

It's subjective, but "Default option with `add`" doesn't quite convey
to me that this is the default behavior of "add". Also, readers would
likely benefit from some explanation of why they might ever want to
use this option. Perhaps it could be rewritten something like this:

    By default, `add` checks out HEAD, however, `--no-checkout` can
    be used to suppress checkout in order to make customizations,
    such as configuring sparse-checkout (see ...).

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -213,4 +213,9 @@ test_expect_success 'local clone from linked checkout' '
>         ( cd here-clone && git fsck )
>  '
>
> +test_expect_success '"add" worktree without a checkout' '
> +       git worktree add --no-checkout -b swamp swamp &&
> +       ( cd swamp && git reset --hard && git fsck)

To match the style of the test immediately above this one, you'd want
a space before the closing ')'.

However, I'm not convinced that reset+fsck is is really telling you
much, as fsck is about checking the object database (which was already
the subject of earlier tests in the script) and doesn't say anything
about the working directory which is the point of --no-checkout. Much
more interesting would be to verify that no files were checked out.
There are many ways to do so; here's one:

    git worktree add --no-checkout -b swamp swamp &&
    ls swamp >actual &&
    test_line_count = 0 actual

> +'

Finally, it wouldn't hurt to also add a test to verify that --checkout
works as expected (because the tests should check expected *behavior*,
not *implementation*).
