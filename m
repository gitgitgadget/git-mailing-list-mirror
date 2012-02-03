From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Convert isatty() calls to git_isatty()
Date: Fri, 03 Feb 2012 10:48:59 +0100
Message-ID: <4F2BAD8B.1080403@viscovery.net>
References: <1328258101-10636-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 10:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtFlb-0004XF-7b
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 10:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab2BCJtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 04:49:07 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13872 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab2BCJtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 04:49:04 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RtFlM-0000aR-Js; Fri, 03 Feb 2012 10:49:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 28D2A1660F;
	Fri,  3 Feb 2012 10:49:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <1328258101-10636-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189745>

Am 2/3/2012 9:35, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> isatty() is used to check for interactive use cases. However if pager=
 is
> set up, standard file handles may be redirected and istty() calls lat=
er
> on no longer reflect the original state.

So what? What's wrong with this behavior?

You converted many cases involving progress indicators. Wouldn't the ne=
w
code pipe progress output to the pager where earlier it was not shown i=
f a
pager was present? That is plainly wrong: Progress output is destined o=
nly
for the terminal, not for the pager.

-- Hannes
