From: Maaartin <grajcar1@seznam.cz>
Subject: Re: [RFC/PATCH] Documentation: start to explain what git replace is for
Date: Wed, 12 Jan 2011 22:47:31 +0000 (UTC)
Message-ID: <loom.20110112T232501-316@post.gmane.org>
References: <746745466.20110111134101@mail.ru> <m3lj2rbmq5.fsf@localhost.localdomain> <20110112000812.GA31950@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 12 23:47:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd9Ts-00029X-Uh
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 23:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab1ALWrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 17:47:48 -0500
Received: from lo.gmane.org ([80.91.229.12]:60296 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab1ALWrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 17:47:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pd9Tl-00027r-AL
	for git@vger.kernel.org; Wed, 12 Jan 2011 23:47:45 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 23:47:45 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 23:47:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.7.62 Version/11.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165028>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

> +. The following example comes from ??????? ??????:

I know unicode exists already for many years, but in cygwin I get just =
a bunch=20
of question marks instead of the name. So I'd suggest to replace "=D0=90=
=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20
=D0=A8=D1=83=D0=BC=D0=BA=D0=B8=D0=BD" by "Alexej Shumkin" or whatever h=
is preferred transcription is.


> +<1> Find all parentless commits in the 'master' branch;
> +for 'master' read the branch holding v2.5 history.

Aren't you later calling it "FIRST" and assuming there's only one?

> +$ sed -i "/^tree / a \\
> +parent $(git rev-parse v2.4)" <tmp >new          <4>

Isn't the combination of "-i" (=3Din-place edit) with redirection wrong=
? I hardly=20
know anything about sed (abandoned it in favor of perl many years ago).

> +$ git hash-object -t commit -w new               <5>
> +$ git replace FIRST <object id from hash-object> <6>

I'd prefer something like

+$ objectId=3D$(git hash-object -t commit -w new)
+$ git replace FIRST $objectId

This is easier for people just willing to use it without much thinking,=
 and=20
also for those having no idea that git-hash-object creates a new object=
=2E

That said, it's a nice example and I've learned quite a few things.
