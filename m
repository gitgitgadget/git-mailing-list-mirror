From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 5/5] Add stack creation and deletion support to the new infrastructure
Date: Thu, 5 Jun 2008 09:34:29 +0200
Message-ID: <20080605073429.GE23209@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211352.32531.10821.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4A0Q-0005UV-Tc
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 09:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbYFEHeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 03:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYFEHeg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 03:34:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4005 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbYFEHef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 03:34:35 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K49zR-0006FQ-00; Thu, 05 Jun 2008 08:34:29 +0100
Content-Disposition: inline
In-Reply-To: <20080604211352.32531.10821.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83872>

The commit message is misleading. What this patch does is make "stg
init" _use_ the new-infrastructure stack init support added in your
previous patches.

On 2008-06-04 22:13:52 +0100, Catalin Marinas wrote:

> diff --git a/stgit/commands/init.py b/stgit/commands/init.py
> index 475a4ce..b68acd7 100644
> --- a/stgit/commands/init.py
> +++ b/stgit/commands/init.py
> @@ -16,13 +16,8 @@ along with this program; if not, write to the Free=
 Software
>  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA
>  """
> =20
> -import sys, os
> -from optparse import OptionParser, make_option
> -
> -from stgit.commands.common import *
> -from stgit.utils import *
> -from stgit import stack, git
> -
> +from stgit.commands import common
> +from stgit.lib import stack

Lots of imports gone, and the remaining ones aren't spilled directly
into the local namespace. Very nice.

> -    crt_series.init()
> +    stack.Stack.initialise(directory.repository)

This would need minor tweaking if you decide to take my advice for
4/5.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
