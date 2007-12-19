From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] Invalid rebase command leaves unclean status
Date: Wed, 19 Dec 2007 08:42:29 +0100
Message-ID: <E2D86FF0-52D2-40D9-A03A-04F400A2C0C6@wincent.com>
References: <a1b6cb1b0712181647v34822692t4a3d88f90cd7346@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: ulrik <ulrik.sverdrup@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 08:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4tZy-0008E1-Gb
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 08:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbXLSHme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 02:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXLSHmd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 02:42:33 -0500
Received: from wincent.com ([72.3.236.74]:35123 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbXLSHmd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 02:42:33 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBJ7gUOh013468;
	Wed, 19 Dec 2007 01:42:31 -0600
In-Reply-To: <a1b6cb1b0712181647v34822692t4a3d88f90cd7346@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68862>

El 19/12/2007, a las 1:47, ulrik escribi=F3:

> Hello git list
>
> A bug in rebase -i: A typo in the command (for example in the branch
> name) still makes later invocations of rebase think a rebase is
> already in process.

It's already been fixed on master:

$ mkdir demo
$ git init
Initialized empty Git repository in .git/
$ echo a > a
$ git add a
$ git commit -m a
Created initial commit 36a2b58: a
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 a
$ git checkout -b other
Switched to a new branch "other"
$ git rebase -i muster
fatal: Needed a single revision
Invalid base
$ git rebase -i master
Nothing to do

Cheers,
Wincent
