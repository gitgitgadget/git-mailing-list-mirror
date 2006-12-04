X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 19:46:10 -0500
Message-ID: <20061204004610.GA16706@spearce.org>
References: <20061203045953.GE26668@spearce.org> <ekv34g$mck$1@sea.gmane.org> <874psceh4z.fsf@freitag.home.jstuber.net> <200612040039.00315.robin.rosenberg.lists@dewire.com> <ekvoan$lst$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 00:46:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ekvoan$lst$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33156>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr1yY-0007uV-8R for gcvg-git@gmane.org; Mon, 04 Dec
 2006 01:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760167AbWLDAqP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 19:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760174AbWLDAqP
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 19:46:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:21465 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1760167AbWLDAqP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 19:46:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gr1xt-0001AI-KT; Sun, 03 Dec 2006 19:45:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 19A8A20FB7F; Sun,  3 Dec 2006 19:46:10 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> I got:
> $ git clone http://www.spearce.org/projects/scm/egit.git
> [...]
>  got 73ed47b2bb1fa5978f7368775979e5c85d354c5a
>  error: File 2332eacf114debb7a27d138811197f06eb262551 
>  (http://www.spearce.org/projects/scm/egit.git/objects/75/1c8f2e504c40d1c41ebbd87d8f8968529e9c30) corrupt
>  Getting pack list for http://www.spearce.org/projects/scm/egit.git/
>  got afefbe09bacc08adb75fb46200a973001c6b02de
> [...]
>  walk c1f287cb19b9910af19756cf29c08b1fda75da8c
>  Some loose object were found to be corrupt, but they might be just
>  a false '404 Not Found' error message sent with incorrect HTTP
>  status code.  Suggest running git fsck-objects.
>  got eab86de8ac23e2e77878835007724146fdd83796
> $ git fsck-objects --unreachable --full --strict   ;# returns no errors

Right.  My web server doesn't send back 404 messages when an object
isn't found (but is packed).  Thus the error...

I've setup a project on repo.or.cz:

  http://repo.or.cz/w/egit.git


-- 
