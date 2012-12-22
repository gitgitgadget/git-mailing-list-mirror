From: Earl Gresh <egresh@codeaurora.org>
Subject: Missing Refs after Garbage Collection
Date: Fri, 21 Dec 2012 17:41:43 -0800
Message-ID: <C0A16EC8-D05A-41D0-BF2A-34BF3B1B839E@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 02:42:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmE6r-0002Vr-Lu
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 02:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab2LVBlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 20:41:42 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:58524 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab2LVBlk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 20:41:40 -0500
X-IronPort-AV: E=Sophos;i="4.84,333,1355126400"; 
   d="scan'208";a="16091663"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Dec 2012 17:41:40 -0800
Received: from myvpn-r-02368.ras.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E9BDE10004B4
	for <git@vger.kernel.org>; Fri, 21 Dec 2012 17:41:39 -0800 (PST)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212022>

Hi-

I have observed that after running GC, one particular git repository ended up with some missing refs in the refs/changes/* namespace the Gerrit uses for storing patch sets. The refs were valid and should not have been pruned. Concerned about loosing data, GC is still enabled but ref packing is turned off. Now the number of refs has grown to the point that it's causing performance problems when cloning the project.

Is anyone familiar with git gc deleting valid references? I'm running git version 1.7.8. Have there been any patches in later git releases that might address this issue ( if it is a git problem )?

Thanks