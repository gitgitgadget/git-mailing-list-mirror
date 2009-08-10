From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: .gitignore vs untracked working file
Date: Mon, 10 Aug 2009 13:41:57 +0200
Message-ID: <4A800785.8050909@viscovery.net>
References: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>	 <20090810100148.GB22200@pengutronix.de> <286817520908100317k4e98faf9n4e852b7abd4719fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Rostislav Svoboda <rostislav.svoboda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 13:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaTGS-0007o3-9a
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 13:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbZHJLmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 07:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZHJLmA
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 07:42:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29546 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbZHJLl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 07:41:59 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MaTGH-0004Zi-SG; Mon, 10 Aug 2009 13:41:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 772C66B7; Mon, 10 Aug 2009 13:41:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <286817520908100317k4e98faf9n4e852b7abd4719fe@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125435>

Rostislav Svoboda schrieb:
> 2009/8/10 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>> Hello,
>>
>>> $ git checkout master
>>> error: Untracked working tree file 'Project/bin/path/file.jjt' woul=
d
>>> be overwritten by merge.
>> What is the output of
>>
>>        $ git ls-files master bin/
>=20
> Nothing:

It should have been

	$ git ls-tree master bin

> BTW the rule to ignore bin/ is exclusively in the .gitignore on the
> branch mybranch not in the master branch. Might this be the problem?

It might be, depending on how precious Project/bin/path/file.jjt is for
you. Try this:

	$ git checkout -f master

This will overwrite the existing file with the version from master. If =
you
later

	$ git checkout mybranch

then the file will be *removed*.

-- Hannes
