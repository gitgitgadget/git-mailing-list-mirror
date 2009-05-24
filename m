From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-ls-files --added?
Date: Sun, 24 May 2009 11:17:04 -0700
Message-ID: <7vmy921i3j.fsf@alter.siamese.dyndns.org>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
	<m3fxeudhho.fsf@localhost.localdomain>
	<2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 20:17:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8IGP-00084y-Vo
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 20:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbZEXSRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 14:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbZEXSRE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 14:17:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47008 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbZEXSRD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 14:17:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524181704.RNMF17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 May 2009 14:17:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id vWH41b0024aMwMQ03WH48t; Sun, 24 May 2009 14:17:04 -0400
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=m6t-_Tl5oBjCg2ybMl8A:9
 a=iDgj683BSzYiz3iPqqtPfG4nbIsA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com> (Jon Seymour's message of "Sun\, 24 May 2009 19\:12\:00 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119849>

Jon Seymour <jon.seymour@gmail.com> writes:

> Jakub,
>
> Thanks - yes, I wasn't happy about parsing git status.
>
> I am still interested in the rationale for git-ls-files not supporting
> such an option directly, since git-diff still seems a little indirect.

Partly historical, but more fundamental reason is because ls-files
plumbing is about the index.

The index by definition knows about the work tree files.  Reporting the
status of work tree files by comparing what was added to the index makes
sense in that context.

git-ls-files documentation lists --cached/deleted...  and if you think
about them, you will realize that the all of them make sense; they are
about the index or comparison between the index and the work tree.

Added is _not_ about comparision between the index and the work tree.  It
is between the HEAD commit and the index, and it does not belong to
ls-files plumbing.
