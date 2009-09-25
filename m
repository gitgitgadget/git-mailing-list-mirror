From: Joe Perches <joe@perches.com>
Subject: git merge conflict resolution?
Date: Thu, 24 Sep 2009 18:18:30 -0700
Message-ID: <1253841510.18126.10.camel@Joe-Laptop.home>
References: <200909250101.n8P11HwO030173@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752715AbZIYBS2@vger.kernel.org Fri Sep 25 03:18:46 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752715AbZIYBS2@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqzSP-0001pJ-SD
	for glk-linux-kernel-3@lo.gmane.org; Fri, 25 Sep 2009 03:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbZIYBS2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 24 Sep 2009 21:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZIYBS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Sep 2009 21:18:27 -0400
Received: from mail.perches.com ([173.55.12.10]:1191 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbZIYBS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Sep 2009 21:18:27 -0400
Received: from [192.168.1.152] (new-host-2.home [192.168.1.152])
	by mail.perches.com (Postfix) with ESMTP id C4DBA24368;
	Thu, 24 Sep 2009 18:18:24 -0700 (PDT)
In-Reply-To: <200909250101.n8P11HwO030173@hera.kernel.org>
X-Mailer: Evolution 2.28.0 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129059>

Question about how git does merge conflict resolution.

This patch doesn't really apply, and the results after the
patch aren't what at least I expect.

Patch 1: ====================

On Fri, 2009-09-25 at 01:01 +0000, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/linus/784546839fd45de485b9e9e4cd072b9d53100aa5
> Commit:     784546839fd45de485b9e9e4cd072b9d53100aa5
> Parent:     07198871dac00e9c250d647e1976d7aee527b805
>     ARM: Update mailing list addresses
>     The old list has now been closed off; update the now invalid addresses.
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  MAINTAINERS |  106 +++++++++++++++++++++++++++++-----------------------------
>  1 files changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837b598..12be157 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -497,7 +497,7 @@ F:	arch/arm/include/asm/floppy.h
>  
>  ARM PORT
>  M:	Russell King <linux@arm.linux.org.uk>
> -L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
> +L:	linux-arm-kernel@lists.infradead.org
>  W:	http://www.arm.linux.org.uk/
>  S:	Maintained
>  F:	arch/arm/

====================

vs the patch that was applied a bit earlier:

Patch 2: ====================

commit efc03ecb9d674588a13aee27289c2af2afe5e6b4
Author: Joe Perches <joe@perches.com>
Date:   Mon Sep 21 17:04:27 2009 -0700

    MAINTAINERS: move ARM lists to infradead

====================

Patch 2 was applied before patch 1.

Russell's patch removes the "(moderated for non-subscribers)"
from each entry, yet the final result includes it.

Can someone help me understand why?
