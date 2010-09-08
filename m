From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] fast-export: ensure that a renamed file is printed after all references
Date: Wed, 8 Sep 2010 20:47:49 +0200
Message-ID: <201009082047.50083.j6t@kdbg.org>
References: <201009072133.02930.j6t@kdbg.org> <AANLkTim4iuDOG9U1epcafWarckaa6ZnxCOpfJW8KJW_m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 20:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtPgf-0006RG-Ch
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 20:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab0IHSr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 14:47:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:61081 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab0IHSry (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 14:47:54 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8681BCDF9A;
	Wed,  8 Sep 2010 20:47:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3E6BA19F5C9;
	Wed,  8 Sep 2010 20:47:50 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTim4iuDOG9U1epcafWarckaa6ZnxCOpfJW8KJW_m@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155809>

On Mittwoch, 8. September 2010, Elijah Newren wrote:
> Patch and description looks good to me...however, I was a little
> surprised to see no testsuite addition or additional explanation.  Are
> you seeing some t9350 tests fail on some platform despite passing on
> linux?

Yes, I see the problem in t9350 on Windows. It is impossible to write a test 
for it because the test would depend on the unspecified behavior of qsort.

BTW, I don't know whether the diff machinery guarantees to produce 'C' and 'R' 
records in this order. If there is no such guarantee, then fast-export would 
have been broken even before 060df62.

-- Hannes
