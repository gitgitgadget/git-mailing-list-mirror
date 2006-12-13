X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Drake <ddrake@brontes3d.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Wed, 13 Dec 2006 11:28:09 -0500
Message-ID: <1166027289.21948.4.camel@systems03.lan.brontes3d.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
	 <20061208203230.GA9193@sashak.voltaire.com>
	 <1165847230.13854.2.camel@systems03.lan.brontes3d.com>
	 <20061211204904.GC1003@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 16:55:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:55:46 EST
In-Reply-To: <20061211204904.GC1003@sashak.voltaire.com>
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: OK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34227>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuXOY-0005rG-Ki for gcvg-git@gmane.org; Wed, 13 Dec
 2006 17:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964988AbWLMQzr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 11:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWLMQzr
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 11:55:47 -0500
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:33881 "EHLO
 smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964988AbWLMQzq (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 11:55:46 -0500
Received: from [10.20.253.243] (host34.155.212.242.conversent.net
 [155.212.242.34]) (Authenticated sender: ddrake@brontes3d.com) by
 relay5.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 20F7B6473BC; Wed,
 13 Dec 2006 11:28:09 -0500 (EST)
To: Sasha Khapyorsky <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

On Mon, 2006-12-11 at 22:49 +0200, Sasha Khapyorsky wrote:
> Maybe I'm starting to understand. Your svn url (url which points to svn
> repository) is https://server/repo and not just https://server, right?
> 
> If so, please remove the patch (you don't need it) and rerun:
> 
>   git-svnimport -v -i -C repo -r https://server/repo

Sorry, apparently I was using the wrong git-svnimport in my last mail.
The above command, with or without your svn_dir patch, doesn't solve the
problem.

With your patch:

# git-svnimport -v -i -C repo -r https://server/repo

RA layer request failed: PROPFIND request failed on '/trunk/.cvsignore':
PROPFIND of '/trunk/.cvsignore': 405 Method Not Allowed (https://svn) at
git-svnimport line 364

# git-svnimport -v -i -C repo -r https://server repo
perl: subversion/libsvn_subr/path.c:377: svn_path_basename: Assertion
`is_canonical (path, len)' failed.
Aborted


Without the patch, the error is the same as the 1st case in both
situations.

-- 
Daniel Drake
Brontes Technologies, A 3M Company
