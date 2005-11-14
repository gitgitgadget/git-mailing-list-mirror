From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git's rev-parse.c function show_datestring presumes gnu date
Date: 14 Nov 2005 15:02:24 -0800
Message-ID: <86zmo6vnnj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 15 00:04:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbnLK-0000ml-BE
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVKNXC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVKNXC0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:02:26 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:7318 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932128AbVKNXC0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:02:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 7F9398F7BE
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 15:02:25 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 32615-01-62 for <git@vger.kernel.org>;
 Mon, 14 Nov 2005 15:02:25 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 207118F7C9; Mon, 14 Nov 2005 15:02:25 -0800 (PST)
To: git <git@vger.kernel.org>
x-mayan-date: Long count = 12.19.12.14.6; tzolkin = 10 Cimi; haab = 4 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11861>


git-rev-parse calls GNU date externally for --since, --after, --before,
and --until, which will fail on at least OpenBSD and Mac OSX (Darwin).

At a minimum, this code can be commented out on such platforms.  Better
would be to have some sort of suitable replacement.

Perhaps the Makefile can test if "date" is GNU date as well.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
