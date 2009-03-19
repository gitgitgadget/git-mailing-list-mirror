From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/10] test-lib: Replace uses of $(expr ...) by POSIX
   shell features.
Date: Thu, 19 Mar 2009 08:38:27 +0100
Message-ID: <49C1F673.9050500@viscovery.net>
References: <cover.1237410682.git.j6t@kdbg.org> <680eb7fed78dc2ae0268f9b3adcd5978aed3ebcf.1237410682.git.j6t@kdbg.org> <alpine.DEB.1.00.0903182319180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 08:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkCrT-0007g3-60
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 08:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbZCSHim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 03:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZCSHim
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 03:38:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38103 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbZCSHil (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 03:38:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LkCpg-0006bW-GX; Thu, 19 Mar 2009 08:38:35 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 51B85543; Thu, 19 Mar 2009 08:38:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903182319180.10279@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113727>

Johannes Schindelin schrieb:
> Hi,
> 
> On Wed, 18 Mar 2009, Johannes Sixt wrote:
> 
>> In particular:
>>
>> - Test case counting can be achieved by arithmetic expansion.
>>
>> - The name of the test, e.g. t1234, can be computed with ${0%%} and ${0##}.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> 
> I guess this makes the tests less slow on Windows?  Do you have numbers?

Actually, while reading through test-lib.sh I found those expr expressions
quite difficult to understand, and my primary intent was to make the code
more readable. Furthermore, as you can see in the hunk that touches
test_known_broken_{ok,failure}_ that the $(( )) construct is already in
use, so it's also a change to improve consistency.

The shorter runtime (primarily on Windows) is just a nice side effect,
although the gain probably vanishes in the noise.

> FWIW I run the tests on Windows with -j10 these days, and they take about 
> 15 minutes on a quad core 3GHz machine (which I may use from time to time; 
> the machine is not mine, otherwise it would run Linux).

Last time I tried -j<something> it bailed out early. I didn't try again
since then. Sequential tests finish in 30-40 minutes here, but I don't run
SVN tests.

-- Hannes
