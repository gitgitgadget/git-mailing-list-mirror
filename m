From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on
 cygwin
Date: Wed, 04 Nov 2009 19:19:03 +0000
Message-ID: <4AF1D3A7.2070407@ramsay1.demon.co.uk>
References: <4AE74408.7080103@ramsay1.demon.co.uk> <4AEFD9E2.6060004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:22:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mN5-0008Cl-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbZKDUWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbZKDUWP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:22:15 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:42136 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932296AbZKDUWO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 15:22:14 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1N5mN1-00041x-mZ; Wed, 04 Nov 2009 20:22:19 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AEFD9E2.6060004@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132140>

Johannes Sixt wrote:
> Ramsay Jones schrieb:
>> When the NO_MMAP build variable is set, which is the case by
>> default on cygwin, the msvc linker complains:
>>
>>     error LNK2001: unresolved external symbol _getpagesize
> 
> Make up your mind: use the cygwin configuration or use the MSVC
> configuration. MSVC doesn't define NO_MMAP for a reason. Where is the problem?

Heh, well as I said elsewhere in this email, the "real problem" is that the
MSVC and cygwin configuration sections are not mutually exclusive and that
is fixed in patch #3. So, if you apply patch #3, this "problem" disappears.

However, ...

> I understand that you run into this error if you define NO_MMAP in your
> config.mak. I don't know whether we support NO_MMAP as a knob for to tweak
> the builds on all platforms. If this is the case (Junio?), then your
> justification must be updated.

AFAICT, the only build to not support NO_MMAP is MSVC (on cygwin *or* msysGit).
The solution was obvious and low impact, so why not remove this anomaly?

(It may even prove to be a useful capability ;-)

ATB,
Ramsay Jones
