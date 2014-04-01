From: Jeff King <peff@peff.net>
Subject: Re: [fatal error] cannot pread pack file: Input/output error
Date: Tue, 1 Apr 2014 07:53:27 -0400
Message-ID: <20140401115326.GC15549@sigill.intra.peff.net>
References: <1396351324120-7607133.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: sunny110 <mehran.sunny@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:54:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUxGn-0005A5-0j
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 13:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbaDALxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 07:53:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:51680 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752248AbaDALxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 07:53:31 -0400
Received: (qmail 26815 invoked by uid 102); 1 Apr 2014 11:53:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 06:53:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 07:53:27 -0400
Content-Disposition: inline
In-Reply-To: <1396351324120-7607133.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245585>

On Tue, Apr 01, 2014 at 04:22:04AM -0700, sunny110 wrote:

> I wanna build GoldenDict from source, however I get a fattal error when I
> try to clone the repository.
> 
> Here is the recorded session:
> 
>     sunny@s9:~/Programs/goldendict$ git clone
> git://github.com/goldendict/goldendict.git
>     Cloning into 'goldendict'...
>     remote: Reusing existing pack: 11370, done.
>     remote: Counting objects: 7, done.
>     remote: Compressing objects: 100% (7/7), done.
>     remote: Total 11377 (delta 1), reused 0 (delta 0)
>     Receiving objects: 100% (11377/11377), 27.17 MiB | 11 KiB/s, done.
>     fatal: cannot pread pack file: Input/output error
>     fatal: index-pack failed 
> 
> So what's the problem? could anyone help me? Thanks in advance.

At the point you see that message, git has received the whole contents
from the remote side and written them to disk. It's then trying to read
back the data it just wrote to do some checks on it. However, your
filesystem has reported a low-level I/O error, which may indicate a
disk problem or filesystem corruption.

Is it possible that your disk is dying?

-Peff
