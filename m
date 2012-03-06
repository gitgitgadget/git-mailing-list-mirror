From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH] fix deletion of .git/objects sub-directories
 in git-prune/repack
Date: Tue, 06 Mar 2012 22:19:10 +0100
Message-ID: <4F567F4E.5020501@kdbg.org>
References: <OF93114E93.E64C1F7D-ONC12579B9.0032A592-C12579B9.00332D78@dcon.de> <4F565849.80303@kdbg.org> <7v4nu1scsl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: karsten.blees@dcon.de, kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:19:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51mx-0002lI-It
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab2CFVTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:19:14 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:65176 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752604Ab2CFVTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:19:13 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6884113004E;
	Tue,  6 Mar 2012 22:19:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 92B1119F681;
	Tue,  6 Mar 2012 22:19:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <7v4nu1scsl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192397>

Am 06.03.2012 21:19, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
>>> index f9463de..a834417 100644
>>> --- a/builtin/prune-packed.c
>>> +++ b/builtin/prune-packed.c
>>> @@ -36,7 +36,6 @@ static void prune_dir(int i, DIR *dir, char *pathname, 
>>> int len, int opts)
>>>                 display_progress(progress, i + 1);
>>>         }
>>>         pathname[len] = 0;
>>> -       rmdir(pathname);
>>
>> After moving the rmdir() away from prune_dir(), the truncation of the
>> pathname does not logically belong here anymore. It should be moved with
>> the rmdir(). Looks good otherwise.
> 
> I agree that it is better to have the NUL termination close to where
> it actually matters.
> 
> Do you want me to take it after locally fixing it up, or do you
> prefer to feed this as part of msysgit related updates to me later?

This patch is fairly independent from other topics that are queued in
msysgit, IIRC. Please take it with the mentioned fixup.

Thanks,
-- Hannes
