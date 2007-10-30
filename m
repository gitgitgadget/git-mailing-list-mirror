From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Mon, 29 Oct 2007 22:06:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org>
References: <20071030042118.GA14729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Andy C <andychup@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 06:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImjJm-0006nh-A6
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 06:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbXJ3FG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 01:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbXJ3FG4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 01:06:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40794 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861AbXJ3FGz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 01:06:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9U56Bk7012654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Oct 2007 22:06:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9U56BcT010112;
	Mon, 29 Oct 2007 22:06:11 -0700
In-Reply-To: <20071030042118.GA14729@sigill.intra.peff.net>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62664>



On Tue, 30 Oct 2007, Jeff King wrote:
>
>   - no improvement on smaller datasets. Running "git-whatchanged -M
>     --raw -l0" on the linux-2.6 repo takes about the same time with the
>     old and new code (presumably the algorithmic savings of the new code
>     are lost in a higher constant factor, so when n is small, it is a
>     wash).

Have you compared the results? IOW, does it find the *same* renames?

I'm a bit worried about the fact that you just pick a single (arbitrary) 
src/dst per fingerprint. Yes, it should be limited, but that seems to be a 
bit too *extremely* limited. But if it gives the same results in practice, 
maybe nobody cares?

		Linus
