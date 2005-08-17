From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Fixed two bugs in git-cvsimport-script.
Date: Wed, 17 Aug 2005 10:07:25 +0200
Message-ID: <u5tiry50ywy.fsf@lysator.liu.se>
References: <u5tacjjdpxq.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Aug 17 10:10:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Iz9-000343-4a
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 10:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVHQIJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Aug 2005 04:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVHQIJK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 04:09:10 -0400
Received: from main.gmane.org ([80.91.229.2]:14261 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750968AbVHQIJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 04:09:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5Ixl-0002bR-O1
	for git@vger.kernel.org; Wed, 17 Aug 2005 10:07:53 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 10:07:53 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 10:07:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:kI1sCmjZz+GmzBcm2Ef8K3AjQPA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David K=E5gedal <davidk@lysator.liu.se> writes:

> The git-cvsimport-script had a copule of small bugs that prevented me
> from importing a big CVS repository.
>
> The first was that it didn't handle removed files with a multi-digit
> primary revision number.

I noticed that this patch was accepted, which is great.  But there is
a problem with the character encoding in the commit message.

The commit in question is b0921331030d52febf52839753eee1b2b9ca1f24

The "author" field is written as "iso-8859-1?Q?David_K=3DE5gedal
<davidk@lysator.liu.se>", which is taken from the "From:" line in my
email.  This should be decoded by the patch import script before
generating the commit message.

But the trickier question is what encoding to use in the commit
message.

This is the signed-off line in my mail:

  Signed-off-by: David K=E5gedal <davidk@lysator.liu.se>

This is what appears in the commit:

  Signed-off-by: David K?5gedal <davidk@lysator.liu.se>

Using ISO-8859-15 or UTF-8 would probably have made more sense here.

Apparently, my mail was encoded as QP, which is not very popular
around here.  But it seems that the diff part was decoded properly
before applying.  Was that done manually?

Since my name contains a character that is not part of ASCII, it isn't
really an option to send the mails encoded as ASCII.  I could probably
convince my mailer (Gnus) to send it as "8bit" or "binary", but that
is a pretty limited solution.  An it isn't even legal to use anything
but ASCII in the mail header.

--=20
David K=E5gedal
