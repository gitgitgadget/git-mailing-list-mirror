From: Florian Weimer <fweimer@bfk.de>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 17:41:15 +0100
Message-ID: <82r6gh9104.fsf@mid.bfk.de>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
	<m37ii9nagt.fsf@roke.D-201>
	<alpine.DEB.1.00.0801161600030.5260@bender.nucleusys.com>
	<200801161520.44668.jnareb@gmail.com>
	<alpine.DEB.1.00.0801161640010.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFBKn-0006yF-RU
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 17:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbYAPQlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 11:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbYAPQlT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 11:41:19 -0500
Received: from mx01.bfk.de ([193.227.124.2]:36015 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627AbYAPQlS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 11:41:18 -0500
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1JFBKE-0005dZ-KD; Wed, 16 Jan 2008 17:41:14 +0100
Received: from fweimer by bfk.de with local id 1JFBKF-0006xu-3M; Wed, 16 Jan 2008 17:41:15 +0100
In-Reply-To: <alpine.DEB.1.00.0801161640010.5260@bender.nucleusys.com> (Petko Manolov's message of "Wed, 16 Jan 2008 16:43:09 +0200 (EET)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70700>

* Petko Manolov:

>>> Unfortunately this is not the case.  These binary blobs are already
>>> compressed and/or encrypted and adding even a few bytes ends up sto=
ring
>>> new version in full size.
>>
>> Can't you store them uncompressed?
>
> Not really, but i can convert them into ascii format and store only
> the delta.  This will admittedly increase the initial size of the
> repository, but hopefully not by much.

If the encryption is halfway decent, a new IV/nonce will be chosen for
each new revision, and you can't tell that two ciphertexts share a
common prefix without fully decrypting them.

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
