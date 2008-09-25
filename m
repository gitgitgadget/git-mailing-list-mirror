From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git apply --directory broken for new files
Date: Thu, 25 Sep 2008 13:41:56 -0700
Message-ID: <48DBF794.9030809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 22:43:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kixg3-0005vC-BV
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbYIYUl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbYIYUl6
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:41:58 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40029 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbYIYUl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 16:41:57 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m8PKfufP019752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Sep 2008 13:41:57 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m8PKfuRW011139;
	Thu, 25 Sep 2008 13:41:56 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m8PKfu35021825;
	Thu, 25 Sep 2008 13:41:56 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Virus-Scanned: ClamAV 0.93.3/8338/Thu Sep 25 11:12:59 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96795>

Trying with git 1.6.0.1:

: tazenda 124 ; git apply --directory=gpxe/ < /tmp/diff
fatal: git-apply: bad git-diff - inconsistent new filename on line 105

Line 105 in the diff is:

    101  diff --git a/src/arch/i386/firmware/pcbios/fakee820.c 
b/src/arch/i386/firmware/pcbios/fakee820.c
    102  new file mode 100644
    103  index 0000000..e171edf
    104  --- /dev/null
    105  +++ b/src/arch/i386/firmware/pcbios/fakee820.c

What I'm trying to do here is to apply a diff created via "git diff" to 
a subdirectory of another git repository.

	-hpa
