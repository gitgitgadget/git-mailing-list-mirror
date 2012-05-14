From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git commit path vs rebase path
Date: Mon, 14 May 2012 08:02:26 +0200
Message-ID: <4FB09FF2.70309@viscovery.net>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>	<4FA8BBB0.1080406@viscovery.net>	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>	<4FA8C5DB.5060002@viscovery.net>	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>	<4FAC047A.4010001@ramsay1.demon.co.uk> <CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com> <4FB03CA1.4030703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon May 14 08:03:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SToNi-0007IY-32
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 08:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab2ENGDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 02:03:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25891 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751750Ab2ENGDP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 02:03:15 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SToNB-00058S-89; Mon, 14 May 2012 08:03:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CBA781660F;
	Mon, 14 May 2012 08:03:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FB03CA1.4030703@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.4.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197762>

Am 5/14/2012 0:58, schrieb Ramsay Jones:
> BTW, Johannes, earlier you said commit be39048 ("git-sh-setup.sh: Add an pwd()
> function for MinGW", 17-04-2012) would fix the problem on MinGW; I'm not so
> sure it will. 

> [...] problem (*which MinGW shares*) is that the
> pwd() function is defined *after* the code that sets $GIT_DIR from which the
> rebase state directory name is derived (see git-sh-setup.sh lines 223-239).

Good catch!

Nevertheless, if I set GIT_EDITOR to "notepad", 'git rebase -i' works to
some degree. Leaving aside that it does not understand LF line endings, it
opens the git-rebase-todo file; I can edit and save it. That is, it looks
like a usable Windows style path was passed to Notepad. (This is with
MinGW git, of course.)

But I can't use "Save As": Notepad just responds with "Error #3002". I
would attribute this to the forward slashes in the absolute path name, and
that the file dialog can't cope with them. Personally, I don't think this
is a big deal: We have heard of people who set GIT_EDITOR to something
Windows-y, but there were no complaints of the kind I mention in this
paragraph. (Why should there be any? There is no reason to use "Save As"
when git invokes an editor.)

-- Hannes
