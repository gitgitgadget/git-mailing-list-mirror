From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/11] Add miss git-compat-util.h at regex.c and fnmatch.c
 Add git-compat-util.h to enable build at MSVC environment
Date: Mon, 17 Aug 2009 18:51:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171850370.4991@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:51:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5R5-00065D-QI
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbZHQQvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757486AbZHQQvp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:51:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:50651 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757464AbZHQQvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:51:44 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:51:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 17 Aug 2009 18:51:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wqMNI/6owDEgpc7EiMzJ2v0Kv7JhPSqbqm2NWN/
	Ikn3KSklosWcDi
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126228>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> Signed-off-by: Frank Li <lznuaa@gmail.com>

How about this instead?

	Add missing git-compat-util.h to regex.c and fnmatch.c

	This will be needed to compile with Microsoft Visual C++.

> diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
> index 14feac7..5cbd49c 100644
> --- a/compat/fnmatch/fnmatch.c
> +++ b/compat/fnmatch/fnmatch.c
> @@ -16,6 +16,10 @@
>     write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>     Boston, MA 02111-1307, USA.  */
>  
> +#ifdef _MSC_VER
> +#include "git-compat-util.h"
> +#endif
> +

Why not leave those #ifdef guards?  Either they don't hurt, or they will 
hurt Microsoft Visual C++, too.

Ciao,
Dscho
