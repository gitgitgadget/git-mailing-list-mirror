From: Robert Pluim <rpluim+git@gmail.com>
Subject: Re: [PATCH] user-manual: ensure generated manual references stylesheet
Date: Fri, 16 Mar 2007 12:44:19 +0000 (UTC)
Message-ID: <loom.20070316T134149-54@post.gmane.org>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu> <11730455591178-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 13:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSBt1-0003dB-O1
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 13:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbXCPMuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 08:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbXCPMuI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 08:50:08 -0400
Received: from main.gmane.org ([80.91.229.2]:43308 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496AbXCPMuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 08:50:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HSBsg-0000pJ-Gw
	for git@vger.kernel.org; Fri, 16 Mar 2007 13:50:02 +0100
Received: from openplug-34-178.cnt.nerim.net ([213.215.34.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 13:50:02 +0100
Received: from rpluim+git by openplug-34-178.cnt.nerim.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 13:50:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.215.34.178 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070216 Firefox/1.5.0.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42356>

J. Bruce Fields <bfields <at> citi.umich.edu> writes:


> +XSLT = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
> +XSLTOPTS = --nonet --xinclude --stringparam html.stylesheet docbook-xsl.css
> +
>  user-manual.html: user-manual.xml
> -	xmlto html-nochunks $<
> +	xsltproc $(XSLTOPTS) -o $ <at>  $(XSLT) $<

Does this actually work for you?  I get:

  xsltproc --nonet --xinclude --stringparam html.stylesheet docbook-xsl.css -o
user-manual.html
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl user-manual.xml
  I/O error : Attempt to load network entity
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
  warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl"
  cannot parse http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
  make[1]: *** [user-manual.html] Error 4


If I remove the --nonet it works fine.

Robert

-- 
