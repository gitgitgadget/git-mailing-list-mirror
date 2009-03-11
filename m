From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when 
	cherry-picking an empty commit
Date: Wed, 11 Mar 2009 11:08:06 +0000
Message-ID: <e2b179460903110408i4ab3c9cg3c863b89a2f57cba@mail.gmail.com>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
	 <20090308144240.GA30794@coredump.intra.peff.net>
	 <7v8wnflrws.fsf@gitster.siamese.dyndns.org>
	 <20090310181730.GD26351@sigill.intra.peff.net>
	 <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com>
	 <20090311003022.GA22273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Chris Johnsen <chris_johnsen@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 12:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhMJg-0002hZ-24
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 12:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZCKLIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 07:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbZCKLIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 07:08:09 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:31826 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZCKLII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 07:08:08 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2339995qwi.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PjxdYRniv39T8Qm4PHXU3m9K/BQulgrKhVzBVXS+wsk=;
        b=Tw/lc0/LKuh0itBa22eQWZC6gm7+eUTnGuJTg5YF8F8ptmXb8nktZ8xCSI6tP+U6dl
         2OXvbJxliyrrNVaw6I7IwTLfrYzjw5LUzKxxz/gRcMNAKMi0Cw8tv9dVJca0G0DEhN7R
         hpSvQKz8LnKeufxeC0BBIOnpxa5d7M99xXq5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LDyDcX8bsgznEzkXCK85HDHOeHcaoYWKSACsZsqLcu5IAf6USlyYkEEvczr6YYGMTA
         F2gkOFdGsNl1k/Tw4c54Ehvr1N0P4BGCex4+EAuc+PDp7nOkw+EfG77Szjk7PSljwKt3
         I7/HqqbQhk9FyPLdk5qOtzWlPqUGkR1z44wOQ=
Received: by 10.224.45.144 with SMTP id e16mr10934427qaf.53.1236769686299; 
	Wed, 11 Mar 2009 04:08:06 -0700 (PDT)
In-Reply-To: <20090311003022.GA22273@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112908>

2009/3/11 Jeff King <peff@peff.net>:
> OK, then nothing to worry about there. I have no idea which shell
> OpenBSD and NetBSD use these days, and I don't have access to a box.
> Anybody?

OpenBSD uses pdksh in Bourne shell mode for non-root shells (ksh mode
for root) [1].

NetBSD >=4 uses a Bourne shell but I don't know the exact provenance.
[2] "A sh command appeared in Version 1 AT&T UNIX.  It was, however,
unmaintainable so we wrote this one."

[1] http://www.openbsd.org/faq/faq10.html#ksh
[2] http://www.netbsd.org/docs/misc/index.html#shells
