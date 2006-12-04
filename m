X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 04 Dec 2006 19:56:57 +0100
Organization: At home
Message-ID: <el1qtr$bca$1@sea.gmane.org>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de> <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com> <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 4 Dec 2006 18:55:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33217>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIyS-0000fG-33 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937193AbWLDSzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 13:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937264AbWLDSzZ
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:55:25 -0500
Received: from main.gmane.org ([80.91.229.2]:45544 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937193AbWLDSzY
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 13:55:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrIxz-0005hv-SE for git@vger.kernel.org; Mon, 04 Dec 2006 19:55:04 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 19:55:03 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 19:55:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Stefan Pfetzing wrote:

> 2006/7/28, Petr Baudis <pasky@suse.cz>:
>>>
>>> mv: cannot stat `"gitweb/test/M\\303\\244rchen"': No such file or directory
>>>
> since when is this file in the official git.git tree?

Since merging in gitweb, Sat Jun 10, 2006.
 
> Its quite problematic when used on HFS+ because it uses UTF-16 internally IMHO.
> 
> Git always thinks there is a new file in my git.git clone.

That is the problem that git tries to be content agnostict, and it
includes being coding agnostic.

I personally think that because the same repository might be deployed
on different systems with different file name encoding (and this is not
something you have control over, contrary to commit/tag message encoding,
and encoding in files), git should acquire core.filesystemEncoding
configuration variable which would encode from filesystem encoding used
in working directory and perhaps index to UTF-8 encoding used in repository
(in tree objects) and perhaps index.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

