From: Hannu Koivisto <azure@iki.fi>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in write_entry()
Date: Mon, 20 Apr 2009 15:34:30 +0300
Message-ID: <83eivnh5bd.fsf@kalahari.s2.org>
References: <49EC2F7C.8070209@viscovery.net>
	<20090420110302.GB25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 14:38:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvsjS-0006LS-TJ
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 14:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbZDTMeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 08:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755104AbZDTMeo
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 08:34:44 -0400
Received: from s2.org ([195.197.64.39]:33797 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755117AbZDTMen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 08:34:43 -0400
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1Lvshi-0000Gt-G8; Mon, 20 Apr 2009 15:34:30 +0300
In-Reply-To: <20090420110302.GB25059@dpotapov.dyndns.org> (Dmitry Potapov's
	message of "Mon, 20 Apr 2009 15:03:02 +0400")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116977>

Dmitry Potapov <dpotapov@gmail.com> writes:

> The cygwin version has the same problem. (In fact, it is even worse,
> because we have an optimized version for lstat/stat but not for fstat,
> and they return different values for some fields like i_no). But even
> if we used the only Cygwin functions, we would still face the problem,
> because Windows returns the wrong values for timestamps (and maybe
> even size on FAT?). So I think the following patch should be squashed
> on top.

I can verify that this fixes the rebase problem I've been having in
Cygwin and that I just mailed about separately.

-- 
Hannu
