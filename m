From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: i18n, alternative solution
Date: Mon, 1 Jan 2007 15:47:47 +0100
Organization: Dewire
Message-ID: <200701011547.48697.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 01 15:44:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1OOm-0000Lc-3S
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 15:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbXAAOoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 09:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbXAAOoU
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 09:44:20 -0500
Received: from [83.140.172.130] ([83.140.172.130]:2973 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755216AbXAAOoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 09:44:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 964A3802671
	for <git@vger.kernel.org>; Mon,  1 Jan 2007 15:40:05 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09005-07 for <git@vger.kernel.org>; Mon,  1 Jan 2007 15:40:05 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 38634802651
	for <git@vger.kernel.org>; Mon,  1 Jan 2007 15:40:03 +0100 (CET)
To: git@vger.kernel.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35738>

Hi and Happy New Year

Things are happening wrt to support for working with multiple locales, which 
is nice to see. I've not had time to follow the development so these comments 
(and code) may be considered somewhat late in the process.

What disturbes me is the complexity that the approach of storing multiple 
encodings in the same repository results in. I was hacking another solution 
earlier this autumn, that takes another approach, i.e. UTF-8 is the internal 
encoding. period. If you want to working with anything else, you convert on 
input and output. The code is very simply since it has few cases to consider 
and I don' t need to store encoding anywhere. What is missing is a flags to 
disable i18n for a flag (or enable it). 

The uglyness is the filename parts since I catch all filename operations and 
not only the ones I need. The target wasn't final code, but to prove that it 
could be done.

The focus is on file names, but commit messages were included since it was so 
simple. You can get the code at http://rosenberg.homelinux.net/repos/GIT.git 
on the branch i18n. I modded the testcases to verify that GIT works after the 
patches, but one would probably prefer to write new test cases for UTF-8. 

5d73e28397f7ec0f85fcb8e31e91326afbcfea19 is the last commit that executes all 
test cases successfully. 

I could send the code as patches if you like, not on top of the lastest 
version though, but 1.4.2-something,

-- robin
