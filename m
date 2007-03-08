From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: mercurial to git
Date: Thu, 8 Mar 2007 08:56:14 +0000
Organization: Berlin University of Technology
Message-ID: <20070308085613.GA2881@peter.daprodeges.fqdn.th-h.de>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070307155929.GD27596@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 09:56:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPEQA-00023I-HY
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 09:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbXCHI4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 03:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbXCHI4T
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 03:56:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:34364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030327AbXCHI4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 03:56:18 -0500
Received: (qmail invoked by alias); 08 Mar 2007 08:56:16 -0000
Received: from unknown (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.31.238]
  by mail.gmx.net (mp010) with SMTP; 08 Mar 2007 09:56:16 +0100
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX18HIz4oTz8Hn3Nee34iomoG944pHYW4ffhI/AqHF8
	OoDl0Zq1mmkNeR
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id C34CB20F0D
	for <git@vger.kernel.org>; Thu,  8 Mar 2007 08:56:15 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070307155929.GD27596@spearce.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14 (2007-03-06)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41719>

Hi,

* Shawn O. Pearce [07-03-07 10:59:29 -0500] wrote:

>I thought that hg stored file revisions such that each source file
>(e.g. foo.c) had its own revision file (e.g. foo.revdata) and that
>every revision of foo.c was stored in that one file, ordered from
>oldest to newest?  If that is the case why not strip all of those
>into fast-import up front, doing one source file at a time as a
>huge series of blobs and mark them, then do the commit/trees later
>on using only the marks?

>Or am I just missing something about hg?

I don't want to use anything except the hg mecurial API so that in 
theory the importer could work even for remote hg repositories.

But the "blob feed" approach doesn't seem perfectly right to me 
especially for incremental imports. There would have to be state files 
and internal tables telling what revisions of what files there are with 
what content. With thousands of files I think this gets quite messy to 
find even the minimum set to start of with for an incremental import. 
Also, you can already specify up to which revision to import so it would 
get even more complicated.

   bye, Rocco
-- 
:wq!
