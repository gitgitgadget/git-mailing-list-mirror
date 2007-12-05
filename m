From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 11:11:32 -0500
Message-ID: <82D48BF0-E01D-4CE4-92F3-44B555531624@silverinsanity.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <1196869526-2197-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:12:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzwrQ-0008Ic-3Y
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 17:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXLEQLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 11:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXLEQLn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 11:11:43 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:46708 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXLEQLm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 11:11:42 -0500
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 9DBFF1FFC00B;
	Wed,  5 Dec 2007 16:11:38 +0000 (UTC)
In-Reply-To: <1196869526-2197-1-git-send-email-jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67163>


On Dec 5, 2007, at 10:45 AM, Jakub Narebski wrote:

> Update configure.ac (and config.mak.in) to keep up with git
> development by adding [compile] test whether your library has
> an old iconv(), where the second (input buffer pointer) parameter
> is declared with type (const char **) (OLD_ICONV).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch needs checking if it correctly sets OLD_ICONV
> when needed.  I have checked only that it is not set when
> with new iconv() declaration.  Could people using Cygwin
> (and other with OLD_ICONV: Darwin) test it?

I could not get git am to apply the patch cleanly, but will try again  
later when I have more time.  That said, 10.5's default /usr/include/ 
iconv.h uses the newer non-const definition of iconv_open.  I've had  
to add a "OLD_ICONV=" line to my config.mak to avoid the warning.   
I'll still test to look for a false positive.

> P.S. Is there any convention on where to use YesPlease, and where
> UnfortunatelyYes when setting Makefile build configuration variables?

AFAICT, YesPlease is the "normal" choice and UnfortunatelyYes is used  
when the person who added it considered it an obnoxious hack or a  
stupid failing in a system.  The test in the Makefile is just if the  
variable is defined, so you technically could use  
"IDontLikeSillyVariableValuesInMyMakefiles", and it would work just  
fine.  ;-)

~~ Brian
