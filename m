From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 4/4] Add tests for pre-commit and commit-msg hooks
Date: Sat, 8 Dec 2007 13:51:43 +0100
Message-ID: <6C67E7B0-EE28-450C-A33F-35D3F742F495@wincent.com>
References: <1197113889-16243-1-git-send-email-win@wincent.com> <1197116987-21802-1-git-send-email-win@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, krh@redhat.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 13:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0zAd-0003ze-KU
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 13:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbXLHMwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2007 07:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbXLHMwS
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 07:52:18 -0500
Received: from wincent.com ([72.3.236.74]:34360 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbXLHMwS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2007 07:52:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB8Cpjd0023133;
	Sat, 8 Dec 2007 06:51:45 -0600
In-Reply-To: <1197116987-21802-1-git-send-email-win@wincent.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67553>

El 8/12/2007, a las 13:29, Wincent Colaiuta escribi=F3:

> As desired, these pass for git-commit.sh, fail for builtin-commit =20
> (prior
> to the fixes), and succeeded for builtin-commit (after the fixes).

Actually, that's a slight lie.

The commit-msg tests 9 and 10 (editing the commit message from the =20
hook) fail for git-commit.sh (tested 1.5.3.4 and 1.5.3.7).

By the looks of it, this discrepancy isn't actually a bug in git-=20
commit.sh, but is because of stuff that was in commit.c back in =20
1.5.3.7 and prior which causes a commit message like "foo" to yield =20
"foo<unknown>" when you do a "git log --pretty=3Dformat:%s%b -1"; post =
=20
1.5.3.7 (on master) it instead yields "foo", which is what I was =20
testing for.

Cheers,
Wincent
