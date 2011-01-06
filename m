From: Phillip Susi <psusi@cfl.rr.com>
Subject: clone breaks replace
Date: Thu, 06 Jan 2011 16:00:24 -0500
Message-ID: <4D262D68.2050804@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 21:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PawrY-0000OD-Qn
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab1AFUzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:55:05 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:35948 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab1AFUzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:55:03 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=3jtQBdTzPyV+fq4oCU/u8ZPrJJGN11HvhaDVxyWhycI= c=1 sm=0 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=xPcQh34sAAAA:8 a=zGQRnAI0rybC4860ju4A:9 a=Vv-J_dFG5gIDc4xokgYA:7 a=Kt_HzqHNV9pYMb-keJ6KMw4niAMA:4 a=wPNLvfGTeEIA:10 a=jxOWgADlrxkA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:4984] helo=[10.1.1.235])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 5D/BF-02631-62C262D4; Thu, 06 Jan 2011 20:55:02 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164672>

I've been experimenting with git replace to remove ancient history, and
I have found that cloning a repository breaks replace.  I read about
this process at http://progit.org/2010/03/17/replace.html.  I managed to
correctly add a replace commit that truncates the history and contains
instructions where you can find it, and running git log only goes back
to the replacement commit, unless you add --no-replace-objects, which
causes it to show the original full history.

The problem is that when I clone the repository, I expect the clone to
contain only history up to the replacement record, and not the old
history before that.  Instead, the clone contains only the full original
history, and the replacement ref is not imported at all.  A git replace
in the new clone shows nothing.

Shouldn't clone copy .git/refs/replace?
