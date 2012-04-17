From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in prepare_shell_cmd
 on Windows
Date: Tue, 17 Apr 2012 16:00:25 +0200
Message-ID: <4F8D7779.9080506@viscovery.net>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org> <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca> <4F8D15B9.70803@viscovery.net> <1334670128-sup-4966@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff <peff@peff.net>, jrnieder <jrnieder@gmail.com>,
	gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:00:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK8xR-0003mV-NB
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 16:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab2DQOAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 10:00:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19055 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975Ab2DQOAc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 10:00:32 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SK8xZ-0006vL-3T; Tue, 17 Apr 2012 16:00:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C50581660F;
	Tue, 17 Apr 2012 16:00:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1334670128-sup-4966@pinkfloyd.chass.utoronto.ca>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195759>

Am 4/17/2012 15:45, schrieb Ben Walton:
> Excerpts from Johannes Sixt's message of Tue Apr 17 03:03:21 -0400 2012:
>> The recent change to use SHELL_PATH instead of "sh" to spawn shell
>> commands is not suited for Windows:
> 
> Ah yes, I can see how that would be undesirable on Windows.
> 
>> +#ifndef WIN32
>>          nargv[nargc++] = SHELL_PATH;
>> +#else
>> +        nargv[nargc++] = "sh";
>> +#endif
>>          nargv[nargc++] = "-c";
> 
> A minor style question: Would this conditional code not be better if
> it were up where the fallback SHELL_PATH is set?  That would leave
> this code block #ifdef free while still avoiding the breakage on
> Windows.

It would require either to #define yet another new name to SHELL_PATH or
"sh", or to #undef SHELL_PATH and re#define it for WIN32. Neither is very
appealing. I personally prefer to have the conditional (if it is as short
as this one) at the point where it matters.

-- Hannes
