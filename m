From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 09/13] refactor duplicated ref_newer() to remote.c
Date: Mon, 23 Feb 2009 09:53:15 +0100
Message-ID: <49A263FB.7030308@viscovery.net>
References: <20090223064510.GA24517@coredump.intra.peff.net> <1235374171-92523-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 09:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbWaW-0003AR-RL
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 09:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbZBWIxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 03:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbZBWIxa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 03:53:30 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3479 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZBWIxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 03:53:30 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LbWYv-0005SG-Mr; Mon, 23 Feb 2009 09:53:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6CDF86EF; Mon, 23 Feb 2009 09:53:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1235374171-92523-1-git-send-email-jaysoffian@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111121>

Jay Soffian schrieb:
> diff --git a/remote.c b/remote.c
> index 2c010a1..d0053d5 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -5,6 +5,7 @@
>  #include "diff.h"
>  #include "revision.h"
>  #include "dir.h"
> +#include "tag.h"

You are only moving code from http-push.c and builtin-send-pack.c to
remote.c, but you have to add this '#include "tag.h"' here. How high are
the chances that you can remove the #include lines from http-push.c and
builtin-send-pack.c?

-- Hannes
