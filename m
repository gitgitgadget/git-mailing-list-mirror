From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Wed, 8 Jun 2011 22:18:38 +0700
Message-ID: <BANLkTink9T7M5989Ntpnt5jYcn3bdCXKhQ@mail.gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:19:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKXo-0003ZA-62
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab1FHPTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:19:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44416 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab1FHPTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:19:39 -0400
Received: by bwz15 with SMTP id 15so503682bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=H0CuPE/6uKJaeaunLyW6Xum5jS5+ZaJxk5nhJnl+1sI=;
        b=sa7ZYgFd5fan2sjrS0Zm4hPvnfMVKRjujTXSARjayth9yXZBtiWgMplgCWk8A/f+hh
         wvgHLC5VaUemBBalhXCeKLy9RGMy4GlVhnFy/vx/DUmkQrxkRbSPr2b6n6YFKxDL3iDy
         75d1e6N2daFyokr8PjrYhpKeiqTSemanwV5UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uC+UWhlaw1ewUaRxZKYhptHJEBBdYwa5mHLC4rkC5+kUELiA6yYtmnKTFEPwmJq8BX
         5Da1k28MWwrtGUG9OvLgF9g3Ss7ax07TutkDtXH8ydAOdVmhJZ9We0uIch5fvJ8A6FO8
         RVyAGc4WNpSCjyVs5nxUlcWHFd+guDaTP58lI=
Received: by 10.204.74.21 with SMTP id s21mr697020bkj.62.1307546357699; Wed,
 08 Jun 2011 08:19:17 -0700 (PDT)
Received: by 10.204.50.150 with HTTP; Wed, 8 Jun 2011 08:18:38 -0700 (PDT)
In-Reply-To: <20110607200659.GA6177@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175381>

On Wed, Jun 8, 2011 at 3:06 AM, Jeff King <peff@peff.net> wrote:
> But another way to think about it is that commits, the index, and the
> working tree are all "locations" with content. And one common operation
> you may want to do is to move content from one spot to another, either
> whole, by file, or by diff hunks.

Also "git put --pretend" or "git put --dry-run" may show the diff of
content movement, without actual moving. "--dry-run --patch"
combination probably does not make sense though.

> As you can see, this handles only three typoes of locations: the
> worktree, the index, and an arbitrary commit (really a tree-ish). Some
> other types I've thought of are:
>
>  ....
>

I find it intuitive (given a source tree and destination one(s), you
can copy content by paths or even by hunks), until you give it more
powers (creating new branch or commit, move subdirs...). The original
git-put idea could reduce a lot of confusion for new users. Your extra
types seem uncommon to me (or can be well covered with current
commands without much confusion). For advanced use cases, maybe the
current command set can be enhanced with new options.
-- 
Duy
