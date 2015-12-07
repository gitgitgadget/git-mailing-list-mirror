From: Charles Bailey <charles@hashpling.org>
Subject: Re: git branch in Bash subshell "$(git branch -a)" including ls
 output as part of return?
Date: Mon, 7 Dec 2015 16:58:10 +0000
Message-ID: <20151207165810.GA25856@hashpling.org>
References: <CAJGk2Wx4B=AHFxkJep=yYVKU9UyJieazoNaC44W5yBXoMi+gdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Jones <ajones@netsertive.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 17:58:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5z7C-0001fH-7T
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 17:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083AbbLGQ6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 11:58:14 -0500
Received: from avasout05.plus.net ([84.93.230.250]:42172 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbbLGQ6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 11:58:13 -0500
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id qgyA1r0032iA9hg01gyB7R; Mon, 07 Dec 2015 16:58:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MryvkDue c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=Ew9TdX-QAAAA:8 a=kj9zAlcOel0A:10 a=wUQvQvOEmiQA:10
 a=-CON0h31e1qCYx00NDgA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1a5z74-0006jP-7j; Mon, 07 Dec 2015 16:58:10 +0000
Content-Disposition: inline
In-Reply-To: <CAJGk2Wx4B=AHFxkJep=yYVKU9UyJieazoNaC44W5yBXoMi+gdg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282097>

On Mon, Dec 07, 2015 at 11:52:28AM -0500, Alex Jones wrote:
> git branch -a output:
> 
> ajonespro:Deploy_Script ajones$ git branch -a
> 
> * DWH_concurrent_api
>   Email_No_Error_If_No_Old_Version
>   IT/configs_in_app_support
>   PHP_Build_Repo
>   master
>   remotes/origin/DWH_concurrent_api
>   remotes/origin/Email_No_Error_If_No_Old_Version
>   remotes/origin/IT/configs_in_app_support
>   remotes/origin/PHP_Build_Repo
>   remotes/origin/master
> 
> echo $(git branch -a) output:
> 
> ajonespro:Deploy_Script ajones$ echo $(git branch -a)
> AppDeploy WebDeploy DWH_concurrent_api
> Email_No_Error_If_No_Old_Version IT/configs_in_app_support
> PHP_Build_Repo master remotes/origin/DWH_concurrent_api
> remotes/origin/Email_No_Error_If_No_Old_Version
> remotes/origin/IT/configs_in_app_support remotes/origin/PHP_Build_Repo
> remotes/origin/master
> 
> While it might be hard to see from that output, The first two
> "branches" in the subshell's output are actually the directories
> contained within the repo.

Looking at the two outputs, you are seeing the shell's glob expansion of
the '*' current branch marker. You probably want to quote the command
expansion to prevent this:

echo "$(git branch -a)"
