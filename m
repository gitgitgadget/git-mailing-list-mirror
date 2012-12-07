From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] sh-setup: work around "unset IFS" bug in some shells
Date: Fri, 07 Dec 2012 23:50:49 +0100
Message-ID: <m2fw3h8oja.fsf@igel.home>
References: <50C22B15.1030607@xiplink.com>
	<7vvccdhhod.fsf@alter.siamese.dyndns.org>
	<50C22F72.6010701@xiplink.com>
	<7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com>
	<7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
	<50C25539.9010206@xiplink.com>
	<7vobi5fu3c.fsf@alter.siamese.dyndns.org>
	<7va9tpfq46.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:51:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th6lD-0007Jh-5a
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 23:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab2LGWuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 17:50:55 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49745 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab2LGWuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 17:50:54 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YJ86M6Nhvz4KK73;
	Fri,  7 Dec 2012 23:50:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YJ86M5QMFzbbnH;
	Fri,  7 Dec 2012 23:50:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id KdnTZXXLIQjt; Fri,  7 Dec 2012 23:50:51 +0100 (CET)
X-Auth-Info: mK10AlzcWzxnHoFbyzMy5ALvLGZjAwvvUgq0sjS3nW0=
Received: from igel.home (ppp-88-217-125-13.dynamic.mnet-online.de [88.217.125.13])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  7 Dec 2012 23:50:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 66282CA2C5; Fri,  7 Dec 2012 23:50:50 +0100 (CET)
X-Yow: I'm ANN LANDERS!!  I can SHOPLIFT!!
In-Reply-To: <7va9tpfq46.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Dec 2012 14:34:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211202>

Junio C Hamano <gitster@pobox.com> writes:

> +# Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
> +# do not equate an unset IFS with IFS with the default, so here is
> +# an explicit SP HT LF.
> +IFS=' 	
> +'

Trailing whitespace can easily get lost, so it's probably better to
stick a '' in here.  The sequence <space><tab> is also easily being
mangled to <tab>.

IFS=' ''	''
'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
