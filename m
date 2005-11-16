From: Andrew Wozniak <awozniak@mc.com>
Subject: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 12:17:11 -0500
Message-ID: <437B6997.8010903@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 18:24:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcQuN-0005U0-H9
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 18:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbVKPRRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 12:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVKPRRN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 12:17:13 -0500
Received: from iris-63.mc.com ([63.96.239.141]:42200 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S1751487AbVKPRRM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 12:17:12 -0500
Received: from ad-email1.ad.mc.com by mc.com (8.8.8+Sun/SMI-SVR4)
	id MAA22070; Wed, 16 Nov 2005 12:17:11 -0500 (EST)
Received: from [172.16.124.85] ([172.16.124.85]) by ad-email1.ad.mc.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 16 Nov 2005 12:16:54 -0500
User-Agent: Thunderbird 1.5 (Windows/20051025)
To: git@vger.kernel.org
X-OriginalArrivalTime: 16 Nov 2005 17:16:54.0705 (UTC) FILETIME=[8AC35A10:01C5EAD1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12031>

Hello,

Have just started using git for u-boot related development. After 
downloading git-snapshot-20051116 tarball and attempting a build under 
RH7.2, I get the following failure:

gcc -o http-fetch.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' 
http-fetch.c
http-fetch.c: In function `fetch_alternates':
http-fetch.c:911: warning: implicit declaration of function 
`curl_multi_perform'
http-fetch.c:911: `curlm' undeclared (first use in this function)
<snip>

It appears that a recent patch "Fix for multiple alternates requests in 
http" references curlm without the necessary #ifdef USE_CURL_MULTI

I'm not that familiar with the git architecture and codebase, so any 
suggestions for a workaround are much appreciated.

Thank you
