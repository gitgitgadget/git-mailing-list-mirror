From: Geert Bosch <bosch@adacore.com>
Subject: Re: git gc taking forever to reflog expire --all
Date: Tue, 11 May 2010 06:05:14 -0400
Message-ID: <3924516F-2626-41C0-8648-47A9481FA09F@adacore.com>
References: <0C5B1A89-551A-4EC8-862A-C306A286FAF4@adacore.com> <20100511050134.GA9413@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 11 12:05:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBmL5-0000s6-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 12:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345Ab0EKKFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 06:05:17 -0400
Received: from rock.gnat.com ([205.232.38.15]:46497 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab0EKKFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 06:05:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 11EA32BABE2;
	Tue, 11 May 2010 06:05:15 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mqpIR6F6FefF; Tue, 11 May 2010 06:05:15 -0400 (EDT)
Received: from [172.16.1.3] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id CE0C22BABDC;
	Tue, 11 May 2010 06:05:14 -0400 (EDT)
In-Reply-To: <20100511050134.GA9413@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146883>


On May 11, 2010, at 01:01, Jeff King wrote:

> On Mon, May 10, 2010 at 01:58:11PM -0400, Geert Bosch wrote:
> 
>> On my recent MacBook Pro, I gave up after reflog expire --all
>> had chewed up 30 minutes of perfectly fine CPU time.
> 
> There are some corner cases that can cause the expire-unreachable
> algorithm to behave badly. The fix is b4ca1db (reflog
> --expire-unreachable: avoid merge-base computation, 2010-04-07), but
> hasn't been included in a release yet.
> 
I tried with v1.7.1 + cherry-pick b4ca1db968eb57d9cd869337bffa254e0b2c83bd,
but that didn't solve the issue.
> In the meantime, you can work around it with:
> 
>  git config gc.reflogExpireUnreachable never

I had tried that too, but I guess I'll just have to be very patient:
22707 ttys001   11:14.27 git reflog expire --all

What would be the easiest way for me to repack my repository
without running reflog expire at all?

  -Geert
