From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: `*' gitignores and nested ignores
Date: Fri, 25 Mar 2011 09:18:23 +0100
Message-ID: <4D8C4FCF.5060900@viscovery.net>
References: <19851.6264.179471.935771@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Fri Mar 25 09:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q32E9-0003yn-9D
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 09:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab1CYISa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 04:18:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28398 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752180Ab1CYIS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 04:18:28 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q32Dw-0000y3-39; Fri, 25 Mar 2011 09:18:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9F92E1660F;
	Fri, 25 Mar 2011 09:18:23 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <19851.6264.179471.935771@winooski.ccs.neu.edu>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169965>

Am 3/24/2011 11:10, schrieb Eli Barzilay:
> According to the man page, a .gitignore file that is deeper has highe=
r
> precedence, and a `!' line overrides lower precedence ignores.  I
> tried that, and it works in cases like the last "vmlinux*" example.
>=20
> But it doesn't work if the lower precedence directory has a "*"
> pattern.  If the last example from the man page is changed to:
>=20
>                $ cat .gitignore
>                *
>                $ ls arch/foo/kernel/vm*
>                arch/foo/kernel/vmlinux.lds.S
>                $ echo =C2=B4!/vmlinux*=C2=B4 >arch/foo/kernel/.gitign=
ore
>=20
> then -- IIUC -- the second ignore should work the same, but it
> doesn't.  This also happens if the first pattern is "/*".
>=20
> Is this a bug?

This has been discussed before, and IMNSHO, this is not a bug:

http://thread.gmane.org/gmane.comp.version-control.git/157190

-- Hannes
