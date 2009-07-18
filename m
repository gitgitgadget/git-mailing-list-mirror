From: Jeff King <peff@peff.net>
Subject: Re: [test failure] t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 09:56:50 -0400
Message-ID: <20090718135649.GA6759@sigill.intra.peff.net>
References: <20090718134551.GC16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 18 15:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSAPM-0002mC-5K
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 15:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbZGRN4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 09:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbZGRN4x
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 09:56:53 -0400
Received: from peff.net ([208.65.91.99]:47519 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbZGRN4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 09:56:52 -0400
Received: (qmail 32503 invoked by uid 107); 18 Jul 2009 13:58:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 18 Jul 2009 09:58:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Jul 2009 09:56:50 -0400
Content-Disposition: inline
In-Reply-To: <20090718134551.GC16708@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123521>

On Sat, Jul 18, 2009 at 03:45:51PM +0200, Nicolas Sebrecht wrote:

> Running 'sh t4114-apply-typechange.sh --verbose --debug' fails since its
> introduction by b67b9612e1a90ae093445abeaeff930e9f4cf936 with this
> output:
> 
> 
>    * expecting success: 
>    	git checkout -f foo-becomes-binary &&
>    	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
>    	git apply --index < patch
>    	
>    ./test-lib.sh: line 234: 26816 Segmentation fault      git checkout -f
>    foo-becomes-binary

Sorry, I can't reproduce here (I tried v1.6.3 and the current
'next'). The tests pass just fine with --debug (which, IIRC, doesn't
actually do much). What is the exact commit you're seeing it fail on?

Can you try running it under gdb to get a stack trace? If you have
valgrind installed, can you run the test script with --valgrind?

-Peff
