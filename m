From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH/RFC] add lame win32 credential-helper
Date: Fri, 16 Sep 2011 08:59:48 -0400 (EDT)
Message-ID: <23805783.18971.1316177988773.JavaMail.root@mail.hq.genarts.com>
References: <CABPQNSZjGzyxJKWRDDWxRj_SLdC1Y_9TxnAMOA+b-Pw3+X-E7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jaysoffian@gmail.com, gitster@pobox.com,
	Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 16 15:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Y1S-0006KF-46
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 15:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab1IPM75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 08:59:57 -0400
Received: from hq.genarts.com ([173.9.65.1]:43121 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754429Ab1IPM74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 08:59:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1A3D8EA28D1;
	Fri, 16 Sep 2011 08:59:55 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TB6n6ByvhPQa; Fri, 16 Sep 2011 08:59:48 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id CFAC3EA28D0;
	Fri, 16 Sep 2011 08:59:48 -0400 (EDT)
In-Reply-To: <CABPQNSZjGzyxJKWRDDWxRj_SLdC1Y_9TxnAMOA+b-Pw3+X-E7w@mail.gmail.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181532>

----- Original Message -----
> From: "Erik Faye-Lund" <kusmabite@gmail.com>
> To: "Jeff King" <peff@peff.net>
> Cc: git@vger.kernel.org, jaysoffian@gmail.com, gitster@pobox.com
> Sent: Thursday, September 15, 2011 5:48:30 PM
> Subject: Re: [PATCH/RFC] add lame win32 credential-helper
> 
> > If it's too hard to adapt it to whatever IPC
> > mechanism would be appropriate on Windows, we can just leave it out
> > on that platform.
> >
> > But the core code in git itself should be pretty straight forward.
> 
> I didn't mean that it was impossible to port, just that it didn't compile
> as-is. I haven't looked into fixing up the code so it compiles on Windows
> again myself. And I'm not really planning to; I have little git-time
> these days, and little knowledge of how unix-sockets works...

This may be common knowledge, but from our brief experiment with them last fall, Windows Named Pipes are fairly similar to Unix Domain Sockets (not named FIFOs as one would expect...).  We didn't quite get a perfect replacement using preprocessor macros, but I think you can get pretty close (we eventually dumped the idea in favor of straight TCP sockets that behave the same on all our platforms of interest).

HTH,
Stephen
