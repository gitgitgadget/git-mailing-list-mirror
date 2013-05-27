From: Xidorn Quan <quanxunzhen@gmail.com>
Subject: Re: [PATCH v2] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 23:46:24 +0800
Message-ID: <CAMdq69_RarEXDdR+xzvSb9YPCR2hE=0tM3o-mF3d=cgDMWSq8A@mail.gmail.com>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
 <1369665359-48242-1-git-send-email-quanxunzhen@gmail.com> <20130527150855.GA8250@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 27 17:47:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugzdf-0004Qg-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 17:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab3E0PrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 11:47:07 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:43606 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab3E0PrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 11:47:06 -0400
Received: by mail-vc0-f180.google.com with SMTP id gd11so4840158vcb.11
        for <git@vger.kernel.org>; Mon, 27 May 2013 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sOjKzayzDfPDClayBPdkqlA4MioDU0OrS1OF18wkCtY=;
        b=D6PnY0pbV1iddkTw5k/yZtA+2rwxjS28JzgdBiMYKRiY3XjyME5ssbpnd+5VM1rLFR
         eyM3PR9VOhVFH9hLlErSyxpawy3XYFGGY3ZgtfOJAOqDdq6X7mlwR6g4riE8VNlOJb23
         5ap4fd9IzOuHZ7Q5n2eaV73M8ZTnk/EYhRrvOwP13xBGIKNbg4Q02Y+td26ulvPfbF9b
         Shpc/lLoA1X/jhHamksvorTS5zFB7/iepkP7d9S8c8dqGiSz5QjshmKE3eLO37cvxrZ7
         p7GGGe1jOGDsX9+TwepTLZ4bdUWzbPGt2HcibWXk2Pct1j05voBO9iQdmvzM79eEOBfb
         +HzQ==
X-Received: by 10.52.95.227 with SMTP id dn3mr13331490vdb.111.1369669625481;
 Mon, 27 May 2013 08:47:05 -0700 (PDT)
Received: by 10.52.34.230 with HTTP; Mon, 27 May 2013 08:46:24 -0700 (PDT)
In-Reply-To: <20130527150855.GA8250@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225601>

On Mon, May 27, 2013 at 11:08 PM, Jeff King <peff@peff.net> wrote:
[snip]
>
> This looks good to me. Git will ask for "protocol=ftp" when
> accessing the dumb protocol over ftp. And it will ask for smtp via
> git-send-email since 4d31a44 (git-send-email: use git credential to
> obtain password, 2013-02-12).
>
> While we are in the area it may be worth thinking if there are other
> schemes we would want to support. Git might feed any URL scheme that
> curl accepts, so I think we would want to handle FTPS alongside FTP, no?

Good point, I'll add that.

> We may also eventually want IMAP for git-imap-send, but we have not yet
> implemented credential-helper support there. We may also want http/socks
> proxy authentication, but we also have not implemented the git side of
> that yet. So I think both of those can wait for now.

Hope the helpers will be implemented soon. IMO, we can add IMAP and
SOCKS for now since the protocol names are clear, while it is unclear
what protocol name will be used for HTTP/HTTPS proxy. I guess that
some may prefer using http/https as protocol name instead of something
specific. What do you think?

--
Xidorn Quan
