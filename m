From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 2/5] implement submodule config cache for lookup of
 submodule names
Date: Tue, 10 Jun 2014 12:19:27 +0200
Message-ID: <20140610101927.GA23384@t2784.greatnet.de>
References: <20140605060425.GA23874@sandbox-ub>
 <20140605060750.GC23874@sandbox-ub>
 <CAPig+cTmXu09QLca4W=VpUS82m0uDSQLch7Gb06U_XeUZ83FrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 12:29:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuJJE-0002sV-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 12:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbaFJK3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 06:29:36 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:54894 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaFJK3g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 06:29:36 -0400
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WuJ9Q-00081u-9G; Tue, 10 Jun 2014 12:19:32 +0200
Content-Disposition: inline
In-Reply-To: <CAPig+cTmXu09QLca4W=VpUS82m0uDSQLch7Gb06U_XeUZ83FrQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251176>

On Sun, Jun 08, 2014 at 05:04:44AM -0400, Eric Sunshine wrote:
> On Thu, Jun 5, 2014 at 2:07 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > This submodule configuration cache allows us to lazily read .gitmodules
> > configurations by commit into a runtime cache which can then be used to
> > easily lookup values from it. Currently only the values for path or name
> > are stored but it can be extended for any value needed.
> >
> > [...]
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> > diff --git a/t/t7410-submodule-config.sh b/t/t7410-submodule-config.sh
> > new file mode 100755
> > index 0000000..ea453c5
> > --- /dev/null
> > +++ b/t/t7410-submodule-config.sh
> > @@ -0,0 +1,73 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2014 Heiko Voigt
> > +#
> > +
> > +test_description='Test submodules config cache infrastructure
> > +
> > +This test verifies that parsing .gitmodules configuration directly
> > +from the database works.
> > +'
> > +
> > +TEST_NO_CREATE_REPO=1
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'submodule config cache setup' '
> > +       mkdir submodule &&
> > +       (cd submodule &&
> > +               git init
> 
> Broken &&-chain.

Will fix. Thanks for catching.

Cheers Heiko
