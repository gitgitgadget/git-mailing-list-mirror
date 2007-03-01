From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: gitweb not friendly to firefox?
Date: Thu, 1 Mar 2007 17:00:47 +0300
Message-ID: <20070301140046.GM57456@codelabs.ru>
References: <989B956029373F45A0B8AF02970818902DA70E@zch01exm26.fsl.freescale.net> <000f01c75c06$555d5e50$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: 'Li Yang-r58472' <LeoLi@freescale.com>, git@vger.kernel.org
To: Raimund Bauer <ray@softwarelandschaft.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 16:03:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMlqD-0007DV-Qv
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 15:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbXCAOAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 09:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbXCAOAz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 09:00:55 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:57948 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbXCAOAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 09:00:55 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMlpz-000H1G-SO; Thu, 01 Mar 2007 17:00:52 +0300
Content-Disposition: inline
In-Reply-To: <000f01c75c06$555d5e50$0b0aa8c0@abf.local>
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41098>

> > Line Number 43, Column 38:<tr><td>author</td><td>Li Yang
> <LeoLi@freescale.com></td></tr> -------------------------------------^
> 
> Try to save the output and verify it with some other xml-parser. The
> "<LeoLi@freescale.com>" seems to be the culprit here, since "@" is no
> allowed character for a xml-tag, and there maybe is some html-escaping of
> the email address missing?

I think that the situation is simpler: <LeoLi@....> is taken as the
XML/HTML tag and it
- does not closed anywhere,
- has the wrong syntax, since "@" and "." can not live inside the
tag name if memory serves me right.

The proper thing is to replace "<" with "&lt;" and ">" with "&gt;".
-- 
Eygene
