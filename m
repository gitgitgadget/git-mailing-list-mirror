From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Fix crlf attribute handling to match documentation
Date: Sat, 19 May 2007 10:58:29 +0100
Message-ID: <200705191058.32473.andyparkins@gmail.com>
References: <200705181333.32719.andyparkins@gmail.com> <7v646p4r50.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 11:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpLi2-0005M0-TF
	for gcvg-git@gmane.org; Sat, 19 May 2007 11:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbXESJ6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 05:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbXESJ6n
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 05:58:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:52226 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbXESJ6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 05:58:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so683797uga
        for <git@vger.kernel.org>; Sat, 19 May 2007 02:58:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ufWrfgBYDpUp5kEogNY0lZt/DwIJOHFbllj/awJKkII8ylUv0O/W+C4/5bih9/9wTvGJ0NZNMSe5XeqYUSzIYKAMhztnwk+7ZIb+T/3B6EfFNHZLDRwpSGY+Mewc8OAnwH335oUhakIei/yF9jqDnC2mxxLFlE7FWOODCCQXmrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=o+/XOy5JJxfBDmOB1CJa8jSpfdhfePKj8GBb/csLkHmXeH1jpvxClu8o4Xcz1jaCsQddNsiGGtjrJngDTXKmf5CIZI4zmkJhmG601/vmpRSoBxtrLF8UzrwVuNTDvA6NylFqjTy39tHlSgpwwgvobKsTNQt00TdGWPvsW1S5Pyg=
Received: by 10.67.96.1 with SMTP id y1mr1739596ugl.1179568716034;
        Sat, 19 May 2007 02:58:36 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id y7sm3850052ugc.2007.05.19.02.58.34;
        Sat, 19 May 2007 02:58:35 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v646p4r50.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47734>

On Saturday 2007, May 19, Junio C Hamano wrote:

> The check you modified in the first hunk is not the above '<='
> comparison but is this:

I was talking about the second hunk there though, which I mentioned 
with "...skipped in crlf_to_worktree()...".   In which case the 
description matches.

> 	(action == CRLF_GUESS && !auto_crlf)
>
> and "core.autocrlf = input" makes "auto_crlf = -1", so when
> action is not GUESS, or even when action is GUESS, if the config
> is set to "input", the if() statement you patched in the first
> hunk should not trigger.  The above description is different from
> what the code was doing.

As I say, the description was for the second hunk.

The fault was my last paragraph, "Similarly for crlf_to_worktree(), if 
core.autocrlf is false, no", which should have said "Similarly for 
crlf_to_git()".  Sorry.

With that small change I think my description was correct.  However, it 
obviously wasn't clear - apologies.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
