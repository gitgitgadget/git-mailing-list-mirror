From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: rsync deprecated?
Date: Thu, 18 Dec 2008 05:13:50 +0100
Message-ID: <200812180513.51107.markus.heidelberg@web.de>
References: <200812180041.10312.markus.heidelberg@web.de> <7vljuei2xw.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 05:14:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDAHo-00057z-2W
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 05:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbYLRENg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 23:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYLRENf
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 23:13:35 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56500 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYLRENe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 23:13:34 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0C104FAAE447;
	Thu, 18 Dec 2008 05:13:33 +0100 (CET)
Received: from [91.19.64.77] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LDAGS-0004Z1-00; Thu, 18 Dec 2008 05:13:32 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vljuei2xw.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+PjtxsqyBaeOnC6khguGYmODyU8jJEP6Sz+yEZ
	cOXt7t9v1zkXHSbSBYzn+Bu2ZiEOBs1MxWoM02czXegEOHeGLA
	ltUEFUM/k0aHGRuHbwnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103432>

Junio C Hamano, 18.12.2008:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > in the "Merging external work" section of the gitcore-tutorial it is
> > stated that the rsync transport is deprecated. The description was added
> > in commit 914328a (Update tutorial., 2005-08-30) together with the
> > "deprecated" note. Having never heard/read this before and since this
> > commit is quite old, I wonder if it is still the case or there was a
> > solution for this problem.
> 
> Sorry, I do not quite understand what you perceive as "this problem".

The problem described in the rsync section in gitcore-tutorial: 

  "can produce unexpected results when you download from the public
  repository while the repository owner is uploading into it via rsync
  transport. Most notably, it could update the files under refs/ which
  holds the object name of the topmost commits before uploading the
  files in objects/ - the downloader would obtain head commit object
  name while that object itself is still not available in the
  repository."

I only thought about git itself uploading into and downloading from the
repository with push and fetch, respectively. And wondered where the
problem with the order of refs and objects was. But I just realized, it
can of course be uploaded with plain rsync, too.

> It has been deprecated for too long a time.  Maybe it is time to remove
> the support, instead of carrying the deprecated command forever?  Is that
> the problem you are talking about?

Yes, this is the answer to my question. I thought maybe it's not
deprecated anymore, because the only place where it is called so, is
gitcore-tutorial.
