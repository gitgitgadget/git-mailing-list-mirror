From: Jan Smets <jan.smets@alcatel-lucent.com>
Subject: git blame performance
Date: Fri, 6 Nov 2015 14:37:52 +0100
Message-ID: <563CAD30.6040608@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:38:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuhDz-0005Hx-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbbKFNia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:38:30 -0500
Received: from fr-hpida-esg-02.alcatel-lucent.com ([135.245.210.21]:52075 "EHLO
	smtp-fr.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161212AbbKFNi3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:38:29 -0500
Received: from fr712usmtp2.zeu.alcatel-lucent.com (unknown [135.239.2.42])
	by Websense Email Security Gateway with ESMTPS id A8F8E43AE9F70
	for <git@vger.kernel.org>; Fri,  6 Nov 2015 13:38:24 +0000 (GMT)
Received: from FR712WXCHHUB03.zeu.alcatel-lucent.com (fr712wxchhub03.zeu.alcatel-lucent.com [135.239.2.74])
	by fr712usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id tA6DbO0j030105
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 6 Nov 2015 14:38:25 +0100
Received: from [172.31.139.43] (135.239.27.40) by
 FR712WXCHHUB03.zeu.alcatel-lucent.com (135.239.2.74) with Microsoft SMTP
 Server (TLS) id 14.3.195.1; Fri, 6 Nov 2015 14:37:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Originating-IP: [135.239.27.40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280982>

Hi

I have recently migrated a fairly large project from CVS to Git.
One of the issues we're having is the blame/annotate performance.

The repository contains +650k commits total, of which ~300k are on 
master. (raw size = ~8GB)

Running blame on one of the oldest files takes over 30 seconds.
This is on a fairly beefy (server) machine with lots of ram and the 
repository on a ramdisk. Running git 2.5.2

cvs annotate of the same file (over the network) is ready in 0.8 seconds.
blame/annotate is a frequently used operation, ranging between 5 to 20 
usages a day per developer.

I have two questions

  1) Is there a way to speed this up (in git)? eg: can it run multi 
threaded? build pre-cached blame views?
  2) I was thinking to work around the issue and use gitweb 
blame_incremental and pre-populate the cache.

If you can think of any other (short term) solutions I would really like 
to hear them.

Thank you

- Jan
