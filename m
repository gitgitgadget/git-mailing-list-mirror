From: Yann Droneaud <ydroneaud@opteya.com>
Subject: git diff returns fatal error with core.safecrlf is set to true.
Date: Fri, 21 Jun 2013 15:26:51 +0200
Organization: OPTEYA
Message-ID: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 15:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq1Mh-0006Td-1q
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 15:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127Ab3FUN0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 09:26:55 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:61036 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030216Ab3FUN0y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 09:26:54 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Uq1MZ-000HGI-9U
	for <git@vger.kernel.org>; Fri, 21 Jun 2013 15:26:51 +0200
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228612>

Hi,

Following my previous email "Tracking vendor release with Git" [1][2],
and the advice from Git users/developers, I'm trying to use 
.gitattributes
to handle CRLF/LF conversion.

While testing the behavor of Git regarding CRLF handling,
when core.safecrlf is set to true, I've found that "git diff" is 
returning
"fatal: CRLF would be replaced by LF" without returning any kind of 
diff.

This make me wonder if its the correct behavor for git diff to (only) 
fail:
It should be fatal for git add / git commit ( / git cherry-pick / ... 
?),
but non fatal for git diff.

According to the documentation git-config(5) [3]:
"Git will verify if a command modifies a file in the work tree either 
directly or indirectly"
I don't thing "git diff" is an operation that could modify a file.

Regards.

1. <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
2. <http://thread.gmane.org/gmane.comp.version-control.git/227466>
    <http://marc.info/?l=git&m=137097069115462&w=2>
3. https://www.kernel.org/pub/software/scm/git/docs/git-config.html

-- 
Yann Droneaud
OPTEYA
