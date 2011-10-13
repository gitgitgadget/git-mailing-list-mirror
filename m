From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 12:44:00 -0700
Message-ID: <CAJsNXTktP_sAOS=nXiyAQOK8LudT-wLRGM+=BoQNt4=-c9otyg@mail.gmail.com>
References: <loom.20111013T094053-111@post.gmane.org>
	<CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	<20111013145924.2113c142@ashu.dyn.rarus.ru>
	<loom.20111013T130924-792@post.gmane.org>
	<4E96D819.20905@op5.se>
	<loom.20111013T152144-60@post.gmane.org>
	<1318517194.4646.30.camel@centaur.lab.cmartin.tk>
	<loom.20111013T171530-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 21:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RERIm-0004zI-2k
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 21:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab1JMTun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 15:50:43 -0400
Received: from smtpauth17.prod.mesa1.secureserver.net ([64.202.165.29]:48172
	"HELO smtpauth17.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754041Ab1JMTun convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 15:50:43 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Oct 2011 15:50:43 EDT
Received: (qmail 31362 invoked from network); 13 Oct 2011 19:44:03 -0000
Received: from unknown (209.85.215.174)
  by smtpauth17.prod.mesa1.secureserver.net (64.202.165.29) with ESMTP; 13 Oct 2011 19:44:03 -0000
Received: by eye27 with SMTP id 27so392066eye.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 12:44:01 -0700 (PDT)
Received: by 10.223.6.25 with SMTP id 25mr4278786fax.14.1318535041187; Thu, 13
 Oct 2011 12:44:01 -0700 (PDT)
Received: by 10.223.83.10 with HTTP; Thu, 13 Oct 2011 12:44:00 -0700 (PDT)
In-Reply-To: <loom.20111013T171530-970@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183520>

On Thu, Oct 13, 2011 at 8:53 AM, arQon <arqon@gmx.com> wrote:
>>git co master
> error: Your local changes to the following files would be overwritten=
 by
> checkout:
> =A0 =A0 =A0 =A0file1.txt
> Please, commit your changes or stash them before you can switch branc=
hes.
> Aborting
>
> I'm sure if I thought about it enough (ie re-read Andreas's post a co=
uple
> more times) I'd be able to understand why git gets it right sometimes=
 but
> not other times, but I'm too tired right now. Even when I *am* awake =
and

Git gets it "right" (by your definition) when file1.txt on one branch
is different from file1.txt on the other branch.  That means that
switching branches would require changing the file, so it refuses to
overwrite your changes by doing so.  If it CAN switch branches without
losing your changes, it does.

The fundamental problem is that you're thinking of the changes to the
working tree (which aren't commited) as being "on" some branch.  Until
they're committed, changes in the working tree are only in the working
tree.  That's basically the difference between "committed" and "not
committed".

-PJ
