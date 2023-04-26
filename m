Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598CC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 06:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbjDZGKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbjDZGKH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 02:10:07 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 23:10:05 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE275139
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 23:10:05 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1prYH0-0005n5-E3
        for git@vger.kernel.org; Wed, 26 Apr 2023 08:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   ParetoOptimalDev <pareto.optimal@mailfence.com>
Subject: With git+ssh deprecated, how can  multiple git identities be managed?
Date:   Wed, 26 Apr 2023 00:59:30 -0500
Message-ID: <87h6t3rxod.fsf@mailfence.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:AGmnfovAhKzfAc7dQt0lIu7kBhM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello all.

For instance with git+ssh I would have the following in my
~/.ssh/config:

```
Host paretooptimal-personal
  User git
  HostName github.com
  IdentityFile /run/agenix/pareto_optimal_personal_priv

Host paretooptimal-work
  User git
  HostName github.com
  IdentityFile /run/agenix/pareto_optimal_work_priv
```

Then I could use it like `git clone
git+ssh://paretooptimal-work/some-work/codebase.git` or
`git+ssh://paretooptimal-personal/some-personal/codebase.git`
respectively.

The problem is that since this is deprecated a tool I use in emacs called forge
doesn't want to add support for this type of git url because it's being deprecated:

https://github.com/magit/forge/issues/545

That's valid and understandable, but I feel like I have a valid use case
that calls into question the deprecation of these urls.

So my desire here is to have a solution for multiple git identities that
isn't deprecated and is supported in forge, or is a feature that can be
added using non-deprecated git functionality.

Un-deprecating git+ssh urls would be one possible solution, but if I had
to bet I'd say the case I make won't be compelling enough ;)

Either that, or some other way of accomplishing this is possible. Or
perhaps, this isn't a use case the git project thinks is worth
supporting.

I also have another case for `git+ssh` urls to create private git
repositories authenticated by ssh key. I'm fairly sure there isn't a
better solution for that.

If one needs a more concrete example of the private git repository use
case using `git+ssh`, I typically use it to create private Nix flakes.

Nix flakes: https://www.tweag.io/blog/2020-05-25-flakes/

Thank you for your time and consideration.

