From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: bugfix: list regression
Date: Tue, 22 Aug 2006 11:30:08 +0200
Organization: At home
Message-ID: <eceir6$rv2$1@sea.gmane.org>
References: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 22 11:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFSb0-0004QD-0D
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 11:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWHVJav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 05:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWHVJav
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 05:30:51 -0400
Received: from main.gmane.org ([80.91.229.2]:57777 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751294AbWHVJau (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 05:30:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFSad-0004LV-Un
	for git@vger.kernel.org; Tue, 22 Aug 2006 11:30:31 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 11:30:31 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 11:30:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25846>

Luben Tuikov wrote:

> Fix regression introduced by
> commit 17d07443188909ef5f8b8c24043cb6d9fef51bca.
> 
> 1. Commit 17d07443188909ef5f8b8c24043cb6d9fef51bca defines
> "a.list" twice in gitweb.css, once with bold and once with
> normal font-weight.
> 
> 2. "a.list" being "bold", makes a myriad of things shown by
> gitweb in bold font-weight, which is a regression from
> pre-17d07443188909ef5f8b8c24043cb6d9fef51bca behavior.
> 
> The fix is to define separately "a.list_bold" and use
> that style in format_subject_html().

This fix is counter to what I wanted to do. I thought that
"list" class is used only in "subject" links, so I defaulted
it to bold (all such elements except one were inside <b>...</b>),
and encoded exceptions; notice

+table.tags a.list {
+       font-weight: normal;
+}
+

We could as well define "bold" class for "a", i.e.

+a.bold {
+       font-weight: bold;
+}

but this is presentational CSS, no better than <b>...</b> element.


The correct solution would be to add "subject" class perhaps,
and do exceptions for it.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
