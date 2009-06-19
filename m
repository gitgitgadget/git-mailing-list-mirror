From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Fri, 19 Jun 2009 13:26:53 -0700
Message-ID: <7veitgkm0i.fsf@alter.siamese.dyndns.org>
References: <200906142238.51725.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHkg2-0005kr-FY
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 22:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbZFSU0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 16:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbZFSU0w
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 16:26:52 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56363 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZFSU0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 16:26:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090619202653.ZJQ17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 19 Jun 2009 16:26:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5wSt1c00C4aMwMQ03wStCP; Fri, 19 Jun 2009 16:26:53 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=4M1fZqYIV4cA:10 a=A9qS8gIqAAAA:8
 a=896JPvTC-gRoVsA4fCcA:9 a=EyL2B4rQfVDML69MOkn5jVCcvBEA:4 a=Kj4G0JfAssAA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121908>

Johannes Sixt <j6t@kdbg.org> writes:

> diff --git a/daemon.c b/daemon.c
> index d7ceca4..3e1a354 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "pkt-line.h"
> -#include "exec_cmd.h"
> +#include "run-command.h"
> +#include "strbuf.h"

    CC daemon.o
cc1: warnings being treated as errors
daemon.c: In function 'main':
daemon.c:981: error: implicit declaration of function 'git_extract_argv0_path'
make: *** [daemon.o] Error 1

I'll add the include back in the meantime.
