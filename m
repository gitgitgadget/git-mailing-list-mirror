From: Johan Herland <johan@herland.net>
Subject: How to supply "raw" bytes to git grep?
Date: Thu, 18 Sep 2008 17:28:18 +0200
Message-ID: <200809181728.18597.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 17:29:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLRq-0000N6-8T
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbYIRP22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbYIRP21
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:28:27 -0400
Received: from sam.opera.com ([213.236.208.81]:54608 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613AbYIRP21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:28:27 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m8IFSI0N011276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 18 Sep 2008 15:28:24 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96203>

Hi,

I wanted to list all text files in my repo which contain carriage 
returns, so I tried the following command-line:

	git grep --cached -I -l -e <CR>

where <CR> is some magic incantation that I've yet to figure out. I've 
tried all the obvious cases (\r, 0x0d, \015, etc.), but none of them 
seem to DWIM...

The only working solution I've found so far is to create a file 
(named "cr") in a hex editor that contains exactly one CR byte, and 
then use the -f option to 'git grep':

	git grep --cached -I -l -f cr

Is there an easier way? And if not, should I try to create one (e.g. 
teaching 'git grep' to grok backslash escapes)?


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
