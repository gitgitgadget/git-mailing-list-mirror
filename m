From: Sam Vilain <sam@vilain.net>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 19:27:13 +1200
Message-ID: <46EF7DD1.9090301@vilain.net>
References: <20070917193027.GA24282@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:25:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXSi-0000Yj-Jf
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbXIRHZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 03:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbXIRHZ3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:25:29 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:39663 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbXIRHZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:25:29 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id F39FB23C261; Tue, 18 Sep 2007 19:25:26 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id F227320C2CA;
	Tue, 18 Sep 2007 19:25:20 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20070917193027.GA24282@old.davidb.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58532>

David Brown wrote:
> I'd like to track a lot of code living in a Perforce repository, so I've
> been playing with 'git-p4.py'.  Is the one in the contrib/fast-import
> directory the latest version, or is there a better place.

I'm pretty close to giving a newer one a spin, that actually imports
from the raw perforce back-end files without needing the perforce
server.  I am hoping that this should give a very clean import and will
be very fast and efficient, sending files that share ancestry to gfi in
sequence so that the on-the-fly delta system works.

If you're interested, take a look at
http://utsl.gen.nz/gitweb/?p=git-p4raw;a=summary.  Expect the commands
that say "WIP" to be rebased :-).  It requires Postgres - I haven't yet
re-written the SQL queries that step outside of MySQL's little box.

It could possibly be adapted to use the p4 client (though I'd expect
that to be relatively slow per-revision), and possibly be extended to be
bidirectional as all of the upstream change number information is
recorded, a la git-svn.

Sam.
