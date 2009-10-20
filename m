From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 08:24:13 +0200
Message-ID: <vpq3a5etwfm.fsf@bauges.imag.fr>
References: <loom.20091019T094924-194@post.gmane.org>
	<4ADC2D45.3020803@viscovery.net> <4ADC45C7.6090907@gmail.com>
	<200910191307.56989.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 08:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0897-0006q2-2D
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 08:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbZJTGYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 02:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbZJTGYX
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 02:24:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59579 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719AbZJTGYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 02:24:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n9K6Nsxe015016
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 08:23:54 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N088j-00022O-Ik; Tue, 20 Oct 2009 08:24:13 +0200
In-Reply-To: <200910191307.56989.wjl@icecavern.net> (Wesley J. Landaker's message of "Mon\, 19 Oct 2009 13\:07\:56 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 20 Oct 2009 08:23:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n9K6Nsxe015016
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1256624637.91903@ctPK73NzSWFF5G8AJZAQdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130760>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> Until I read this thread, I didn't realize you needed --full to check
> objects in packs.

Same here.

> -	OPT_BOOLEAN(0, "full", &check_full, "also consider alternate objects"),
> +	OPT_BOOLEAN(0, "full", &check_full, "also consider packs and alternate objects"),

IMHO, something like this should be applied to "maint", this is kind
of a serious bug indeed. Just check the "alternate" thing, according
to Junio:

Junio C Hamano <gitster@pobox.com> writes:

>     Side note.  I think the help description of --full option is wrong (or
>     at least stale).  We always look at alternate object store these days
>     since e15ef66 (fsck: check loose objects from alternate object stores
>     by default, 2009-01-30).  It probably should read "check packed
>     objects fully" or something.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
