From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Trying base32
Date: Thu, 14 Apr 2005 00:26:47 -0700
Message-ID: <425E1B37.20408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 14 09:24:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLyhT-00050T-4D
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 09:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDNH04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 03:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDNH04
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 03:26:56 -0400
Received: from terminus.zytor.com ([209.128.68.124]:5863 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261453AbVDNH0v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 03:26:51 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3E7Qle9030726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 00:26:48 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Out of curiosity, I cooked up a version of git which used a flat base32, 
instead of base64, repository.  The goal of this is, of course, to 
provide for compatibility with case-deficient filesystems.

The answer is that the base32 format is measurably slower than base64, 
with a cache-hot checkout time of 19.19 seconds (as compared to 15.68 
for base64.)  So the length of the filenames does matter.

Anyway, I have uploaded the base32 patch onto kernel.org, and I have 
moved all the git patches into:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/git/

At this point, though, I would recommend the base64-flat patch.

	-hpa
