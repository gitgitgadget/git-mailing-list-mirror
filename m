From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: After update to 1.6.3.1. I get this error: error: bad index file
 sha1    signature
Date: Fri, 29 May 2009 11:33:00 +0200
Message-ID: <4A1FABCC.7000808@viscovery.net>
References: <64fe838e0905290025h6bf2172agea4beb1ccff6dd6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Thorben_Schr=F6der?= <stillepost@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 11:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ySk-00056J-8y
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 11:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbZE2JdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 05:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756116AbZE2JdI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 05:33:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59956 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbZE2JdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 05:33:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M9ySV-0003AK-2O; Fri, 29 May 2009 11:33:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 617BFC6C1; Fri, 29 May 2009 11:33:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <64fe838e0905290025h6bf2172agea4beb1ccff6dd6e@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120265>

Thorben Schr=F6der schrieb:
> I've recently updated from 1.6.1.2 to 1.6.3.1 on OS X. And after that
> transition I get this:
>=20
>   error: bad index file sha1 signature
>   fatal: index file corrupt
>=20
> on any git command I invoke in any of my repositories. I even tried t=
o
> go back to 1.6.1.2 but the error still occurs.
>=20
> Is there any thing I can do to fix this? Would be great, otherwise al=
l
> my local repositories are busted :/

In one of your less important repositories you can try:

   $ mv .git/index .git/index.prev
   $ git reset

This reconstructs the index file from the HEAD commit. You loose only w=
hat
you might have staged for the next commit, but otherwise this will neit=
her
change you repostitory nor your working directory.

You can keep .git/index.prev around for a while; perhaps someone from t=
his
list wants it for more diagnoses.

As to why this happened, I don't know, but it's certainly interesting.

-- Hannes
