From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some options"
Date: Sat, 27 Feb 2016 19:53:02 -0500
Message-ID: <CAPig+cSXY0XE7C71EAO8MOpzrtSFOA0fcxu5wxAZ-J9RzjusPg@mail.gmail.com>
References: <20160226232507.GA9404@sigill.intra.peff.net>
	<20160226232957.GB9552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 28 01:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZpbi-0005Dj-SD
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 01:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992585AbcB1AxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 19:53:05 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34730 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791AbcB1AxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 19:53:04 -0500
Received: by mail-vk0-f68.google.com with SMTP id e6so7296285vkh.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=dyle0hsvTrOFG3xVNfProJ0L0mCEB9xIIXSE26VV8Bk=;
        b=OhDHQzCN2D6xQ/jBKc3bMpVqiMsJV628IzosDOqi61pSz3IUq/fDRA9F8q66VHfdTi
         +HrVq3JBf22myxwHhdYvF0wux7pGovJ6VC4XLYaAbMEfoov0JoJl+wod7K7nheHM88ma
         PvgFdcGItxSIWz4JGLm8n3QS6oiNj96rRb3fD+mNQKab6cjLi1CE7Q070fhmOPvzlrXn
         Sr3otyOuybvVRuAerIn747MvLp8QNDb8rKVQpfEm5mpgfwi41JkduPSXQ5w2sfbZFD2R
         KXS4fqEweJW+EDvXLEsVcixBGKX8e7eES9ZV1S2prt2p/HfqawPm6gUO6kIczjnm8BHS
         j5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dyle0hsvTrOFG3xVNfProJ0L0mCEB9xIIXSE26VV8Bk=;
        b=UrqQEs8mKL8g5mM30ZW/V2tDdzz1xwu2wEgRxFQWvegOuzbpgg7LhghMjurg+yPefg
         jk/UXLDF7ddsZQfdrQh4afMlFFOhFf3YdClYcvZ9so9xbV3Ak0OC89Yf6nDXd/07J0P0
         lD4U/n2jZp2ZKL0eEcXUnBKfRlj5wmswR07cfD2Vh6haMsSjSWQL9FJ17QJG3hm7A5c9
         L6hDnAGVxjRBGVsc/9ECNv0xI62CK8OCVnr+ppe4CGBAT070TLTi3Msfh7KPeyL24G5V
         m3x9ezo9ZqLuZT0wiiTUb5Thp5MA63+4YszUG5chdCyH2E6Wm0Uq8ACbTAQivLSZx3VZ
         0vqQ==
X-Gm-Message-State: AD7BkJIlIWmrnEK5oTeS84A5c1hLUD1A8S0/M6M+NwZsm6ajrGI+hUorY+XakMLVFWOV1Ti945xj9dP/JpUbUg==
X-Received: by 10.31.41.14 with SMTP id p14mr6461112vkp.151.1456620782469;
 Sat, 27 Feb 2016 16:53:02 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 27 Feb 2016 16:53:02 -0800 (PST)
In-Reply-To: <20160226232957.GB9552@sigill.intra.peff.net>
X-Google-Sender-Auth: baE_GAnQu6J1HBF-kj1E74bKSVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287737>

On Fri, Feb 26, 2016 at 6:29 PM, Jeff King <peff@peff.net> wrote:
> This reverts commit 68889b416d5b6a5cf7d280a428281d635fe9b292.
>
> That commit bumped some rev-parse options into the main
> option-parsing loop, which meant that they no longer had to
> come at the very beginning of the option list. However, that
> also means that they now came after our call to
> setup_git_directory(), and will no longer run outside of a
> git repository.
>
> For --local-env-vars, this is semi-questionable. The main
> use of that option is to get a list of environment variables
> to clear, and if you are not in a repository, there
> _probably_ isn't anything to clear. But it places an
> unnecessary restriction on callers who may be using it
> preemptively.
>
> For --resolve-git-dir, it is almost certainly a regression.
> That option is about finding a git dir in the first place,
> so it is reasonably likely to be called from outside an
> existing repository.
>
> The best solution here would be to have a full parsing loop
> that handles all options, but only calls setup_git_directory
> as appropriate. Unfortunately, that's a bit complicated to
> implement. We _have_ to handle each option in the order it
> appears on the command line. If the caller asked for:
>
>   git rev-parse --resolve-git-dir foo/.git --show-toplevel
>
> then it must receive the two lines of output in the correct

s/correct/& order/

> to know which is which. But asking for:
>
>   git rev-parse --show-toplevel --resolve-git-dir foo/.git
>
> is weird; we have to setup_git_directory() for the first
> option.
>
> So any implementation would probably have to either:
>
>   - make two passes over the options, first figuring out
>     whether we need a git-dir, and then actually handling
>     the options. That's possible, but it's probably not
>     worth the trouble.
>
>   - call setup_git_directory() on the fly when an option
>     needs it; that requires annotating all of the options,
>     and there are a considerable number of them.
>
> The original patch was not spurred by an actual bug report,
> but by an observation[1] that was essentially "eh, this
> looks unnecessarily restrictive". It _is_ restrictive, but
> it turns out to be necessarily so. :)
>
> And in practice, it is unlikely anybody was bothered by the
> restriction. It's not really sane to use --local-env-vars
> with other options, anyway, as it produces unbounded output
> (so the caller only know it ends at EOF). It's more
> plausible for --resolve-git-dir to be used with other
> options, but still unlikely. It's main use is accessing

s/It's/Its/

> _other_ repositories (e.g., submodules), so making a query
> on the main repository at the same time isn't very useful.
>
> This patch therefore just reverts 68889b416, with a few
> caveats:
>
>   1. Since the original change, --resolve-git-dir learned to
>      avoid segfaulting on a bogus. We don't know need to

s/bogus/& argument/

>      backport that, because the "restricted" form checks
>      argc.
>
>   2. The original patch mentioned that we didn't need to
>      clean up any documentation, because the restriction
>      wasn't documented. We can at least fix that by
>      mentioning the restriction in the manpage.
>
>   3. We can now mark our newly-added tests as passing. :)
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/230849
>
> Signed-off-by: Jeff King <peff@peff.net>
