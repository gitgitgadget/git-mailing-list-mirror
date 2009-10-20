From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git gc and kernel.org
Date: Tue, 20 Oct 2009 16:00:54 +0900
Message-ID: <4ADD6026.8070203@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ftpadmin@kernel.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 09:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08jN-0002vc-V2
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 09:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbZJTHB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 03:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbZJTHB4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 03:01:56 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40891 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZJTHBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 03:01:55 -0400
Received: from [192.168.51.134] (p32183-ipbffx02marunouchi.tokyo.ocn.ne.jp [220.106.13.183])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.3) with ESMTP id n9K710Ac023618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 00:01:01 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Thunderbird/3.0b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130768>

We have run into two major problems with git on kernel.org.  We have 
discussed workarounds, but I believe they are generally major problems 
which will affect other sites, and really need to be fixed upstream.

1) git receive-pack doesn't run git gc --auto.

This cause repositories which people thought were being autopacked to 
not be so.  This can be done via a hook, but that is way too painful for 
people to do -- in fact, it's hard enough just to get people to enable 
the post-update hook for http fetching.

1b) as per the above, a way to make "git update-server-info" at 
post-update time a configurable option rather than needing to be done 
via the hook would be very nice, since a configuration option can be 
enabled sitewide.

2) When pushing to a repository, it apparently doesn't honor new objects 
in alternate repositories.  This causes massive unnecessary duplication.

I believe these are major issues that need to be addressed.  If we are 
*mistaken* on these, then we would appreciate being corrected.

Thanks,

	-hpa
