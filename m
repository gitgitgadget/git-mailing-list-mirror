From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Re: How does Git know which files no longer needed during upgrade?
Date: Wed, 4 Mar 2009 12:28:07 +0000 (UTC)
Message-ID: <loom.20090304T122643-455@post.gmane.org>
References: <22318714.post@talk.nabble.com> <20090303233058.GE4371@genesis.frugalware.org> <20090304094951.GA32433@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 13:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeqET-0004kv-Dd
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 13:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbZCDM2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 07:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbZCDM2Y
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 07:28:24 -0500
Received: from main.gmane.org ([80.91.229.2]:33774 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbZCDM2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 07:28:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LeqCv-0004XQ-HO
	for git@vger.kernel.org; Wed, 04 Mar 2009 12:28:17 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 12:28:17 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 12:28:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE) AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112207>

Jeff King <peff <at> peff.net> writes:

> 
> > cd /path/to/copy
> > rm -rf *
> > cp -a /path/to/new/version/* .
> > git add -A
> > git commit -m 'update foo to 2.0'
> 
> Nit: "rm -rf *" will miss files starting with '.'. So it is probably
> simpler to say what you mean: delete all files managed by git:
> 
>   git ls-files -z | xargs -0 rm -f
> 
> -Peff

But maybe one wants to keep a .gitignore file. 

Regrads,
Stefan
