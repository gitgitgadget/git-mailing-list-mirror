X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: A call for better git-rebase messages
Date: Tue, 19 Dec 2006 11:17:35 +0100
Organization: At home
Message-ID: <em8e32$s7b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 19 Dec 2006 10:15:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 34
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34809>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwc0V-0005rS-98 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932756AbWLSKPc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWLSKPc
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:15:32 -0500
Received: from main.gmane.org ([80.91.229.2]:36993 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932756AbWLSKPb
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 05:15:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gwc05-0005jC-Fy for git@vger.kernel.org; Tue, 19 Dec 2006 11:15:09 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 11:15:09 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 19 Dec 2006
 11:15:09 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

 $ git rebase abort
 mkdir: cannot create directory `.dotest': File exists

 It seems that I cannot create a .dotest directory, and I wonder if you
 are in the middle of patch application or another rebase.  If that is not
 the case, please rm -fr .dotest and run me again.  I am stopping in case
 you still have something valuable there.

Why we do not tell to run "git rebase --abort" here? I think the command
know that it is a middle of git-rebase, not the middle of git-am...


 $ git rebase --onto origin next gitweb/web
 Nothing to do.

I'm not sure, but I think gitweb/web which was empty branch based off
former next is now empty branch based off current gitweb, i.e. at least
head of this branch has changed... but I'm not sure because

 $ git rebase --abort

is _not_ recorded as such, but as "reset --hard ORIG_HEAD" (I think).
It looks like it is, because after "reset --hard ORIG_HEAD" (which was
result of "git rebase --abort" of "git rebase origin" (I forgot
gitweb/web was based off other branch) there is "reset --hard <sha1>",
and this sha1 is sha1 of both gitweb/web and origin.

I'd rather rebase told me that it did something (moved head), but
there are no patches to be applied.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

