From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Help: Found odd git bug
Date: Mon, 04 Jun 2012 15:52:07 -0400
Message-ID: <4FCD11E7.2060509@xiplink.com>
References: <4FCCE433.7090007@xiplink.com> <7vd35ft159.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 21:51:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdJj-0005ni-KB
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 21:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab2FDTvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 15:51:51 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:33953 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2FDTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 15:51:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp27.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6AFF72A8084;
	Mon,  4 Jun 2012 15:51:50 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp27.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C89E92A8090;
	Mon,  4 Jun 2012 15:51:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vd35ft159.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199174>

On 12-06-04 01:52 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> A commit claims to add a line to a file.  Indeed, "git diff" shows the line
>> being added.
>>
>> However, when I check out the commit, the file contains a *different* line,
>> with slightly modified contents.
>>
>> What's more, "git show SHA:path/to/file" shows that the blob contains the
>> wrong line.
>>
>> I found this using git 1.7.9, but 1.7.11.rc1 also shows the problem.
>>
>> How can I narrow down what's causing this problem?
> 
> Without any information useful to diagnose, I would say it probably
> is not a bug but is an operator error when either of the "git diff"
> or "check out the commit" steps were done.  Even if you cannot share
> the repository, at least a _complete_ command line with arguments is
> needed.

(Apply egg to face...)

Indeed, not a bug, nor a misunderstanding of git's workings.  Rather, the
offending file already had a line that the no-longer-problematic commit
should have replaced, instead of adding a nearly-identical new line later on
in the file.  So all this basically stems from not paying enough attention to
the diff's context surrounding the change.

Sorry for the false alarm, and thanks for the patient reply!

		M.
