X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unprivileged User
Date: Thu, 30 Nov 2006 10:07:13 +0100
Organization: At home
Message-ID: <ekm6si$psp$1@sea.gmane.org>
References: <2b9545a0611292154r4334d1afn1f49bbd3be2c3374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 09:05:58 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32711>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gphra-00016G-RG for gcvg-git@gmane.org; Thu, 30 Nov
 2006 10:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759190AbWK3JFq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 04:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759191AbWK3JFq
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 04:05:46 -0500
Received: from main.gmane.org ([80.91.229.2]:31395 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1759190AbWK3JFp (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 04:05:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GphrO-00012c-BN for git@vger.kernel.org; Thu, 30 Nov 2006 10:05:38 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 10:05:38 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 10:05:38 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Ed wrote:

> Hi, I'm new to git.  Just got everything setup and imported a new project.
> 
> From gitweb it says that my git project's owner is: Unprivileged User
> 
> Should I be worried about this when I begin using this git project with others?
> 
> How would I resolve this, to make the owner as the name I set in my
> ~/.gitconfig, or is there something I didn't read in the docs?
> 
> Thanks, beside this small glitch, git has been great.

Actually gitweb uses uid/user the repository (the $GIT_DIR), unless you
provide it with an index file. The simplest way is to click on "TXT" link
in projects list page, save it somewhere, edit it, and recompile gitweb
with this file as GITWEB_LIST (see README): 
   make ... GITWEB_LIST=<index> gitweb/gitweb.cgi
(or just edit gitweb.cgi or gitweb_conf.perl setting $projects_list
to this file).

Perhaps gitweb should use user.name from the repository instead...

P.S. Please reply also to git mailing list
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

