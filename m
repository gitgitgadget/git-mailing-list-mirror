From: Loet Avramson <loet@forter.com>
Subject: Submodule's .git file contains absolute path when created using 'git clone --recursive'
Date: Thu, 5 May 2016 12:51:22 +0000 (UTC)
Message-ID: <loom.20160505T140253-275@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 14:55:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayIoF-0000Z4-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 14:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbcEEMzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 08:55:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:37850 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbcEEMzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 08:55:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ayIo5-0000TZ-N0
	for git@vger.kernel.org; Thu, 05 May 2016 14:55:05 +0200
Received: from 199.203.127.113 ([199.203.127.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:55:05 +0200
Received: from loet by 199.203.127.113 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:55:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 199.203.127.113 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/49.0.2623.108 Chrome/49.0.2623.108 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293647>

Hi,

According to git-clone man page - running 'git clone --recursive' "...is 
equivalent to running 'git submodule update --init --recursive' immediately 
after the clone is finished...", though I found a little difference between 
the two regarding the submodule's .git file:

1. Running 'git clone' and 'git submodule update --init --recursive' 
separately will create the .git file in each submodule containing a relative 
path to the superproject's .git directory as expected.

2. Running 'git clone --recursive' will create the .git file containing an 
*absolute* path to the superproject's .git directory. (as it was expected 
using git versions 1.7.8 - 1.7.10 as far as I understand)

Not sure if that's a bug but it got stuff behaving really weird in a specific 
usecase on one of our environments. It would be highly appreciated to update 
the docs at least.

Thanks.

 -Loet
