From: bdowning@lavos.net (Brian Downing)
Subject: Bug in gitk search box
Date: Wed, 25 Jul 2007 08:56:21 -0500
Message-ID: <20070725135621.GC21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 15:56:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDhMF-0007xT-6s
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 15:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbXGYN4r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 09:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbXGYN4r
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 09:56:47 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:2235 "EHLO
	asav08.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbXGYN4q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 09:56:46 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav08.insightbb.com with ESMTP; 25 Jul 2007 09:56:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9ABDzpkZKhvbzRmdsb2JhbACBTIVpiCgBAQE1AQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id CD1FA309F31; Wed, 25 Jul 2007 08:56:21 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53691>

To reproduce:

* Open gitk in any repository, the Git one seems to work fine.
* Type a string that it won't find into the search box, like 'asdfasdf'.
* Click find.

You'll get:

can't read "commitdata(e83c5163316f89bfbde7d9ab23ca2e25604af290)": no such element in array
can't read "commitdata(e83c5163316f89bfbde7d9ab23ca2e25604af290)": no such element in array
    while executing
"doesmatch $commitdata($id)"
    (procedure "findmore" line 21)
    invoked from within
"findmore"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)

Where the SHA1 is always the earliest SHA1 in the rev-list gitk is
examining.

After this happens you get a "busy cursor" when hovering over most of
gitk, and you can't search again until gitk is restarted.

-bcd
