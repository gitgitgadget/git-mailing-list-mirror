From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] diff: report bogus input to -C/-M/-B
Date: Thu, 21 Oct 2010 13:37:29 -0700
Message-ID: <9E2CE0E8-40A4-4909-9317-B3DE9006474E@sb.org>
References: <20101021144947.GA18210@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91tI-0005T3-Mx
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab0JUUhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:37:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36920 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab0JUUhb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 16:37:31 -0400
Received: by pzk3 with SMTP id 3so2399pzk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:37:31 -0700 (PDT)
Received: by 10.143.8.3 with SMTP id l3mr1233742wfi.125.1287693451079;
        Thu, 21 Oct 2010 13:37:31 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm3027273wfg.8.2010.10.21.13.37.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:37:30 -0700 (PDT)
In-Reply-To: <20101021144947.GA18210@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159561>

On Oct 21, 2010, at 7:49 AM, Jeff King wrote:

> We already detect invalid input to these functions, but we
> simply exit with an error code, never saying anything as
> simple as "your input was wrong". Let's fix that.
> 
> Before:
> 
>  $ git diff -CM
>  $ echo $?
>  128
> 
> After:
> 
>  $ git diff -CM
>  error: invalid argument to -C: M
>  $ echo $?
>  128
> 
> There should be no problems with having diff_opt_parse print
> to stderr, as there is already precedent in complaining
> about bogus --color and --output arguments.

Thank you. I've had a note to myself to fix this for the past month, and still haven't gotten around to it. Glad to see that procrastinating pays off! ;)

-Kevin Ballard