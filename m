From: James Cloos <cloos@jhcloos.com>
Subject: git-fetch vs ipv6 routing issues
Date: Sat, 31 May 2008 17:56:01 +0000
Message-ID: <m38wxq1hou.fsf@eagle.jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 20:07:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2VUM-0001iL-0U
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 20:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbYEaSGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYEaSGW
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 14:06:22 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:2762 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbYEaSGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 14:06:21 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 May 2008 14:06:21 EDT
Received: by eagle.jhcloos.com (Postfix, from userid 500)
	id 9F34F4012D; Sat, 31 May 2008 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1212256561; bh=h8pZrsHsgIhBhPUzwrttNJ/WwAP0deH+W/kMSU8sy
	vw=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kDz3XJylTNSemulncFTa+8Q41DweY/ITrwmvM6rjhY/d+o5M9gfnER3mO27uMQR+n
	WHJz6Bo1p2RNh1lvqsAgzGT6o4fHKHgQGRt6uYNSRE61cSn/GpuOI/JZRp+7EuJX2G6
	six5uXu8Wca2L4kx0q31nJkBUrHL5WfvJ0HwCz4=
X-Hashcash: 1:20:080531:git@vger.kernel.org::0YqNp+/DWM/LtfKC:0000000000000000000000000000000000000000000nTZ
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83397>

I just noticed that, given a remote URL with a hostname which has both A
and AAAA RRs in the DNS, git-fetch will retry a git-protocol fetch using
the v4 address if the v6 address is unreachable, but will not do so when
the remote is an http URL.

(I'm currently running bdb87afb4b4 from last month but will be updating
later today.  I don't see any relevant changes in the git log between
then and now.)

-JimC
-- 
cloos@jhcloos.com
