From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [cgit PATCH] use Host: header to generate cgit_hosturl
Date: Mon, 1 Sep 2008 23:30:33 +0000
Message-ID: <20080901233033.GB19984@hand.yhbt.net>
References: <20080901063033.GA21848@untitled> <8c5c35580809011336v58b139acu5078cafd3440c786@mail.gmail.com> <20080901230741.GA19984@hand.yhbt.net> <8c5c35580809011614k6ec5a0e9tdfd5d3031c58b84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 01:31:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIsH-0004Ji-Rq
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 01:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbYIAXaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbYIAXaf
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 19:30:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:36009 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbYIAXae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 19:30:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D2A6C2DC01B;
	Mon,  1 Sep 2008 16:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8c5c35580809011614k6ec5a0e9tdfd5d3031c58b84@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94630>

Lars Hjemli <hjemli@gmail.com> wrote:
> On Tue, Sep 2, 2008 at 1:07 AM, Eric Wong <normalperson@yhbt.net> wrote:
> > Lars Hjemli <hjemli@gmail.com> wrote:
> >> On Mon, Sep 1, 2008 at 8:30 AM, Eric Wong <normalperson@yhbt.net> wrote:
> >> > So use the "Host" header if it is available and fall back to
> >> > SERVER_NAME/SERVER_PORT for some clients that don't set
> >> > HTTP_HOST.
> >>
> >> Maybe it would be better to use a new cgitrc parameter as fallback if
> >> the client doesn't provide the "Host" header?
> >
> > That sounds a bit hackish to me since HTTP_HOST, SERVER_NAME and
> > SERVER_PORT are all standardized.  Anyhow, it's your call :)
> 
> I just figured that since SERVER_NAME/SERVER_PORT doesn't work in a
> setup like the one you described, clients which doesn't provide the
> "Host" header would never get a correct url. A default value for the
> "Host" header in cgitrc would work around this issue.

Actually, in my situation, the proxy server will unconditionally set a
Host: header before sending the request to the lighttpd backend.  Header
rewriting/injection is a common feature in HTTP aware proxies.

-- 
Eric Wong
