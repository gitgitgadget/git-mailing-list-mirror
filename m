From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH 1/2] MSVC: Do not close stdout to prevent a
 crash
Date: Tue, 22 Nov 2011 21:24:03 +0100
Message-ID: <4ECC04E3.70407@kdbg.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org> <4EC80D84.2010202@kdbg.org> <4ECB4501.1060100@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com,
	kusmabite@gmail.com, Johannes.Schindelin@gmx.de
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 21:24:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSwt4-0003LQ-P1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 21:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab1KVUYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 15:24:08 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:49081 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755951Ab1KVUYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 15:24:07 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3B34B130068;
	Tue, 22 Nov 2011 21:24:04 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E4F7B19F3ED;
	Tue, 22 Nov 2011 21:24:03 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4ECB4501.1060100@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185809>

Am 22.11.2011 07:45, schrieb Vincent van Ravesteijn:
>>> To prevent the crash and to prevent git from writing cruft into the
>>> patch
>>> file, we do not close stdout, but redirect it to "nul" instead.
>> A more robust solution is to add invalidcontinue.obj to the linker
>> command line. This installs an invalid argument handler that does not
>> abort, and restores a sane behavior.
> 
> This seems to work only for release builds or did I miss something ?

I cannot tell, but I would be surprised if that were the case. I didn't
test with debug builds (only our 'make MSVC=1' build). A cursory look at
the CRT source code does not show anything that would be different
between a debug and a release build regarding invalidcontinue.obj.

> Is there any argument to not redirect stdout to "/dev/null" on all
> platforms ?

You paper over a crack in the wall. You hide a bug.

-- Hannes
