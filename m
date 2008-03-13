From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Q] assume unchanged?
Date: Thu, 13 Mar 2008 08:27:57 +0100
Message-ID: <47D8D77D.8070908@op5.se>
References: <20080227222243.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZhrj-0005x0-UT
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbYCMH2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 03:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYCMH2A
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:28:00 -0400
Received: from mail.op5.se ([193.201.96.20]:35416 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbYCMH17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:27:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A085C1F080D0;
	Thu, 13 Mar 2008 08:29:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3WMvB9Og4VI; Thu, 13 Mar 2008 08:29:04 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id D0FF61F080CF;
	Thu, 13 Mar 2008 08:29:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <20080227222243.6117@nanako3.bluebottle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77043>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:
> I was looking at the documentation of git-update-index because I
> thought git-add is the preferred way to do what the command was used
> for in the old versions of git, and wanted to see if the old command
> has more features that are missing from git-add.
>=20
> I noticed that there is --assume-unchanged option, and I read its
> description three times, but I do not understand it.  What is it good
> for?  Version control systems are used in order to keep track
> changes, and if using that option makes my changes ignored, how can
> it be a good thing?
>=20
> The manual says "This is sometimes helpful when working with a big
> project on a filesystem that has very slow lstat(2) system call", but
> unfortunately it does not answer my question.
>=20
> Could somebody explain, please?
>=20

If you're hacking on, oh, let's say the openoffice repo (or something
similarly huge), and the files you're actually testing are located on
an NFS-mounted network disk, you can use "--assume-unchanged java
--assume-unchanged writer" to make git not walk through those directori=
es
and lstat(2) everything in it to see if there are changes. For huge
projects, doing the lstat() walk can take a couple of seconds on a quic=
k
filesystem sitting on a local disk, and several minutes on a really slo=
w
network disk.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
