From: Jason Wang <jason77.wang@gmail.com>
Subject: help: the question about relative path in the objects/info/alternates
Date: Mon, 1 Aug 2011 17:16:56 +0800
Message-ID: <4E366F08.2060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 11:17:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnocW-0000D6-Fw
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 11:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab1HAJRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 05:17:03 -0400
Received: from mail.windriver.com ([147.11.1.11]:63121 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab1HAJRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 05:17:00 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p719H0Eo003634
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 1 Aug 2011 02:17:00 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Mon, 1 Aug
 2011 02:16:59 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178323>

Hi git experts,

 From the objects/info/alternates part of this URL 
http://www.kernel.org/pub/software/scm/git/docs/gitrepository-layout.html, 
it says it will work if alternates has relative path in it. But i found 
it will always fail under below situation, i don't know whether the 
failure is due to the git nature or it is a git potential bug.

The failure situation is like that:
On my machine, i have a git bare base repository, e.g. 
/home/jason/source/base-bare. On the same machine, i have a git bare 
incremental (it need to refer to base repository) repository, e.g. 
/home/jason/source/incremental-bare. In the 
incremental-bare/objects/info/alternates, i set a relative path to point 
to the objects of base-bare like this "../../base-bare/objects". Then i 
want to clone a new repository from the incremental-bare on the same 
machine, if i use this command "git clone 
/home/jason/source/incremental-bare new-project", it will fail; but if i 
use this command "git clone file:///home/jason/source/incremental-bare 
new-project", it will work successfully, Why the first one can't work, 
it is a bug for git?

In addtion, if i write an absolute path in the 
incremental-bare/objects/info/alternates like this 
"/home/jason/source/base-bare/objects", it will always work well no 
matter i add or don't add "file://".

Thanks
Jason Wang.
