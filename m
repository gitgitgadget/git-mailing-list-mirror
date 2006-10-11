From: Ralf Baechle <ralf@linux-mips.org>
Subject: Gitweb indentation wrong in Internet Explorer
Date: Wed, 11 Oct 2006 18:25:53 +0100
Message-ID: <20061011172553.GA1147@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 11 19:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXhq0-0001lT-VP
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 19:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWJKRZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 13:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWJKRZp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 13:25:45 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:51632 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1161149AbWJKRZp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 13:25:45 -0400
Received: from localhost.localdomain ([127.0.0.1]:37064 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037437AbWJKRZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 18:25:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9BHPsCK001221;
	Wed, 11 Oct 2006 18:25:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9BHPr1j001220;
	Wed, 11 Oct 2006 18:25:53 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28728>

I have a report from an MSIE suffering user:

> When I use it (and I believe I've seen this on my laptop as well as my
> workstation) all left-hand margin whitespace is collapsed to nothingness.
> Once can still parse the code, but it's harder with no indentations.

A screenshot from a Windows laptop to illustrate the problem is at
http://www.linux-mips.org/~ralf/gitweb.png.  It shows the code was
preformatted correctly which seems to be an IE bug but the following patch
seems to work around it.

*** gitweb.cgi.dist	2006-10-09 19:02:19.561726255 +0100
--- gitweb.cgi	2006-10-09 19:03:31.744837495 +0100
***************
*** 234,239 ****
--- 234,240 ----
  	my $str = shift;
  	$str = decode("utf8", $str, Encode::FB_DEFAULT);
  	$str = escapeHTML($str);
+ 	$str =~ s/ /&nbsp;/g;
  	return $str;
  }

Thanks,

  Ralf  
