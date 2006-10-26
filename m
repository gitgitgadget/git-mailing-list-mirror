X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Thu, 26 Oct 2006 11:12:36 +0200
Organization: At home
Message-ID: <ehpu4t$ch2$1@sea.gmane.org>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 09:12:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 35
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30159>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1I0-0007Yo-7P for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752124AbWJZJM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWJZJM3
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:12:29 -0400
Received: from main.gmane.org ([80.91.229.2]:59351 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752124AbWJZJM2 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:12:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd1Hh-0007W7-CM for git@vger.kernel.org; Thu, 26 Oct 2006 11:12:21 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 11:12:21 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 11:12:21 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> * The 'master' branch has these since the last announcement.
> 
>   I've flushed all the 'gitweb/' changes from "next" and core
>   support that some of them needed; notably "for-each-ref" and
>   "blame --porcelain" is now in "master".  Oh, and "annotate"
>   is now a mere synonym for "blame -c".
[...]
>    Junio C Hamano (20):
[...]
>       gitweb: prepare for repositories with packed refs.
[...]
>       gitweb: use for-each-ref to show the latest activity across branches

This unfortunately means that I cannot test gitweb based on 'master'
branch using _released_ git core, git version 1.4.3.3, as it doesn't have
git-for-each-ref nor git-show-ref.

BTW. do people often use latest gitweb with older git binaries? Should
we try to wait for core feature to mature to released version before using
it in gitweb? Or perhaps we should add some kind of version checking, and
provide workrounds, e.g. using $ENV{GIT_DIR} if git core doesn't support
--git-dir option, pathlimit filtering using git-rev-list piped to 
git-diff-tree --stdin in git_history if there is no --full-history
option, show always HEAD activity if there is no git-for-each-ref
etc.; well the latest we can do without checking for git core version, just

        if -x qx($GIT --exec-path)/git-for-each-ref

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

