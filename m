From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 21:53:25 +0100
Message-ID: <512D20C5.7050305@kdbg.org>
References: <20130226201305.GA3502@ftbfs.org> <CAHXAxrOcC7GX-rhT793t4vcF68TvrE9w9OW856+7cGDBGMx0VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:53:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UARX8-0003ru-7r
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759674Ab3BZUx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:53:29 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:55698 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757815Ab3BZUx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:53:28 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3F708130052;
	Tue, 26 Feb 2013 21:53:25 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8F84519F486;
	Tue, 26 Feb 2013 21:53:25 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <CAHXAxrOcC7GX-rhT793t4vcF68TvrE9w9OW856+7cGDBGMx0VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217181>

Am 26.02.2013 21:32, schrieb Mike Gorchak:
>> If I remove the call to pthread_create, it doesn't output anything and
>> exits successfully.
> 
> I see. Most resource managers use procmgr_daemon(), which has no such
> limitation. Anyway, as far as I can see current git sources do not use
> fork together with pthread, except for daemonize() function.

Not true: When a clean or smudge filter is configured, a thread is
created, and the thread runs the external program via fork().

-- Hannes
