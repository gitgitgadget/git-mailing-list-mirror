From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: [PATCH] Replace the cryptic messages from "git stash show".
Date: Sat, 15 Dec 2007 12:08:05 -0500
Message-ID: <20071215170805.GA16589@fawkes>
References: <20071214012838.GA8914@fawkes> <7vir32xdn3.fsf@gitster.siamese.dyndns.org> <20071215051425.GA9118@fawkes> <7v63z0o59r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3aVW-00061m-U3
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 18:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbXLORIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 12:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759212AbXLORIO
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 12:08:14 -0500
Received: from k2smtpout06-02.prod.mesa1.secureserver.net ([64.202.189.103]:52105
	"HELO k2smtpout06-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752965AbXLORIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 12:08:13 -0500
Received: (qmail 17521 invoked from network); 15 Dec 2007 17:08:12 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout06-02.prod.mesa1.secureserver.net (64.202.189.103) with ESMTP; 15 Dec 2007 17:08:12 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 5BD9E100A37;
	Sat, 15 Dec 2007 17:08:12 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LNeEHN0xR44I; Sat, 15 Dec 2007 12:08:06 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 8EB37100A10;
	Sat, 15 Dec 2007 12:08:06 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id BB1E39ACFB; Sat, 15 Dec 2007 12:08:05 -0500 (EST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v63z0o59r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68400>

On Fri, Dec 14, 2007 at 10:12:32PM -0800, Junio C Hamano wrote:
> 
> Is it just me who feels that the added code is much worse than the
> disease?

I wouldn't be surprised. Shell scripting is by no means my long suit -
in fact, I am not even sure it's "a suit" of mine at all. I didn't like
what I saw and basically had two options:

1. Send a "this is not user friendly" rant and get beaten up by "why
don't you even try?"

2. Try and hack together something, submit it, and keep fixing it until
it makes it - and learn something in the process, maybe at the price of
being mocked at, but I don't care.

In particular, as far as I _could_ see, there are probably at least one
place I'm doing something potentially absurd, but couldn't figure out
anything better:

I'm not sure how to test if there is a stash name specified, so I
tried:

test "$flags" = "$@"

but then it breaks when $@ has a space in it. Hence the pointless
assignment to $arguments first.

The reason I removed the --default option to rev-parse is that it
doesn't distinguish between no stash name or an invalid one.

I'm sure there are other things people don't like - some because my
shell scripting sucks, some others maybe because of style differences.
At any rate, I'm open to criticism. So bring it on. 8-)
-- 
Jing Xue
