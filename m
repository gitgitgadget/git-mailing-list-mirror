From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t7005 and vi in GIT_EXEC_PATH
Date: Sat, 10 Nov 2007 17:45:46 -0500
Message-ID: <443CE405-547F-4BBC-B32E-FFEE7E46700D@silverinsanity.com>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> <85abpl69ck.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqz5W-0004ul-S9
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 23:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbXKJWps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 17:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXKJWps
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 17:45:48 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38065 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbXKJWpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 17:45:47 -0500
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 2AB791FFC142;
	Sat, 10 Nov 2007 22:45:47 +0000 (UTC)
In-Reply-To: <85abpl69ck.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64385>


On Nov 10, 2007, at 5:09 PM, David Kastrup wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> If vi is in GIT_EXEC_PATH, then t7005-editor.sh fails because the  
>> real
>> vi is invoked instead of the test vi script.  This is because the git
>> wrapper puts GIT_EXEC_PATH ahead of ".".  I see no easy solution to
>> this problem, and thought I should bring it up with the list.
>
> Putting "." at the front of GIT_EXEC_PATH instead of PATH would appear
> to do the trick then, wouldn't it?

The GIT_EXEC_PATH I was referring to is the one set in the Makefile  
and compiled into git.  The GIT_EXEC_PATH environment variable is set  
to the git repository.  PATH ends up looking like this (paraphrased):   
"git.git:install directory:.:normal PATH".  And since the install  
directory contains vi, the test fails (actually appears to hang  
because vi is waiting for input while it's output is being sent to / 
dev/null).

~~ Brian
