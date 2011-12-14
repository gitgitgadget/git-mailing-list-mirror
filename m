From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH resend] Do not create commits whose message contains NUL
Date: Wed, 14 Dec 2011 14:23:29 +0900
Message-ID: <buomxavwwtq.fsf@dhlpc061.dev.necel.com>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <20111213175932.GA1663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 14 06:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RahJj-0003JQ-19
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 06:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab1LNFXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 00:23:34 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:37477 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1LNFXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 00:23:33 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LW600IFUHN86Z20@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Wed, 14 Dec 2011 14:23:32 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LW6009OVHN7GHD0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Wed, 14 Dec 2011 14:23:32 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 1BB5748093; Wed, 14 Dec 2011 14:23:32 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 0ED1248087; Wed,
 14 Dec 2011 14:23:32 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac4.idc.renesas.com with ESMTP id QAD31513; Wed,
 14 Dec 2011 14:23:32 +0900
X-IronPort-AV: E=Sophos;i="4.71,349,1320591600";   d="scan'208";a="59567204"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii2.idc.renesas.com with ESMTP; Wed, 14 Dec 2011 14:23:31 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.98.108])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pBE5NUHk022588;
 Wed, 14 Dec 2011 14:23:31 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 885C752E1F5; Wed,
 14 Dec 2011 14:23:30 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20111213175932.GA1663@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187095>

Jeff King <peff@peff.net> writes:
>      But maybe it would be nicer to say something like:
>
>        error: your commit message contains NUL characters.
>        hint: This is often caused by using multibyte encodings such as
>        hint: UTF-16. Please check your editor settings.

I think the error message with the hint is much better for users, but
isn't the term "multibyte" a little misleading here?  It seems like
it's really _wide_ encodings that are generally the culprit.

[UTF-16 of course is particularly nasty in that it uses both units which
are wider than a byte ("wide"), _and_ multiple units per code-point....]

Thanks,

-Miles

-- 
Quack, n. A murderer without a license.
