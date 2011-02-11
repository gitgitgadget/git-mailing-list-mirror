From: Lars Noschinski <lars@public.noschinski.de>
Subject: grep --no-index and pathspec
Date: Fri, 11 Feb 2011 09:59:38 +0100
Message-ID: <20110211095938.360726y1zinab9gk@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 10:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnp1m-0001f7-RM
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 10:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab1BKJKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 04:10:53 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:54177 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1BKJKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 04:10:51 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Feb 2011 04:10:51 EST
Received: from [80.67.16.117] (helo=webmailfront06.ispgateway.de)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1Pnoqo-0000Ch-AB
	for git@vger.kernel.org; Fri, 11 Feb 2011 09:59:38 +0100
Received: from lapbroy157d.informatik.tu-muenchen.de
 (lapbroy157d.informatik.tu-muenchen.de [131.159.46.149]) by webmail.df.eu
 (Horde Framework) with HTTP; Fri, 11 Feb 2011 09:59:38 +0100
Content-Disposition: inline
User-Agent: Dynamic Internet Messaging Program (DIMP) H3 (1.1.2)
X-Originating-IP: 131.159.46.149
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166545>

Hi everyone,

I encountered some strange behaviour with grep when using both the  
--no-index option and a pathspec. Glob patterns seem to be ignored:

----------
$ git grep -l --no-index . -- '*.bib'
paper.bib
paper.tex
ex1.tex
----------

But on the other hands, leading path matches work:
----------
$ git grep -l --no-index . -- 'paper'
paper.bib
paper.tex
----------

Without the --no-index option, everything works fine:
----------
$ git grep -l --no-index . -- '*.bib'
paper.bib
----------

This is with git version 1.7.4, but I encountered it also with the  
1.7.2.3 Debian package.

   -- Lars
