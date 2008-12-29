From: "Zorba" <cr@altmore.co.uk>
Subject: Re: turn off "LF will be replaced by CRLF" thingy
Date: Mon, 29 Dec 2008 15:55:37 -0000
Message-ID: <gjaru8$14g$4@ger.gmane.org>
References: <gjaqta$tg7$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 16:57:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHKUy-0006PA-GE
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 16:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbYL2P4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 10:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYL2P4I
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 10:56:08 -0500
Received: from main.gmane.org ([80.91.229.2]:40284 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYL2P4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 10:56:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHKTI-00072b-Ng
	for git@vger.kernel.org; Mon, 29 Dec 2008 15:56:00 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 15:56:00 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 15:56:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Response
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104105>

OK, lets be brave and see if I can work this out:

Tutorial says:

"The git configuration file contains a number of variables that affect the 
git command's behavior. .git/config file for each repository is used to 
store the information for that repository, and $HOME/.gitconfig is used to 
store per user information to give fallback values for .git/config file. The 
file /etc/gitconfig can be used to store system-wide defaults."

.git/config
======
[core]
 repositoryformatversion = 0
 filemode = false
 bare = false
 logallrefupdates = true
 symlinks = false
 ignorecase = true


$ echo $HOME
gives:
c\docs and settings\<my name>

$HOME\.gitconfig
=============
[gui]
 recentrepo = C:/Documents and Settings/conorr/Desktop/TEMP
 recentrepo = C:/Documents and Settings/conorr/Desktop/TEMP/swproj
[user]
 email = cr@altmore.co.uk
 name = Conor Rafferty

/etc/gitconfig  (under Git installation)
===============================
[core]
 symlinks = false
 autocrlf = true
[color]
 diff = auto
[pack]
 packSizeLimit = 2g
[help]
 format = html


Then tuturial -> the two settings are
core.autocrlf
and
core.safecrlf

So I should set the autocrlf=false in the etc/config file I'm guessing?
lets try that


"Zorba" <cr@altmore.co.uk> wrote in message 
news:gjaqta$tg7$4@ger.gmane.org...
> Dear All,
>
> I was just in the process of creating our first live version on git (5k+ 
> files), when I noticed this in the output of
>
> $ git add .
>
> being "Warning: LF will be replaced by CRLF in <filename>"
> about 500 times !!
>
> I'd rather not let git change any files, many of which are PHP that run on 
> Apache
> I think I remember reading that this is a config option that gets swithced 
> on by default on windows (which we are running git on)
>
> how do I switch it off ?
>
> thanks
>
> 
