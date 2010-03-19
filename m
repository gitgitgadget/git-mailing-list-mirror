From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [egit-dev] Translation of reflog messages?
Date: Fri, 19 Mar 2010 10:42:01 +0100
Message-ID: <201003191042.01536.robin.rosenberg@dewire.com>
References: <D3AA6127B29A3048B2939A08CC561AF55DEFBE1813@DEWDFECCR01.wdf.sap.corp> <20100319040420.GA14689@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Lay, Stefan" <stefan.lay@sap.com>,
	Git Mailing List <git@vger.kernel.org>
To: egit-dev@eclipse.org
X-From: git-owner@vger.kernel.org Fri Mar 19 10:42:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsYic-00005P-9O
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 10:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab0CSJmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 05:42:08 -0400
Received: from mail.dewire.com ([83.140.172.130]:21287 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab0CSJmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 05:42:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F26CC1493E32;
	Fri, 19 Mar 2010 10:42:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWDxEOQa57Oy; Fri, 19 Mar 2010 10:42:02 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 6B2DB80037B;
	Fri, 19 Mar 2010 10:42:02 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-20-generic; KDE/4.3.5; i686; ; )
In-Reply-To: <20100319040420.GA14689@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142571>

fredagen den 19 mars 2010 05.04.20 skrev  Shawn O. Pearce:
> "Lay, Stefan" <stefan.lay@sap.com> wrote:
> > Do we need to externalize reflog messages?
> >
> > We proposed a change to externalize all translatable Strings in egit.core
> > (http://egit.eclipse.org/r/#change,332). It contains code that writes to
> > the reflog, for example in BranchOperation:
> >
> > RefUpdate u = repository.updateRef(Constants.HEAD);
> > u.setRefLogMessage("checkout: moving to " + refName, false);
> >
> > Is this message subject to translation? Or maybe only part of it, namely
> > the name of the git command "checkout"? Are there tools which parse the
> > reflog message and rely on standardized texts?
> 
> Nope.  Currently nobody relies on the format of the message part of a
> reflog record.  So translating them should not break an application.

> Since these are strictly local to the repository, it probably makes
> sense to translate these messages for the user, so they make sense
> to them when they are reading a reflog history in some sort of
> browser UI.
> 
> I say, translate them.

On the other hand we try to use the same format as C git, which doesn't 
translate. Keeping the current messages and trying to translate on read is
another option. Be careful to translate only those parts that can be 
positively identified, so some pattern matching is required.  

If the contents of the reflog is translated before putting it there we destroy
all ability for people to make ad-hoc use of it using . I occasionally grep 
the log and a mix of swedish and english makes that much harder.

(Cc:ing the Git ML)

-- robin
