From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] fix flaky untracked-cache test
Date: Wed, 21 Oct 2015 22:25:39 +0200
Message-ID: <CACsJy8BRFvD=kVH6-W1j+PgHdNYCmuwrKXTADmHG=AQPv9GUUA@mail.gmail.com>
References: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, larsxschneider@gmail.com,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:26:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zozxp-0008Qa-3I
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbbJUU0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:26:12 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36328 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbJUU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:26:10 -0400
Received: by lffz202 with SMTP id z202so26792597lff.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RElzxmVP+VlqtA5/5tvlLyIIEUlh4CRxUjfb/2zbvfE=;
        b=dIIRqt7RC4fzV8gw65BjoyfU8HrATnB0ZZuKgkw/zVCu1DL9bqB5x6ZRcLnHGtVTWX
         mdeJzMMa20P0Ec4nxNyAB6GCzacYV3DEiV1mgN8RsK/0g1v+rjFOeJS+oYYDHjqkSNE4
         yGDYzlf5tCqE9IBOcEwwMcqBB/lZ4884+OEcFePzLBFYGuJW/BYU9qg//27IfGh3HW8c
         2RjjRgms8vf1zbZUk5JFK6XE/c5cjLiDW/l1YD4BdKIljtS1bIRC6UyNli4LTnGJwSYU
         f2RKppsbMVGSZm4tAPgqAjFI/fSbFPhF+F9e5wRLvN6Uo9e6BnRcuaBa6JdYfGC3wb26
         HItg==
X-Received: by 10.25.40.65 with SMTP id o62mr4255500lfo.115.1445459168837;
 Wed, 21 Oct 2015 13:26:08 -0700 (PDT)
Received: by 10.112.255.229 with HTTP; Wed, 21 Oct 2015 13:25:39 -0700 (PDT)
In-Reply-To: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280013>

On Mon, Oct 19, 2015 at 9:48 PM, David Turner <dturner@twopensource.com> wrote:
> Dirty the test worktree's root directory, as the test expects.
>
> When testing the untracked-cache, we previously assumed that checking
> out master would be sufficient to mark the mtime of the worktree's
> root directory as racily-dirty.  But sometimes, the checkout would
> happen at 12345.999 seconds and the status at 12346.001 seconds,
> meaning that the worktree's root directory would not be racily-dirty.
> And since it was not truly dirty, occasionally the test would fail.
> By making the root truly dirty, the test will always succeed.

I'm sorry for my deadly silence lately. I hope it will end in a few
weeks. From a quick glance, the description and the change look ok
(but don't weigh too much on my opinion).

Back to my silence..
-- 
Duy
