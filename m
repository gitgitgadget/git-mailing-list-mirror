X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Light-weight checkouts via ".gitlink"
Date: Fri, 08 Dec 2006 23:18:12 +0100
Organization: At home
Message-ID: <elco6p$uku$1@sea.gmane.org>
References: <200612082252.31245.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 8 Dec 2006 22:16:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 40
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33759>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gso0v-0005de-Up for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947437AbWLHWQP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 17:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947440AbWLHWQP
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:16:15 -0500
Received: from main.gmane.org ([80.91.229.2]:46872 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947437AbWLHWQN
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 17:16:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gso0k-0007iw-Dc for git@vger.kernel.org; Fri, 08 Dec 2006 23:16:06 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 23:16:06 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 23:16:06 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

A few (very few) comments:

Josef Weidendorfer wrote:

> This can be implemented by enhancing git to ignore any subdirectory which
> has a file .gitlink in it.

If I remember correctly, while git ignores .git, it does not ignore
by default (i.e. without entry in either GIT_DIR/info/excludes, or
.gitignore) the directory which has .git directory in it.

And that should not change for .gitlink. You can always add
.gitignore file with * .* patterns in it (ignore all).
 
> * Gitdir = "<Path to base git repository>"
[...]
> * Name: <explicit name for this checkout>

Why use once "key = value", once "key: value" form? Better to stick
with one. I Would prefer "key = value" one.

GIT_DIR = path to base git repository
it is equivalent to setting the following:

GIT_INDEX_FILE = path to index file
GIT_OBJECT_DIRECTORY = path to object directory
GIT_HEAD_FILE = path to HEAD file
GIT_REFS_DIRECTORY = path to refs directory

NAME = name
should match "name subdirectory" entry in modules file in superproject.


Perhaps instead of adding arbitrary number of .. in front of relative
path, we better use some magic, like ... for finding somewhere up?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

