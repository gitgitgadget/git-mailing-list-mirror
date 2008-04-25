From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with git fetch over http://
Date: Fri, 25 Apr 2008 14:24:24 -0700
Message-ID: <7v3ap9pr07.fsf@gitster.siamese.dyndns.org>
References: <63F7B390-32D1-458A-8ED9-D5AC62F46745@newartisans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Wiegley <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 23:25:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpVQ3-00022j-3v
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 23:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760584AbYDYVYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 17:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759688AbYDYVYf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 17:24:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759286AbYDYVYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 17:24:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B9644500;
	Fri, 25 Apr 2008 17:24:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 94E2444FC; Fri, 25 Apr 2008 17:24:29 -0400 (EDT)
In-Reply-To: <63F7B390-32D1-458A-8ED9-D5AC62F46745@newartisans.com> (John
 Wiegley's message of "Fri, 25 Apr 2008 16:42:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80349>

John Wiegley <johnw@newartisans.com> writes:

> Hello, I'm using the Builtbot to pull sources from a Git repository,
> and have found that the Buildbot's Git step always uses git-fetch -- a
> detail of Buildbot which I currently have little control over.
>
> This is no problem if the git:// protocol is used, but using fetch
> with http:// doesn't work.  This has been mentioned elsewhere:
>
>   http://lists.berlios.de/pipermail/bitbake-dev/2007-November/000765.html
>
> Here's a quick example of what I mean:
>
>   cd /tmp ; mkdir foo ; cd foo ; git init
>
>   git fetch git://newartisans.com/ledger.git	# works fine
>
>   cd /tmp ; rm -fr foo ; mkdir foo ; cd foo ; git init
>
>   git fetch http://newartisans.com/git/ledger.git  # fails

Is this related to this independent observation?

$ wget http://newartisans.com/git/ledger.git
--14:23:54--  http://newartisans.com/git/ledger.git
           => `ledger.git'
Resolving newartisans.com... 208.70.150.153
Connecting to newartisans.com|208.70.150.153|:80... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: http://git.newartisans.com//ledger.git [following]
--14:23:55--  http://git.newartisans.com//ledger.git
           => `ledger.git'
Resolving git.newartisans.com... 208.70.150.153
Connecting to git.newartisans.com|208.70.150.153|:80... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: http://git.newartisans.com/ledger.git/ [following]
--14:23:55--  http://git.newartisans.com/ledger.git/
           => `index.html'
Connecting to git.newartisans.com|208.70.150.153|:80... connected.
HTTP request sent, awaiting response... 403 Forbidden
14:23:55 ERROR 403: Forbidden.
