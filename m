From: "H. Peter Anvin" <hpa@zytor.com>
Subject: gitweb on kernel.org broken
Date: Mon, 16 Jan 2006 10:44:35 -0800
Message-ID: <43CBE993.9060701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 16 19:45:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyZLe-0002mu-B2
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 19:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWAPSon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 13:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWAPSol
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 13:44:41 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6091 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751150AbWAPSoj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 13:44:39 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0GIiZdp030868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jan 2006 10:44:37 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14750>

It seems that gitweb throws an error every time.  This means that 
nothing gets cached, and therefore the load on the kernel.org machines 
is driven into the high double digits:

[Mon Jan 16 10:42:01 2006] [error] [client 82.181.110.11] [Mon Jan 16 
10:42:01 2006] index.cgi: Use of uninitialized value in scalar 
assignment at /home/httpd/html/git/index.cgi line 411.
[Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] fatal: Not a 
git repository: '/pub/scm/linux/hotplug/hotplug-ng.git'
[Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] [Mon Jan 16 
10:42:03 2006] index.cgi: Use of uninitialized value in scalar chomp at 
/home/httpd/html/git/index.cgi line 406.
[Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] [Mon Jan 16 
10:42:03 2006] index.cgi: Use of uninitialized value in pattern match 
(m//) at /home/httpd/html/git/index.cgi line 407.

This is all very bad...

	-hpa
