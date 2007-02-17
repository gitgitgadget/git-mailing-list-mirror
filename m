From: Bruno Haible <bruno@clisp.org>
Subject: Re: how to speed up "git log"?
Date: Sat, 17 Feb 2007 20:19:20 +0100
Message-ID: <200702172019.20536.bruno@clisp.org>
References: <200702111252.28393.bruno@clisp.org> <20070211152840.GA2781@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 17 20:12:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUyd-0006W6-9R
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 20:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbXBQTLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbXBQTLy
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 14:11:54 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:62574 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932775AbXBQTLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 14:11:53 -0500
Received: from linuix.haible.de (cable-139-176.iesy.net [81.210.139.176])
	by post.webmailer.de (mrclete mo14) (RZmta 4.7) with ESMTP id B04907j1H9LDw7 
	; Sat, 17 Feb 2007 20:11:51 +0100 (MET)
In-Reply-To: <20070211152840.GA2781@steel.home>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY4JDL5tImGAQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40010>

Alex Riesen wrote:
> MacOS X is famous for its bad perfomance when doing serious work.
> The mmap(2) of it, in particular.

You can't blame MacOS X mmap(2) for git's slow execution of "git log".
Here are is execution times of "git log tr.c > output"

  - with git-1.5.0-rc4 built with -DNO_MMAP

      real    0m26.032s
      user    0m13.580s
      sys     0m11.730s

  - with git-1.5.0-rc4 built with the default settings:

      real    0m25.469s
      user    0m13.530s
      sys     0m11.490s

You can see that using mmap() provides a speedup of about 2% on MacOS X,
which is similar to the 4% than Shawn measured on Linux.

Bruno
