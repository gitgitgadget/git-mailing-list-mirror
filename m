From: Stefan Beller <sbeller@google.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Wed, 20 Apr 2016 16:05:33 -0700
Message-ID: <CAGZ79kbyDuu8hUQXOUNmDLyO88GOi3kqSzsc0UfgzwAL9peZHg@mail.gmail.com>
References: <20160420152209.GH23764@onerussian.com>
	<CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
	<xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
	<xmqqshygt1gs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 01:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at1Bj-0000wa-8o
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 01:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbcDTXFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 19:05:35 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37089 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbcDTXFe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 19:05:34 -0400
Received: by mail-ig0-f176.google.com with SMTP id g8so64870312igr.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=US1eJcuWchk/ttnLZc4dkUX7IZitUvAExfCpwtO/nu4=;
        b=Ct25jschEvf2qFX8JqO2Ys63kxQoiJz7n9GnqyWO8EuOG5F+B5dqok44Y2pnZaR/u4
         QDzFtIj6L2wYrYuZbfvB5VYxs8nhOyuLFrWnUYOp8yqNn168/WDNz3mTZLdix//Ws2Nx
         JAquX3SgrKcIryaf+TxuBfd8fm67IVTAFfAXdbY4rguEPKaJYT/59IymCZH2eu8ZWD5m
         ZiTvhl8oQRz2xAiLGbVGeekYo59zXDPCZ3FXFYLT81pq9GSV5+OesQHUJmYaTf0cnzVO
         gn9TzwqIpyZqvleaQRhQwgJin653MqKy14fj7M7SUHf8SKKN3iDlhhMjWZy50hHNxYy9
         yVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=US1eJcuWchk/ttnLZc4dkUX7IZitUvAExfCpwtO/nu4=;
        b=SMNA+wbbwL4jlRkTCsINMcvtJSVVN0NrnNbUiI9cf1WhVap1/tU5KRkiSlTZHlIz/R
         AE7Qqhf6cuZdozParjvJj3Cukj8c6I7yualxBV/fdNv4xIJcyG3UbDe+EP1KPayYuDj7
         K6LJ4R4dhJQq5Kz7OWQuEVPJoaIfCgHy6/wq3iVFEVNImzjl7mGRJAqB7q4FWr9/n89R
         iVOyj3cggrrjCstv4qOX4QC3VLFuMTQ7V3Noq91TdLibUnti3+HJrkq4+Bt6Ap761zHX
         GU8fHdEieDUn4mGKidUj6p8bijoi5U2s7jlQfzDSFAAsS0PddTm+90yDPKQWrr3IY5HO
         Umcg==
X-Gm-Message-State: AOPr4FWZWtSZLmONUntUcfArBLi7v68oSClCgXyPr6tWnCMXGkyJas4DHTgV3RFWGpcigWfB7meXxVhtC2HtgRC3
X-Received: by 10.50.72.107 with SMTP id c11mr6628318igv.85.1461193533280;
 Wed, 20 Apr 2016 16:05:33 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 20 Apr 2016 16:05:33 -0700 (PDT)
In-Reply-To: <xmqqshygt1gs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292089>

On Wed, Apr 20, 2016 at 2:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I may be missing the subtleties, but if you are serving others from
>>> a non-bare repository with submodules, I do not think you would want
>>> to expose the in-tree version of the submodule in the first place.
>>
>> Well I would imagine that is the exact point.
>> If I was not trying to expose my state, I could ask you to
>> obtain your copy from $(git remote get-url origin) just as I did.
>
> That wasn't what I had in mind, but if the cloner cloned from your
> repository with a working tree, the cloner would discover submodules
> you use from your .gitmodules file, which would record the location
> you cloned them from, so something like that may come into the
> picture.  What I had in mind was more like this one you mentioned
> below:
>
>>     $GIT_DIR_SUPER_PROJECT/modules/$MODULE_NAME
>> ...
>> Right instead of cloning $WORKTREE/sub/.git you rather want
>> $GITDIR/module/sub
>
>> So currently the protocol doesn't allow to even specify the submodules
>> directories.
>
> Depends on what you exactly mean by "the protocol", but the
> networking protocol is about accessing a single repository.  It is
> up to you to decide where to go next after learning what you can
> learn from the result, typically by following what appears in
> the .gitmodules file.

Right. But the .gitmodules file is not sufficient.

If I clone from a bare hosting location, the .gitmodules file
is the best we can do and the .gitmodules file works as intended.
But in the non bare I case I think we would want to get the submodule
from that location as well.

So in git clone (which calls out to git submodule update, which uses
submodule--helper update_clone for cloning submodules) we'd want to see

    if remote was bare:
        do as usual (obtain URL from .gitmodules file)
    else
        take URL=$NON_BARE_REMOTE/module/submodule



>
> The only special case is when .gitmodules file records the URL in a
> relative form, I would think.  Traditionally (i.e. when it was
> considered sane to clone only from bare repositories) I think people
> expected a layout like this:
>
>         top.git/
>         top.git/refs/{heads,tags,...}/...
>         top.git/objects/...
>         top.git/sub.git/
>         top.git/sub.git/refs/{heads,tags,...}/...
>         top.git/sub.git/objects/...

which could also be referred to as

      top

without the .git suffix as someone thought this was an optimization?

Relative paths for submodules I have seen so far (on github,
googlesource, eclipse)
start with a ../ such that we'd have

>         top.git/
>         top.git/refs/{heads,tags,...}/...
>         top.git/objects/...
>         sub.git/
>         sub.git/refs/{heads,tags,...}/...
>         sub.git/objects/...

and the .git suffix omission works as we only need to check for the last
for characters and not somewhere in between. The sub.git is a standalone
repository, and you cannot tell it is a submodule (except by its contents)

>
> and refer to ./sub.git from .gitmodules recorded in top.git.  It
> still would be norm for common distribution sites (i.e. the original
> place Yaroslav likely has cloned things from) to be bare, and with
> or without $GIT_DIR/modules/, the relative path of submodule seen
> by its superproject would (have to) be different between a bare and
> a non-bare repository.

I think on a hosting site they could even coexist when having the
layout as above.

         top.git/
         top.git/refs/{heads,tags,...}/...
         top.git/objects/...
         sub.git/
         sub.git/refs/{heads,tags,...}/...
         sub.git/objects/...

         # the following only exist in non bare:
         top.git/modules/sub.git/
         top.git/modules/sub.git/refs/{heads,tags,...}/...
         top.git/modules/sub.git/objects/...

The later files would be more reflective of what you *really*
want if you clone from top.git.

Traditionally (when cloning was done from bare repos only),
the .gitmodules file provides a very good way to indicate what
the intent of the superproject is as the recorded sha1 in the tree
doesn't tell you anything and tracking the remote for the submodule
out of tree is cumbersome, so an in tree solution makes perfect sense.

If we have a non bare repo, it is safe to assume that the cloner actually
meant to get the whole state from the remote (including submodules)?

I am trying to think of reasons why you would not want to get that copy
from the remote. One (weak) reason is that the submodule may be a
well known library, which you can obtain faster from a well known git
hosting site rather than $remote.

>
> I'd imagine that people could agree on a common layout like this
> even for a forest of bare repositories:
>
>         top.git/
>         top.git/refs/{heads,tags,...}/...
>         top.git/objects/...
>         top.git/modules/sub.git/
>         top.git/modules/sub.git/refs/{heads,tags,...}/...
>         top.git/modules/sub.git/objects/...
>
> which would probably make the "relative" relationship between the
> supermodule and its submodules the same between bare and non-bare
> repositories, but I didn't think it too deeply.

Forrests as of now are handled as a flat level thing, e.g.

    git clone git://git.eclipse.org/gitroot/platform/eclipse.platform.releng.aggregator.git

will produce a superproject with 25 submodules, all of them
are either at ../ or at ../../ such that it would follow

         projects/top.git/
         projects/top.git/refs/{heads,tags,...}/...
         projects/top.git/objects/...
         projects/sub.git/
         projects/sub.git/refs/{heads,tags,...}/...
         projects/sub.git/objects/...
         libs/sub2.git
         libs/sub2.git/refs/{heads,tags,...}/...
         libs/sub2.git/objects/...

Looking at our internal code search there is no .gitmodules file
whose url starts with "./", they all start with ../ or are absolute.
