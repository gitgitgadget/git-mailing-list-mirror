X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: egit/jgit wishlist
Date: Mon, 04 Dec 2006 13:19:42 -0800
Message-ID: <457490EE.30606@midwinter.com>
References: <20061204172836.GB6011@spearce.org> <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net> <20061204182902.GG6011@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 21:19:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=gFcabYcXA7/8V+eCN7oF8/aIq0HTpP48o7/ekG08qesmsqRAlqHWFjmuBlBMF3CB  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <20061204182902.GG6011@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33253>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLDy-0007un-RZ for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967177AbWLDVTk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937399AbWLDVTk
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:19:40 -0500
Received: from tater.midwinter.com ([216.32.86.90]:51159 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937398AbWLDVTj
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:19:39 -0500
Received: (qmail 31713 invoked from network); 4 Dec 2006 21:19:38 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 4 Dec 2006 21:19:38 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> I personally want to avoid calling external programs
> as much as possible here, and that means staying with a 100% pure
> Java implementation.  

I think that's exactly the right decision.

One big advantage of doing it this way is that it will be reasonably 
cross-platform from the start. As soon as you start running external 
programs, you introduce all the system dependencies of the Git 
command-line tools, especially acute if you're running some of the non-C 
porcelain commands (which will then require a working shell or Perl 
environment to be installed.)

With a wrapper-based implementation, the temptation would probably be 
pretty great to just leave some stuff implemented as wrappers and not 
bother porting them, which would potentially kill portability. Insisting 
on 100% pure Java means that particular temptation is never an issue.

