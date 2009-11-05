From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on
 cygwin
Date: Thu, 05 Nov 2009 08:55:27 +0100
Message-ID: <4AF284EF.2030606@viscovery.net>
References: <4AE74408.7080103@ramsay1.demon.co.uk> <4AEFD9E2.6060004@viscovery.net> <7veiogt4g8.fsf@alter.siamese.dyndns.org> <4AF1E1FD.1050102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5xBu-0007Pc-LO
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 08:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbZKEHzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 02:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZKEHzX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 02:55:23 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:50332 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755058AbZKEHzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 02:55:23 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5xBn-0001j5-FJ; Thu, 05 Nov 2009 08:55:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3C1CA4E9; Thu,  5 Nov 2009 08:55:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AF1E1FD.1050102@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132209>

Ramsay Jones schrieb:
> Junio C Hamano wrote:
>> Shouldn't this be solved by teaching the Makefile about this new "Cygwin
>> but using MSVC as compiler toolchain" combination?
> 
> Yes. Err... see patch #3 :-P

A clarifiction: Junio talks about using the MSVC tools to build Cygwin
programs, that is, to merely substitute Cygwin's gcc by MSVC, but to still
link against cygwin's C runtime.

But this is not what this series is about.

When the "MSVC build" of git is made, then the MSVC compiler is used, and
this will always use Microsoft libraries in the resulting executables,
regardless of whether "make MSVC=1" was called from a "cygwin environment"
or from and "msys environment".

This series is about fixing "make MSVC=1" when it is run from a "cygwin
environment" by disentangling the MSVC and Cygwin configuration sections
in the Makefile.

-- Hannes
