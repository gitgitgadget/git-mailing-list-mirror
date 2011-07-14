From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 11:52:01 -0700
Message-ID: <CA+55aFy5Kr1oHgvQ0m4m+4zJVSTU-QPc_a-cbv=tDDMG0u_-2Q@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:52:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhR1u-0002d1-3z
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179Ab1GNSwx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 14:52:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46870 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932162Ab1GNSwx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:52:53 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6EIqLrl028621
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:52:22 -0700
Received: by wyg8 with SMTP id 8so350766wyg.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:52:21 -0700 (PDT)
Received: by 10.216.58.135 with SMTP id q7mr2322545wec.48.1310669541098; Thu,
 14 Jul 2011 11:52:21 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Thu, 14 Jul 2011 11:52:01 -0700 (PDT)
In-Reply-To: <20110714183710.GA26820@sigill.intra.peff.net>
X-Spam-Status: No, hits=-102.895 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177153>

On Thu, Jul 14, 2011 at 11:37 AM, Jeff King <peff@peff.net> wrote:
>
> There's also one other issue with generation numbers. How do you hand=
le
> grafts and object-replacement refs? =A0If you graft history, your emb=
edded
> generation numbers will all be junk, and you can't trust them.

So I don't think this is a real problem in practice.

Grafts are already unreliable. You cannot sanely merge over a graft,
and it has nothing to do with generation numbers.

I'm actually sorry that we ever did grafting. It's fundamentally
broken, and can actually destroy your repository (by hiding real
parents and then causing the commits to get garbage collected). So I
don't think grafting should be used as an argument for or against
anything - it's a hack that breaks some fundamental git database
constraints.

                             Linus
