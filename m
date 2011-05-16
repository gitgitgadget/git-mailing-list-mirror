From: Philipp Metzler <phil@goli.at>
Subject: Re: git commit -a reports untracked files after a clone
Date: Mon, 16 May 2011 14:25:09 +0200
Message-ID: <56A79A18-E53A-4E84-8054-5D2ED6F01835@goli.at>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at> <7v39kgr5ln.fsf@alter.siamese.dyndns.org> <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at> <20110516103829.GA23889@sigill.intra.peff.net> <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at> <20110516120825.GA24418@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 14:26:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLwsw-0003h6-D3
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 14:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab1EPM0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 08:26:49 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:60174 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab1EPM0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 08:26:48 -0400
Received: from [62.47.237.162] (helo=silberpfeil.lan)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <phil@goli.at>)
	id 1QLwrG-0002Vr-G5; Mon, 16 May 2011 14:25:10 +0200
In-Reply-To: <20110516120825.GA24418@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
X-Df-Sender: phil@goli.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173730>

Hi,

created two directories tmp and tmp2 and executed the commands in a different order with different results:

[phil@silberpfeil tmp]$ git clone git://git.kernel.org/pub/scm/git/git.git
Cloning into git...
remote: Counting objects: 140472, done.
remote: Compressing objects: 100% (33586/33586), done.
remote: Total 140472 (delta 105843), reused 139396 (delta 104981)
Receiving objects: 100% (140472/140472), 27.66 MiB | 641 KiB/s, done.
Resolving deltas: 100% (105843/105843), done.
[phil@silberpfeil tmp]$ cd git
[phil@silberpfeil git]$ git commit -a
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	t/t9150/
#	t/t9151/
#	t/t9153/
#	t/t9154/
#	t/t9601/
#	t/t9602/
#	t/t9603/
#	t/t9700/
#	t/valgrind/
#	templates/
#	vcs-svn/
#	xdiff/
nothing added to commit but untracked files present (use "git add" to track)
[phil@silberpfeil git]$ git commit --all -uall
# On branch master
nothing to commit (working directory clean)
[phil@silberpfeil git]$ git commit -a
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	t/t9150/
#	t/t9151/
#	t/t9153/
#	t/t9154/
#	t/t9601/
#	t/t9602/
#	t/t9603/
#	t/t9700/
#	t/valgrind/
#	templates/
#	vcs-svn/
#	xdiff/
nothing added to commit but untracked files present (use "git add" to track)


******************************************************************************


[phil@silberpfeil tmp2]$ git clone git://git.kernel.org/pub/scm/git/git.git
Cloning into git...
remote: Counting objects: 140472, done.
remote: Compressing objects: 100% (33586/33586), done.
remote: Total 140472 (delta 105841), reused 139396 (delta 104981)
Receiving objects: 100% (140472/140472), 27.67 MiB | 602 KiB/s, done.
Resolving deltas: 100% (105841/105841), done.
[phil@silberpfeil tmp2]$ cd git
[phil@silberpfeil git]$ git commit --all -uall
# On branch master
nothing to commit (working directory clean)
[phil@silberpfeil git]$ git commit -a
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	vcs-svn/
#	xdiff/
nothing added to commit but untracked files present (use "git add" to track)
[phil@silberpfeil git]$ git commit --all -uall
# On branch master
nothing to commit (working directory clean)
[phil@silberpfeil git]$ git commit -a
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	vcs-svn/
#	xdiff/
nothing added to commit but untracked files present (use "git add" to track)
[phil@silberpfeil git]$ git status
# On branch master
nothing to commit (working directory clean)
[phil@silberpfeil git]$ git commit -a
# On branch master
nothing to commit (working directory clean)

Cheers,

Philipp

_______________________________________________________________

DI Philipp Metzler
Goli.at GesbR.
Dorf Rieden 7/11
A-6900 Bregenz
EU - Austria

E-Mail: phil@goli.at
Skype: googol
Tel: +43 / 676 / 72 94 176
ICQ: 13950954

o www.philippmetzler.com - Softwareentwicklung und Websites mit Django und Typo3.
o www.goli.at - Ihr Speicherplatz im Netz. Messen Sie uns an unseren Daten.
o www.clickshopping.at - Wir bringen Ihre Produkte auf den Punkt.
o www.greencar.at - Elektroautos und mehr ...
_______________________________________________________________

Am 16.05.2011 um 14:08 schrieb Jeff King:

> On Mon, May 16, 2011 at 12:49:07PM +0200, Philipp Metzler wrote:
> 
>> [phil@Silberpfeil git]$ git commit -uall
>> # On branch master
>> nothing to commit (working directory clean)
> 
> Hmm, nothing. That's odd.
> 
>> [phil@Silberpfeil git]$ git commit -a
>> # On branch master
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #	t/t9154/
>> #	t/t9601/
>> #	t/t9602/
>> #	t/t9603/
>> #	t/t9700/
>> #	t/valgrind/
>> #	templates/
>> #	vcs-svn/
>> #	xdiff/
>> nothing added to commit but untracked files present (use "git add" to track)
> 
> And now totally different output from before, and from the previous run.
> 
> So this is really strange. The fact that the list of directories is
> _different_ from your previous posting implies to me that it is not
> something about those particular files, but rather some weird race
> condition in the creation of those directories or the index.
> 
> But then the fact that we see them with no "-u", but don't see them with
> "-uall" implies some weird heisenbug in git's directory traversal. What
> happens if you do "git commit --all -uall"? I'd like to see if the thing
> that switches the behavior is the presence of "--all" or the absence of
> a "-u" option.
> 
> -Peff
