From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 3 Aug 2011 23:45:58 +0200
Message-ID: <20110803214530.GA34347@book.hvoigt.net>
References: <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de> <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de> <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de> <20110803062536.GB33203@book.hvoigt.net> <1312374382.3261.913.camel@Naugrim.eriador.com> <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	henri GEIST <henri.geist@flying-robots.com>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:46:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojGW-0001iu-46
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab1HCVqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:46:08 -0400
Received: from darksea.de ([83.133.111.250]:60686 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752952Ab1HCVqG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:46:06 -0400
Received: (qmail 30526 invoked from network); 3 Aug 2011 23:45:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 3 Aug 2011 23:45:58 +0200
Content-Disposition: inline
In-Reply-To: <4E399C62.30604@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178627>

Hi,

On Wed, Aug 03, 2011 at 09:07:14PM +0200, Jens Lehmann wrote:
> Am 03.08.2011 19:11, schrieb Junio C Hamano:
> But the superproject is still the place to say: I know these versions of
> all submodules work together, so I commit their gitlinks here. But this
> scheme enables submodules to give hints to help the superproject's user.
> 
> > I also suspect that allowing each submodule to know and demand specific
> > versions of other submodules will lead to inconsistencies. Which version
> > of submodule C would you demand to have when submodule A wants version C0
> > and submodule B wants version C1 of it?
> 
> Right, in the discussion so far it seemed like henri seems to be the only
> user who is wanting an exact match, and he says he needs to see these
> inconsistencies. But I think he can modify the "version xxx or newer" to
> his needs without imposing these inconsistencies on users (like me) who
> don't want to see them.

And I imagine if a submodule has such hints we could add a command say

	git submodule resolve-dependencies

which could resolve such "I need a version newer than" hints given by a
submodule to help the user to update a submodule in the superproject.

Disclaimer: I think we need to think about all the implications such a
scheme introduces very carefully. The picture is still a bit blurry for
me.

Cheers Heiko
