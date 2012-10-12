From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v4 12/12] t3070: disable two fnmatch tests that have different
 results on different libc
Date: Fri, 12 Oct 2012 09:22:22 +0200
Message-ID: <5077C52E.2050000@viscovery.net>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com> <1349865651-31889-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZZx-0005Uu-La
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab2JLHWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 03:22:30 -0400
Received: from so.liwest.at ([212.33.55.24]:47194 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243Ab2JLHW3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 03:22:29 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TMZZf-0002Ml-Ce; Fri, 12 Oct 2012 09:22:23 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1CB421660F;
	Fri, 12 Oct 2012 09:22:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1349865651-31889-13-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207531>

Am 10/10/2012 12:40, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> fnmatch on glibc-2.12.1 returns no match. glibc-2.15 returns ok.

There are many more cases that fail with the fnmatch() that we ship in
compat/fnmatch. To test this on Linux, you have to remove the "#if defi=
ned
_LIBC || !defined __GNU_LIBRARY__" brackets from compat/fnmatch/fnmatch=
=2Ec
and build with NO_FNMATCH.

-- Hannes
