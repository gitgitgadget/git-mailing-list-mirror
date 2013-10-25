From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 13/19] pack-objects: implement bitmap writing
Date: Fri, 25 Oct 2013 08:21:12 +0700
Message-ID: <CACsJy8By5bdJLMnf2FDJKU5+wD=NFh8QmS80crmk_u+K78Qa_A@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180642.GM24180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 03:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZW5z-0007P2-I4
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 03:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab3JYBVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 21:21:44 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:33498 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab3JYBVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 21:21:43 -0400
Received: by mail-qa0-f51.google.com with SMTP id ii20so236456qab.10
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QPWYeR7wIQKv53xEGHECJnjuDPyga2eCay/xz1JV4tU=;
        b=OM+KaHJGi3cLHDOgBfx0yI1sYYkDarStmuw1SSvZcbynNhx/ExIAWwsRDkorgVys+u
         SHAlGgoK4spKQs3iso91Fd3Iqa0jSe5sgCqJNrdPDBIKaot6S1iti+gfH8cY7h8HkR/W
         HVZlIwJK0z2U8TqTBLZgal2Oc749r02dUhMcOck6eN7bpvJhue3XS6zt+DUgoENonLLS
         0pVlljCppqroR/10Ind15Dm/LGLGmzL6zopHBQR9Qt9Bcihp1w9RKx4fvw7I//jAFULD
         XB5aC7eTW7+yEkHDspa3yDXjIVNqoFVYwychQKteBDdhesd029qrW0NsUA7gqMFwDDFL
         MDiw==
X-Received: by 10.224.88.193 with SMTP id b1mr8014098qam.81.1382664102825;
 Thu, 24 Oct 2013 18:21:42 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 18:21:12 -0700 (PDT)
In-Reply-To: <20131024180642.GM24180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236641>

On Fri, Oct 25, 2013 at 1:06 AM, Jeff King <peff@peff.net> wrote:
> From: Vicent Marti <tanoku@gmail.com>
>
> This commit extends more the functionality of `pack-objects` by allowing
> it to write out a `.bitmap` index next to any written packs, together
> with the `.idx` index that currently gets written.
>
> If bitmap writing is enabled for a given repository (either by calling
> `pack-objects` with the `--write-bitmap-index` flag or by having
> `pack.writebitmaps` set to `true` in the config) and pack-objects is
> writing a packfile that would normally be indexed (i.e. not piping to
> stdout), we will attempt to write the corresponding bitmap index for the
> packfile.

I haven't read the actual patch yet, but the diffstat says user
documentation is missing..
-- 
Duy
