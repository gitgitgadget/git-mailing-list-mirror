From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in run_command.c:prepare_shell_cmd
Date: Tue, 27 Mar 2012 08:23:22 +0200
Message-ID: <4F715CDA.2010500@viscovery.net>
References: <20120326182427.GA10333@sigill.intra.peff.net> <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca> <20120327032917.GB17338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, jrnieder@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:23:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPoc-0000Pe-U6
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821Ab2C0GX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:23:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36277 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756625Ab2C0GX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:23:27 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SCPoR-0001q2-Dm; Tue, 27 Mar 2012 08:23:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 199501660F;
	Tue, 27 Mar 2012 08:23:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <20120327032917.GB17338@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194018>

Am 3/27/2012 5:29, schrieb Jeff King:
> On Mon, Mar 26, 2012 at 10:41:18PM -0400, Ben Walton wrote:
>> diff --git a/run-command.c b/run-command.c
>> index 1db8abf..f005a31 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -4,6 +4,10 @@
>>  #include "sigchain.h"
>>  #include "argv-array.h"
>>  
>> +#ifndef SHELL_PATH
>> +# define SHELL_PATH "sh"
>> +#endif
> 
> Does this default ever kick in? The Makefile defaults SHELL_PATH to
> /bin/sh, so we will always end up with at least that.

People do use this code outside git. Providing a fallback here would help
them.

-- Hannes
