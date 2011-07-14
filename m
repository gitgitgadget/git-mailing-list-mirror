From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 12:51:39 -0700
Message-ID: <CA+55aFzuQnfo1iywnp-WAajMHe2+6_HOM85aw0bS+p0xv5RyhA@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com> <20110714194638.GE8453@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:52:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRxD-0003YR-8j
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab1GNTwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:52:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48758 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753854Ab1GNTwE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 15:52:04 -0400
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6EJq2AP000477
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:52:03 -0700
Received: by wwg11 with SMTP id 11so799659wwg.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:51:59 -0700 (PDT)
Received: by 10.216.38.76 with SMTP id z54mr2439658wea.102.1310673119098; Thu,
 14 Jul 2011 12:51:59 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Thu, 14 Jul 2011 12:51:39 -0700 (PDT)
In-Reply-To: <20110714194638.GE8453@thunk.org>
X-Spam-Status: No, hits=-102.895 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177167>

On Thu, Jul 14, 2011 at 12:46 PM, Ted Ts'o <tytso@mit.edu> wrote:
>
> Would it be considered evil if we put the generation number in the
> pack, but not consider it part of the formal object (i.e., it would be
> just a cache, but one that wouldn't change once the pack was created)?

That would actually be a major change to data structures, and would
require some serious surgery and be hard to support in a
backwards-compatible way (think different git versions accessing the
same repository).

Much bigger patch than the one I did.

So it sounds like it would work - and it would probably be a simple
matter of just incrementing the pack version number if you just say
"cannot access the pack with old versions" - but I think it's a really
fragile approach.

                  Linus
