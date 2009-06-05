From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/8] enhancing builds on Solaris
Date: Fri,  5 Jun 2009 18:36:08 -0500
Message-ID: <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:39:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCj0n-0003GM-No
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbZFEXjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZFEXjk
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:39:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42255 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbZFEXjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:39:39 -0400
Received: by mail.nrlssc.navy.mil id n55NaRhY019246; Fri, 5 Jun 2009 18:36:27 -0500
In-Reply-To: <7vk53vlxhz.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 05 Jun 2009 23:36:27.0489 (UTC) FILETIME=[722C2D10:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120846>

From: Brandon Casey <drafnel@gmail.com>

Junio,

Here is a re-roll of the work on Solaris which integrates the ideas from you
and Jeff.  This should replace bc/solaris in pu.

This should allow compiling on Solaris with or without a c99 compiler,
GCC or SUNWspro.

Solaris 7 should be able to compile when using GCC and bash.

-brandon


Brandon Casey (7):
  Makefile: use /usr/ucb/install on SunOS platforms rather than
    ginstall
  Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile
    arguments
  diff-delta.c: "diff.h" is not a required include
  On Solaris choose the OLD_ICONV iconv() declaration based on the UNIX
    spec
  git-compat-util.h: tweak the way _XOPEN_SOURCE is set on Solaris
  Makefile: define __sun__ on SunOS
  Makefile: add section for SunOS 5.7

Junio C Hamano (1):
  Makefile: introduce SANE_TOOL_PATH for prepending required elements
    to PATH

 Makefile          |   40 +++++++++++++++++++++++++++++++++++-----
 diff-delta.c      |    1 -
 git-compat-util.h |   17 ++++++++++++++---
 git-sh-setup.sh   |    2 ++
 utf8.c            |    2 +-
 5 files changed, 52 insertions(+), 10 deletions(-)
