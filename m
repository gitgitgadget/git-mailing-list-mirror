From: Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>
Subject: Git archiving only branch work
Date: Thu, 13 Nov 2014 12:32:40 +0000
Message-ID: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:48:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xotox-0004kZ-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 13:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbaKMMsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 07:48:13 -0500
Received: from server-h-r4.ipv4.uk.syrahost.com ([176.74.28.17]:49076 "EHLO
	cpanel2.uk.syrahost.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932767AbaKMMsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 07:48:12 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Nov 2014 07:48:12 EST
Received: from 97e0dcfc.skybroadband.com ([151.224.220.252]:57073 helo=geldenhuys.co.uk)
	by cpanel2.uk.syrahost.com with esmtpa (Exim 4.82)
	(envelope-from <mailinglists@geldenhuys.co.uk>)
	id 1XotZr-000c3h-85
	for git@vger.kernel.org; Thu, 13 Nov 2014 12:32:48 +0000
X-Default-Received-SPF: pass (skip=loggedin (res=PASS)) x-ip-name=151.237.238.126;
X-Originating-IP: 151.237.238.126
X-Mailer: SurgeWeb - Ajax Webmail Client
X-Authenticated-User: mailinglists@geldenhuys.co.uk 
X-OutGoing-Spam-Status: No, score=-1.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.uk.syrahost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - geldenhuys.co.uk
X-Get-Message-Sender-Via: cpanel2.uk.syrahost.com: authenticated_id: ang@angela-g-photographer.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've strung together the following git alias command for our company. 
This command allows us to create a deployment package (archive) for a 
specific feature. The archive will contain only the files that changed 
during the development of that feature. We then deploy that archive to 
our client's web/database server for example.

[alias]
    deploy = !sh -c 'git archive --prefix=$1/ -o deploy_$1.zip HEAD 
$(git diff --name-only -D $2)' -


usage:
   git deploy OPS123 develop..ops-123


'OPS123' is the prefix directory to store the changes in
'ops-123' is the feature branch the work was done in.

This works very well. The only problem we have so far is that if we 
have files with spaces in the name (eg: SQL update scripts), then the 
command breaks.

Does anybody have an idea on how this can be resolved?  Any help would 
be much appreciated.

Not sure if this is useful, but we are working on Windows systems and 
use Git Bash consoles.

Regards,
  Graeme
