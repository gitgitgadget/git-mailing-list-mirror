From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Brown paper bag fix for MinGW 64-bit stat
Date: Sat, 07 Mar 2009 12:00:09 -0800
Message-ID: <7vzlfxnlx2.fsf@gitster.siamese.dyndns.org>
References: <cover.1236436185u.git.johannes.schindelin@gmx.de>
 <03fcab37c921f5728deded11c07bdf32a263b79b.1236436185u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2iU-0004U8-23
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbZCGUAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 15:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756470AbZCGUAW
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:00:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448AbZCGUAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 15:00:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E0BAA0E1C;
	Sat,  7 Mar 2009 15:00:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9F1DA0E1A; Sat,
  7 Mar 2009 15:00:11 -0500 (EST)
In-Reply-To: <03fcab37c921f5728deded11c07bdf32a263b79b.1236436185u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Sat, 7 Mar 2009 15:37:18 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 949CE0F6-0B52-11DE-8059-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112571>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When overriding the identifier "stat" so that "struct stat" will be
> substituted with "struct _stati64" everywhere, I tried to fix the calls
> to the _function_ stat(), too, but I forgot to change the earlier
> attempt "stat64" to "_stati64" there.
>
> So, the stat() calls were overridden by calls to _stati64() instead.
>
> Unfortunately, there is a function _stati64() so that I missed that
> calls to stat() were not actually overridden by calls to mingw_lstat(),
> but t4200-rerere.sh showed the error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Since this is a fix-up to a new on 'master', I've applied the patch
myself, but how would we want to handle MinGW related patches in general?

My preference is to have somebody I can rely on receiving Acked forwards
from (or pulling from).
