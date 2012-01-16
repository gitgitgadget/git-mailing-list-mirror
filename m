From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Re* Regulator updates for 3.3
Date: Sun, 15 Jan 2012 16:14:28 -0800
Message-ID: <4F136BE4.4040502@pcharlan.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com> <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com> <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com> <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com> <7vmx9v7z1r.fsf@alter.siamese.dyndns.org> <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com> <7vehv77xeq.fsf@alter.siamese.dyndns.org> <CA+55aFzuGtJkQFDooSGWQ2_NiJVHN2E7S5dmOnWTYn8_s8Gg3g@mail.gmail.com> <7vzkdu7miv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 01:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmaDa-0006mA-DT
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 01:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2APAOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 19:14:30 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:56344 "EHLO
	homiemail-a48.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751045Ab2APAO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2012 19:14:29 -0500
Received: from homiemail-a48.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a48.g.dreamhost.com (Postfix) with ESMTP id E4B9F4F8057;
	Sun, 15 Jan 2012 16:14:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=VBSVS1HLXjYrEAgz7hm6JpVNWXne3tW65JzTe2rjCl5R1/9tH9EoivU3juxm6
	P/tjKyiaKSa4K/jF0YaRGMoLLY97DcCKIrdc5PCXjK4ErPf31No5JwS3O6VcRDkj
	D7QVFfSfvF6Aa5Ut68I4hK5X3cai0sOcGOWCcEnw38p1mQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=3pOt
	a3MmNBF52XTXGFVhzitXG50=; b=PoleND3pV/CajvhcQU+MrKh/zoqQSQZJN3kq
	k0gSXjXm9PBjrcWLy+wkIXwu2bbSpKheqthl1t/9WR/aiOGcPeUDKnakQcDveFqt
	edsQBgxVZVjLTenX/CRNGZ9VhNZfEak/91bk4j1P1i9vzcgOdlNm8pmGgiSZ8R5M
	1z6s0Mw=
Received: from [192.168.0.106] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a48.g.dreamhost.com (Postfix) with ESMTPSA id AF5644F8058;
	Sun, 15 Jan 2012 16:14:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <7vzkdu7miv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188600>

On 01/10/2012 10:59 PM, Junio C Hamano wrote:
> There may be existing scripts that leave the standard input and the
> standard output of the "git merge" connected to whatever environment the
> scripts were started, and such invocation might trigger the above
> "interactive session" heuristics. Such scripts can export GIT_MERGE_LEGACY
> environment variable set to "yes" to force the traditional behaviour.

The name GIT_MERGE_LEGACY gives no clue about what flavor of legacy
merge behavior is being enabled.  Something like GIT_MERGE_LEGACY_EDIT
might be clearer, or perhaps just have GIT_MERGE_EDIT=0 to get the old
behavior without reference to whether or not that behavior is
considered legacy.

--Pete
