From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 13:19:51 -0700
Message-ID: <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com> <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com> <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com> <20110714200144.GE26918@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:20:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhSOX-000241-25
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab1GNUUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:20:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43394 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab1GNUUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:20:18 -0400
Received: by gyh3 with SMTP id 3so273853gyh.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 13:20:17 -0700 (PDT)
Received: by 10.150.67.20 with SMTP id p20mr2775740yba.79.1310674817675;
        Thu, 14 Jul 2011 13:20:17 -0700 (PDT)
Received: from [26.211.72.234] (mcf2736d0.tmodns.net [208.54.39.207])
        by mx.google.com with ESMTPS id o10sm309332ybl.7.2011.07.14.13.20.11
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 13:20:16 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20110714200144.GE26918@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177172>



Jeff King <peff@peff.net> wrote:
>
>Out of curiosity, what don't you like about the generation cache?

The thing I hate about it is very fundamental: I think it's a hack around a basic git design mistake. And it's a mistake we have known about for a long time.

Now, I don't think it's a *fatal* mistake, but I do find it very broken to basically say "we made a mistake in the original commit design, and instead of fixing it we create a separate workaround for it".

THAT I find distasteful. My reaction is that if we're going to add generation numbers, then were should just do it the way we should have done them originally, rather than as some separate hack.

See? That's why I wouldn't have any problem with adding a separate cache on top of it, if it's really required, but I would hope that it isn't really needed.

So a cache in itself is not necessarily wrong. But leaving the original design mistake in place IS.

And fixing it really ended up being a very tiny patch, no?

     Linus
