From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] tail -n not supported in all OSs
Date: Tue, 16 Oct 2007 18:06:24 -0400
Message-ID: <20071016220624.GC1314@closure.lan>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:07:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhuYp-0005VE-CP
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935017AbXJPWG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965968AbXJPWG1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:06:27 -0400
Received: from thunk.org ([69.25.196.29]:48300 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965964AbXJPWG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:06:26 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IhuiK-0006YI-JK; Tue, 16 Oct 2007 18:16:36 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IhuYS-0001KF-Hv; Tue, 16 Oct 2007 18:06:24 -0400
Content-Disposition: inline
In-Reply-To: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61263>

On Tue, Oct 16, 2007 at 07:57:14PM +0300, Jari Aalto wrote:
> 
> SunOS/Solaris tail(1) does not support option '-n'. The
> following patches change occurrances of:
> 
>    tail -n <N>
> 
> to
> 
>    tail <N>

POSIX.2 guarantees that "tail -n 2" works.  "Tail -<N>" is considered
obsolete.  Unfortunately Solaris requires you to use
/usr/xpg4/bin/tail if you want a POSIX.2 compliant header file.  The
/usr/bin/tail is designed for System V R3 compliance (i.e., from a
full two decades ago; SVR3 was released in 1987), and is due to Sun's
vow to Backwards Compatible Forever. 

See "man 5 standards" on a Solaris box to see how your PATH variable
has to be set if you want something which is compatible with modern
Unix/Linux common usage.

					- Ted
