From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] branch: say "Reset to" in reflog entries for 'git branch
 -f' operations
Date: Fri, 09 Apr 2010 14:20:16 +0200
Message-ID: <4BBF1B80.8050307@viscovery.net>
References: <1270799112-4308-1-git-send-email-rctay89@gmail.com>	<4BBF159A.1000206@drmicha.warpmail.net> <vpqk4sgltoh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 09 14:20:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0DCE-0006m4-JT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 14:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab0DIMUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 08:20:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7671 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359Ab0DIMUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 08:20:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O0DC5-0001UB-8A; Fri, 09 Apr 2010 14:20:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E467F1660F;
	Fri,  9 Apr 2010 14:20:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <vpqk4sgltoh.fsf@bauges.imag.fr>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144429>

Am 4/9/2010 14:03, schrieb Matthieu Moy:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> But I also have a functional question: Is "start_from" really the ref
>> *to* which the branch is reset? I hope reset does it right.
> 
> I don't know which is which, but if start_from is the destination of
> the ref, then it should be renamed. I don't think we want to have this
> 
> 		snprintf(msg, sizeof msg, "branch: Reset to %s",
>                                                          ^^
>  			 start_name);
>                          ^^^^^
> 
> in the code.

I think the patch is right.

The "start" part refers to where the branch forks off of existing history.

In the case were an existing branch is pointed to a new commit, the "Reset
to" is indeed correct. IIUC, the "start_name" is what was given on the
command line as fork point (or HEAD if not given). For example, after

   git branch -f thebranch master~23

the reflog of 'thebranch' would now read as "Reset to master~23".

-- Hannes
