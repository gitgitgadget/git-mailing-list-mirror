From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: What's the difference between `git show branch:file | diff -u
	- file` vs `git diff branch file`?
Date: Tue, 23 Aug 2011 20:45:02 +0400
Message-ID: <1314117902.17151.2.camel@n900.home.ru>
References: <loom.20110823T091132-107@post.gmane.org>
	 <4E537AF0.9070604@drmicha.warpmail.net>
	 <1314096731.15017.2.camel@n900.home.ru>
	  <4E53C89A.9000604@drmicha.warpmail.net>
Reply-To: Marat Radchenko <marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 18:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvu6N-0002re-4S
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 18:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab1HWQpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 12:45:18 -0400
Received: from static.231.38.47.78.clients.your-server.de ([78.47.38.231]:55160
	"EHLO slonopotamus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab1HWQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 12:45:17 -0400
Received: from [85.26.155.88] (helo=[172.18.44.183])
	by slonopotamus.org with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <marat@slonopotamus.org>)
	id 1Qvu2Y-0006tH-Qm; Tue, 23 Aug 2011 20:41:29 +0400
X-Mailer: Modest 3.90.7
In-Reply-To: <4E53C89A.9000604@drmicha.warpmail.net>
Content-ID: <1314117901.17151.1.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179947>

On =D0=B2=D1=82 23 =D0=B0=D0=B2=D0=B3 2011 19:34:50 MSD, Michael J Grub=
er <git@drmicha.warpmail.net> wrote:=20
> Well, we have to read the full tree before diffing.
I don't see why you need that.

> But I can't
> reproduce the extreme difference which you observed (0.003s vs. 30s)
Well, I have an extreme repo (sadly, private) that has already shown se=
veral scalability issues in various parts of git code. Hope this thread=
 will help to improve it.

> In your case, do you have a lot of differing files besides the one yo=
u
> are limitting to?
1. I'm diffing a single (and rather small, <50kb) text file
2. Diff is done between two branches (master and bugfix for a particula=
r release) one of which (master) already has several thousands of commi=
ts after fork, so yes, whole tree diffs a lot.

P.S. Fix for [1] might somewhat improve the situation but it still isn'=
t clear to me why whole tree needs to be processed when specific path i=
s given. Btw, it is 30s even with --no-renames.

[1] http://git.661346.n2.nabble.com/git-diff-is-slow-patience-is-fast-t=
d6667216.html
