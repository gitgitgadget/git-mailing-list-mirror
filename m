From: Jeff King <peff@peff.net>
Subject: Re: How to ignore space when using 'git send-email' command
Date: Thu, 16 Jul 2009 06:09:26 -0400
Message-ID: <20090716100926.GC6742@coredump.intra.peff.net>
References: <3b9893450907131353o77102b8cx6c8944f6cc45214a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: n179911 <n179911@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 12:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRNuF-0003Wj-8d
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 12:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbZGPKJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 06:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbZGPKJa
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 06:09:30 -0400
Received: from peff.net ([208.65.91.99]:52121 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbZGPKJa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 06:09:30 -0400
Received: (qmail 19813 invoked by uid 107); 16 Jul 2009 10:11:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Jul 2009 06:11:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jul 2009 06:09:26 -0400
Content-Disposition: inline
In-Reply-To: <3b9893450907131353o77102b8cx6c8944f6cc45214a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123396>

On Mon, Jul 13, 2009 at 01:53:11PM -0700, n179911 wrote:

> When i use 'git send-email' command how can I specify it to
> 'ignore-all-space'?

Have you tried:

  git send-email --ignore-all-space origin

?

> I see there is an 'ignore-all-space' option in 'git diff' and 'git
> format-patch', but there is not such option for git send-email.

There are two ways of running send-email:

  1. format-patch your patches into a file or directory, and then
     send-email on it. In this case, you need to --ignore-all-space when
     doing the format-patch, which is what is generating the patches.

  2. give send-email revision arguments, which are fed to format-patch
     (which is what I showed above).  In this case, you can give
     format-patch arguments directly to send-email.

Does that help?

-Peff
