From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitk: git bisect view doesn't work
Date: Mon, 01 Dec 2008 17:29:53 +0100
Message-ID: <49341101.8050400@viscovery.net>
References: <4933F819.1010701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:31:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7BgH-00025o-SM
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbYLAQ36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbYLAQ36
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:29:58 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46875 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYLAQ34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 11:29:56 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L7Bek-0003ym-4N; Mon, 01 Dec 2008 17:29:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DDF0969F; Mon,  1 Dec 2008 17:29:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4933F819.1010701@viscovery.net>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Johannes Sixt schrieb: > gitk bails out like this if I do
	"git bisect view": > > $ git bisect start HEAD HEAD~2 > Bisecting: 0 revisions
	left to test after this > [9a61060c7e0d112d0742f5b845210ea8c41b6c6b] Added
	encoding > > $ git bisect view > Error in startup script: can't read "notflag":
	no such variable > while executing > "expr {!$notflag}" > ("--not" arm line
	2) > invoked from within > "switch -glob -- $arg { > "-d" - > "--date-order"
	{ > set vdatemode($n) 1 > # remove from origargs in case we hit an unknown
	option > set origarg..." > (procedure "parseviewargs" line 21) > invoked
	from within > "parseviewargs $view $args" > (procedure "start_rev_list" line
	27) > invoked from within > "start_rev_list $curview" > (procedure "getcommits"
	line 5) > invoked from within > "getcommits {}" > (file "/usr/local/bin/gitk"
	line 10897) [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102057>

Johannes Sixt schrieb:
> gitk bails out like this if I do "git bisect view":
> 
> $ git bisect start HEAD HEAD~2
> Bisecting: 0 revisions left to test after this
> [9a61060c7e0d112d0742f5b845210ea8c41b6c6b] Added encoding
> 
> $ git bisect view
> Error in startup script: can't read "notflag": no such variable
>     while executing
> "expr {!$notflag}"
>     ("--not" arm line 2)
>     invoked from within
> "switch -glob -- $arg {
>             "-d" -
>             "--date-order" {
>                 set vdatemode($n) 1
>                 # remove from origargs in case we hit an unknown option
>                 set origarg..."
>     (procedure "parseviewargs" line 21)
>     invoked from within
> "parseviewargs $view $args"
>     (procedure "start_rev_list" line 27)
>     invoked from within
> "start_rev_list $curview"
>     (procedure "getcommits" line 5)
>     invoked from within
> "getcommits {}"
>     (file "/usr/local/bin/gitk" line 10897)

Bisection points to this commit:

commit 2958228430b63f2e38c55519d1f98d8d6d9e23f3
Author: Paul Mackerras <paulus@samba.org>
Date:   Tue Nov 18 19:44:20 2008 +1100

    gitk: Fix switch statement in parseviewargs

-- Hannes
