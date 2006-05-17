From: Pavel Roskin <proski@gnu.org>
Subject: Re: 1.3.2 git-clone segfaults
Date: Wed, 17 May 2006 15:29:25 -0400
Message-ID: <1147894165.16654.10.camel@dv>
References: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Wed May 17 21:29:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRiH-0004iM-7E
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWEQT3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWEQT3i
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:29:38 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:41372 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751021AbWEQT3i
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:29:38 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgRiD-0004kh-K6
	for git@vger.kernel.org; Wed, 17 May 2006 15:29:37 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgRi1-0004Mt-IY; Wed, 17 May 2006 15:29:25 -0400
To: Bill Yoder <byoder@cs.utexas.edu>
In-Reply-To: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20231>

On Wed, 2006-05-17 at 13:32 -0500, Bill Yoder wrote:
> /usr/local/downloads/git-1.3.2/git-clone: line 323: 25972  
> Segmentation fault      git-http-fetch -v -a -w "$tname" "$name" "$1/"

I've seen git-http-fetch segfaults many times when cloning qgit, but
it's hard to reproduce on demand.

I think you should compile git without optimizations and allow coredumps
(ulimit -c  unlimited), then load git-http-fetch in gdb with the core
(gdb --core=core git-http-fetch) and run bt to see the backtrace.

-- 
Regards,
Pavel Roskin
